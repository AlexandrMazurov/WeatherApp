//
//  WeatherInfoPresenter.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/12/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//

import Foundation

class WeatherInfoPresenter: WeatherInfoPresenterProtocol {
    
    private unowned let view: WeatherInfoViewProtocol
    
    init(view: WeatherInfoViewProtocol) {
        self.view = view
    }
    
}
