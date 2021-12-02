

import UIKit
import SDWebImage
import CommonCrypto



var callbackLocation : ((String,String,String) -> Void)?
var vcStatusBarChange = "dark"

extension String
{
    func isStringBlank() -> Bool
    {
        return self.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
  
        
    var convert24to12Format:String {
            let dateAsString = self //"13:15"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            let date = dateFormatter.date(from: dateAsString)
            dateFormatter.dateFormat = "h:mm a"
            print(date)
            var Date12 = ""
            if date != nil {
                Date12 = dateFormatter.string(from: date!)
            }
            
            return Date12
        }
        
    var getDateWithFrom:String{
            let formator:DateFormatter = DateFormatter()
            formator.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let strDate = formator.date(from: self)
            var strDay = ""
            let formator2:DateFormatter = DateFormatter()
            formator2.dateFormat = "dd-MMM-YYY" //"MMM d, yyy"
            formator2.string(from: strDate!)
            strDay = formator2.string(from: strDate!)
            return strDay
    }
    var gettimefromstring:String{
        let formator:DateFormatter = DateFormatter()
        formator.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let strDate = formator.date(from: self)
        var strDay = ""
        let formator2:DateFormatter = DateFormatter()
        formator2.dateFormat = "hh.mm a" //"MMM d, yyy"
        formator2.string(from: strDate!)
        strDay = formator2.string(from: strDate!)
        return strDay
        
    }
    
    var getTimeWithFrom:String{
               let formator:DateFormatter = DateFormatter()
               formator.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
               let strDate = formator.date(from: self)
               var strDay = ""
               let formator2:DateFormatter = DateFormatter()
               formator2.dateFormat = "hh.mm a"
               formator2.string(from: strDate!)
               strDay = formator2.string(from: strDate!)
               return strDay
    }
    
    var getDateFrom:String{
                  let formator:DateFormatter = DateFormatter()
                  formator.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                  let strDate = formator.date(from: self)
                  var strDay = ""
                  let formator2:DateFormatter = DateFormatter()
                  formator2.dateFormat = "dd-MMM-YYY"
                  formator2.string(from: strDate!)
                  strDay = formator2.string(from: strDate!)
                  return strDay
       }
    
        var getTimeWithSimpleDate:String{
            let formator:DateFormatter = DateFormatter()
            formator.dateFormat = "MM/dd/yyyy"
            let strDate = formator.date(from: self)
            var strDay = ""
            let formator2:DateFormatter = DateFormatter()
            formator2.dateFormat = "d-MMM-YYY" //"MMM d, yyy"
            formator2.string(from: strDate!)
            strDay = formator2.string(from: strDate!)
            return strDay
        }
    
    
        var toMD5: String {
        get {
            let messageData = self.data(using:.utf8)!
            var digestData: Data = Data(count: Int(CC_MD5_DIGEST_LENGTH))
            
            _ = digestData.withUnsafeMutableBytes {digestBytes in
                messageData.withUnsafeBytes {messageBytes in
                    CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
                }
            }
            
            return digestData.map { String(format: "%02hhx", $0 as CVarArg) }.joined()
        }
        }
 
        var htmlToAttributedString: NSAttributedString? {
            guard let data = data(using: .utf8) else { return NSAttributedString() }
            do {
                return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
            } catch {
                return NSAttributedString()
            }
        }
        var htmlToString: String {
            return htmlToAttributedString?.string ?? ""
        }
    
    func ConvertTimeformatToOther(currentFormat:String,NewFormat:String)->String{
        let dtft = DateFormatter()
        dtft.dateFormat = currentFormat
        let dtOld = dtft.date(from: self)
        dtft.dateFormat = NewFormat
        let strdt = dtft.string(from: dtOld ?? Date())
        return strdt
     }
   
}

extension Date {
    func toMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
   

