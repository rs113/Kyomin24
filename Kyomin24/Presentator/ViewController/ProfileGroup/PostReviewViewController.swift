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
        
        self.navigationController?.popViewController(animated: true)

    }
    
    @IBAction func ContinueBtnClicked(_ sender: Any) {
        
        ProfileApiFunc()
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
    
    
    func ProfileApiFunc(){
        
        let userId = obj.prefs.string(forKey: APP_USER_ID) ?? ""
        
        let idInt = Int(userId) ?? 0
        print(idInt)
        let dictRegParam = [
            
            "profile_id": 87,
            "review": addReviewTxt.text ?? ""

            
        ]  as [String : Any]
        
        
        print(dictRegParam)
        
        ApiManager.apiShared.sendRequestServerPostWithHeaderK24(url: PostAreveiw, VCType: self, dictParameter: dictRegParam, success: { [self] (ResponseJson) in
            
            let stCode = ResponseJson["status_code"].int
            let strMessage = ResponseJson["message"].string
        
            if stCode == 200{
                
                if let resdata = ResponseJson["data"].dictionary{
                    
                    self.navigationController?.popViewController(animated: true)

                }
            }else{
                self.showCustomPopupView(altMsg: strMessage ?? "", alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
                    self.dismiss(animated: true, completion: nil)
                })
            }
            

        }) { (Strerr,stCode) in
            self.showCustomPopupView(altMsg: Strerr, alerttitle: "Error!".localized(), alertimg: UIImage(named: "Errorimg") ?? UIImage(), OkAction: {
                self.dismiss(animated: true, completion: nil)
            })
        }
        
        
    }
}
