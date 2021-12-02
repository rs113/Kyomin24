//
//  CountryDetail.swift
//  BoltCustomer
//
//  Created by Mac on 06/02/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation

// Mark: ModelClass of ShowCodeData
class CodeData {
    
    var name: String!
    var code: String!
    var isSelected: Bool = false
    
    init(name: String, code: String!) {
        self.name = name
        self.code = code
    }
    
    init(name: String, code: String!, isSelected: Bool) {
        self.name = name
        self.code = code
        self.isSelected = isSelected
    }
}
