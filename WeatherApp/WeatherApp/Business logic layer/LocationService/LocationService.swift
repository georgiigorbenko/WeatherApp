//
//  LocationService.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 15.10.2021.
//

import CoreLocation
import PromiseKit
 
class LocationService {
    
    private class LocationUpdateDelegate: NSObject, CLLocationManagerDelegate {
        
        private let (promise, seal) = Promise<CLLocation>.pending()
        
        var delegatePromise: Promise<CLLocation> {
            
            return promise
        }
        
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            
            switch status {
            case .authorizedAlways, .authorizedWhenInUse:
                manager.startUpdatingLocation()
            case .denied:
                seal.reject(LocationServiceError.deniedAuthorization)
            case .notDetermined:
                manager.requestWhenInUseAuthorization()
            case .restricted:
                seal.reject(LocationServiceError.serviceDisabled)
                manager.stopUpdatingLocation()
            @unknown default:
                seal.reject(LocationServiceError.serviceDisabled)
                manager.stopUpdatingLocation()
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            
            guard let location = locations.last else { return }
            seal.fulfill(location)
        }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            
            let (domain, code) = { ($0.domain, $0.code) }(error as NSError)
            guard code != CLError.locationUnknown.rawValue &&
                domain != kCLErrorDomain else { return /* Apple docs say you should just ignore this error */ }
            seal.reject(error)
        }
    }
    
    var requestType: RequestLoctionType?
    
    private var initialAuthorizationState: CLAuthorizationStatus {
        
        return locationManager.authorizationStatus
    }
    
    private lazy var locationManager: CLLocationManager = {
        
        let manager = CLLocationManager()
        
        manager.distanceFilter = kCLDistanceFilterNone
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = locationUpdateDelegate
        
        return manager
    }()
    
    private lazy var locationUpdateDelegate: LocationUpdateDelegate = {
        
        return LocationUpdateDelegate()
    }()
    
    deinit {
        
        locationManager.stopUpdatingLocation()
    }
    
    
    
}

// MARK: - Public methods
extension LocationService {
    
    func requestLoction(with type: RequestLoctionType) -> Promise<CLLocation> {
        
        switch (requestType, type) {
        case (.access?, .access):
            requestType = type
            return requestLoctionAccess()
        case (.find?, .find):
            requestType = type
            return findLocation()
        case (.subscribe?, .subscribe):
            requestType = type
            return subscribeLocationUpdate()
        case (.access?, .find):
            requestType = type
            locationManager.stopUpdatingLocation()
            return findLocation()
        case (.find?, .access):
            requestType = type
            locationManager.stopUpdatingLocation()
            return requestLoctionAccess()
        case (.find?, .subscribe):
            requestType = type
            locationManager.stopUpdatingLocation()
            return subscribeLocationUpdate()
        case (_, .access):
            requestType = type
            return requestLoctionAccess()
        case (_, .find):
            requestType = type
            return findLocation()
        case (_, .subscribe):
            requestType = type
            return subscribeLocationUpdate()
        }
    }
    
}

// MARK: - Public type definitions
extension LocationService {
    
    enum RequestLoctionType {
        
        case access
        case find
        case subscribe
    }
    
}

// MARK: - Private methods
extension LocationService {
    
    func subscribeLocationUpdate() -> Promise<CLLocation> {
        
        switch initialAuthorizationState {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            break
        case .restricted:
            break
        @unknown default:
            break
        }
        return locationUpdateDelegate.delegatePromise
    }
    
    func findLocation() -> Promise<CLLocation> {
        
        switch initialAuthorizationState {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            return Promise<CLLocation> { seal in
                seal.reject(LocationServiceError.deniedAuthorization)
            }
        case .restricted:
            return Promise<CLLocation> { seal in
                seal.reject(LocationServiceError.serviceDisabled)
            }
        @unknown default:
            return Promise<CLLocation> { seal in
                seal.reject(LocationServiceError.serviceDisabled)
            }
        }
        return locationUpdateDelegate.delegatePromise
    }
    
    func requestLoctionAccess() -> Promise<CLLocation> {
        
        switch initialAuthorizationState {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            return Promise<CLLocation> { seal in
                
                seal.reject(LocationServiceError.deniedAuthorization)
            }
        case .restricted:
            return Promise<CLLocation> { seal in
                
                seal.reject(LocationServiceError.serviceDisabled)
            }
        @unknown default:
            return Promise<CLLocation> { seal in
                seal.reject(LocationServiceError.serviceDisabled)
            }
        }
        return locationUpdateDelegate.delegatePromise
    }
    
}
