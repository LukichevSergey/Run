//
//  LocationManager.swift
//  Run
//
//  Created by Лукичев Сергей on 26.08.2023.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate: AnyObject {
    func didUpdateUserLocation(_ location: CLLocation)
}

final class LocationManager: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    private var location: CLLocation?
    private let geocoder = CLGeocoder()
    weak var delegate: LocationManagerDelegate?
    override init() {
        super.init()
        logger.log("\(#fileID) -> \(#function)")
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.distanceFilter = 10
    }
    func requestAuthorization() {
        logger.log("\(#fileID) -> \(#function)")
        locationManager.requestWhenInUseAuthorization()
    }
    func startUpdatingLocation() {
        logger.log("\(#fileID) -> \(#function)")
        locationManager.startUpdatingLocation()
    }
    func stopUpdatingLocation() {
        logger.log("\(#fileID) -> \(#function)")
        locationManager.stopUpdatingLocation()
    }
    func calculateDistance(routeCoordinates: [CLLocationCoordinate2D]) -> CLLocationDistance {
        logger.log("\(#fileID) -> \(#function)")
        var totalDistance: CLLocationDistance = 0
        if routeCoordinates.count > 1 {
            for i in 0..<routeCoordinates.count-1 {
                let source = CLLocation(latitude: routeCoordinates[i].latitude,
                                        longitude: routeCoordinates[i].longitude)
                let destination = CLLocation(latitude: routeCoordinates[i+1].latitude,
                                             longitude: routeCoordinates[i+1].longitude)
                totalDistance += source.distance(from: destination)
            }
        }
        return totalDistance
    }
    func getCityFromCoordinates(_ latitude: Double, _ longitude: Double, completion: @escaping (String) -> Void) {
        logger.log("\(#fileID) -> \(#function)")
        var city: String = ""
        let location = CLLocation(latitude: latitude, longitude: longitude)

        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, _) in
            guard self != nil else {
                return
            }
            if let placemark = placemarks?.first {
                if let foundCity = placemark.locality {
                    city = foundCity
                    completion(city)
                } else {
                    completion(Tx.Training.cityNotFound)
                }
            } else {
                completion(Tx.Training.cityNotFound)
            }
        }
    }
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        logger.log("\(#fileID) -> \(#function)")
        guard let location = locations.last else { return }
        self.location = location
        delegate?.didUpdateUserLocation(location)
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        logger.log("\(#fileID) -> \(#function)")
        if status == .authorizedWhenInUse {
            startUpdatingLocation()
        }
    }
}
