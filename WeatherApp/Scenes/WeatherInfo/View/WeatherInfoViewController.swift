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
        presenter?.handleViewDidLoad()
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        hourlyForecastCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: flowLayout)
        hourlyForecastCollectionView?.register(UINib(nibName: "HourForecastCell", bundle: Bundle.main), forCellWithReuseIdentifier: "HourForecastCell")
        hourlyForecastCollectionView?.delegate = self
        hourlyForecastCollectionView?.dataSource = self
        hourlyForecastCollectionView?.showsHorizontalScrollIndicator = false
        
        hourlyForecastCollectionView?.backgroundColor = .clear
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
        
        //customView.addSubview(hourlyForecastCollectionView ?? UIView())
        return hourlyForecastCollectionView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        110
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return UITableViewCell()
        case 1:
            return UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 150
        case 1:
            return 150
        default:
            return 2
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
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: .zero, left: .zero, bottom: .zero, right: .zero)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
}
