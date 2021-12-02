//
//  CustomImagePageControl.swift
//  Mzadi
//
//  Created by Emizentech on 26/08/21.
//

import UIKit

class CustomImagePageControl: UIPageControl {

   let activeImage:UIImage = UIImage(named: "dotwhite")!
      let inactiveImage:UIImage = UIImage(named: "dotclear")!


     // adjust these parameters for specific case
       let customActiveYOffset: CGFloat = 5.0
       let customInactiveYOffset: CGFloat = 5.0
       var hasCustomTintColor: Bool = false
       let customActiveDotColor: UIColor = UIColor(white: 0xe62f3e, alpha: 1.0)

       override var numberOfPages: Int {
           didSet {
               updateDots()
           }
       }

       override var currentPage: Int {
           didSet {
               updateDots()
           }
       }

       override func awakeFromNib() {
           super.awakeFromNib()
           self.pageIndicatorTintColor = .clear
           self.currentPageIndicatorTintColor = .clear
           self.clipsToBounds = false
       }

       func updateDots() {
          var i = 0
          let activeSize = self.activeImage.size
          let inactiveSize = self.inactiveImage.size
          let activeRect = CGRect(x: -4, y: 0, width: activeSize.width , height: activeSize.height)
          let inactiveRect = CGRect(x: 0, y: 0, width: inactiveSize.width, height: inactiveSize.height)

          for view in self.subviews {
              if let imageView = self.imageForSubview(view) {
                  if i == self.currentPage {
                    imageView.image = self.activeImage
                    if self.hasCustomTintColor {
                        imageView.tintColor = customActiveDotColor
                    }
                    imageView.frame = activeRect
                    imageView.frame.origin.y = imageView.frame.origin.y - customActiveYOffset
                  } else {
                    imageView.image = self.inactiveImage
                    imageView.frame = inactiveRect
                    imageView.frame.origin.y = imageView.frame.origin.y - customInactiveYOffset
                  }
                  i = i + 1
              } else {
                  var dotImage = self.inactiveImage
                  if i == self.currentPage {
                      dotImage = self.activeImage
                  }
                  view.clipsToBounds = false
                  let addedImageView: UIImageView = UIImageView(image: dotImage)
                  if dotImage == self.activeImage {
                     addedImageView.frame = activeRect
                     addedImageView.frame.origin.y = addedImageView.frame.origin.y - customActiveYOffset
                    if self.hasCustomTintColor {
                        addedImageView.tintColor = customActiveDotColor
                    }
                 } else {
                     addedImageView.frame.origin.y = addedImageView.frame.origin.y - customInactiveYOffset
                 }
                 view.addSubview(addedImageView)
                 i = i + 1
              }
          }
      }

     func imageForSubview(_ view:UIView) -> UIImageView? {
        var dot: UIImageView?
        if let dotImageView = view as? UIImageView {
            dot = dotImageView
        } else {
            for foundView in view.subviews {
                if let imageView = foundView as? UIImageView {
                    dot = imageView
                    break
                }
            }
        }
        return dot
    }

    }
