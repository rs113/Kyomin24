//
//  AddressViewController.swift
//  Mzadi
//
//  Created by Emizentech on 06/08/21.
//

import UIKit
import MapKit
import GooglePlaces
import SDWebImage
import GoogleMaps
import CoreLocation

class AddressViewController: UIViewController {
    
    @IBOutlet weak var Btnback: UIButton!
    @IBOutlet weak var lblcurrentlocationtext: UILabel!
    @IBOutlet weak var lblcurrentlocation: UILabel!
    @IBOutlet weak var lbladdress: UILabel!
    @IBOutlet weak var mapViewGoogle: GMSMapView!
    
    var resultsViewController: GMSAutocompleteResultsViewController?
    let marker = GMSMarker()
    
    var callBack: ((_ storeloc: String,_ lat:Double,_ long:Double)-> Void)?
    var Lati=Double()
    var Long=Double()
    var mapMove = true
    
    var index = Int()
    var bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        // lblcurrentlocation.text="Current Location"
        
        LocationManager.sharedInstance.delegate = self
        LocationManager.sharedInstance.startUpdatingLocation()
        self.mapViewGoogle.settings.myLocationButton = true
        self.mapViewGoogle.settings.compassButton = true
        self.mapViewGoogle.isMyLocationEnabled = true
        self.mapViewGoogle.settings.allowScrollGesturesDuringRotateOrZoom = false
        
        self.mapViewGoogle.isIndoorEnabled = true
        self.mapViewGoogle.isBuildingsEnabled = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(saveAddressAndSHowImageMap(noti:)), name: NSNotification.Name("AddressSave"), object: nil)
        
        do {
            // Set the map style by passing the URL of the local file.
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                mapViewGoogle.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        
        mapViewGoogle.delegate = self
        setMarkerData()
        
        if obj.prefs.value(forKey:HOME_ADDRESS) as? String == nil{
            lblcurrentlocation.text = "Add Location"
        }else{
            lblcurrentlocation.text = obj.prefs.value(forKey:HOME_ADDRESS) as? String
        }
        
        
    }
    
    
    @IBAction func Btnback(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
    }
    @IBAction func Btncrossaction(_ sender: Any) {
        lbladdress.text = ""
        lblcurrentlocation.text=""
    }
    
    func setMarkerData(){
        let camera = GMSCameraPosition.camera(withLatitude: CURRENT_CORDINATE?.latitude ?? 0, longitude: CURRENT_CORDINATE?.longitude ?? 0, zoom: 12.0)
        
        let markerImage = UIImage(named: "pinred")
        
        //creating a marker view
        
        
        //                   let imgv =  UIImageView(image: markerImage)
        //                   let imgv2 =  UIImageView(frame: CGRect(x: 7, y: 5, width: 40, height: 40))
        //                   imgv2.layer.cornerRadius = 20
        //                   imgv2.clipsToBounds = true
        //                  imgv2.backgroundColor = .red
        //                   imgv2.sd_setImage(with: URL(string: obj.prefs.value(forKey: APP_User_IMAGE) as? String ?? ""), placeholderImage: UIImage(named: "placeholderImage"))
        //                   imgv.addSubview(imgv2)
        //                   let markerView = imgv
        
        //changing the tint color of the image
        // markerView.tintColor = UIColor.red
        
        marker.position = CLLocationCoordinate2D(latitude: CURRENT_CORDINATE?.latitude ?? 0, longitude: CURRENT_CORDINATE?.longitude ?? 0)
        marker.icon = markerImage
        //                   marker.title = "I Am here"
        // marker.snippet = "India"
        marker.map = mapViewGoogle
        
        
        //comment this line if you don't wish to put a callout bubble
        mapViewGoogle.selectedMarker = marker
        
        mapViewGoogle.camera = camera
    }
    @IBAction func Btnsearchlocation(_ sender: Any) {
        LocationManager.sharedInstance.stopUpdatingLocation()
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        // Specify the place data types to return.
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.all.rawValue) |
            UInt(GMSPlaceField.placeID.rawValue))
        autocompleteController.placeFields = fields
        
        // Specify a filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .address
        autocompleteController.autocompleteFilter = filter
        
        // Display the autocomplete view controller.
        
        present(autocompleteController, animated: true, completion: nil)
        
    }
    
    
    
    
    @IBAction func Btncontinue(_ sender: Any) {
        
        //        self.callBack?(self.lbladdress.text ?? "",Lati,Long)
        //        print(Lati)
        //        print(Long)
        //        print(lbladdress.text ?? "")
        //
        //        self.navigationController?.popViewController(animated: true)
        if bool == true {
            var boolean=true
            let data: [String:Any] = ["SelectedValue": lbladdress.text!, "Index": index,"lati": Lati,"long":Long,"booleanvalue":boolean]
            self.navigationController?.popViewController(animated: true)
            NotificationCenter.default.post(name: Notification.Name("LOCATION"), object: nil, userInfo: data)
            
        } else {
            self.callBack?(self.lbladdress.text ?? "",Lati,Long)
            print(Lati)
            print(Long)
            print(lbladdress.text ?? "")
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    
    
    @objc func saveAddressAndSHowImageMap(noti:NSNotification){
        let dictRes = noti.userInfo! as NSDictionary
        let adr = dictRes["adr"]
        let lat = dictRes["lat"]
        let long = dictRes["long"]
        lbladdress.text = adr as? String
        lblcurrentlocation.text = adr as? String
        Lati=dictRes["lat"] as! Double
        Long=dictRes["long"] as! Double
        LocationManager.sharedInstance.stopUpdatingLocation()
        
    }
    
    
    
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)") ?? 0.0
        //21.228124
        let lon: Double = Double("\(pdblLongitude)") ?? 0.0
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        let geoG:GMSGeocoder = GMSGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                
                // geoG.reverseGeocodeCoordinate(loc.coordinate) { (placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]
                //let pm = placemarks
                
                //                    let comAdr = placemarks?.first.lin
                //                    let comAdr =  placemarks?.firstResult()?.lines?.first
                if pm.count > 0 {
                    // if pm?.count ?? 0 > 0 {
                    //let pm = placemarks?[0]
                    let pm = placemarks![0]
                    var addressString : String = ""
                    //                  if pm?.subLocality != nil {
                    //                      addressString = addressString + (pm?.subLocality ?? "") + ", "
                    //                  }
                    //                  if pm?.thoroughfare != nil {
                    //                      addressString = addressString + (pm?.thoroughfare ?? "") + ", "
                    //                  }
                    //                  if pm?.locality != nil {
                    //                      addressString = addressString + (pm?.locality ?? "") + ", "
                    //                  }
                    //                  if pm?.country != nil {
                    //                      addressString = addressString + (pm?.country ?? "") + ", "
                    //                  }
                    //                  if pm?.postalCode != nil {
                    //                      addressString = addressString + (pm?.postalCode ?? "") + " "
                    //                  }
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                    
                    
                    print(addressString)
                    
                    print(addressString)
                    
                    
                    self.lbladdress.text = addressString
                    self.lblcurrentlocation.text = addressString
                    LocationManager.sharedInstance.stopUpdatingLocation()
                    
                    
                }
                //}
        })
        
        
    }
    
    
    
    
    
}

