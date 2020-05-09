//
//  WeakForecastManagedObject+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/9/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//
//

import Foundation
import CoreData


extension WeakForecastManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeakForecastManagedObject> {
        return NSFetchRequest<WeakForecastManagedObject>(entityName: "WeakForecastManagedObject")
    }

    @NSManaged public var dayName: String?
    @NSManaged public var image: String?
    @NSManaged public var dayDegree: Int16
    @NSManaged public var nightDegree: Int16
    @NSManaged public var weather: WeatherManagedObject?

}
