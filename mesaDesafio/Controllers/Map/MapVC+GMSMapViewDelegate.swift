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
    // empty the default infowindow
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        return MarkerInfoView()
    }

    // reset custom infowindow whenever marker is tapped
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        guard let placeMarker = marker as? PlaceMarker else {
            return false
        }
        
        // If exists a infoView destroy it
        if(viewModel.infoView != nil){
            viewModel.infoView?.removeFromSuperview()
        }
        viewModel.infoView = UIView.viewFromNibName("MarkerInfoView") as? MarkerInfoView
        
        for place in viewModel.places {
            if (place.coordinate.latitude == marker.position.latitude
                && place.coordinate.longitude == marker.position.longitude) {
                self.viewModel.selectedPlace = place
            }
        }
        
        // Settings style for labels
        viewModel.infoView?.placeName.textColor = Utils.hexStringToUIColor(hex: GREY_TEXT_COLOR)
        viewModel.infoView?.placeName.font = UIFont(name: "Helvetica", size:INFO_VIEW_TEXT_SIZE)
        viewModel.infoView?.placeName.font = UIFont.boldSystemFont(ofSize: INFO_VIEW_TEXT_SIZE)
        viewModel.infoView?.placeAddress.textColor = Utils.hexStringToUIColor(hex: GREY_TEXT_COLOR)
        viewModel.infoView?.placeAddress.font = UIFont(name: "Helvetica", size:13)
        viewModel.infoView?.placePhone.textColor = Utils.hexStringToUIColor(hex: RED_TEXT_COLOR)
        viewModel.infoView?.placePhone.font = UIFont(name: "Helvetica", size:13)

        // Inflating content in labels
        viewModel.infoView?.placeName.text = placeMarker.place.name
        if placeMarker.place.address != "" {
            viewModel.infoView?.placeAddress.text = placeMarker.place.address
        }else{
            viewModel.infoView?.placeAddress.text = "Sem endereço"
        }
        if placeMarker.place.phone != ""{
            viewModel.infoView?.placePhone.text = placeMarker.place.phone
        }else{
            viewModel.infoView?.placePhone.text = "Sem telefone"
        }
        viewModel.infoView?.latitude = marker.position.latitude
        viewModel.infoView?.longitude = marker.position.longitude
        viewModel.infoView?.name = placeMarker.place.name
        
        // Fixing view location, shows only camera location is right
        viewModel.infoView?.setIsHidden(true, animated: false)
        self.view.addSubview(viewModel.infoView!)

        // Remember to return false
        // so marker event is still handled by delegate
        return false
    }

    // let the custom infowindow follows the camera
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        if (viewModel.selectedPlace?.coordinate != nil){
            viewModel.infoView?.center = mapView.projection.point(for: viewModel.selectedPlace!.coordinate)
            viewModel.infoView?.center.y -= 135
            
            viewModel.infoView?.setIsHidden(false, animated: true)
        }
    }

    // take care of the close event
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        viewModel.infoView?.removeFromSuperview()
    }
}
