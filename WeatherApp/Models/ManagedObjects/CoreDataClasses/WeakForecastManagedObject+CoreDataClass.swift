//
//  WeakForecastManagedObject+CoreDataClass.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/9/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//
//

import Foundation
import CoreData

@objc(WeakForecastManagedObject)
public class WeakForecastManagedObject: NSManagedObject {
    
    func fill(with weakForecast: WeakForecast) {
        self.dayName = weakForecast.dayName
        self.image = weakForecast.imageName
        self.dayDegree = weakForecast.maxTemperature
        self.nightDegree = weakForecast.minTemperature
    }
}
