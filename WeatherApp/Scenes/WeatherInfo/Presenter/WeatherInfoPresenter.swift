//
//  WeatherInfoPresenter.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/12/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//

import Foundation

private enum Constants {
    static let numberOfTodayForecast = 1
    static let numberOfInfoSectionsInRow = 2
    static let arrayIndexDifference = 1
    static let nextArrayIterrationStep = 1
    static let errorConnectionTitle = "Connection Error"
    static let errorConnectionMessage = "Please, check internet connection"
    static let errorLocationTitle = "Erorr getting location"
    static let errorLocationMessage = "Please enable location in settings"
}

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
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(errorGettingLocationAction),
                                               name: .errorGettingLocation, object: nil)
    }
    
    private func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: .locationAvailable, object: nil)
        NotificationCenter.default.removeObserver(self, name: .errorGettingLocation, object: nil)
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
            case .failure(_):
                DispatchQueue.main.async {
                    self?.view.showErrorConnectionAllert(title: Constants.errorConnectionTitle,
                                                         message: Constants.errorConnectionMessage)
                }
            }
        }
    }
    
    @objc
    private func didLocationAvailable() {
        updateCurrentLocationWeather()
    }
    
    @objc
    private func errorGettingLocationAction() {
        view.showLocationErrorAllert(title: Constants.errorLocationTitle,
                                     message: Constants.errorLocationMessage)
    }
    
    private func numberOfWeakForecast() -> Int {
        guard let weakForecastCount = weatherData?.weakForecast.count else {
            return .zero
        }
        return weakForecastCount - Constants.numberOfTodayForecast
    }
    
    private func numberOfInfoSections() -> Int {
        guard let weatherInfoDataCount = weatherData?.weatherInfo.count else {
            return .zero
        }
        return weatherInfoDataCount / Constants.numberOfInfoSectionsInRow
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
        return weatherData?.weakForecast[indexPath.row + Constants.numberOfTodayForecast]
    }
    
    func weatherInfo(for indexPath: IndexPath) -> [WeatherInfo?] {
        let elementPosition = indexPath.row * 2 - numberOfWeakForecast() * 2
        let nextElemenPosition = elementPosition + Constants.nextArrayIterrationStep
        return [weatherData?.weatherInfo[elementPosition], weatherData?.weatherInfo[nextElemenPosition]]
    }
    
    func numberOfInfoRows() -> Int {
        return numberOfWeakForecast() + numberOfInfoSections()
    }
    
    func weakForecastRange() -> ClosedRange<Int> {
        return .zero...numberOfWeakForecast() - Constants.arrayIndexDifference
    }
    
    func weatherInfoRange() -> ClosedRange<Int> {
        let startValue = numberOfWeakForecast()
        return (startValue)...(startValue + numberOfInfoSections()) - Constants.arrayIndexDifference
    }
}
