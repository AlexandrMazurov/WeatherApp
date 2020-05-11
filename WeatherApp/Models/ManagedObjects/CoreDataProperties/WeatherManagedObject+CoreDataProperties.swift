//
//  WeatherManagedObject+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/9/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//
//

import Foundation
import CoreData


extension WeatherManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherManagedObject> {
        return NSFetchRequest<WeatherManagedObject>(entityName: "WeatherManagedObject")
    }
    
    @nonobjc public class func fetchCurrentLocationWeatherRequest() -> NSFetchRequest<WeatherManagedObject> {
        let currenLocationWeatherRequest = NSFetchRequest<WeatherManagedObject>(entityName: "WeatherManagedObject")
        let predicate = NSPredicate(format: "isCurrentLocation == %d", true)
        currenLocationWeatherRequest.predicate = predicate
        return currenLocationWeatherRequest
    }
    
    @NSManaged public var isCurrentLocation: NSNumber?
    @NSManaged public var cityName: String?
    @NSManaged public var degree: Int16
    @NSManaged public var situation: String?
    @NSManaged public var hourlyForecast: NSOrderedSet?
    @NSManaged public var weakForecast: NSOrderedSet?
    @NSManaged public var weatherInfo: NSOrderedSet?

}

// MARK: Generated accessors for hourlyForecast
extension WeatherManagedObject {

    @objc(addHourlyForecastObject:)
    @NSManaged public func addToHourlyForecast(_ value: HourlyForecastManagedObject)

    @objc(removeHourlyForecastObject:)
    @NSManaged public func removeFromHourlyForecast(_ value: HourlyForecastManagedObject)

    @objc(addHourlyForecast:)
    @NSManaged public func addToHourlyForecast(_ values: NSSet)

    @objc(removeHourlyForecast:)
    @NSManaged public func removeFromHourlyForecast(_ values: NSSet)

}

// MARK: Generated accessors for weakForecast
extension WeatherManagedObject {

    @objc(addWeakForecastObject:)
    @NSManaged public func addToWeakForecast(_ value: WeakForecastManagedObject)

    @objc(removeWeakForecastObject:)
    @NSManaged public func removeFromWeakForecast(_ value: WeakForecastManagedObject)

    @objc(addWeakForecast:)
    @NSManaged public func addToWeakForecast(_ values: NSOrderedSet)

    @objc(removeWeakForecast:)
    @NSManaged public func removeFromWeakForecast(_ values: NSOrderedSet)

}

// MARK: Generated accessors for weatherInfo
extension WeatherManagedObject {

    @objc(addWeatherInfoObject:)
    @NSManaged public func addToWeatherInfo(_ value: WeatherInfoManagedObject)

    @objc(removeWeatherInfoObject:)
    @NSManaged public func removeFromWeatherInfo(_ value: WeatherInfoManagedObject)

    @objc(addWeatherInfo:)
    @NSManaged public func addToWeatherInfo(_ values: NSSet)

    @objc(removeWeatherInfo:)
    @NSManaged public func removeFromWeatherInfo(_ values: NSSet)

}
