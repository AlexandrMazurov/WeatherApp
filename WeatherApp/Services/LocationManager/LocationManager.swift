//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/10/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//

import CoreLocation

class LocationManager: NSObject, LocationManagerProtocol, CLLocationManagerDelegate  {
    
    private let locationManager: CLLocationManager
    private (set) var latitude: String?
    private (set) var longitude: String?
    
    override init() {
        self.locationManager = CLLocationManager()
        super.init()
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first?.coordinate else {
            return
        }
        latitude = location.latitude.description
        longitude = location.longitude.description
        NotificationCenter.default.post(name: .locationAvailable, object: nil)
    }
}
