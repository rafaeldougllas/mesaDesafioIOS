//
//  DataProvider.swift
//  mesaDesafio
//
//  Created by Rafael Douglas on 01/03/20.
//  Copyright © 2020 com.rafael.douglas. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation
import SwiftyJSON

class DataProvider {
    
    static let shared = DataProvider()
    
    /// Gets the places nearby
    func getPlaces(coordinate: CLLocationCoordinate2D, radius: Double, types: [String], closure: @escaping (([GooglePlace]) -> (Void))){
        print("DataProvider - getPlaces")
        var typesConverted: [String] = []

        let URL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
        
        for type in types {
            
            switch type {
            case "Aeroportos":
                typesConverted.append("airport")
            case "Restaurantes":
                typesConverted.append("restaurant")
            case "Baladas":
                typesConverted.append("bar")
            case "Supermercados":
                typesConverted.append("grocery_or_supermarket")
            case "Shopping centers":
                typesConverted.append("shopping_mall")
            default:
                typesConverted.append("")
            }
            
        }
    
        
        let typesString = typesConverted.joined(separator: "|")

        let parameters = ["location":"\(coordinate.latitude),\(coordinate.longitude)", "radius":"\(radius)", "key":GOOGLE_MAPS_APIKEY, "types":typesString]
        
        var placesArray: [GooglePlace] = []
        
        Alamofire.request(URL, method: .get, parameters: parameters).responseJSON { response in
            switch response.result {
            case .failure:
                print("Error")
                break
            case .success:
                print("Success!")
//                print(response.value)
                
                let json = JSON(response.result.value!)
                let results = json["results"].arrayObject as! [[String: Any]]
                
                results.forEach {
                    let place = GooglePlace(dictionary: $0)
                    placesArray.append(place)
                    print(place.name)
                }
                
                print(placesArray)
                closure(placesArray)
            }
        }
    }
}