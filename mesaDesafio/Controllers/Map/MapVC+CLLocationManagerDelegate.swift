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
        
        guard status == .authorizedAlways || status == .authorizedWhenInUse else {
            return
        }
        viewModel.locationManager.startUpdatingLocation()
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true 
    }
    
    /// Provide the map on the right location and gets the places nearby; called every time location is updated
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.first else {
            return
        }
        // Adjust camera on user position
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        // Set User position and profile image position
        viewModel.profilePic.position = location.coordinate
        viewModel.currentLocation = location
        viewModel.locationManager.stopUpdatingLocation()
        // Retrieve all places nearby
        viewModel.getPlaces(mapView: mapView)
    }
}

