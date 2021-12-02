//
//  Chat_Detail_VC.swift
//  Walkys
//
//  Created by emizen on 23/09/20.
//  Copyright © 2020 emizen. All rights reserved.
//

import UIKit

class Chat_Detail_VC: UIViewController {
    

    
    @IBOutlet weak var Backview: UIView!
    
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var txt_view_message: UITextView!
    @IBOutlet weak var tbl_Chat: UITableView!
    
    

    var textviewPreHeight:CGFloat = 30
    var chat_Type = ""
    var arrchat=[Chatpojo]()
     
       
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden=true
        lbl_Name.text=obj.prefs.value(forKey: APP_USER_NAME) as? String ?? ""
        setInitials()
      
        Backview.layer.cornerRadius = 5
        Backview.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        txt_view_message.placeholder="Type here"
        

    }
    
    //MARK:- IBActions

    
    
    
    
    @IBAction func btn_Back_Action(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btn_Send_message_Actiion(_ sender: Any) {
        
    if self.txt_view_message.text.isStringBlank() || self.txt_view_message.text == "Type here" {
            self.showCustomPopupView(altMsg: "Please type here", alerttitle: "Error!", alertimg: UIImage(named: "Errorimg") ?? UIImage()) {
                self.dismiss(animated: true, completion: nil)
            }
            return
        }
    
       // let dict = ["msg":txt_view_message.text ?? "","time":"5.23 AM","userID":"12345"] as [String : Any]
       // arr_chat_Message.append(dict)
        tbl_Chat.reloadData()
        DispatchQueue.main.async {
           // self.tbl_Chat.scrollToRow(at: IndexPath(row: self.arr_chat_Message.count-1, section: 0), at: .bottom, animated: true)
            self.txt_view_message.isScrollEnabled = false
            self.txt_view_message.resignFirstResponder()
            self.txt_view_message.becomeFirstResponder()
            self.txt_view_message.resignFirstResponder()
        
        
    }
        
    }
    
    
    
    //MARK:- Custom Methods
    func setInitials() {
        
        tbl_Chat.register(UINib(nibName: "Tbl_chat_user_Self_Cell", bundle: nil), forCellReuseIdentifier: "Tbl_chat_user_Self_Cell")
        
        tbl_Chat.register(UINib(nibName: "tbl_Chat_buddy_Cell", bundle: nil), forCellReuseIdentifier: "tbl_Chat_buddy_Cell")
        tbl_Chat.reloadData()
        txt_view_message.delegate = self
        txt_view_message.textColor = .black
        
        DispatchQueue.main.async {
          //  self.tbl_Chat.scrollToRow(at: IndexPath(row: self.arr_chat_Message.count-1, section: 0), at: .bottom, animated: false)
        }
//        if chat_Type == "group"{
//            lbl_Group_Mem_Name.isHidden = false
//        }else{
//            lbl_Group_Mem_Name.isHidden = true
//        }
        

    }


    
}
//MARK: TableMethods
extension Chat_Detail_VC: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrchat.count
    }
        
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//            return 80 * scaleFactorY
//    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dict = arrchat[indexPath.row]
        let uID = dict.sender
        
        if uID == obj.prefs.value(forKey: APP_USER_ID) as? String ?? ""{
          let cell = tbl_Chat.dequeueReusableCell(withIdentifier: "tbl_Chat_buddy_Cell") as! tbl_Chat_buddy_Cell
           cell.lbl_Message.text = dict.message
           cell.lbl_Time.text = dict.time

            if chat_Type == "group"{
                cell.lblBuddyName.isHidden = false
                cell.height_Const_lblName.constant = 20
                cell.lblBuddyName.textColor = .black
                cell.lblBuddyName.text = ""

            }else{
                cell.lblBuddyName.isHidden = true
                cell.height_Const_lblName.constant = 0
            }

              return cell
        }else{
            let cell = tbl_Chat.dequeueReusableCell(withIdentifier: "Tbl_chat_user_Self_Cell") as! Tbl_chat_user_Self_Cell
            cell.lbl_Message.text = dict.message
            cell.lbl_Time.text = dict.time
              return cell
        }
       
           
      
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let requestDetailVC = UIStoryboard.getITProfessionStoryBoard().instantiateViewController(withIdentifier: "RequestDetailVC") as! RequestDetailVC
//        requestDetailVC.requestDetailModel = self.requestModel?.data[indexPath.row]
//            self.navigationController?.pushViewController(requestDetailVC, animated: true)
//
    }
}
extension Chat_Detail_VC:UITextViewDelegate{
//    func textViewDidBeginEditing(_ textView: UITextView) {
//
//        if textView.text == "Enter Message"{
//            txt_view_message.textColor = .black
//            txt_view_message.text = ""
//        }
//
//    }
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if textView.text.isEmpty{
//            txt_view_message.textColor = .lightGray
//            txt_view_message.text = "Enter Message"
//        }
//
//    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        let numLines = (textView.contentSize.height / (textView.font?.lineHeight ?? 0))
        print(numLines)
       
        if numLines > 5{
         
           txt_view_message.isScrollEnabled = true
           
        }else{
           
           txt_view_message.isScrollEnabled = false
        }
        return true
    }
}
extension Chat_Detail_VC{
    func saveToJsonFile() {
        print("Hello")
        // Get the url of Persons.json in document directory
        guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileUrl = documentDirectoryUrl.appendingPathComponent("Persons.json")
       var isDirectory: ObjCBool = false
        if FileManager.default.fileExists(atPath: fileUrl.path, isDirectory: &isDirectory){
              print("file already Present")
            try? FileManager.default.removeItem(atPath: fileUrl.path)
          }else{
               print("file not available")
          }

        // Create a write-only stream
        guard let stream = OutputStream(toFileAtPath: fileUrl.path, append: false) else { return }
        stream.open()
        defer {
            stream.close()
        }
         let personArray =  [["person": ["name": "Dani", "age": "24"]], ["person": ["name": "ray", "age": "70"]]]
        // Transform array into data and save it into file
        var error: NSError?
        JSONSerialization.writeJSONObject(personArray, to: stream, options: [], error: &error)

        // Handle error
        if let error = error {
            print(error)
        }
    }
    
    func retrieveFromJsonFile() {
        // Get the url of Persons.json in document directory
        guard let documentsDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileUrl = documentsDirectoryUrl.appendingPathComponent("Persons.json")
  
        // Create a read-only stream
        guard let stream = InputStream(url: fileUrl) else { return }
        stream.open()
        defer {
            stream.close()
        }

        // Read data from .json file and transform data into an array
        do {
            guard let personArray = try JSONSerialization.jsonObject(with: stream, options: []) as? [[String: [String: String]]] else { return }
            print(personArray) // prints [["person": ["name": "Dani", "age": "24"]], ["person": ["name": "ray", "age": "70"]]]
        } catch {
            print(error)
        }
    }
}
