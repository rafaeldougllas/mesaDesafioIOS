//
//  MapVC+GMSMapViewDelegate.swift
//  mesaDesafio
//
//  Created by Rafael Douglas on 01/03/20.
//  Copyright © 2020 com.rafael.douglas. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import GoogleMaps
import GooglePlaces

extension MapVC: GMSMapViewDelegate {
    
//    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
//        print("GMSMapViewDelegate - mapView")
////        self.detailView.isHidden = false
////        self.mapView.addGestureRecognizer(mapTapGesture)
//
//        for place in places {
//            if (place.coordinate.latitude == marker.position.latitude
//                && place.coordinate.longitude == marker.position.longitude) {
//                self.selectedPlace = place
//            }
//        }
//
//        if let place = selectedPlace {
//            setPopupInfo(place: place)
//        }
//
//        return true
//    }
    
//    func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
//      guard let placeMarker = marker as? PlaceMarker else {
//        return nil
//      }
//      guard let infoView = UIView.viewFromNibName("MarkerInfoView") as? MarkerInfoView else {
//        return nil
//      }
//
//      infoView.placeName.text = placeMarker.place.name
//      infoView.placeAddress.text = placeMarker.place.address
//      infoView.placePhone.text = placeMarker.place.phone
//
//
//      return infoView
//    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
      if (gesture) {
        self.selectedPlace = nil
      }
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
      guard let placeMarker = marker as? PlaceMarker else {
        return nil
      }
      guard let infoView = UIView.viewFromNibName("MarkerInfoView") as? MarkerInfoView else {
        return nil
      }
      
      infoView.placeName.text = placeMarker.place.name
      if placeMarker.place.address != "" {
        infoView.placeAddress.text = placeMarker.place.address
      }else{
        infoView.placeAddress.text = "Sem endereço"
      }
      if placeMarker.place.phone != ""{
            infoView.placePhone.text = placeMarker.place.phone
      }else{
        infoView.placePhone.text = "Sem telefone"
      }
      infoView.latitude = placeMarker.place.coordinate.latitude
      infoView.longitude = placeMarker.place.coordinate.longitude
        
        infoView.mapsBtn.addTarget(self, action: #selector(showLocationInMaps), for: .touchUpInside)
        
      return infoView
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
      return false
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
      selectedPlace = nil
      return false
    }
    
}