        func offsetFrom(date: Date) -> String {

            let dayHourMinuteSecond: Set<Calendar.Component> = [.year,.month, .day, .hour, .minute, .second]
            let difference = NSCalendar.current.dateComponents(dayHourMinuteSecond, from: date, to: self)

            let seconds = "\(difference.second ?? 0)" + " " + "Seconds ago"
            let minutes = "\(difference.minute ?? 0)" + " " + "Minutes ago"
            let hours = "\(difference.hour ?? 0)" + " " + "Hours ago"
            let days = "\(difference.day ?? 0)" + " " + "Days ago"
            let months = "\(difference.month ?? 0)" + " " + "Months ago"
            let years = "\(difference.year ?? 0)" + " " + "Years ago"
            
            if let yaer = difference.year, yaer       > 0 { return years }
            if let moths = difference.month, moths    > 0 { return months }
            if let day = difference.day, day          > 0 { return days }
            if let hour = difference.hour, hour       > 0 { return hours }
            if let minute = difference.minute, minute > 0 { return minutes }
            if let second = difference.second, second > 0 { return seconds }
            
            return ""
        }
    
    func OffsetFromDays(date: Date) -> Int {

        let dayHourMinuteSecond: Set<Calendar.Component> = [.day]
        let difference = NSCalendar.current.dateComponents(dayHourMinuteSecond, from: date, to: self)

        
        let days =  difference.day ?? 0
        
       
        if let day = difference.day, day          > 0 { return days }
        
        
        return 0
    }

    
}

extension UITableView {
    func addCorner(){
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
    }

    func addShadow(){
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = .zero
        self.layer.masksToBounds = false
    }
    

        func setEmptyMessage(_ message: String) {
            let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
            messageLabel.text = message
            messageLabel.textColor = .darkGray
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = .center
            messageLabel.font = UIFont(name: "proximanova-semibold", size: 20)
            messageLabel.sizeToFit()

            self.backgroundView = messageLabel
            self.separatorStyle = .none
        }

        func restore() {
            self.backgroundView = nil
            self.separatorStyle = .none
        }
    
    func ShowCustomNoDataView(noDataMsg:String)->NoDataScreen{
       let NoDataView = Bundle.main.loadNibNamed("NoDataScreen", owner: self, options: nil)?.first as? NoDataScreen
        NoDataView?.frame = self.bounds
        NoDataView?.lblMsg.text = noDataMsg
        self.addSubview(NoDataView!)
        return NoDataView ?? NoDataScreen()
    }
    
}
extension UICollectionView{
    func setEmptyMessage(_ message: String,strImg:String) {
        
         let noImage = UIImageView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        let messageLabel = UILabel(frame: noImage.frame)
        messageLabel.text = message
        messageLabel.textColor = .darkGray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "proximanova-semibold", size: 20)
       // messageLabel.sizeToFit()
        noImage.image = UIImage(named: strImg)
        noImage.contentMode = .scaleAspectFill
        noImage.addSubview(messageLabel)
        
        self.backgroundView = noImage
       
    }
    
    func ShowCustomNoDataView(noDataMsg:String)->NoDataScreen{
       let NoDataView = Bundle.main.loadNibNamed("NoDataScreen", owner: self, options: nil)?.first as? NoDataScreen
        NoDataView?.frame = self.bounds
        NoDataView?.lblMsg.text = noDataMsg
        self.addSubview(NoDataView!)
        return NoDataView ?? NoDataScreen()
    }

    func restore() {
        self.backgroundView = nil

    }
}



extension UIButton {
    func underline() {
        guard let text = self.titleLabel?.text else { return }
        
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
        
        self.setAttributedTitle(attributedString, for: .normal)
    }
}


extension UIApplication {
    var statusBarView: UIView? {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}




// for textfield text enter according to language 
extension UITextField {
  open override func awakeFromNib() {
   super.awakeFromNib()
   if obj.prefs.value(forKey: APP_CURRENT_LANG) as? String == "ar" {
      // if textAlignment == .natural {
           self.textAlignment = .right
           self.semanticContentAttribute = UISemanticContentAttribute.forceRightToLeft
   //    }
       
   }else{
       self.textAlignment = .left
       self.semanticContentAttribute = UISemanticContentAttribute.forceLeftToRight
   }
  }
}

extension UserDefaults {
    func object<T: Codable>(_ type: T.Type, with key: String, usingDecoder decoder: JSONDecoder = JSONDecoder()) -> T? {
        guard let data = self.value(forKey: key) as? Data else { return nil }
        return try? decoder.decode(type.self, from: data)
    }

