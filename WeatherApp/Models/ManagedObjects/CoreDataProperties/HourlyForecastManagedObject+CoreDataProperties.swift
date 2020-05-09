//
//  HourlyForecastManagedObject+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/9/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//
//

import Foundation
import CoreData


extension HourlyForecastManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HourlyForecastManagedObject> {
        return NSFetchRequest<HourlyForecastManagedObject>(entityName: "HourlyForecastManagedObject")
    }

    @NSManaged public var time: String?
    @NSManaged public var imageName: String?
    @NSManaged public var degree: String?
    @NSManaged public var weather: WeatherManagedObject?

}
