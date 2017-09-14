//
//  EventLocationViewController.swift
//  Hier
//
//  Created by Yang Zhao on 9/3/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import UIKit
import MapKit


protocol HandleMapSearch {
    var selectedPlacemark: MKPlacemark? { get set }
    func dropPinZoomIn(placemark: MKPlacemark)
}

class EventLocationViewController: UIViewController, UISearchBarDelegate, MKMapViewDelegate, CLLocationManagerDelegate, HandleMapSearch {
    
    // MARK: - Outlets
    
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.delegate = self
        }
    }
    
    // MARK: - Actions
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        view.endEditing(true)
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Properties
    
    let locationManager = CLLocationManager()
    
    var resultSearchController: UISearchController!
    
    var selectedPlacemark: MKPlacemark?
    
    // MARK: - Location manager delegate methods
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            mapViewZoomIn(coordinate: location.coordinate)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("\(error)")
    }
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Location manager set up
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // Search controller set up
        if let locationSearchTable = storyboard?.instantiateViewController(withIdentifier: "locationSearchTableViewController") as? LocationSearchTableViewController {
            resultSearchController = UISearchController(searchResultsController: locationSearchTable)
            resultSearchController.searchResultsUpdater = locationSearchTable
            
            // Search bar set up
            let searchBar = resultSearchController.searchBar
            searchBar.sizeToFit()
            searchBar.placeholder = "Places"
            searchBar.tintColor = Constants.LightGreen
            navigationItem.titleView = searchBar
            
            resultSearchController.hidesNavigationBarDuringPresentation = false
            resultSearchController.dimsBackgroundDuringPresentation = true
            definesPresentationContext = true
            
            locationSearchTable.mapView = mapView
            locationSearchTable.handleMapSearchDelegate = self
        }
        
        if let placemark = selectedPlacemark {
            dropPinZoomIn(placemark: placemark)
        }
    }
    
    // MARK: - Custom methods
    
    func dropPinZoomIn(placemark: MKPlacemark) {
        resultSearchController.searchBar.text = placemark.name
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        mapView.addAnnotation(annotation)
        mapViewZoomIn(coordinate: placemark.coordinate)
    }
    
    private func mapViewZoomIn(coordinate: CLLocationCoordinate2D) {
        let span = MKCoordinateSpanMake(Constants.MapZoomInLatitudeRange, Constants.MapZoomInLongtudeRange)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
}
