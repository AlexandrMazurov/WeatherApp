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
    
    var presenter: WeatherInfoPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = WeatherInfoPresenter(view: self)

    }
}

extension WeatherInfoViewController: WeatherInfoViewProtocol {
    
}

extension WeatherInfoViewController: UIScrollViewDelegate {
    
}

extension WeatherInfoViewController: UITableViewDelegate, UITableViewDataSource {

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
            return 0
        case 1:
            return 1
        default:
            return 2
        }
    }
    
    
}
