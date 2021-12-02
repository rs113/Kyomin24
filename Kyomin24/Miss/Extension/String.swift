//
//  String.swift
//  Mzadi
//
//  Created by MacBook on 07/06/21.
//

import Foundation
import UIKit

//MARK:- String Extension
extension String {
    
    func convertToDate(serverDateFormat: String) -> Date {
        let df = DateFormatter()
        df.dateFormat = serverDateFormat
        
        if let date = df.date(from: self) {
            return date
        }
        return Date()

    }
    
    /*func convertServerDateToTimeInterval(_ dateFormat: String) -> TimeInterval {
        let df = DateFormatter()
        df.dateFormat = dateFormat
        if let date = df.date(from: self) {
            return date.timeIntervalSince1970
        }
        return Date().timeIntervalSince1970
    }*/
    
    func removeHtmlFromString() -> String{
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: Data(utf8),
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
    
   
    func convertToDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            return data.convertToDictionary()
        }
        return nil
    }
    
    func underlinedText(_ lineColor: UIColor) -> NSAttributedString {
        let textRange = NSMakeRange(0, self.count)
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: textRange)
        attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: lineColor, range: textRange)
        return attributedString
    }
    
    func getTextSize(font: UIFont, boundedBySize: CGSize) -> CGSize {
        let attrString = NSAttributedString(string: self, attributes: [NSAttributedString.Key.font: font])
        let size = attrString.boundingRect(with: boundedBySize, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil).size
        return size
    }
    
    subscript(i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
}

extension String {
    
    func convertServerDateToTimeInterval(_ dateFormat: String) -> TimeInterval {
        let df = DateFormatter()
        df.dateFormat = dateFormat
        df.locale = Locale(identifier: "en_US_POSIX")
        if let date = df.date(from: self) {
            return date.timeIntervalSince1970
        }
        return Date().timeIntervalSince1970
    }
    
    func getDate(withFormat format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.current
       // dateFormatter.timeZone = TimeZone(identifier: "UTC/GMT")
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.date(from: self)
    }
}