extension AddressViewController:LocationManagerDelegate{
    func tracingLocation(currentLocation: CLLocation) {
        CURRENT_LAT = "\(currentLocation.coordinate.latitude)"
        CURRENT_LONG = "\(currentLocation.coordinate.longitude)"
        CURRENT_CORDINATE = currentLocation.coordinate
        SELECTED_CORDINATE = currentLocation.coordinate
        
        Lati=currentLocation.coordinate.latitude
        Long=currentLocation.coordinate.longitude
        
        //        self.mapViewGoogle.clear()
        let camera = GMSCameraPosition.camera(withLatitude: CURRENT_CORDINATE?.latitude ?? 0, longitude: CURRENT_CORDINATE?.longitude ?? 0, zoom: 15.0)
        //        let markerImage = UIImage(named: "pinMap")
        //        let markerView = UIImageView(image: markerImage)
        marker.position = CLLocationCoordinate2D(latitude: CURRENT_CORDINATE?.latitude ?? 0, longitude: CURRENT_CORDINATE?.longitude ?? 0)
        //        marker.iconView = markerView
        //        marker.title = "I Am here"
        marker.map = mapViewGoogle
        mapViewGoogle.selectedMarker = marker
        mapViewGoogle.camera = camera
        
        getAddressFromLatLon(pdblLatitude: CURRENT_LAT , withLongitude: CURRENT_LONG )
    }
    
    func tracingLocationDidFailWithError(error: NSError) {
        print("Error to get Location")
    }
    
