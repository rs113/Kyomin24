//
//  UploadStatusView.swift
//  World Album
//
//  Created by Shubham Sharma on 10/04/20.
//  Copyright © 2020 Shubham Sharma. All rights reserved.
//

import UIKit
import Alamofire
protocol UploadStatusDelegate {
	func fileUploaded(response: NetworkResponseState,
					  uploadStatusView: UploadStatusView,
					  messageType: MessageType,
					  fileMeta: [String: Any],
					  date: Date)
}
class UploadStatusView: UIView {
	 
	
	@IBOutlet weak var uploadProgress: UIImageView!
	@IBOutlet weak var progressUploadImage: UIImageView!
	@IBOutlet weak var fileTitle: UILabel!
	@IBOutlet weak var fileProgress: UILabel!
	@IBOutlet weak var progressBar: UIProgressView!
	
	fileprivate var upload: UploadRequest?
	
	fileprivate var messageType: MessageType!
	fileprivate var fileMeta: [String: Any]!
	fileprivate var date: Date!
	
	var delegate: UploadStatusDelegate?
	 
	
	deinit {
		print("UploadStatusView deinit")
	}

	@IBAction func didTapCancel(_ sender: UIButton) {
		upload?.cancel()
	}
	
	fileprivate func fileUploaded(response: NetworkResponseState,
								  messageType: MessageType,
								  fileMeta: [String: Any],
								  date: Date){
		self.delegate?.fileUploaded(response: response, uploadStatusView: self, messageType: self.messageType, fileMeta: self.fileMeta, date: date)
		releaseTheMemory()
		
	}
	fileprivate func releaseTheMemory()  {
		self.delegate = nil
		self.upload = nil
	}
	//MARK: Public Methods
	public class func initialize(with frame: CGRect) -> UploadStatusView? {
		let view = UINib(nibName: "UploadStatusView", bundle: nil).instantiate(withOwner: self, options: nil).first as? UploadStatusView
		 
		return view
	}
	
	func uploadChatFile(file: SSFiles, parameters: Parameters, messageType: MessageType, fileMeta: [String: Any], date: Date) {
		
		self.messageType = messageType
		self.fileMeta = fileMeta
		self.date = date
		 
		
		callService(url: NetworkManager.URL_FILE_UPLOAD, item: file, parameters: parameters )
		
		//		fileTitle.text = file.name
		if let thumb: UIImage = file.thumbImage {
			uploadProgress.image = thumb
		}else if let thumb: UIImage = file.image {
			uploadProgress.image = thumb
		}else {
			
		}
		self.fileMeta[MediaMetaModel.KEY_FILE_SIZE] = -1
		
		if let fileUrl: URL = file.url {
			var fileSize : UInt64
			do {
				let attr = try FileManager.default.attributesOfItem(atPath: fileUrl.path)
				fileSize = attr[FileAttributeKey.size] as! UInt64
				fileTitle.text = FileUtils.convertFileSize(byteSize: Double(fileSize))
				self.fileMeta["file_size"] = fileSize
			} catch {
				print("Error: \(error)")
			}
        }else{
            // get size in bytes
          let imgsize=file.image?.getSizeIn(.byte)
            self.fileMeta["file_size"] = imgsize
            print(imgsize)
        }
	}
	
	func callService(url: String, item: SSFiles, parameters:Parameters){
		
        
        let headers: HTTPHeaders!
         headers = [
             "Authorization": "Bearer \(obj.prefs.value(forKey: APP_ACCESS_TOKEN) as? String ?? "")",
             "X-localization":obj.prefs.value(forKey: APP_CURRENT_LANG) as? String ?? "en"
         ]
		AF.upload(
			multipartFormData: { multipartFormData in
				if let fileUrl: URL = item.url {
					do {
						let data = try Data(contentsOf: fileUrl )
						multipartFormData.append(data, withName: "file", fileName: (fileUrl.absoluteString as NSString).lastPathComponent, mimeType: "application/octet-stream")
						
						var fileName: String = (fileUrl.absoluteString as NSString).lastPathComponent
						fileName = fileName.replacingOccurrences(of: ".\(fileUrl.pathExtension)", with: ".jpg")
						if let thumb: UIImage = item.thumbImage {
                            multipartFormData.append(thumb.jpegData(compressionQuality: 1.0)!, withName: "thumbnail", fileName: fileName, mimeType: "image/jpg")
						}
						
					} catch let error{
						print(error)
					}
				} else if let image = item.image {
                    guard let imageData = image.jpegData(compressionQuality: 1.0) else {
						print("Could not get JPEG representation of UIImage")
						return
					}
					
					let fileName: String = "\(Date().timeIntervalSince1970).jpg"
					
					multipartFormData.append(imageData, withName: "file", fileName: fileName, mimeType: "image/jpg")
					
					if let thumb: UIImage = item.thumbImage {
                        multipartFormData.append(thumb.jpegData(compressionQuality: 1.0)!, withName: "thumbnail", fileName: fileName, mimeType: "image/jpg")
					}
				}
				
				for (key, value) in parameters {
					multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
				}
				
    }, to: url, method: .post, headers: headers).uploadProgress(queue: .main, closure: {[weak self]  (fileUploadProgress) in
           if let selfStrong = self {
             print(fileUploadProgress)
             let progress = Float(fileUploadProgress.fractionCompleted)
    
           DispatchQueue.main.async {
           selfStrong.progressBar.progress = progress
           selfStrong.fileProgress.text = String(format: "%.2f", (progress * 100))
          }
        }
    })
                   .responseJSON { [weak self] (response) in
                    if let selfStrong = self {
                        
                       switch response.result {
                       case .success(let upload):
                        
                        selfStrong.upload = upload as? UploadRequest

                           if response.response?.statusCode == 200 {
                            let responseJSON = response.value as? [String: Any]
                            selfStrong.fileUploaded(response: .success(responseJSON ?? [String: Any]()), messageType: selfStrong.messageType, fileMeta: selfStrong.fileMeta, date: selfStrong.date)
                           }else{
                            selfStrong.fileUploaded(response: .failed("Something went wrong!!"), messageType: selfStrong.messageType, fileMeta: selfStrong.fileMeta, date: selfStrong.date)
                           }
                          
          
                   case .failure( _):
                        selfStrong.fileUploaded(response: .failed("Something went wrong!!"), messageType: selfStrong.messageType, fileMeta: selfStrong.fileMeta, date: selfStrong.date)
                   }
                    
				
			}
		
       
            
        }
	}
}

