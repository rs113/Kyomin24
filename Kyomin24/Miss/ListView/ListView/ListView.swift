//
//  SelectTypeView.swift
//  Bolt
//
//  Created by Mac on 06/02/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

enum SelectType {
    case countryCode
    case vehicleType
}


class ListView: UIView {
    
    //MARK: Properties
    @IBOutlet weak var tblCodeList: UITableView!
    @IBOutlet weak var containerView: UIView!
  //  @IBOutlet var txtFieldSearchCountryCode: TextField!
    
    @IBOutlet weak var tfCountryCode: UITextField!
    
    
    
    var codeDataList = [CodeData]()
    var callBack: ((CodeData, SelectType, Int) -> ())!
    var lastSelectedCountry: CodeData?
    var selectType: SelectType!

    
    static func initialize(_ lastSelected: CodeData?, type: SelectType, callback: @escaping ((CodeData, SelectType, Int) -> ())) {
        
        let nib = UINib(nibName: "ListView", bundle: Bundle.main)
        let codeView = nib.instantiate(withOwner: self, options: nil)[0] as! ListView
        codeView.frame = UIScreen.main.bounds
        codeView.lastSelectedCountry = lastSelected
        codeView.tblCodeList.register(UINib(nibName: "ListCell", bundle: nil), forCellReuseIdentifier: "ListCell")
        codeView.callBack = callback
        codeView.selectType = type
        UIApplication.currentViewController()?.view.addSubview(codeView)
        codeView.tblCodeList.reloadData()
        codeView.setDataOnList()
        
    }
    
    //MARK:- set Data On View
    func setDataOnList() {
        if selectType == .countryCode {
            self.tfCountryCode.isHidden = false
             codeDataList.removeAll()
             codeDataList = self.readCountryCodeJson()
        }else if selectType == .vehicleType {
            self.tfCountryCode.isHidden = true
            self.setVehicleData()
        }
        containerView.transformView()
        reloadInMain()
        
        self.tfCountryCode.addTarget(self, action: #selector(edtingChange(_:)), for: UIControl.Event.editingChanged)
        
        
    }
    
    //MARK: action methods of textfied
    @objc func edtingChange(_ sender: UITextField) {
        codeDataList.removeAll()
        codeDataList = readCountryCodeJson()
        guard
            tfCountryCode.text! != "" else {
            tblCodeList.reloadData()
            return
        }
        codeDataList = codeDataList.filter({$0.name.lowercased().contains(tfCountryCode.text!)})
        if codeDataList.count > 0 {
            print(">>> data >>>> ")
            self.tblCodeList.removeBackgroundText()
        }else {
            self.tblCodeList.displayBackgroundText(text: "No Data")
        }
        tblCodeList.reloadData()
    }
    
    
    
    
    //MARK:- read ContryCode JSON
    func readCountryCodeJson() -> [CodeData] {
        var countryList = [CodeData]()
        if let path = Bundle.main.path(forResource: "countryCodes", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                
                for item in json as! [[String: Any]] {
                    let code = item["dial_code"] as! String
                    countryList.append(CodeData(name: item["name"] as! String, code: code, isSelected: code ==
                        self.lastSelectedCountry?.code))
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }
        return countryList
    }

    //MARK:- set Vehicle Type Data
    func setVehicleData() {
        // use map here
        let vehicles = ["Bike", "Motorcycle", "Truck", "SUV", "Sedan", "Pickup truck"]
        self.codeDataList = vehicles.map({CodeData(name: $0, code: nil, isSelected: $0 == self.lastSelectedCountry?.name)})
    }
    
    //MARK:- reload tableView
    func reloadInMain() {
        DispatchQueue.main.async {
            self.tblCodeList.reloadData()
        }
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.removeFromSuperview()
    }
}



// MARK: TABLEVIEW DATASOURCE AND DELEGATE
extension ListView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return codeDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)as! ListCell
        cell.selectionStyle = .none
        cell.setUpData(selectTypeList: codeDataList[indexPath.row])
     
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = codeDataList.map({ $0.isSelected = false })
        codeDataList[indexPath.row].isSelected = true
        
        if let completion = self.callBack {
            completion(codeDataList[indexPath.row], selectType, indexPath.row)
        }
        
        reloadInMain()
        self.removeFromSuperview()
    }
}



