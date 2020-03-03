//
//  PlaceMarker.swift
//  mesaDesafio
//
//  Created by Rafael Douglas on 01/03/20.
//  Copyright © 2020 com.rafael.douglas. All rights reserved.
//

import UIKit
import GoogleMaps

class PlaceMarker: GMSMarker {
  let place: GooglePlace
  
  init(place: GooglePlace) {
    self.place = place
    super.init()
    
    position = place.coordinate
    groundAnchor = CGPoint(x: 0.5, y: 1)
    appearAnimation = .pop
  }
}
