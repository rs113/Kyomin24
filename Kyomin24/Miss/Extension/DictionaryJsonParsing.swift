//
//  DictionaryJsonParsing.swift
//  Mzadi
//
//  Created by MacBook on 07/06/21.
//

import Foundation
import UIKit

//MARK:- Dictionary Extension
extension Dictionary {
    func getString(forKey key: Key, pointValue val: Int = 2, defaultValue def: String = "") -> String {
        if let str = self[key] as? String {
            return str
        } else if let num = self[key] as? NSNumber {
            let doubleVal = Double(truncating: num)
            return String(format: "%0.\(val)f", doubleVal)
        }
        return def
    }
    
    func getInt(forKey key: Key, defaultValue def: Int = 0) -> Int {
        if let num = self[key] as? Int {
            return num
        } else if let str = self[key] as? String {
            if let val = Int(str) {
                return val
            }
        } else if let num = self[key] as? NSNumber {
            return Int(truncating: num)
        }
        return def
    }
    
    func getDouble(forKey key: Key, defaultValue def: Double = 00.00) -> Double {
        if let num = self[key] as? Double {
            return num
        } else if let str = self[key] as? String {
            if let val = Double(str) {
                return val
            }
        } else if let num = self[key] as? NSNumber {
            return Double(truncating: num)
        }
        return def
    }
    
    func getBool(forKey key: Key, defaultValue def: Bool = false) -> Bool {
        if let val = self[key] as? Bool {
            return val
        } else if let num = self[key] as? NSNumber {
            if num == 0 {
                return false
            } else if num == 1 {
                return true
            }
        } else if let str = self[key] as? String {
            if str.lowercased() == "true" || str.lowercased() == "yes" {
                return true
            } else if str.lowercased() == "false" || str.lowercased() == "no" {
                return false
            }
        }
        return def
    }
    
    func getDictionary(forKey key: Key, defaultValue def: [String: Any] = [:]) -> [String: Any] {
        if let dict = self[key] as? [String: Any] {
            return dict
        } else if let nsdict = self[key] as? NSDictionary, let dict = nsdict as? [String: Any] {
            return dict
        } else if let str = self[key] as? String, let dict = str.convertToDictionary() {
            return dict
        } else if let data = self[key] as? Data, let dict = data.convertToDictionary() {
            return dict
        }
        
        return def
    }
}

extension Float {
    func round(nearest: Float) -> Float {
        let n = 1 / nearest
        let numberToRound = self * n
        return numberToRound.rounded() / n
        
    }
}

//extension Int {
//    func round(nearest: Int) -> Int {
//        let n = 1 / nearest
//        let numberToRound = self * n
//        return numberToRound.round(nearest: n)
//        
//    }
//}
