//
//  MapViewController.swift
//  Mzadi
//
//  Created by Emizentech on 02/09/21.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation

class MapViewController: UIViewController {

    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var mapview: GMSMapView!
    
    
       var Subcatid:String?
       var maincatid:String?
       var catid:String?
       var categoryId:String?
       var ProductProId:String?
       var Productid:String?
       var tag = 0
       var selectedValue = 0
       var Searchtext=""
       var ProductCount=""
       
       
       var adtype=0
       var protype=0
       var procondition=0
       var proguaranty=0
       var city=0
       var procamera=0
       var procapicity=0
       var prosim=0
       var promodal=0
       var prokm=""
       var fromPrice=""
       var toPrice=""
       
      private var placesClient: GMSPlacesClient!
         let marker = GMSMarker()
       var Arrlocationlist:ProductLocationModal?
       var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//    placesClient = GMSPlacesClient.shared()
//
//    marker.map = mapview
     ProductLocationList()
      
        
    }
    

@IBAction func btnback(_ sender: Any) {
self.navigationController?.popViewController(animated: true)
    }
    
    
//    func MapShow(){
//        var maplati=Double()
//        maplati = Double("26.3152") ?? 0
//        var maplong=Double()
//        maplong=Double("75.3661") ?? 0
//        let camera = GMSCameraPosition.camera(withLatitude:maplati, longitude:maplong, zoom: 13.0)
//        mapview?.animate(to: camera)
//        mapview.isMyLocationEnabled=false
//        let cellmarker=GMSMarker()
//        cellmarker.position=CLLocationCoordinate2D(latitude:maplati, longitude:maplong)
//        cellmarker.icon=UIImage(named:"pinred")
//        cellmarker.map=mapview
//    }
    
    
    
    
    func setmapData(Mapcordinates:CLLocationCoordinate2D){
           mapview.animate(to: GMSCameraPosition(target: Mapcordinates, zoom: 12))
           marker.position = Mapcordinates
    }
    
//    func MapShow(){
//        for mapdata in Arrlocationlist?.data  ?? [ProductLocation](){
//       var maplati=Double()
//        maplati = Double(mapdata.lat) ?? 0
//       var maplong=Double()
//       maplong=Double(mapdata.long) ?? 0
//       // markerpark(mapLat:maplati, mapLong: maplong)
//
//       self.mapview.backgroundColor = .red
//       let camera = GMSCameraPosition.camera(withLatitude:maplati, longitude:maplong, zoom: 12.0)
//       self.mapview?.animate(to: camera)
//       self.mapview.isMyLocationEnabled=false
//       let cellmarker=GMSMarker()
//       cellmarker.position=CLLocationCoordinate2D(latitude:maplati, longitude:maplong)
//       cellmarker.icon=UIImage(named:"pinred")
//       cellmarker.map=self.mapview
//        }
//
//    }

    
    func SetAllStoreOnMap(){
          var allStoreMarker:[GMSMarker] = []

        for mapdata in Arrlocationlist?.data  ?? [ProductLocation](){

            let storeLat = Double(Float(mapdata.lat ) ?? 0)
            let storeLong = Double(Float(mapdata.long ) ?? 0)
               let positionStore = CLLocationCoordinate2D(latitude:storeLat, longitude: storeLong)
               let markerSore = GMSMarker(position: positionStore)
                markerSore.title = mapdata.title

            let camera = GMSCameraPosition.camera(withLatitude:storeLat, longitude:storeLong, zoom: 10.0)
            mapview?.animate(to: camera)
            mapview.isMyLocationEnabled=false

            markerSore.icon=UIImage(named: "pinred")
             allStoreMarker.append(markerSore)
            markerSore.map  = mapview
            
        }


        }


    
    func ProductLocationList(){
             let dictParam =        ["ad_type":adtype,
                                    "pro_type":protype,
                                    "pro_model": promodal,
                                    "pro_condition":procondition,
                                    "pro_guaranty":proguaranty,
                                    "pro_km":prokm,
                                    "city":city,
                                    "pro_sim":prosim,
                                    "pro_capacity":procapicity,
                                    "pro_camera":procamera,
                                    "location":"",
                                    "lat":"",
                                    "long":"",
                                    "price_from":fromPrice,
                                    "price_to": toPrice,
                                    "subcategory": Subcatid ?? "",
                                    "category": categoryId ?? "",
                                    "search_keyword":"",
                                    "product_id":""] as [String : Any]
                   print(dictParam)
            ApiManager.apiShared.sendRequestServerPostWithHeaderModel(url: ProductLocationUrl, VCType: self, ReqMethod: .post, dictParameter: dictParam, responseObject: ProductLocationModal.self, success: { [self] (ResponseJson, resModel, st) in
                    let stCode = ResponseJson["status_code"].int
                    let strMessage = ResponseJson["message"].string
                print(ResponseJson)
                    if stCode == 200{
                        self.Arrlocationlist = resModel
                        self.SetAllStoreOnMap()
   
                    }else{
                       self.showCustomPopupView(altMsg: strMessage ?? "", alerttitle: "Error!", alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
                        self.dismiss(animated: true, completion: nil)
                        })
                    }
                }) { (stError) in
                    self.showCustomPopupView(altMsg: stError, alerttitle: "Error!", alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
    

}
