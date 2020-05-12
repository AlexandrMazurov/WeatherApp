//
//  OpenWeatherMapApi.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/8/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//

import Foundation

class OpenWeatherMapApi: ApiProtocol {
    
    func getWeatherForecast(lat: String, lon: String, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        guard let url = URL(string: URLEndpoint
            .getWeatherForecast(latitude: lat,
                                longitude: lon,
                                apiKey: "2e0254193f6b563ad2bfdee9b187c823")) else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                guard let error = error else {
                    return
                }
                completion(Result.failure(error))
                return
            }
            do {
                let items = try JSONDecoder().decode(WeatherData.self, from: data)
                completion(Result.success(items))
            } catch {
                completion(Result.failure(error))
            }
        }.resume()
    }
}
