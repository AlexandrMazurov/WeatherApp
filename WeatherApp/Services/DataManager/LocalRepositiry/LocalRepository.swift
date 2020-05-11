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
        guard let weatherManagedObject = getCurrentWeatherManagedObject(context: context) else {
            return nil
        }
        return Weather(managedWeather: weatherManagedObject)
    }
    
    func updateWeatherInCurrentLocation(_ weather: Weather) {
        let updateContext = persistentContainer.newBackgroundContext()
        guard let currentLocationManagedObject = getCurrentWeatherManagedObject(context: updateContext) else {
            saveCurrenLocationWeather(weather: weather)
            return
        }
        currentLocationManagedObject.fill(with: weather, context: updateContext)
        saveContext(updateContext)
    }
    
    private func saveCurrenLocationWeather(weather: Weather) {
        let saveBacgroundContext = persistentContainer.newBackgroundContext()
        let weatherManagedObject = WeatherManagedObject(context: saveBacgroundContext)
        weatherManagedObject.fill(with: weather, context: saveBacgroundContext)
        saveContext(saveBacgroundContext)
    }
    
    private func getCurrentWeatherManagedObject(context: NSManagedObjectContext) -> WeatherManagedObject? {
        var resultWeatherManagedObject: WeatherManagedObject?
        let weatherManagedObjectRequest: NSFetchRequest<WeatherManagedObject> = WeatherManagedObject.fetchCurrentLocationWeatherRequest()
        do {
            resultWeatherManagedObject = try context.fetch(weatherManagedObjectRequest).first
        } catch {
            print(error)
        }
        return resultWeatherManagedObject
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
