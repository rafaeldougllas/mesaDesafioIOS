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

protocol MarkerInfoViewDelegate: class {
    func mapsBtnPressed()
    func wazeBtnPressed()
}
class MarkerInfoView: UIView {
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var placeAddress: UILabel!
    @IBOutlet weak var placePhone: UILabel!
    
    @IBOutlet weak var mapsBtn: UIButton!
    @IBOutlet weak var wazeBtn: UIButton!
    
    /// To handle mapsbutton and wazebutton action using delegation
    weak var delegage: MarkerInfoViewDelegate?
    /// To handle backbutton action using closure
    var mapsBtnPressed: (() -> Void)?
    var wazeBtnPressed: (() -> Void)?
    
    var latitude = CLLocationDegrees()
    var longitude = CLLocationDegrees()
    
    
    @IBAction func mapsBtnAction(_ sender: Any) {
        if let _mapsButtonPressed = mapsBtnPressed {
            _mapsButtonPressed()
        } else {
            delegage?.mapsBtnPressed()
        }
    }
    @IBAction func wazeBtnAction(_ sender: Any) {
        if let _wazeBtnPressed = wazeBtnPressed {
            _wazeBtnPressed()
        } else {
            delegage?.wazeBtnPressed()
        }
    }
    
    
    
    func testeMaps(){
        print("MAPS")
        let coordinates = CLLocationCoordinate2DMake(self.latitude, self.longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: 10000, longitudinalMeters: 10000)
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center)])
    }
    
    
}
