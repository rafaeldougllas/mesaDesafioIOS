//
//  MapVC+CLLocationManagerDelegate.swift
//  mesaDesafio
//
//  Created by Rafael Douglas on 01/03/20.
//  Copyright © 2020 com.rafael.douglas. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import GoogleMaps
import GooglePlaces

extension MapVC: CLLocationManagerDelegate {
    
    /// Called when user grants or revokes permission to access location
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("locationManager didChangeAuthorization")
        guard status == .authorizedAlways || status == .authorizedWhenInUse else {
            return
        }
        
        locationManager.startUpdatingLocation()
        
        mapView.isMyLocationEnabled = true //blue dot where the user is
        mapView.settings.myLocationButton = true //button that centers the map in the current location
    }
    
    /// Provide the map on the right location and gets the places nearby; called every time location is updated
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("locationManager didUpdateLocations")
        guard let location = locations.first else {
            return
        }
    
        profilePic.position = location.coordinate
        self.currentLocation = location
        
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        
        locationManager.stopUpdatingLocation()
        getPlaces()
    }
}

