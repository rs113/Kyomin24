//
//  CityViewController.swift
//  Kyomin24
//
//  Created by emizen on 11/24/21.
//

import UIKit
import SwiftyJSON

class CityViewController: UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    
    var id = ""
    var StateId = ""
    var CityId = ""
    
    
    var namestr = ""
    var emailStr = ""
    var mobileStr = ""
    var passwordstr = ""
    var confirmPassStr = ""

    struct Country {
        
        var name : String
        var code : String
        
    }
    
    var selected = "true"
    var CountryArray:[Country] = []
    
    var CountryArr:[String] = []
    
    @IBOutlet weak var CityTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiname()

    }
    
    
    
    @IBAction func BackBtnAction(_ sender: Any) {
        
       // self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
        
    }
}

extension CityViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return CountryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:City_TableViewCell? =
            CityTable?.dequeueReusableCell(withIdentifier: "City_TableViewCell") as? City_TableViewCell
        
        cell?.CityLbl.text = CountryArray[indexPath.row].name
        
        if id == CountryArray[indexPath.row].code
        {
            cell?.CityRadio.image = #imageLiteral(resourceName: "citySelected")
            
        }else {
            
            cell?.CityRadio.image = #imageLiteral(resourceName: "CiityRadio")
            
        }
        
        cell?.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = CityTable.cellForRow(at: indexPath) as! City_TableViewCell
        
        id  = CountryArray[indexPath.row].code
        
        cell.CityRadio.image = #imageLiteral(resourceName: "citySelected")
        
        if titleLbl.text == "Country" {
            
            CountryArray.removeAll()

            GetStateApi()
            
        }else if titleLbl.text == "Region"{
            

            
            StateId  = CountryArray[indexPath.row].code
            CountryArray.removeAll()

            GetCityApi()
            
            
        }else if titleLbl.text == "City" {

            let vc = SignupViewController.instance(.main) as! SignupViewController
            vc.City = CountryArray[indexPath.row].name
            vc.nameSend = namestr
            vc.emailSend = emailStr
            vc.mobileSend = mobileStr
            vc.passwordSend = passwordstr
            vc.confirmPassSend = confirmPassStr
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
    
    func apiname() {
        
       // CountryArray.removeAll()
        //id = ""
        
        NetworkManager.getState(uiRef: self, Webservice: "https://classified.ezxdemo.com/api/get-countries"){(sJson)in
            
            //  GIFHUD.shared.dismiss()
            
            print(sJson)
            
            let sJSON = JSON(sJson)
            
            print(sJSON)
            
            
            if sJSON["status_code"].intValue == 200 {
                
                for item in sJSON["data"].arrayValue{
                    
                    
                    let nameStr = item["name"].stringValue
                    let id = item["id"].stringValue
                    
                    
                    
                    self.CountryArray.append(Country.init(name: nameStr, code: id))
                    
                }
                
            }
            else {
//                self.showCustomPopupView(altMsg: Strerr, alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
//                    self.dismiss(animated: true, completion: nil)
               // })
                //   self.showAlert(message: sJSON["message"].stringValue)
                
            }
            
            self.CityTable.reloadData()
            //  }
        }
    }
    
    
    func GetStateApi(){
        
        
        let dictRegParam = [
            
            "country_id":id
            
        ]  as [String : Any]
        
        CountryArray.removeAll()
        print(dictRegParam)
        
        ApiManager.apiShared.sendRequestServerPostWithHeader1(url:GetState, VCType: self, dictParameter: dictRegParam, success: { (ResponseJson) in
            
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
            if stCode == 200{
                // let resdata = ResponseJson["data"].arrayValue
                
                self.titleLbl.text = "Region"
                
                for item in ResponseJson["data"].arrayValue{
                    
                    let nameStr = item["name"].stringValue
                    let id = item["id"].stringValue
                    self.CountryArray.append(Country.init(name: nameStr, code: id))
                    
                }
                
            }else{
                self.showCustomPopupView(altMsg: strMessage ?? "", alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
                    self.dismiss(animated: true, completion: nil)
                })
            }
            
            self.CityTable.reloadData()
            
        }) { (Strerr,stCode) in
            self.showCustomPopupView(altMsg: Strerr, alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
                self.dismiss(animated: true, completion: nil)
            })
        }
        
        
    }
    
    
    func GetCityApi(){
        
        CountryArray.removeAll()
    
        let dictRegParam = [
            
            "state_id":StateId
            
        ]  as [String : Any]

        print(dictRegParam)
        
        ApiManager.apiShared.sendRequestServerPostWithHeader1(url:GetCities, VCType: self, dictParameter: dictRegParam, success: { (ResponseJson) in
            
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
            if stCode == 200{
                // let resdata = ResponseJson["data"].arrayValue
                
                self.titleLbl.text = "City"
                
                
                
                for item in ResponseJson["data"].arrayValue{
                    
                    let nameStr = item["name"].stringValue
                    let id = item["id"].stringValue
                    self.CountryArray.append(Country.init(name: nameStr, code: id))
                    
                }
                
            }else{
                self.showCustomPopupView(altMsg: strMessage ?? "", alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
                    self.dismiss(animated: true, completion: nil)
                })
            }
            
            self.CityTable.reloadData()
            
        }) { (Strerr,stCode) in
            self.showCustomPopupView(altMsg: Strerr, alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
                self.dismiss(animated: true, completion: nil)
            })
        }
        
        
    }
}

