//
//  WeatherInfoViewController.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/12/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//

import UIKit

class WeatherInfoViewController: UIViewController {
    
    @IBOutlet weak var contentScrollView: UIScrollView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherCituationName: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var weatherInfoTableView: UITableView!
    
    var hourlyForecastCollectionView: UICollectionView?
    
    var presenter: WeatherInfoPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = WeatherInfoPresenter(view: self)
        setupViewSettings()
        presenter?.handleViewDidLoad()
    }
    
    private func setupViewSettings() {
        setupHourlyForecastCollectionView()
        registerCells()
        weatherInfoTableView.allowsSelection = false
    }
    
    private func setupHourlyForecastCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        hourlyForecastCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: flowLayout)
        hourlyForecastCollectionView?.delegate = self
        hourlyForecastCollectionView?.dataSource = self
        hourlyForecastCollectionView?.showsHorizontalScrollIndicator = false
        hourlyForecastCollectionView?.backgroundColor = #colorLiteral(red: 0.3137254902, green: 0.7215686275, blue: 1, alpha: 1)
    }
    
    private func registerCells() {
        hourlyForecastCollectionView?.register(UINib(nibName: "HourForecastCell",
                                                     bundle: Bundle.main),
                                               forCellWithReuseIdentifier: "HourForecastCell")
        weatherInfoTableView.register(UINib(nibName: "WeakForecastCell",
                                            bundle: Bundle.main),
                                      forCellReuseIdentifier: "WeakForecastCell")
        weatherInfoTableView.register(UINib(nibName: "WeatherInfoCell",
                                            bundle: Bundle.main),
                                      forCellReuseIdentifier: "WeatherInfoCell")
    }
}

extension WeatherInfoViewController: WeatherInfoViewProtocol {

    func reloadData(with weather: Weather?) {
        self.cityNameLabel.text = weather?.cityName
        self.weatherCituationName.text = weather?.situation
        self.degreeLabel.text = "\(weather?.degree ?? .zero)°"
        hourlyForecastCollectionView?.reloadData()
        weatherInfoTableView.reloadData()
    }
}

extension WeatherInfoViewController: UIScrollViewDelegate {
    
}

extension WeatherInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return hourlyForecastCollectionView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        110
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeakForecastCell", for: indexPath) as? WeakForecastCell else {
                fatalError("Cell for row at \(indexPath) fails to cast to weak forecast cell")
            }
            cell.configure(with: presenter.weakForecast(for: indexPath))
            return cell
        case presenter.weatherInfoRange():
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherInfoCell", for: indexPath) as? WeatherInfoCell else {
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
            return 40
        case presenter.weatherInfoRange():
            return 60
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
        guard let cell = hourlyForecastCollectionView?.dequeueReusableCell(withReuseIdentifier: "HourForecastCell", for: indexPath) as? HourForecastCell else {
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
        return CGSize(width: 60, height: collectionView.frame.height)
    }
}
