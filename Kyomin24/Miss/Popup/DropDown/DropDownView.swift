//
//  DropDownView.swift
//  CustomerFactor
//
//  Created by Mac on 31/01/18.
//  Copyright © 2018 Mac All rights reserved.
//

import UIKit

class DropDownView: UIView {
    
    typealias CompletionBlock = (String, Int) -> Void
    
    public enum Direction {
        case top
        case bottom
    }
    
    static let cellReuseIdentifier = "DropDownCell"
    static let textLabelFont = UIFont.systemFont(ofSize: 16.0)
    static let verticalPadding: CGFloat = 13.0
    static let horizontalPadding: CGFloat = 8.0
    
    fileprivate let tableContainerView = UIView()
    fileprivate let tableView = UITableView()
    fileprivate var dataArray = [String]()
    fileprivate var direction = Direction.bottom
    fileprivate var completion: CompletionBlock?
    
    public var backgroundViewColor = UIColor.clear {
        didSet {
            backgroundColor = backgroundViewColor
        }
    }
    
    class func addDropDown(frame: CGRect, dataArray: [String], completion: CompletionBlock? = nil) {
        if let visibleWindow = UIWindow.visibleWindow() {
            let dropDownView = DropDownView(frame: UIScreen.main.bounds)
            visibleWindow.addSubview(dropDownView)
            dropDownView.addTapGestureRecognizerOnView()
            dropDownView.setupTableView(frame: frame)
            dropDownView.dataArray = dataArray
            dropDownView.tableView.reloadDataInMain()
            dropDownView.completion = completion
            
            dropDownView.tableContainerView.dropShadow(color: .black, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)

        }
    }
    
    class func addDropDown(inView view: UIView, direction: Direction, dataArray: [String], completion: CompletionBlock? = nil) {
        if let visibleWindow = UIWindow.visibleWindow() {
            let dropDownView = DropDownView(frame: UIScreen.main.bounds)
            visibleWindow.addSubview(dropDownView)
            dropDownView.addTapGestureRecognizerOnView()
            dropDownView.setupTableView(frame: dropDownView.calculateTableFrame(forDirection: direction, inView: view, dataArray: dataArray))
            dropDownView.dataArray = dataArray
            dropDownView.tableView.reloadDataInMain()
            dropDownView.completion = completion
            
            dropDownView.tableContainerView.dropShadow(color: .black
                , opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        }
    }
    
    fileprivate func calculateTableFrame(forDirection direction: Direction, inView: UIView, dataArray: [String]) -> CGRect {
        if let globalFrame = inView.globalFrame {
            let padding: CGFloat = DropDownView.horizontalPadding
            let tableWidth = globalFrame.size.width
            var calculatedTableHeight: CGFloat = 0
            for str in dataArray {
                let calculatedStringHeight = str.height(withConstrainedWidth: tableWidth - (padding * 2), font: DropDownView.textLabelFont)
                calculatedTableHeight += calculatedStringHeight + (DropDownView.verticalPadding * 2)
            }
            var tableMaxHeight: CGFloat = 0.0
            switch direction {
            case .top:
                tableMaxHeight = CGFloat(fabsf(Float(globalFrame.origin.y - 50.0)))
                break
            case .bottom:
                tableMaxHeight = CGFloat(fabsf(Float(ScreenSize.inOrientation().height - globalFrame.origin.y + globalFrame.size.height - 100.0)))
                break
            }
            let tableHeight = min(calculatedTableHeight, tableMaxHeight)
            
            switch direction {
            case .top:
                let frame = CGRect(x: globalFrame.origin.x, y: globalFrame.origin.y - tableHeight, width: globalFrame.size.width, height: tableHeight)
                return frame
            case .bottom:
                let frame = CGRect(x: globalFrame.origin.x, y: globalFrame.origin.y + globalFrame.size.height, width: globalFrame.size.width, height: tableHeight)
                return frame
            }
            
        }
        return CGRect.zero
    }
    
    fileprivate func removeDropDown() {
        dataArray.removeAll()
        self.removeFromSuperview()
    }
    
    fileprivate func addTapGestureRecognizerOnView() {
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapOnBackground(_:)))
        tap.numberOfTapsRequired = 1
        tap.delegate = self
        self.addGestureRecognizer(tap)
    }
    
    fileprivate func setupTableView(frame: CGRect) {
        tableContainerView.frame = frame
        tableView.frame = tableContainerView.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 34.0
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.register(UINib(nibName: DropDownView.cellReuseIdentifier, bundle: nil), forCellReuseIdentifier: DropDownView.cellReuseIdentifier)
        tableView.backgroundColor = UIColor.white
//        tableView.layer.cornerRadius = 5
        tableContainerView.addSubview(tableView)
        self.addSubview(tableContainerView)
    }

    @objc fileprivate func tapOnBackground(_ sender: UITapGestureRecognizer) {
        removeDropDown()
    }
    
}

extension DropDownView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DropDownView.cellReuseIdentifier) as! DropDownCell
        cell.optionLabel.text = dataArray[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let completion = self.completion {
            completion(dataArray[indexPath.row], indexPath.row)
        }
        removeDropDown()
    }
    
}

extension DropDownView: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if let touchView = touch.view, touchView.isDescendant(of: self.tableView) {
            return false
        }
        return true
    }
    
}


extension UIView {
    var globalPoint: CGPoint? {
        return self.superview?.convert(self.frame.origin, to: nil)
    }
    
    var globalFrame: CGRect? {
        return self.superview?.convert(self.frame, to: nil)
    }
    
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
}

internal extension UIWindow {
    static func visibleWindow() -> UIWindow? {
        var currentWindow = UIApplication.shared.keyWindow
        if currentWindow == nil {
            let frontToBackWindows = Array(UIApplication.shared.windows.reversed())
            for window in frontToBackWindows {
                if window.windowLevel == UIWindow.Level.normal {
                    currentWindow = window
                    break
                }
            }
        }
        return currentWindow
    }
}


extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.width)
    }
}


