//
//  ViewController.swift
//  MealsOnWheels
//
//  Created by Akhilesh on 12/16/15.
//  Copyright (c) 2015 Akhilesh. All rights reserved.
//

import UIKit
import AVFoundation
import GoogleMaps

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var directionView: UILabel!
    @IBOutlet weak var lblInfo: UITextView!
    @IBOutlet weak var viewMap: GMSMapView!
    var locationManager = CLLocationManager()
    var didFindMyLocation = false
    var locationMarker: GMSMarker!
    var originMarker: GMSMarker!
    var destinationMarker: GMSMarker!
    var routePolyline: GMSPolyline!
    var mapTasks = MapTasks()
    var stuffOnMap = Array<AnyObject>()
    var checkPointNum = 0
    var checkpointDist: Double = 0
    var currentStep: GMSCircle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        viewMap.addObserver(self, forKeyPath: "myLocation", options: NSKeyValueObservingOptions.New, context: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            viewMap.myLocationEnabled = true
        }
    }
    
    
//    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
//        var step = MapTasks.steps[0]
//        let check = newLocation.distanceFromLocation(step.location)
//        if(check < checkpointDist) {
//            switch (checkPointNum) {
//            case 3:
//                checkpointDist = step.distance * 0.25
//                checkPointNum -= 1
//            case 2:
//                checkpointDist = step.distance * 0.1
//                checkPointNum -= 1
//            case 1:
//                step = MapTasks.steps.removeAtIndex(0)
//                checkpointDist = step.distance * 0.9
//                checkPointNum = 3
//            default:
//                checkpointDist = step.distance * 0.9
//                checkPointNum = 3
//            }
//        }
//    }
//    
//    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
//        print("hello")
//        locationManager.stopMonitoringForRegion(region)
//        if checkPointNum == 0 {
//            let step = MapTasks.steps[0]
//            let speech = step.direction
//            let utterance = AVSpeechUtterance(string: speech)
//            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
//            let synthesizer = AVSpeechSynthesizer()
//            synthesizer.speakUtterance(utterance)
//            locationManager.startMonitoringForRegion(CLCircularRegion(center: step.location, radius: step.distance * 0.25, identifier: "checkpoint one"))
//            checkPointNum += 1
//        } else if checkPointNum == 1 {
//            let step = MapTasks.steps[0]
//            let speech = step.direction
//            let utterance = AVSpeechUtterance(string: speech)
//            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
//            let synthesizer = AVSpeechSynthesizer()
//            synthesizer.speakUtterance(utterance)
//            checkPointNum += 1
//            locationManager.startMonitoringForRegion(CLCircularRegion(center: step.location, radius: step.distance * 0.1 , identifier: "checkpoint two"))
//        } else {
//            
//            let speech = MapTasks.steps.removeAtIndex(0).direction
//            let step = MapTasks.steps[0]
//            let utterance = AVSpeechUtterance(string: speech)
//            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
//            let synthesizer = AVSpeechSynthesizer()
//            synthesizer.speakUtterance(utterance)
//            locationManager.startMonitoringForRegion(CLCircularRegion(center: step.location, radius: step.distance * 0.8 , identifier: "checkpoint three"))
//            checkPointNum  = 0
//        }
//    }
    
    override func viewWillAppear(animated: Bool) {
        if MapTasks.originCoordinate != nil {
            self.clearMap()
            self.configureMapAndMarkersForRoute()
            self.drawRoute()
            self.displayRouteInfo()
            self.setZoom()
            let step = MapTasks.steps[0]
            let speech = step.direction
            let utterance = AVSpeechUtterance(string: speech)
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
            let synthesizer = AVSpeechSynthesizer()
            synthesizer.speakUtterance(utterance)
            locationManager.startUpdatingLocation()
            self.checkpointDist = step.distance * 0.9
            let attrStr = try! NSMutableAttributedString(data: step.direction.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
            attrStr.addAttribute(NSFontAttributeName, value: UIFont(name: "Georgia", size: 20.0)!, range: NSRange(location: 0, length: attrStr.length))
            directionView.attributedText = attrStr
            
            
            print(step.location)
//            let region = CLCircularRegion(center: step.location, radius: step.distance * 1, identifier: "checkpoint one")
//            locationManager.startMonitoringForRegion(region)
//            checkPointNum = 1

        }
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String:AnyObject]!, context: UnsafeMutablePointer<Void>) {
        
        if !didFindMyLocation {
            
            let myLocation: CLLocation = change[NSKeyValueChangeNewKey] as! CLLocation
            viewMap.camera = GMSCameraPosition.cameraWithTarget(myLocation.coordinate, zoom: 10.0)
            viewMap.settings.myLocationButton = true
            
            didFindMyLocation = true // Change top variable to true
            
        }
    }
    
    
    @IBAction func nextButton(sender: AnyObject) {
        if(MapTasks.steps.count == 0) {
            return
        }
        let prevStep = MapTasks.steps.removeFirst()
        let step = MapTasks.steps[0]
        let attrStr = try! NSMutableAttributedString(data: step.direction.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
        attrStr.addAttribute(NSFontAttributeName, value: UIFont(name: "Georgia", size: 20.0)!, range: NSRange(location: 0, length: attrStr.length))
        directionView.attributedText = attrStr
        let bounds = GMSCoordinateBounds(coordinate: step.location.coordinate, coordinate: prevStep.location.coordinate)
        if currentStep != nil {
            currentStep.map = nil
        }
        currentStep = GMSCircle(position: step.location.coordinate, radius: CLLocationDistance(step.distance * 0.1))
        currentStep.map = viewMap
        currentStep.fillColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.2)
        stuffOnMap.append(currentStep)
        viewMap.moveCamera(GMSCameraUpdate.fitBounds(bounds))
        drawRoute()
        
        

        
    }
    
    
    func setupLocationMarker(coordinate: CLLocationCoordinate2D) {
        locationMarker = GMSMarker(position: coordinate)
        stuffOnMap.append(locationMarker)
        locationMarker.map = viewMap
        locationMarker.title = mapTasks.fetchedFormattedAddress
        locationMarker.appearAnimation = kGMSMarkerAnimationPop
        locationMarker.icon = GMSMarker.markerImageWithColor(UIColor.blueColor())
        locationMarker.opacity = 0.75
    }
    
    func clearMap() {
        for stuff in stuffOnMap {
            if let overlayStuff = stuff as? GMSOverlay{
                overlayStuff.map = nil
            }
        }
    }
    
    func setZoom() {
        let route = MapTasks.overviewPolyline["points"] as! String
        let path: GMSPath = GMSPath(fromEncodedPath: route)
        let bounds = GMSCoordinateBounds(path: path)
        viewMap.moveCamera(GMSCameraUpdate.fitBounds(bounds))
        print("zoom")

    }
    
    @IBAction func createRoute(sender: AnyObject) {
        let addressAlert = UIAlertController(title: "Create Route", message: "connect locations with a route", preferredStyle: UIAlertControllerStyle.Alert)
        addressAlert.addTextFieldWithConfigurationHandler {(textField) -> Void in
            textField.placeholder = "Origin"
        }
        addressAlert.addTextFieldWithConfigurationHandler {(textField) -> Void in
            textField.placeholder = "Destination"
        }
        let createRouteAction = UIAlertAction(title: "Create Route", style: UIAlertActionStyle.Default, handler: {(alertAction) -> Void in
            let origin = addressAlert.textFields![0].text
            let destination = addressAlert.textFields![1].text
            
            MapTasks.getDirections(origin, destination: destination, waypoints: nil, travelMode: nil, completionHandler: { (status, success) -> Void in
                if success {
                    self.clearMap()
                    self.configureMapAndMarkersForRoute()
                    self.drawRoute()
                    self.displayRouteInfo()
                    self.setZoom()
                } else {
                    print(status)
                }
            })
        })
        let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler: {(AlertAction) -> Void in
            
        })
        addressAlert.addAction(createRouteAction)
        addressAlert.addAction(closeAction)
        
        presentViewController(addressAlert, animated: true, completion: nil)
        
    }
    
    func configureMapAndMarkersForRoute() {
        
        viewMap.camera = GMSCameraPosition.cameraWithTarget(MapTasks.originCoordinate, zoom: 9.0)
        
        originMarker = GMSMarker(position: MapTasks.originCoordinate)
        stuffOnMap.append(originMarker)
        originMarker.map = self.viewMap
        originMarker.icon = GMSMarker.markerImageWithColor(UIColor.greenColor())
        originMarker.title = MapTasks.originAddress
        
        destinationMarker = GMSMarker(position: MapTasks.destinationCoordinate)
        stuffOnMap.append(destinationMarker)
        destinationMarker.map = self.viewMap
        destinationMarker.icon = GMSMarker.markerImageWithColor(UIColor.redColor())
        destinationMarker.title = MapTasks.destinationAddress
        
        
        
    }
    
    func drawRoute() {
        let route = MapTasks.overviewPolyline["points"] as! String
        let path: GMSPath = GMSPath(fromEncodedPath: route)
        routePolyline = GMSPolyline(path: path)
        stuffOnMap.append(routePolyline)
        routePolyline.strokeWidth = 3
        routePolyline.geodesic = true
        routePolyline.map = viewMap
        
    }
    
    func displayRouteInfo() {
        lblInfo.text = MapTasks.totalDistance + "\n" + MapTasks.totalDuration
    }
}

