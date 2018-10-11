//
//  MainTitleModel.swift
//  RxTest
//
//  Created by myxc on 2018/8/11.
//  Copyright © 2018 myxc. All rights reserved.
//

import RxSwift

enum RXSwift_Test_Type {
    case observer_desc
    case observer_listen
    case label_extension
    case textField_extension
    case tableview_basic
    case tableView_RxDataSources
    case mvvm
    case notification
    case rxalamofire
    case login
    case web
}

struct MainTitleModel {

    let titleModel = Observable.just([
            Title.init(title: "Observable介绍、创建可观察序列", subTitle: "", testType: .observer_desc, pushVC: "ObservableController"),
            Title.init(title: "Observable订阅、事件监听、订阅销毁", subTitle: "", testType: .observer_listen, pushVC: "ObservableController"),
            Title.init(title: "UI控件扩展1：UILabel", subTitle: "", testType: .label_extension, pushVC: "LabelEtensionController"),
            Title.init(title: "UI控件扩展2：UITextField、UITextView", subTitle: "", testType: .textField_extension, pushVC: "TextFieldController"),
            Title.init(title: "UITableView的使用1：基本用法", subTitle: "", testType: .tableview_basic, pushVC: "TableBasicController"),
            Title.init(title: "RxDataSources", subTitle: "", testType: .tableView_RxDataSources, pushVC: "RxDataSourcesController"),
            Title.init(title: "MVVM", subTitle: "", testType: .mvvm, pushVC: "RxMvvmController"),
            Title.init(title: "NotificationCenter", subTitle: "", testType: .notification, pushVC: "NotificationController"),
            Title.init(title: "RxAlamofire", subTitle: "", testType: .rxalamofire, pushVC: "RxAlamofireController"),
            Title.init(title: "Login", subTitle: "", testType: .login, pushVC: "LoginController"),
            Title.init(title: "Web", subTitle: "", testType: .web, pushVC: "BaseWKWebController")

        ])

}

struct Title {
    
    let title : String
    let subTitle : String
    let testType : RXSwift_Test_Type
    let pushVC : String

    init(title:String, subTitle:String, testType:RXSwift_Test_Type, pushVC:String) {
        self.title = title
        self.subTitle = subTitle
        self.testType = testType
        self.pushVC = pushVC
    }
    
}

extension Title : CustomStringConvertible {
    var description: String {
        return "title:\(self.title) subTitle:\(self.subTitle) testType:\(self.testType) pushVC:\(self.pushVC)"
    }
    

}
