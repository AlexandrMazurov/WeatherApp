//
//  WeatherInfoManagedObject+CoreDataClass.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/9/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//
//

import Foundation
import CoreData

@objc(WeatherInfoManagedObject)
public class WeatherInfoManagedObject: NSManagedObject {
    
    func fill(with weatherInfo: WeatherInfo) {
        self.name = weatherInfo.name
        self.value = weatherInfo.value
    }
}
