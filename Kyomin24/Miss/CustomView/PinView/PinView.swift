//
//  PinView.swift
//  LovCash
//
//  Created by ABC on 14/06/18.
//  Copyright © 2018 ABC. All rights reserved.
//

import UIKit

protocol PinViewDelegate: NSObjectProtocol {
    func pinViewBeginEditing()
    func pinViewDidChange(_ text: String)
    func pinViewDidEndEditing()
}

class PinView: UIView, UITextFieldDelegate {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var hiddenTextField: UITextField!
    @IBOutlet var textFields: [UITextField]!
    weak var delegate: PinViewDelegate?
    
    var pin: String {
        set {
            setPinValue(newValue)
        } get {
            return (textFields.map() { $0.text ?? "" }).joined(separator: "")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialSetup()
    }
    
    func startEditing() {
        hiddenTextField.becomeFirstResponder()
    }
    
    func makeSecureText(_ status: Bool) {
        _ = textFields.map() { $0.isSecureTextEntry = status }
    }
    
    
    func setPinValue(_ text: String) {
        hiddenTextField.text = text
        for i in 0 ..< textFields.count {
            delegate?.pinViewDidChange(text)
            textFields[i].text = i < text.count ? "\(text[i])" : ""
        }
    }
    
    // MARK: - Private methods
    
    fileprivate func initialSetup() {
        _ = Bundle.main.loadNibNamed(self.nameOfClass, owner: self, options: nil)
        addSubview(self.contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin]
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField != hiddenTextField {
            hiddenTextField.text = pin
            hiddenTextField.becomeFirstResponder()
            delegate?.pinViewBeginEditing()
            return false
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldString = textField.text else { return true }
        let newString = oldString.replacingCharacters(in: Range(range, in: oldString)!, with: string)
        for i in 0 ..< textFields.count {
            delegate?.pinViewDidChange(newString)
            
            textFields[i].text = i < newString.count ? "\(newString[i])" : ""
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.pinViewDidEndEditing()
    }
    
}

