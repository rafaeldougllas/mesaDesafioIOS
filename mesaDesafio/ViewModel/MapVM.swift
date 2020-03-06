//
//  MapVM.swift
//  mesaDesafio
//
//  Created by Rafael Douglas on 05/03/20.
//  Copyright © 2020 com.rafael.douglas. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import GoogleMaps
import GooglePlaces
import SwiftyJSON
import MapKit

class MapVM{
    // Google Maps
    var locationManager = CLLocationManager()
    var currentLocation = CLLocation()
    var placesClient = GMSPlacesClient.shared()
    var zoomLevel: Float = 15.0
    let nearbyRadiusMeters: Double = 1000
    var infoView:MarkerInfoView?

    // Profile picture variables
    let profilePic = GMSMarker()
    
    // Filter variables
    let filterOptions = ["Todos", "Aeroportos", "Restaurantes", "Baladas", "Supermercados", "Shopping centers"]
    var selectedFilter: String = "Todos"
    var places: [GooglePlace] = []
    var selectedPlace: GooglePlace?
    
    func setProfileMarker(mapView: GMSMapView){
        print("setProfileMarker")
        profilePic.map = mapView
        fetchUserProfilePicture { (img) in
            let roundImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            roundImage.image = img
            roundImage.layer.cornerRadius = 25
            roundImage.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            roundImage.layer.borderWidth = 4
            roundImage.clipsToBounds = true
            roundImage.backgroundColor = UIColor.clear
            
            self.profilePic.iconView = roundImage
        }
    }

    func getPlaces(mapView: GMSMapView) {
        print("getPlaces")
        if selectedFilter == "Todos" {
            DataProvider.shared.getPlaces(coordinate: currentLocation.coordinate, radius: nearbyRadiusMeters, types: filterOptions) { (placesArray) -> (Void) in
                mapView.clear()
                self.setProfileMarker(mapView: mapView)
                placesArray.forEach {
                    let marker = PlaceMarker(place: $0)
                    marker.map = mapView
                    $0.marker = marker
                }
                self.places = placesArray
            }
        } else {
            DataProvider.shared.getPlaces(coordinate: currentLocation.coordinate, radius: nearbyRadiusMeters, types: [selectedFilter]) { (placesArray) -> (Void) in
                mapView.clear()
                self.setProfileMarker(mapView: mapView)
                placesArray.forEach {
                    let marker = PlaceMarker(place: $0)
                    marker.map = mapView
                    $0.marker = marker
                }
                
                self.places = placesArray
            }
        }
    }
    
    func fetchUserProfilePicture(closure: @escaping ((UIImage) -> Void)) {
        print("fetchUserProfilePicture")
        var fetchedPicture = UIImage()
        let graphPath = "/me"
        let parameters = ["fields":"id, email, picture.width(200).height(200)"]
        
        let connection = GraphRequestConnection()
        connection.add(GraphRequest(graphPath: graphPath, parameters: parameters)) { httpResponse, result, error   in
            if error != nil {
                NSLog(error.debugDescription)
                return
            }else{
                let json = JSON(result!)

                let urlString = json["picture"]["data"]["url"].stringValue
                let url = NSURL(string: urlString)! as URL
                if let imageData: NSData = NSData(contentsOf: url) {
                    fetchedPicture = UIImage(data: imageData as Data)!
                    closure(fetchedPicture)
                }
            }
        }
        connection.start()
    }
}
