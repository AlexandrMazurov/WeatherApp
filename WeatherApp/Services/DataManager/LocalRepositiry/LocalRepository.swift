//
//  LocalRepository.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/8/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//

import UIKit
import CoreData

class LocalRepository: LocalRepositoryProtocol {
    
    private let persistentContainer: NSPersistentContainer
    private let mainContext: NSManagedObjectContext
    
    init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Could not convert delegate to AppDelegate")
        }
        self.persistentContainer = appDelegate.persistentContainer
        self.mainContext = persistentContainer.viewContext
    }
    
    func getCurrentLocationWeather() -> Weather? {
        let context = persistentContainer.newBackgroundContext()
        var resultWeatherManagedObject: WeatherManagedObject?
        let weatherManagedObjectRequest: NSFetchRequest<WeatherManagedObject> = WeatherManagedObject.fetchRequest()
        do {
            resultWeatherManagedObject = try context.fetch(weatherManagedObjectRequest).first
        } catch {
            print(error)
        }
        guard let managedResult = resultWeatherManagedObject else {
            return nil
        }
        return Weather(managedWeather: managedResult)
    }
    
    func saveCurrenLocationWeather(weather: Weather) {
        let saveBacgroundContext = persistentContainer.newBackgroundContext()
        let weatherManagedObject = WeatherManagedObject(context: saveBacgroundContext)
        weatherManagedObject.fill(with: weather, context: saveBacgroundContext)
        saveContext(saveBacgroundContext)
    }
    
    func updateWeatherInCurrentLocation(_ weather: Weather) {
        
    }
    
    private func saveContext(_ context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            debugPrint(error)
            context.reset()
        }
    }
}
