//
//  MarkerInfoView.swift
//  mesaDesafio
//
//  Created by Rafael Douglas on 02/03/20.
//  Copyright © 2020 com.rafael.douglas. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
import MapKit

class MarkerInfoView: UIView {
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var placeAddress: UILabel!
    @IBOutlet weak var placePhone: UILabel!
    @IBOutlet weak var mapsBtn: UIButton!
    @IBOutlet weak var wazeBtn: UIButton!
    
    var latitude = CLLocationDegrees()
    var longitude = CLLocationDegrees()
    var name: String?
    
    @IBAction func mapsBtnAction(_ sender: Any) {
        let coordinates = CLLocationCoordinate2DMake(self.latitude, self.longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: 10000, longitudinalMeters: 10000)
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = self.name
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center)])

    }
    @IBAction func wazeBtnAction(_ sender: Any) {
        // Verifying if waze was intalled
        let appUrl = URL(string : "waze://?ll=\(self.latitude),\(self.longitude)")
        if UIApplication.shared.canOpenURL(appUrl!) {
            UIApplication.shared.open(appUrl!)
        } else {
        let url  = URL(string: "https://apps.apple.com/us/app/waze-navigation-live-traffic/id323229106")
            UIApplication.shared.open(url!)
        }
    }
}
