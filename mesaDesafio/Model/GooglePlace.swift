//
//  GooglePlace.swift
//  mesaDesafio
//
//  Created by Rafael Douglas on 01/03/20.
//  Copyright © 2020 com.rafael.douglas. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreLocation
import GoogleMaps

class GooglePlace {
    let name: String
    let address: String
    let phone: String
    let coordinate: CLLocationCoordinate2D
    var marker: PlaceMarker?
    
    init(dictionary: [String: Any])
    {
        let json = JSON(dictionary)
        name = json["name"].stringValue
        address = json["vicinity"].stringValue
        phone = json["formatted_phone_number"].stringValue
        
        let lat = json["geometry"]["location"]["lat"].doubleValue as CLLocationDegrees
        let lng = json["geometry"]["location"]["lng"].doubleValue as CLLocationDegrees
        coordinate = CLLocationCoordinate2DMake(lat, lng)
        
        
    }
}
