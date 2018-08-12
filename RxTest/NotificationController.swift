//
//  NotificationController.swift
//  RxTest
//
//  Created by myxc on 2018/8/12.
//  Copyright © 2018 myxc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NotificationController: UIViewController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        _ = NotificationCenter.default.rx.notification(Notification.Name.UIApplicationDidEnterBackground).takeUntil(self.rx.deallocated).subscribe(onNext: { _ in
          print("程序进入到后台了!")
        })
        
    }

}
