//
//  HourlyForecastManagedObject+CoreDataClass.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/9/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//
//

import Foundation
import CoreData

@objc(HourlyForecastManagedObject)
public class HourlyForecastManagedObject: NSManagedObject {

    func fill(with hourlyForecast: HourlyForecast) {
        self.time = hourlyForecast.time
        self.imageName = hourlyForecast.imageName
        self.degree = hourlyForecast.degree
    }
}