    func set<T: Codable>(object: T, forKey key: String, usingEncoder encoder: JSONEncoder = JSONEncoder()) {
        let data = try? encoder.encode(object)
        self.set(data, forKey: key)
    }
}


extension UINavigationController {

    func setStatusBar(backgroundColor: UIColor) {
        let statusBarFrame: CGRect
        if #available(iOS 13.0, *) {
            statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        } else {
            statusBarFrame = UIApplication.shared.statusBarFrame
        }
        let statusBarView = UIView(frame: statusBarFrame)
       // statusBarView.backgroundColor = backgroundColor
       // view.addSubview(statusBarView)
    }
    
   

}

extension UILabel {
    func underline() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }
    }
}

extension NSAttributedString {
    func height(withConstrainedWidth width: CGFloat) -> CGSize {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return boundingBox.size
    }
    
    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.width)
    }
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0


                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xFF0000) >> 16) / 255.0
                    g = CGFloat((hexNumber & 0x00FF00) >> 8) / 255.0
                    b = CGFloat(hexNumber & 0x0000FF) / 255.0
                    a = CGFloat(1.0)

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}

extension NSMutableAttributedString {
    var fontSize:CGFloat { return 14 }
    var boldFont:UIFont { return UIFont(name: "ProximaNova-Bold", size: fontSize) ?? UIFont.boldSystemFont(ofSize: fontSize) }
    var normalFont:UIFont { return UIFont(name: "ProximaNova-Reg", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)}
    
    func bold(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font : boldFont
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func normal(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font : normalFont,
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    /* Other styling methods */
    func orangeHighlight(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .foregroundColor : UIColor.white,
            .backgroundColor : UIColor.orange
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func blackHighlight(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .foregroundColor : UIColor.white,
            .backgroundColor : UIColor.black
            
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func underlined(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .underlineStyle : NSUnderlineStyle.single.rawValue
            
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
}
class MyRootNavigationController: UINavigationController {
  
    override var preferredStatusBarStyle: UIStatusBarStyle {
    if vcStatusBarChange == "dark"{
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            return .default
        }
        
      }else{
       
        return .lightContent

     }
    }
    override var childForStatusBarStyle: UIViewController? {
        return nil
    }
}

extension UIImage {

    public enum DataUnits: String {
        case byte, kilobyte, megabyte, gigabyte
    }

    func getSizeIn(_ type: DataUnits)-> String {

        guard let data = self.pngData() else {
            return ""
        }

        var size: Double = 0.0

        switch type {
        case .byte:
            size = Double(data.count)
        case .kilobyte:
            size = Double(data.count) / 1024
        case .megabyte:
            size = Double(data.count) / 1024 / 1024
        case .gigabyte:
            size = Double(data.count) / 1024 / 1024 / 1024
        }

        return String(format: "%.2f", size)
    }
}


extension UITabBar {
   func addBadge(index:Int) {
       if let tabItems = self.items {
           let tabItem = tabItems[index]
           tabItem.badgeValue = "●"
           tabItem.badgeColor = .clear
           tabItem.setBadgeTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .normal)
       }
   }
   func removeBadge(index:Int) {
       if let tabItems = self.items {
           let tabItem = tabItems[index]
           tabItem.badgeValue = nil
       }
   }
   
}

//extension NSObject{
//    func getUserDetails() -> UserDetails
//    {
//
//        if UserDefaults.standard.object(forKey: kUserDetails) != nil
//        {
//            let decode: Data = (UserDefaults.standard.object(forKey: kUserDetails) as? Data)!
//            print(decode)
//            do {
//                let decodeduserData = NSKeyedUnarchiver.unarchiveObject(with: decode as Data) as! UserDetails
//                return decodeduserData
//            }
//        }
//        return UserDetails()
//
//    }
//}

