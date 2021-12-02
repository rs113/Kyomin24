//
//  ChatPojo.swift
//  Mzadi
//
//  Created by Emizentech on 01/10/21.
//

import Foundation

class Chatpojo: NSObject {
    var message:String
    var receiver:String
    var sender:String
    var time:String
    
    init(dic:NSDictionary) {
    self.message=dic["message"] as? String ?? ""
    self.receiver=dic["receiver"] as?String ?? ""
    self.sender=dic["sender"] as? String ?? ""
    self.time=dic["time"]as? String ?? ""
}

}

