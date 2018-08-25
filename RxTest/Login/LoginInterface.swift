//
//  LoginModel.swift
//  RxTest
//
//  Created by myxc on 2018/8/13.
//  Copyright © 2018 myxc. All rights reserved.
//

//相当于ViewModel

import UIKit

//MARK:提交错误信息展示接口、输入框状态接口
protocol LoginModelViewDelegate {
    
    func canSubmitStatusDidChange(_ viewModel: LoginModelInterface, status: Bool)
    func errorMessageDidChange(_ viewModel: LoginModelInterface, message: String)

}
//MARK:登录接口
protocol LoginInterface {
    func login(username: String, password: String, completionHandler: @escaping (_ error: NSError?) ->())
}

//登录信息接口
protocol LoginModelInterface {
    
    var viewDelegate: LoginModelViewDelegate? { get set }
    var loginModel: LoginInterface? { get set }
    
    var username:String {get set}
    var password:String {get set}
    
    var canSubmit: Bool { get }
    func submit()

    var errorMessage: String { get }

}
