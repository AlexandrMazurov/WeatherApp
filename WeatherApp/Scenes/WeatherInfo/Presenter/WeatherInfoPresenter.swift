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
    
    private func numberOfWeakForecast() -> Int {
        return weatherData?.weakForecast.count ?? .zero
    }
    
    private func numberOfInfoSections() -> Int {
        return (weatherData?.weatherInfo.count ?? .zero) / 2
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
    
    func weatherInfo(for indexPath: IndexPath) -> [WeatherInfo?] {
        let elementPosition = indexPath.row * 2 - (weatherData?.weakForecast.count ?? .zero) * 2
        let nextElemenPosition = elementPosition + 1
        return [weatherData?.weatherInfo[elementPosition], weatherData?.weatherInfo[nextElemenPosition]]
    }
    
    func numberOfInfoRows() -> Int {
        return numberOfWeakForecast() + numberOfInfoSections()
    }
    
    func weakForecastRange() -> ClosedRange<Int> {
        return 0...(weatherData?.weakForecast.count ?? 1) - 1
    }
    
    func weatherInfoRange() -> ClosedRange<Int> {
        let startValue = weatherData?.weakForecast.count ?? .zero
        return (startValue)...(startValue + (weatherData?.weatherInfo.count ?? 1)) - 1
    }
    
}
