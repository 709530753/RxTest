//
//  LabelEtensionController.swift
//  RxTest
//
//  Created by myxc on 2018/8/11.
//  Copyright © 2018 myxc. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class LabelEtensionController: UIViewController {

    @IBOutlet weak var rxLabel: UILabel!
    
    @IBOutlet weak var attributeLabel: UILabel!
    
    let disPoseBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        //创建定时器
        let timer = Observable<Int>.interval(0.1, scheduler: MainScheduler.instance)
        
        timer.map { String.init(format: "%0.2d:%0.2d.%0.1d", arguments:[($0 / 600) % 600, ($0 % 600 ) / 10, $0 % 10])}.bind(to: rxLabel.rx.text).disposed(by: disPoseBag)
        
        timer.map(formatTimeInterval)
            .bind(to: attributeLabel.rx.attributedText)
            .disposed(by: disPoseBag)
    }

    //将数字转成对应的富文本
    func formatTimeInterval(ms: NSInteger) -> NSMutableAttributedString {
        let string = String(format: "%0.2d:%0.2d.%0.1d",
                            arguments: [(ms / 600) % 600, (ms % 600 ) / 10, ms % 10])
        //富文本设置
        let attributeString = NSMutableAttributedString(string: string)
        //从文本0开始6个字符字体HelveticaNeue-Bold,16号
        attributeString.addAttribute(NSAttributedStringKey.font,
                                     value: UIFont(name: "HelveticaNeue-Bold", size: 16)!,
                                     range: NSMakeRange(0, 5))
        //设置字体颜色
        attributeString.addAttribute(NSAttributedStringKey.foregroundColor,
                                     value: UIColor.white, range: NSMakeRange(0, 5))
        //设置文字背景颜色
        attributeString.addAttribute(NSAttributedStringKey.backgroundColor,
                                     value: UIColor.orange, range: NSMakeRange(0, 5))
        return attributeString
    }
    
}
