//
//  ViewController.swift
//  RxTest
//
//  Created by myxc on 2018/8/11.
//  Copyright © 2018 myxc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MBProgressHUD

class ViewController: UIViewController {

    @IBOutlet weak var mainTable: UITableView!
    //数据源
    let mainTitleModel = MainTitleModel()
    //负责对象销毁
    let disPosBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
//         MBProgressHUD.show(message: "", view: self.view)
        //绑定数据
        mainTitleModel.titleModel.bind(to: mainTable.rx.items(cellIdentifier: "cell")) { _, titleModel, cell in
            cell.textLabel?.text = titleModel.title
            cell.detailTextLabel?.text = titleModel.subTitle
        }.disposed(by: disPosBag)
        
        mainTable.rx.modelSelected(Title.self).subscribe(onNext: { titleModel in
            let VC = titleModel.pushVC.getVC()
            VC.title = titleModel.title
            self.navigationController?.pushViewController(VC, animated: true)
        }).disposed(by: disPosBag)
     
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        MBProgressHUD.hideHUDForView(view: self.view)

    }
    
}

