//
//  WeatherManagedObject+CoreDataClass.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/9/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//
//

import Foundation
import CoreData

@objc(WeatherManagedObject)
public class WeatherManagedObject: NSManagedObject {
    
    func fill(with weatherObject: Weather, context: NSManagedObjectContext) {
        self.isCurrentLocation = NSNumber(booleanLiteral: weatherObject.isCurrentLocation)
        self.cityName = weatherObject.cityName
        self.degree = weatherObject.degree
        self.situation = weatherObject.situation
        self.hourlyForecast = NSOrderedSet(array: weatherObject.hourlyForecast.compactMap {
            let forecast = HourlyForecastManagedObject(context: context)
            forecast.fill(with: $0)
            return forecast
        })
        self.weakForecast = NSOrderedSet(array: weatherObject.weakForecast.compactMap {
            let forecast = WeakForecastManagedObject(context: context)
            forecast.fill(with: $0)
            return forecast
        })
        self.weatherInfo = NSOrderedSet(array: weatherObject.weatherInfo.compactMap {
            let info = WeatherInfoManagedObject(context: context)
            info.fill(with: $0)
            return info
        })
    }
}
