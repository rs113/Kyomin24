

import Foundation
import CoreLocation


protocol LocationManagerDelegate {
    func tracingLocation(currentLocation: CLLocation)
    func tracingLocationDidFailWithError(error: NSError)
    func ChangeLocationStatus(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
}

class LocationManager: NSObject,CLLocationManagerDelegate {
    var locationManager: CLLocationManager?
    var lastLocation: CLLocation? = CLLocation.init(latitude: 22.7196, longitude: 75.8577)
    var delegate: LocationManagerDelegate?
    
    static let sharedInstance:LocationManager = {
        let instance = LocationManager()
        return instance
    }()
    
    override init() {
        super.init()
        self.locationManager = CLLocationManager()
        guard let locationManagers=self.locationManager else {
            return
        }
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManagers.requestAlwaysAuthorization()
            locationManagers.requestWhenInUseAuthorization()
            
        }

        if #available(iOS 9.0, *) {
            //            locationManagers.allowsBackgroundLocationUpdates = true
        } else {
            // Fallback on earlier versions
        }
        locationManagers.desiredAccuracy = kCLLocationAccuracyBest
        locationManagers.pausesLocationUpdatesAutomatically = false
      //  locationManagers.distanceFilter = 0.1
        locationManagers.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        self.lastLocation = location
        updateLocation(currentLocation: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
                switch status {
                case .notDetermined:
                    delegate?.ChangeLocationStatus(manager, didChangeAuthorization: .notDetermined)
                    locationManager?.requestAlwaysAuthorization()
                    break
                case .authorizedWhenInUse:
                    delegate?.ChangeLocationStatus(manager, didChangeAuthorization: .authorizedWhenInUse)
                    locationManager?.startUpdatingLocation()
                    break
                case .authorizedAlways:
                    delegate?.ChangeLocationStatus(manager, didChangeAuthorization: .authorizedAlways)
                    locationManager?.startUpdatingLocation()
                    break
                case .restricted:
                    delegate?.ChangeLocationStatus(manager, didChangeAuthorization: .restricted)
                    // restricted by e.g. parental controls. User can't enable Location Services
                    break
                case .denied:
                    delegate?.ChangeLocationStatus(manager, didChangeAuthorization: .denied)
                    // user denied your app access to Location Services, but can grant access from Settings.app
                    break
                default:
                    break
                }
    }
 
//    private func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
//        switch status {
//        case .notDetermined:
//            locationManager?.requestAlwaysAuthorization()
//            break
//        case .authorizedWhenInUse:
//            locationManager?.startUpdatingLocation()
//            break
//        case .authorizedAlways:
//            locationManager?.startUpdatingLocation()
//            break
//        case .restricted:
//            // restricted by e.g. parental controls. User can't enable Location Services
//            break
//        case .denied:
//            // user denied your app access to Location Services, but can grant access from Settings.app
//            break
//        default:
//            break
//        }
//    }
    
    // Private function
    private func updateLocation(currentLocation: CLLocation) {
        guard let delegate = self.delegate else {
            return
        }
        delegate.tracingLocation(currentLocation: currentLocation)
    }
    
    private func updateLocationDidFailWithError(error: NSError) {
        guard let delegate = self.delegate else {
            return
        }
        delegate.tracingLocationDidFailWithError(error: error)
    }
    
    func startUpdatingLocation() {
        print("Starting Location Updates")
        self.locationManager?.startUpdatingLocation()
       // get_nearby_company()
    }
    
    func stopUpdatingLocation() {
        print("Stop Location Updates")
        self.locationManager?.stopUpdatingLocation()
       
    }
    
    func startMonitoringSignificantLocationChanges() {
        self.locationManager?.startMonitoringSignificantLocationChanges()
        
        
    }
    
    
    func inputDictLogin() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        if let lat = locationManager?.location?.coordinate.latitude {
             dict["lat"]               = "22.7027857" as AnyObject
        }
        if let lon = locationManager?.location?.coordinate.longitude {
            dict["lon"]               = "75.8716059" as AnyObject
        }
        if let user_id = UserDefaults.standard.value(forKey: "user_id") {
            dict["user_id"]         =   user_id as AnyObject
        }
       
        // dict["register_id"]     =   "" as AnyObject
      
        return dict
    }
    //["email": cm50@gmail.com, "password": 123456, "type": USER, "ios_register_id": c20Fq_k3wjs:APA91bEP0mo8SDoKrb4P8eGBd4AumqN-B4j_OyBT8Kd9NANEdDiNx2ItV4aLyXT9sCjr8sLqTm9oVc8_ybD0_dmr98luy8qQ_i0a-u0vW_CTi-_VbrFXoGLyG0YEojQpBOl65vtbf5k5]
    
    
    func get_nearby_company() {

//         let user_id = UserDefaults.standard.value(forKey: "user_id") as? String
//        if user_id == nil || user_id == ""{
//            return
//        }
//        let lat = locationManager?.location?.coordinate.latitude
//        if lat == nil{
//            return
//        }
//        let long = locationManager?.location?.coordinate.longitude
//        if long == nil{
//            return
//        }
//
//        let paramsDict = self.inputDictLogin()
//        print(paramsDict)
//        let story = UIStoryboard(name: "Main", bundle: nil)
//        let vc = story.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
//        DispatchQueue.global(qos: .background).async {
//            CommunicationManeger.callPostService(apiUrl: BASE_URL + get_nearBy_com_URL, parameters: paramsDict, Method: .get, parentViewController: vc,
//                                                 successBlock: { (response : AnyObject,message : String) in
//                                                    print("success")
//
//            },
//                                                 failureBlock: { (error : Error) in
//                                                    print("error")
//
//            })
//        }
        
        
     
    }
    
    // #MARK:   get the alarm time from date and time
}
