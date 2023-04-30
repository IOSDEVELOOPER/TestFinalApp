//
//  CoordinateService.swift
//  WeatherTestProject_Final
//
//  Created by Андрей Федоров on 29.04.2023.
//

import Foundation
import CoreLocation

class CoordinateService: NSObject, CLLocationManagerDelegate{
    private var locationManager : CLLocationManager?
    override init(){
        super.init()
        checkLocationServiceIsEnabled()
    }
    
    //MARK: - Func to get lat and lot fot URL
    func getLocation() -> (lat: Double, lon: Double)?{
        guard let coordinate = locationManager?.location?.coordinate else {return nil}
        return (lat: coordinate.latitude, lon: coordinate.longitude)
    }
    
    //MARK: - func for check Enabled location
    func checkLocationServiceIsEnabled(){
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled(){
                self.locationManager = CLLocationManager()
                self.locationManager?.delegate = self
                self.checkLocationAuthorization()
                
            }else{
                print("Show an alert")
            }
        }
       
    }
    
    //MARK: - func for nec-ry request  user
    func checkLocationAuthorization(){
        guard let locationManager = locationManager else {return}
        switch locationManager.authorizationStatus{
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("restricted")
        case .denied:
            print("Go to settings")
        case .authorizedAlways, .authorizedWhenInUse:
            break
        @unknown default:
            break
        }
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
