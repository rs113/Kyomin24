//
//  PostReviewViewController.swift
//  Kyomin24
//
//  Created by emizen on 12/2/21.
//

import UIKit

class PostReviewViewController: UIViewController,UITextViewDelegate {

    @IBOutlet weak var addReviewTxt: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        addReviewTxt.text = "Add a Review..."
        addReviewTxt.textColor = UIColor.lightGray
        addReviewTxt.delegate = self
    }
    
    @IBAction func backBtnClciked(_ sender: Any) {
    }
    
    @IBAction func ContinueBtnClicked(_ sender: Any) {
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Add a Review..."
            textView.textColor = UIColor.lightGray
        }
    }
}
