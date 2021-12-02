//
//  SideViewController.swift
//  ChompVendorApp
//
//  Created by Emizentech on 14/04/21.
//  Copyright © 2021 Emizentech. All rights reserved.
//

import UIKit
import SideMenu
import Localize_Swift

class SideViewController:SideMenuNavigationController {

    var st=SideMenuSettings()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
          // go lefiside menu and select default for side menu for arabic
           if Localize.currentLanguage() == "ar" {
                                  UIView.appearance().semanticContentAttribute = .forceRightToLeft
                       self.leftSide = false
            
                             } else {
                                 UIView.appearance().semanticContentAttribute = .forceLeftToRight
                       self.leftSide = true
           }
        
        st.menuWidth=self.view.frame.width*0.86
        st.statusBarEndAlpha=0
        st.presentationStyle = .menuSlideIn
        self.settings=st
     
    }
    

    

}

