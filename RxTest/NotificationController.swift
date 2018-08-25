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
    
    @IBOutlet weak var mainTable: UITableView!
    
    lazy var data = Observable.just([["title":"username","subTitle":"divay"],
                                     ["title":"password","subTitle":"123456"]])
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.mainTable.delegate = self
        self.mainTable.dataSource = self
        _ = NotificationCenter.default.rx.notification(Notification.Name.UIApplicationDidEnterBackground).takeUntil(self.rx.deallocated).subscribe(onNext: { _ in
          print("程序进入到后台了!")
        })
        
//        data.bind(to: mainTable.rx.items(cellIdentifier: "cell")) { _ ,data ,cell in
//            cell.textLabel?.text = data["title"]
//            cell.detailTextLabel?.text = data["subTitle"]
//        }.disposed(by: disposeBag)
        
    }

}

extension NotificationController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = "username"
        return cell
    }
    
    
}
