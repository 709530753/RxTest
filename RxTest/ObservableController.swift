//
//  ObservableController.swift
//  RxTest
//
//  Created by myxc on 2018/8/11.
//  Copyright © 2018 myxc. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ObservableController: UIViewController {
    
    var subject:PublishSubject<String>! = PublishSubject<String>()

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if (subject != nil) {
            subject.onNext("😁😁😁😁😁😁")
        }
        
    }
    
}
