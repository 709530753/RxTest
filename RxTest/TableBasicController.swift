//
//  TableBasicController.swift
//  RxTest
//
//  Created by myxc on 2018/8/12.
//  Copyright © 2018 myxc. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class TableBasicController: UIViewController {

    @IBOutlet weak var mainTable: UITableView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainTable.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")

        let items = Observable.just([ "文本输入框的用法",
                                      "开关按钮的用法",
                                      "进度条的用法",
                                      "文本标签的用法",])
        //设置单元格数据（其实就是对 cellForRowAt 的封装）
        items.bind(to: mainTable.rx.items) { (tableview,item,element) in
            let cell = tableview.dequeueReusableCell(withIdentifier: "cell")
            cell?.textLabel?.text = "\(item)：\(element)"
            return cell!
        }.disposed(by: disposeBag)
        
        mainTable.rx.itemSelected.subscribe(onNext: { indexPath in
            print("选中项的indexPath为：\(indexPath)")
        }).disposed(by: disposeBag)
        //获取选中项的内容
        mainTable.rx.modelSelected(String.self).subscribe(onNext: { item in
            print("选中项的标题为：\(item)")
        }).disposed(by: disposeBag)
        
        //获取被取消选中项的索引
        mainTable.rx.itemDeselected.subscribe(onNext: { [weak self] indexPath in
            print("被取消选中项的indexPath为：\(indexPath)")
        }).disposed(by: disposeBag)
        
        //获取被取消选中项的内容
        mainTable.rx.modelDeselected(String.self).subscribe(onNext: {[weak self] item in
            print("被取消选中项的的标题为：\(item)")
        }).disposed(by: disposeBag)
        
        
    }

}