    func ChangeLocationStatus(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(status)
    }
    
    
}
extension AddressViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        mapMove = false
        LocationManager.sharedInstance.stopUpdatingLocation()
        print("Place name: \(place.name)")
        print("Place ID: \(place.placeID)")
        print("Place attributions: \(place.attributions)")
        self.lbladdress.text = "\(place.formattedAddress ?? "")"
        self.lblcurrentlocation.text = "\(place.formattedAddress ?? "")"
        self.mapViewGoogle.clear()
        SELECTED_CORDINATE = place.coordinate
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude , longitude: place.coordinate.longitude, zoom: 12.0)
        
        //get lat and long
        Lati=place.coordinate.latitude
        Long=place.coordinate.longitude
        
        //    let markerImage = UIImage(named: "pinMap")
        //
        //
        //     let markerView = UIImageView(image: markerImage)
        marker.position = CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        //     marker.iconView = markerView
        //     marker.title = "I Am here"
        marker.map = mapViewGoogle
        mapViewGoogle.selectedMarker = marker
        mapViewGoogle.camera = camera
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            self.mapMove = true
        }
        dismiss(animated: true, completion: nil)
        
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
extension AddressViewController:MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        let imageForAnnotation = UIImage(named: "pinred")
        let annotationTitle = (annotation.title ?? "") ?? ""
        //annotationView.image = imageForAnnotation
        annotationView.image = combineImageAndTitle(image: imageForAnnotation ?? UIImage(), title: annotationTitle)
        return annotationView
        
        //        let annotationIdentifier = "AnnotationIdentifier"
        //
        //        var annotationView: MKAnnotationView?
        //        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
        //            annotationView = dequeuedAnnotationView
        //            annotationView?.annotation = annotation
        //        }
        //        else {
        //            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
        //            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        //        }
        //
        //        if let annotationView = annotationView {
        //            // Configure your annotation view here
        //            annotationView.canShowCallout = true
        //            annotationView.image = UIImage(named: "pinMap")
        //
        //
        //        }
        //
        //        return annotationView
    }
    
    
    func combineImageAndTitle(image: UIImage, title: String) -> UIImage {
        // Create an image from ident text
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = title
        label.backgroundColor = .white
        let titleImage = UIImage.imageFromLabel(label: label)
        
        // Resulting image has a 100 by 100 size
        let contextSize = CGSize(width: 150 , height: 150)
        
        UIGraphicsBeginImageContextWithOptions(contextSize, false, UIScreen.main.scale)
        
        let rect1 = CGRect(x: 50 - Int(image.size.width / 2), y: 50 - Int(image.size.height / 2)+30, width: Int(image.size.width), height: Int(image.size.height))
        image.draw(in: rect1)
        
        let rect2 = CGRect(x: 0, y: 10, width: Int(titleImage.size.width), height: Int(titleImage.size.height))
        
        titleImage.draw(in: rect2)
        
        let combinedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return combinedImage!
    }
}
extension AddressViewController:GMSMapViewDelegate{
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print(coordinate)
        //
        //         self.mapViewGoogle.clear()
        //
        //        let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude , longitude: coordinate.longitude, zoom: 12.0)
        //
        //         let markerImage = UIImage(named: "pinMap")
        //
        //         let markerView = UIImageView(image: markerImage)
        //         marker.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        //         marker.iconView = markerView
        //         marker.title = "I Am here"
        //         marker.map = mapViewGoogle
        //
        //         mapViewGoogle.selectedMarker = marker
        //
        //         mapViewGoogle.camera = camera
    }
    func mapView(_ mapView: GMSMapView, didTapMyLocation location: CLLocationCoordinate2D) {
        print(location)
    }
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        //                CATransaction.begin()
        //        CATransaction.setValue(0.5, forKey: kCATransactionAnimationDuration)
        //                CATransaction.setCompletionBlock {
        //                    self.marker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        //
        //        //            self.mapViews.animate(to: GMSCameraPosition.camera(withLatitude: sourceLat , longitude: sourceLong, zoom: 15))
        //                }
        //                     self.marker.position = CLLocationCoordinate2D(latitude: position.target.latitude, longitude: position.target.longitude)
        //
        //        //            self.marker.iconView = markerView
        //        //            self.marker.title = "I Am here"
        //                    //self.marker.map = self.mapViewGoogle
        //                   // self.mapViewGoogle.selectedMarker = self.marker
        //                 CATransaction.commit()
        //        print(position.target.latitude)
        //        SELECTED_CORDINATE = position.target
        //        CURRENT_CORDINATE = position.target
        if mapMove{
            Lati=position.target.latitude
            Long=position.target.longitude
            
            getAddressFromLatLon(pdblLatitude: "\(position.target.latitude)", withLongitude: "\(position.target.longitude)")
        }
        
    }
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        // print(position)
        //  self.marker.position = CLLocationCoordinate2D(latitude: position.target.latitude, longitude: position.target.longitude)
        if mapMove{
            CATransaction.begin()
            CATransaction.setValue(0.1, forKey: kCATransactionAnimationDuration)
            CATransaction.setCompletionBlock {
                //self.marker.groundAnchor = CGPoint(x: 0, y: 0)
                self.marker.position = CLLocationCoordinate2D(latitude: position.target.latitude, longitude: position.target.longitude)
                
            }
            
            
            
            //            self.marker.iconView = markerView
            //            self.marker.title = "I Am here"
            //self.marker.map = self.mapViewGoogle
            // self.mapViewGoogle.selectedMarker = self.marker
            CATransaction.commit()
            print(position.target.latitude)
            
            Lati=position.target.latitude
            Long=position.target.longitude
            
            SELECTED_CORDINATE = position.target
            CURRENT_CORDINATE = position.target
            //  getAddressFromLatLon(pdblLatitude: "\(position.target.latitude)", withLongitude: "\(position.target.longitude)")
            
        }
        
    }
    
    func mapView(_ mapView: GMSMapView, didBeginDragging marker: GMSMarker) {
        
    }
}
extension UIImage {
    /// Convert a label to an image
    class func imageFromLabel(label: UILabel) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, 0.0)
        label.layer.render(in: UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}






