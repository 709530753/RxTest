//
//  TextFieldController.swift
//  RxTest
//
//  Created by myxc on 2018/8/11.
//  Copyright © 2018 myxc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TextFieldController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var commit: UIButton!
    @IBOutlet weak var label: UILabel!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
/*
        textField.rx.text.orEmpty.asObservable().subscribe(onNext:{
            print("orEmpty --您输入的是: \($0)")
        }).disposed(by: disposeBag)
        
        //文本改变时候的打印 与只用orEmpty 效果一样
        textField.rx.text.orEmpty.changed.subscribe(onNext:{
            print("changed--您输入的是: \($0)")
        }).disposed(by: disposeBag)
        
        //当文本框内容改变
       let input = textField.rx.text.orEmpty
            .asDriver() // 将普通序列转换为 Driver
            .throttle(0.3)//在主线程中操作，0.3秒内值若多次改变，取最后一次
        
        //内容绑定到另一个输入框中
        input.drive(textField2.rx.text).disposed(by: disposeBag)
   
        //内容绑定到文本标签中
        input.map{ "当前字数：\($0.count)" }
            .drive(self.textView.rx.text)
            .disposed(by: disposeBag)
        
        //根据内容字数决定按钮是否可用
        input.map{ $0.count > 5 }
            .drive(commit.rx.isEnabled)
            .disposed(by: disposeBag)
        
        //同时监听多个 textField 内容的变化
        Observable.combineLatest(self.textField.rx.text.orEmpty,self.textField2.rx.text.orEmpty) { (textFieldValue,textFieldValue2) -> String in
            return "你输入的是：\(textFieldValue)-\(textFieldValue2)"
            }.map { ($0) }.bind(to: label.rx.text).disposed(by: disposeBag)
        
        //开始编辑
        textField.rx.controlEvent([.editingDidBegin])//状态可以组合
            .asObservable().subscribe(onNext:{_ in
                print("开始编辑内容!")
            }).disposed(by: disposeBag)
 */
        /*示例
//        如果当前焦点在用户名输入框时，按下 return 键时焦点自动转移到密码输入框上。
//        如果当前焦点在密码输入框时，按下 return 键时自动移除焦点
        //在用户名输入框中按下 return 键
        textField.rx.controlEvent(.editingDidEndOnExit).subscribe(onNext: {
            [weak self] (_) in
            self?.textField2.becomeFirstResponder()
        }).disposed(by: disposeBag)
        
        //在密码输入框中按下 return 键
        textField2.rx.controlEvent(.editingDidEndOnExit).subscribe(onNext: {
            [weak self] (_) in
            self?.textField2.resignFirstResponder()
        }).disposed(by: disposeBag)

 */
        
        //开始编辑响应
        textView.rx.didBeginEditing
            .subscribe(onNext: {
                print("开始编辑")
            })
            .disposed(by: disposeBag)
        
        //结束编辑响应
        textView.rx.didEndEditing
            .subscribe(onNext: {
                print("结束编辑")
            })
            .disposed(by: disposeBag)
        
        //内容发生变化响应
        textView.rx.didChange
            .subscribe(onNext: {
                print("内容发生改变")
            })
            .disposed(by: disposeBag)
        
        //选中部分变化响应
        textView.rx.didChangeSelection
            .subscribe(onNext: {
                print("选中部分发生变化")
            })
            .disposed(by: disposeBag)
        
    }

}
