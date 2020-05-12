//
//  WeatherInfoPresenter.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/12/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//

import Foundation

class WeatherInfoPresenter {
    
    private unowned let view: WeatherInfoViewProtocol
    private var weatherManager: WeatherManagerProtocol?
    private var localRepository: LocalRepositoryProtocol?
    private var weatherData: Weather?
    
    
    init(view: WeatherInfoViewProtocol) {
        self.view = view
        self.weatherManager = WeatherManager()
        self.localRepository = LocalRepository()
    }
    
    deinit {
        removeObservers()
    }
    
    private func setupObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didLocationAvailable),
                                               name: .locationAvailable, object: nil)
    }
    
    private func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: .locationAvailable, object: nil)
    }
    
    private func updateCurrentLocationWeather() {
        weatherManager?.getWeatherAtCurrentLocation { [weak self] result in
            switch result {
            case .success(let weather):
                guard let weather = weather else {
                    return
                }
                DispatchQueue.main.async {
                    self?.localRepository?.updateWeatherInCurrentLocation(weather)
                    self?.weatherData = weather
                    self?.view.reloadData(with: weather)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc
    private func didLocationAvailable() {
        updateCurrentLocationWeather()
    }
}

extension WeatherInfoPresenter: WeatherInfoPresenterProtocol {

    func handleViewDidLoad() {
        setupObservers()
        weatherData = localRepository?.getCurrentLocationWeather()
        view.reloadData(with: weatherData)
    }
    
    func numberOfHourForecasts() -> Int {
        return weatherData?.hourlyForecast.count ?? .zero
    }
    
    func hourForecast(for indexPath: IndexPath) -> HourlyForecast? {
        return weatherData?.hourlyForecast[indexPath.row]
    }
    
    func weakForecast(for indexPath: IndexPath) -> WeakForecast? {
        return weatherData?.weakForecast[indexPath.row]
    }
}
