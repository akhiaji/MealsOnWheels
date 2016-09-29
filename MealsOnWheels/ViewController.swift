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
import Firebase
import SAConfettiView
import KCFloatingActionButton


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
    var backSteps = Array<Step>()
    var stepNum = 0
    let fab = KCFloatingActionButton
    var curentLocation:CLLocation? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        viewMap.addObserver(self, forKeyPath: "myLocation", options: NSKeyValueObservingOptions.new, context: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            viewMap.isMyLocationEnabled = true
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
            self.curentLocation = newLocation
    }
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
    
    override func viewWillAppear(_ animated: Bool) {
        if MapTasks.originCoordinate != nil {
//            if (fab.items.count > 0) {
//                let item = KCFloatingActionButtonItem()
//                item.buttonColor = UIColor.blueColor()
//                item.title = "Add to End"
//                item.handler = {x in MapTasks.sendToEnd()}
//                fab.addItem(item: item)
//            }
            self.viewMap.addSubview(fab)
            self.clearMap()
            self.configureMapAndMarkersForRoute()
            self.drawRoute()
            self.displayRouteInfo()
            self.setZoom()
            if MapTasks.steps.count > 0 {
                let step = MapTasks.steps[0]
//                let speech = step.direction
//                let utterance = AVSpeechUtterance(string: speech)
//                utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
//                let synthesizer = AVSpeechSynthesizer()
//                synthesizer.speakUtterance(utterance)
                locationManager.startUpdatingLocation()
                self.checkpointDist = step.distance * 0.9
                let attrStr = try! NSMutableAttributedString(data: step.direction.data(using: String.Encoding.unicode, allowLossyConversion: true)!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
                attrStr.addAttribute(NSFontAttributeName, value: UIFont(name: "Georgia", size: 20.0)!, range: NSRange(location: 0, length: attrStr.length))
                directionView.attributedText = attrStr
                drawRoute()
                
                
                print(step.location)
                //            let region = CLCircularRegion(center: step.location, radius: step.distance * 1, identifier: "checkpoint one")
                //            locationManager.startMonitoringForRegion(region)
                //            checkPointNum = 1
            }
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey:Any]!, context: UnsafeMutableRawPointer?) {
        
        if !didFindMyLocation {
            
            let myLocation: CLLocation = change[NSKeyValueChangeKey.newKey] as! CLLocation
            viewMap.camera = GMSCameraPosition.camera(withTarget: myLocation.coordinate, zoom: 10.0)
            viewMap.settings.myLocationButton = true
            
            didFindMyLocation = true // Change top variable to true
            
        }
    }
    
    
    @IBAction func nextButton(_ sender: AnyObject) {
        if(MapTasks.steps.count == stepNum - 1) {
            return
        }
        self.stepNum += 1
        let step = MapTasks.steps[self.stepNum]
        let attrStr = try! NSMutableAttributedString(data: step.direction.data(using: String.Encoding.unicode, allowLossyConversion: true)!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
        attrStr.addAttribute(NSFontAttributeName, value: UIFont(name: "Georgia", size: 20.0)!, range: NSRange(location: 0, length: attrStr.length))
        directionView.attributedText = attrStr
        if currentStep != nil {
            currentStep.map = nil
        }
        currentStep = GMSCircle(position: MapTasks.steps[self.stepNum - 1].location.coordinate, radius: CLLocationDistance(step.distance * 0.1))
        if step.waypoint {
            if MapTasks.waypointsArray.count != 0 {
                let waypoint = MapTasks.waypointsArray.removeFirst() as Waypoint
                var infoString = "Address: "
                infoString += waypoint.address
                infoString += " Phone: "
                infoString += waypoint.phoneNumber
                infoString += "\n"
                infoString += "Details: "
                infoString += waypoint.info
                
                let titleString = "Destination Reached \n" + waypoint.title
                let waypointAlert = UIAlertController(title: titleString, message: infoString, preferredStyle: UIAlertControllerStyle.alert)
                let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.cancel, handler: {(AlertAction) -> Void in
                    
                })
                let addToEnd = UIAlertAction(title: "Add to End", style: UIAlertActionStyle.default, handler: {(AlertAction) -> Void in
                    let geocoder = CLGeocoder()
                    geocoder.reverseGeocodeLocation(self.curentLocation!, completionHandler: {(placeMarks,error) -> Void in
                        print(placeMarks![0].addressDictionary)
                    })
                    MapTasks.sendToEnd(waypoint, completionHandler: {(status, success ) -> Void in
                        if success {
                            self.clearMap()
                            self.configureMapAndMarkersForRoute()
                            self.drawRoute()
                            self.displayRouteInfo()
                            self.setZoom()
                            if MapTasks.steps.count > 0 {
                                let step = MapTasks.steps[0]
                                //                let speech = step.direction
                                //                let utterance = AVSpeechUtterance(string: speech)
                                //                utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
                                //                let synthesizer = AVSpeechSynthesizer()
                                //                synthesizer.speakUtterance(utterance)
                                self.locationManager.startUpdatingLocation()
                                self.checkpointDist = step.distance * 0.9
                                let attrStr = try! NSMutableAttributedString(data: step.direction.data(using: String.Encoding.unicode, allowLossyConversion: true)!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
                                attrStr.addAttribute(NSFontAttributeName, value: UIFont(name: "Georgia", size: 20.0)!, range: NSRange(location: 0, length: attrStr.length))
                                self.directionView.attributedText = attrStr
                                self.drawRoute()
                            }
                        }
                    })
                })
                waypointAlert.addAction(closeAction)
                waypointAlert.addAction(addToEnd)
                present(waypointAlert, animated: true, completion: nil)
            } else {
                let confettiView = SAConfettiView(frame: self.view.bounds)
                self.view.addSubview(confettiView)
                confettiView.startConfetti()
                let waypointAlert = UIAlertController(title: "Finished Route", message: "", preferredStyle: UIAlertControllerStyle.alert)
                let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.cancel, handler: {(AlertAction) -> Void in
                    confettiView.stopConfetti()
                })
                waypointAlert.addAction(closeAction)
                present(waypointAlert, animated: true, completion: nil)
                
                
            }
            
        }
        currentStep.map = viewMap
        currentStep.fillColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.2)
        stuffOnMap.append(currentStep)
        let bounds = GMSCoordinateBounds(path: step.path)
        viewMap.moveCamera(GMSCameraUpdate.fit(bounds))
    }
    
    
    @IBAction func backButton(_ sender: AnyObject) {
        if(backSteps.count == 1) {
            return
        }
        stepNum -= 1
        let step = MapTasks.steps[stepNum]
        let attrStr = try! NSMutableAttributedString(data: step.direction.data(using: String.Encoding.unicode, allowLossyConversion: true)!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
        attrStr.addAttribute(NSFontAttributeName, value: UIFont(name: "Georgia", size: 20.0)!, range: NSRange(location: 0, length: attrStr.length))
        directionView.attributedText = attrStr
        if currentStep != nil {
            currentStep.map = nil
        }
        if stepNum != 0 {
            currentStep = GMSCircle(position: MapTasks.steps[stepNum - 1].location.coordinate, radius: CLLocationDistance(step.distance * 0.1))
            currentStep.map = viewMap
            currentStep.fillColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.2)
            stuffOnMap.append(currentStep)
        }
        let bounds = GMSCoordinateBounds(path: step.path)
        viewMap.moveCamera(GMSCameraUpdate.fit(bounds))
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
        let path: GMSPath = GMSPath(fromEncodedPath: route)!
        let bounds = GMSCoordinateBounds(path: path)
        viewMap.moveCamera(GMSCameraUpdate.fit(bounds))
        print("zoom")

    }
    
    @IBAction func createRoute(_ sender: AnyObject) {
        let addressAlert = UIAlertController(title: "Create Route", message: "connect locations with a route", preferredStyle: UIAlertControllerStyle.alert)
        addressAlert.addTextField {(textField) -> Void in
            textField.placeholder = "Origin"
        }
        addressAlert.addTextField {(textField) -> Void in
            textField.placeholder = "Destination"
        }
        let createRouteAction = UIAlertAction(title: "Create Route", style: UIAlertActionStyle.default, handler: {(alertAction) -> Void in
            let origin = addressAlert.textFields![0].text
            let destination = addressAlert.textFields![1].text
            
            MapTasks.getDirections(origin, destination: destination, waypointsTemp: nil, travelMode: nil, completionHandler: { (status, success) -> Void in
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
        let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.cancel, handler: {(AlertAction) -> Void in
            
        })
        addressAlert.addAction(createRouteAction)
        addressAlert.addAction(closeAction)
        
        present(addressAlert, animated: true, completion: nil)
        
    }
    
    func configureMapAndMarkersForRoute() {
        
        viewMap.camera = GMSCameraPosition.camera(withTarget: MapTasks.originCoordinate, zoom: 9.0)
        
        originMarker = GMSMarker(position: MapTasks.originCoordinate)
        stuffOnMap.append(originMarker)
        originMarker.map = self.viewMap
        originMarker.icon = GMSMarker.markerImage(with: UIColor.green)
        originMarker.title = MapTasks.originAddress
        
        destinationMarker = GMSMarker(position: MapTasks.destinationCoordinate)
        stuffOnMap.append(destinationMarker)
        destinationMarker.map = self.viewMap
        destinationMarker.icon = GMSMarker.markerImage(with: UIColor.red)
        destinationMarker.title = MapTasks.destinationAddress
        
        
        
    }
    
    func drawRoute() {
        for i in MapTasks.steps {
            let pathLine = GMSPolyline(path: i.path)
            pathLine.map = viewMap
            stuffOnMap.append(pathLine)
            pathLine.strokeWidth = 3
        }
    }
    
    func displayRouteInfo() {
        lblInfo.text = MapTasks.totalDistance + "\n" + MapTasks.totalDuration
    }
}

