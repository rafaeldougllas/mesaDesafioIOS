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
    
    // Google Maps
    var locationManager = CLLocationManager()
    var currentLocation = CLLocation()
    @IBOutlet weak var mapView: GMSMapView!
    var placesClient = GMSPlacesClient.shared()
    var zoomLevel: Float = 15.0
    let nearbyRadiusMeters: Double = 1000

    // Profile picture variables
    let profilePic = GMSMarker()
    
    // Filter variables
//    @IBOutlet weak var filterButton: UIButton!
//    @IBOutlet weak var filterView: UIView!
//    @IBOutlet weak var filterTableView: UITableView!
    let filterOptions = ["Todos", "Aeroportos", "Restaurantes", "Baladas", "Supermercados", "Shopping centers"]
    var selectedFilter: String = "Todos"
    var places: [GooglePlace] = []
    var selectedPlace: GooglePlace?
    

    override func viewDidLoad() {
        print("viewDidLoad")
        super.viewDidLoad()
        
        setupView()
        
        setupMap()
        
        // Handle popup
//        self.mapTapGesture = UITapGestureRecognizer(target: self, action: #selector(tapMap(_:)))
//        self.mapTapGesture.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      guard let navigationController = segue.destination as? UINavigationController,
        let controller = navigationController.topViewController as? TypesTableVC else {
          return
      }
      controller.selectedTypes = selectedFilter
      controller.delegate = self
    }
    
    func setupView(){
        print("setupView")
        //Hiding back button
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        //Set color on background
        let backgroundColor = Utils.hexStringToUIColor(hex: COLOR_BACKGROUND)
        self.view.backgroundColor = backgroundColor
        self.navigationController?.navigationBar.barTintColor = backgroundColor
    }
    
    func setupMap(){
        print("setupMap")
        // Location
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()

        // Map
        self.mapView.delegate = self
    }
    
    func setProfileMarker(){
        print("setProfileMarker")
        self.profilePic.map = self.mapView
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

    func getPlaces() {
        print("getPlaces")
        if selectedFilter == "Todos" {
            DataProvider.shared.getPlaces(coordinate: currentLocation.coordinate, radius: nearbyRadiusMeters, types: filterOptions) { (placesArray) -> (Void) in
                self.mapView.clear()
                self.setProfileMarker()
                placesArray.forEach {
                    let marker = PlaceMarker(place: $0)
                    marker.map = self.mapView
                    $0.marker = marker
                }
                self.places = placesArray
            }
        } else {
            DataProvider.shared.getPlaces(coordinate: currentLocation.coordinate, radius: nearbyRadiusMeters, types: [selectedFilter]) { (placesArray) -> (Void) in
                self.mapView.clear()
                self.setProfileMarker()
                placesArray.forEach {
                    let marker = PlaceMarker(place: $0)
                    marker.map = self.mapView
                    $0.marker = marker
                }
                
                self.places = placesArray
            }
        }
    }
    
    func setPopupInfo(place: GooglePlace) {
        print("setPopupInfo")
//        self.selectedPlaceNameLabel.text = place.name
//        self.selectedPlaceAddressLabel.text = place.address
//        self.selectedPlacePhoneLabel.text = place.phone
        
        //TODO - PENSAR COMO COLOCAR EM CIMA DO LUGAR E APARECER CONTEUDO
//        let infoView = UINib(nibName: "MarkerInfoView", bundle: .main).instantiate(withOwner: nil, options: nil).first as! UIView as? MarkerInfoView
//        // let view = Bundle.main.loadNibNamed("CustomView", owner: nil, options: nil)!.first as! UIView // does the same as above
//        
//        
//        infoView?.placeName.text = place.name
//        infoView?.placeAddress.text = place.address
//        infoView?.placePhone.text = place.phone
//        
//        self.view.addSubview(infoView!)
        print(place.name)
    }
    
    func fetchUserProfilePicture(closure: @escaping ((UIImage) -> Void)) {
        print("fetchUserProfilePicture")
        var fetchedPicture = UIImage()
        let graphPath = "me"
        let parameters = ["fields":"id, email, picture.width(200).height(200)"]
        
//        let graphRequest = GraphRequest(graphPath: graphPath, parameters: parameters)
//
//        graphRequest.start(completionHandler: { (connection, result, error) in
//            if let error = error {
//                print(error.localizedDescription)
//            } else {
//                print("graphRequest.start")
//                let json = JSON(result!)
//
//                let urlString = json["picture"]["data"]["url"].stringValue
//                let url = NSURL(string: urlString)! as URL
//                if let imageData: NSData = NSData(contentsOf: url) {
//                    fetchedPicture = UIImage(data: imageData as Data)!
//                    closure(fetchedPicture)
//                }
//
//            }
//        })
        
        let connection = GraphRequestConnection()
        connection.add(GraphRequest(graphPath: "/me", parameters: parameters)) { httpResponse, result, error   in
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
    
    
    @objc func showLocationInMaps(){
        print("maps")
        let coordinates = CLLocationCoordinate2DMake((self.selectedPlace?.coordinate.latitude)!, (self.selectedPlace?.coordinate.longitude)!)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: 10000, longitudinalMeters: 10000)
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center)])
    }
}

/// Delegate is used to handle buttons action in MarkerInfoViewDelegate
extension MapVC: MarkerInfoViewDelegate {
    func mapsBtnPressed() {
        print("maps")
        print(selectedPlace?.coordinate.latitude)
    }
    func wazeBtnPressed() {
        print("waze")
        print(selectedPlace?.coordinate.latitude)
    }
}
