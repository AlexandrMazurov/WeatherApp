//
//  WeatherInfoManagedObject+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/9/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//
//

import Foundation
import CoreData


extension WeatherInfoManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherInfoManagedObject> {
        return NSFetchRequest<WeatherInfoManagedObject>(entityName: "WeatherInfoManagedObject")
    }

    @NSManaged public var name: String?
    @NSManaged public var value: String?
    @NSManaged public var weather: WeatherManagedObject?

}
