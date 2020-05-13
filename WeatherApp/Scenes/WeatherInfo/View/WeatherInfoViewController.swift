//
//  WeatherInfoViewController.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/12/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//

import UIKit

private enum Constants {
    static let hourForecastCellIdentifier = "HourForecastCell"
    static let weakForecastCellIdentifier = "WeakForecastCell"
    static let weatherInfoCellIndentifier = "WeatherInfoCell"
    static let weatherInfoTableViewHeaderHeight: CGFloat = 140
    static let weakForecastCellHeight: CGFloat = 40
    static let weatherInfoCellHeight: CGFloat = 60
    static let hourlyForecastCellWidth: CGFloat = 60
    static let weatherInfoTableViewHeight: CGFloat = 515
}

class WeatherInfoViewController: UIViewController {
    
    @IBOutlet private weak var contentScrollView: UIScrollView!
    @IBOutlet private weak var cityNameLabel: UILabel!
    @IBOutlet private weak var weatherCituationName: UILabel!
    @IBOutlet private weak var degreeLabel: UILabel!
    @IBOutlet private weak var weatherInfoTableView: UITableView!
    @IBOutlet weak var weatherInfoTableViewHeightConstraint: NSLayoutConstraint!
    
    private var hourlyForecastView: HourlyForecastView?
    
    private var presenter: WeatherInfoPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = WeatherInfoPresenter(view: self)
        setupViewSettings()
        presenter?.handleViewDidLoad()
    }
    
    private func setupViewSettings() {
        weatherInfoTableViewHeightConstraint.constant = Constants.weatherInfoTableViewHeight
        setupHourlyForecastView()
        registerCells()
        weatherInfoTableView.allowsSelection = false
    }
    
    private func setupHourlyForecastView() {
        hourlyForecastView = HourlyForecastView()
    }
    
    private func registerCells() {
        weatherInfoTableView.register(UINib(nibName: Constants.weakForecastCellIdentifier,
                                            bundle: Bundle.main),
                                      forCellReuseIdentifier: Constants.weakForecastCellIdentifier)
        weatherInfoTableView.register(UINib(nibName: Constants.weatherInfoCellIndentifier,
                                            bundle: Bundle.main),
                                      forCellReuseIdentifier: Constants.weatherInfoCellIndentifier)
    }
}

extension WeatherInfoViewController: WeatherInfoViewProtocol {

    func reloadData(with weather: Weather?) {
        self.cityNameLabel.text = weather?.cityName
        self.weatherCituationName.text = weather?.situation
        self.degreeLabel.text = "\(weather?.degree ?? .zero)°"
        hourlyForecastView?.configure(with: weather?.weakForecast.first,
                                      delegateAndDataSourceOwner: self)
        hourlyForecastView?.reloaData()
        weatherInfoTableView.reloadData()
    }
    
    func showErrorConnectionAllert(title: String, message: String) {
        showOKAlert(title: title, message: message)
    }
    
    func showLocationErrorAllert(title: String, message: String) {
        showLocationSettingsAllert(title: title, message: message)
    }
}

extension WeatherInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return hourlyForecastView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        Constants.weatherInfoTableViewHeaderHeight
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfInfoRows() ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter = presenter else {
            fatalError("Presenter is not resolved")
        }
        switch indexPath.row {
        case presenter.weakForecastRange():
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.weakForecastCellIdentifier,
                                                           for: indexPath) as? WeakForecastCell else {
                fatalError("Cell for row at \(indexPath) fails to cast to weak forecast cell")
            }
            cell.configure(with: presenter.weakForecast(for: indexPath))
            return cell
        case presenter.weatherInfoRange():
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.weatherInfoCellIndentifier,
                                                           for: indexPath) as? WeatherInfoCell else {
                fatalError("Cell for row at \(indexPath) fails to cast to info cell")
            }
            cell.configure(with: presenter.weatherInfo(for: indexPath))
            return cell

        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let presenter = presenter else {
            return .zero
        }
        switch indexPath.row {
        case presenter.weakForecastRange():
            return Constants.weakForecastCellHeight
        case presenter.weatherInfoRange():
            return Constants.weatherInfoCellHeight
        default:
            return .zero
        }
    }
}

extension WeatherInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.numberOfHourForecasts() ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = hourlyForecastView?.hourlyForecastCollectionView?.dequeueReusableCell(withReuseIdentifier: Constants.hourForecastCellIdentifier,
                                                                           for: indexPath) as? HourForecastCell else {
            fatalError("Cell for row at \(indexPath) fails to cast to hour forecast cell")
        }
        cell.configure(with: presenter?.hourForecast(for: indexPath))
        return cell
    }
}

extension WeatherInfoViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.hourlyForecastCellWidth, height: collectionView.frame.height)
    }
}
