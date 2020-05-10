//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/8/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//

import Foundation

private enum Constants {
    static let kelvinConstant: Int16 = 273
    static let numberForecastsInDay = 8
    static let oneDayIndex = 1
    static let dayPod = "d"
    static let feelsLikeParameterName = "Feels like"
    static let humidityParameterName = "Humidity"
    static let pressureParameterName = "Pressure"
    static let windSpeedParameterName = "Wind"
    static let sunRiseParameterName = "Sunrise"
    static let suncSetParameterName = "Sunset"
}

class WeatherManager: WeatherManagerProtocol {
    
    private let api: ApiProtocol
    
    init() {
        self.api = OpenWeatherMapApi()
    }
    
    func getWeatherAtCurrentLocation(completion: @escaping (Result<Weather?, Error>) -> Void)  {
        api.getWeatherForecast(lat: "53.893009", lon: "27.567444") { [weak self] result in
            switch result {
            case .success(let weatherData):
                completion(.success(self?.setupWeather(from: weatherData)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func setupWeather(from weatherData: WeatherData) -> Weather {
         Weather(cityName: weatherData.city.name,
                 degree: getCurrentDegree(weather: weatherData),
                 situation: getWeatherSituation(weather: weatherData),
                 hourlyForecast: getHourlyForecast(weather: weatherData),
                 weakForecast: getWeakForecast(weather: weatherData),
                 weatherInfo: getWeatherInfo(weather: weatherData))
    }
    
    private func getCurrentDegree(weather data: WeatherData) -> Int16 {
        guard let degree = data.list.first?.main.temperature else {
            return .zero
        }
        return convertKelvinToCelsion(kelvin: degree)
    }
    
    private func getWeatherSituation(weather data: WeatherData) -> String {
        guard let situationDescription = data.list.first?.weather.first?.description else {
            return ""
        }
        return situationDescription
    }
    
    private func getHourlyForecast(weather data: WeatherData) -> [HourlyForecast] {
        Array(data.list.compactMap {
            HourlyForecast(time: String($0.time),
                           imageName: $0.weather.first?.icon ?? "",
                           degree: convertKelvinToCelsion(kelvin: $0.main.temperature).description)
            }[..<Constants.numberForecastsInDay])
    }
    
    private func getWeakForecast(weather data: WeatherData) -> [WeakForecast] {
        let firstForecastDay = Calendar.current.startOfDay(for: Date(timeIntervalSince1970: TimeInterval(data.list.first?.time ?? .zero)))
        let lastForecastDay = Calendar.current.startOfDay(for: Date(timeIntervalSince1970: TimeInterval(data.list.last?.time ?? .zero)))
        guard let numberOfForecastDays = Calendar.current.dateComponents([.day], from: firstForecastDay, to: lastForecastDay).day,
            numberOfForecastDays > .zero else {
            return []
        }
        return calculateWeakForecastParameters(weatherData: data, daysCount: numberOfForecastDays)
    }
    
    private func getWeatherInfo(weather data: WeatherData) -> [WeatherInfo] {
        return [
            WeatherInfo(name: Constants.feelsLikeParameterName,
                        value: "\(convertKelvinToCelsion(kelvin: data.list.first?.main.feelsLike)) °C"),
            WeatherInfo(name: Constants.humidityParameterName,
                        value: "\(data.list.first?.main.humidity.description ?? "") %"),
            WeatherInfo(name: Constants.pressureParameterName,
                        value: "\(data.list.first?.main.pressure.description ?? "") hPa"),
            WeatherInfo(name: Constants.windSpeedParameterName,
                        value: "\(Int16(data.list.first?.wind.speed ?? .zero)) km/h"),
            WeatherInfo(name: Constants.sunRiseParameterName,
                        value: timeFormat(from: TimeInterval(data.city.sunRise))),
            WeatherInfo(name: Constants.suncSetParameterName,
                        value: timeFormat(from: TimeInterval(data.city.sunSet)))
            
        ]
    }
    
    private func calculateWeakForecastParameters(weatherData: WeatherData, daysCount: Int) -> [WeakForecast] {
        Array(Constants.oneDayIndex...daysCount).compactMap {
            let forecastDay = Calendar.current.date(byAdding: .day, value: $0, to: Date()) ?? Date()
            let startOfDay = Int(Calendar.current.startOfDay(for: forecastDay).timeIntervalSince1970)
            let endOfDay = Int(Calendar.current.startOfDay(for: Calendar.current.date(byAdding: .day, value: 1, to: forecastDay)
                ?? Date()).timeIntervalSince1970)
            let forecastArray = weatherData.list.filter { $0.time >= startOfDay && $0.time < endOfDay }
            return WeakForecast(dayName: getDayName(timeInterval: TimeInterval(startOfDay)),
                                imageName: forecastArray.filter { $0.timesOfDay.pod == Constants.dayPod }.first?.weather.first?.icon ??
                                    forecastArray.first?.weather.first?.icon ?? "",
                                minTemperature: Int16(forecastArray.compactMap { convertKelvinToCelsion(kelvin: $0.main.minTemperature) }.min() ?? .zero),
                                maxTemperature: Int16(forecastArray.compactMap { convertKelvinToCelsion(kelvin: $0.main.maxTemperature) }.max() ?? .zero))
        }
    }
    
    private func convertKelvinToCelsion(kelvin value: Double?) -> Int16 {
        guard let kelvin = value else {
            return .zero
        }
        return Int16(kelvin) - Constants.kelvinConstant
    }
    
    private func timeFormat(from interval: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.hour, .minute]
        let startOfDay = Calendar.current.startOfDay(for: Date(timeIntervalSince1970: interval))
        return formatter.string(from: interval - startOfDay.timeIntervalSince1970) ?? ""
    }
    
    private func getDayName(timeInterval: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeInterval)
        let dayNumber = Calendar.current.component(.weekday, from: date)
        switch dayNumber {
        case 1: return "Sunday"
        case 2: return "Monday"
        case 3: return "Tuesday"
        case 4: return "Wednesday"
        case 5: return "Thursday"
        case 6: return "Friday"
        case 7: return "Saturday"
        default: return ""
        }
    }
}
