//
//  String.swift
//  RxTest
//
//  Created by myxc on 2018/8/14.
//  Copyright © 2018 myxc. All rights reserved.
//

import UIKit

extension String {

    //MARK:获取StoryBoard中的Controller
    func getVC() -> UIViewController {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(withIdentifier: self) as UIViewController
        return controller
    }
    
}
