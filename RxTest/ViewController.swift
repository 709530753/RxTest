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
import SLMPatternLock
import SLMAuthKit
import RxAlamofire

class ViewController: UIViewController {

    @IBOutlet weak var mainTable: UITableView!
    //数据源
    let mainTitleModel = MainTitleModel()
    //负责对象销毁
    let disPosBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        SLMPatternLockManager().startPattern()
        //哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈
        //注释
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

        request(.get, "http://localhost:9528/Demo/message/message.json").data().subscribe(onNext: { (data) in
            print(data)
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : Any]
            print("json :\(String(describing: json))")
        }).disposed(by: disPosBag)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        MBProgressHUD.hideHUDForView(view: self.view)

    }
    
}

