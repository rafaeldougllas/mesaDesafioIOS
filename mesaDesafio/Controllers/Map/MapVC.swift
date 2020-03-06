//
//  MapVC.swift
//  mesaDesafio
//
//  Created by Rafael Douglas on 28/02/20.
//  Copyright © 2020 com.rafael.douglas. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import GoogleMaps
import GooglePlaces
import SwiftyJSON
import MapKit

class MapVC: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    var viewModel = MapVM()

    override func viewDidLoad() {
        print("viewDidLoad")
        super.viewDidLoad()
        
        setupView()
        setupMap()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      guard let navigationController = segue.destination as? UINavigationController,
        let controller = navigationController.topViewController as? TypesTableVC else {
          return
      }
        controller.viewModel.selectedTypes = viewModel.selectedFilter
        controller.viewModel.delegate = self
    }
    
    func setupView(){
        print("setupView")
        //Set color on background
        let backgroundColor = Utils.hexStringToUIColor(hex: BACKGROUND_COLOR)
        self.view.backgroundColor = backgroundColor
        self.navigationController?.navigationBar.barTintColor = backgroundColor
        
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    func setupMap(){
        print("setupMap")
        // Location
        viewModel.locationManager.delegate = self
        viewModel.locationManager.requestAlwaysAuthorization()

        // Map
        mapView.delegate = self
    }
    @IBAction func refreshPlaces(_ sender: Any) {
        viewModel.getPlaces(mapView: mapView)
    }
    
}

