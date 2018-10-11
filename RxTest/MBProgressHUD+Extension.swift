//
//  MBProgressHUD+Extension.swift
//  RxTest
//
//  Created by myxc on 2018/9/27.
//  Copyright © 2018 myxc. All rights reserved.
//

import Foundation
import MBProgressHUD

extension MBProgressHUD {
    
    class func show(message:String, view:UIView) {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = message
        hud.removeFromSuperViewOnHide = true
    }

     class func hideHUDForView(view:UIView) {
        self.hide(for: view, animated: true)
    }
    
}
