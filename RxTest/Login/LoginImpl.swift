//
//  LoginImpl.swift
//  RxTest
//
//  Created by myxc on 2018/8/14.
//  Copyright © 2018 myxc. All rights reserved.
//

import UIKit

//登录接口实现
class LoginImpl: LoginInterface {
    
    func login(username: String, password: String, completionHandler: @escaping (NSError?) -> ()) {
        DispatchQueue.global().async {
            var error: NSError? = nil
            if username != "123@qq.com" || password != "123456" {
                error = NSError(domain: "MVVM-C",
                                code: 1,
                                userInfo: [NSLocalizedDescriptionKey: "Invalid Email or Password"])
            }
            completionHandler(error)
        }
    }

}

//登录信息接口实现
class LoginModel: LoginModelInterface {
    var viewDelegate: LoginModelViewDelegate?
    var loginModel: LoginInterface?
    
    fileprivate var userNameIsValidFormat: Bool = false
    fileprivate var passwordIsValidFormat: Bool = false
    
    var username: String = "" {
        
        didSet {
            if oldValue != username {
                let oldCanSubmit = canSubmit
                userNameIsValidFormat = validateUserNameFormat(username)
                if canSubmit != oldCanSubmit {
                    print("canSubmit : \(canSubmit)")
                    viewDelegate?.canSubmitStatusDidChange(self, status: canSubmit)
                }
            }
        }
        
    }
    
    var password: String = "" {
        
        didSet {
            if oldValue != password {
                let oldCanSubmit = canSubmit
                passwordIsValidFormat = validatePasswordFormat(password)
                if canSubmit != oldCanSubmit {
                    viewDelegate?.canSubmitStatusDidChange(self, status: canSubmit)
                }
            }
        }
        
    }
    
    var canSubmit: Bool {
        return userNameIsValidFormat && passwordIsValidFormat
    }
    
    func submit() {
        errorMessage = "提交了"
        guard let dataModel = loginModel , canSubmit else {
            errorMessage = NSLocalizedString("NOT_READY_TO_SUBMIT", comment: "")
            return
        }
        dataModel.login(username: username, password: password, completionHandler: { [weak self] (error) in
            print("username:\(String(describing: self?.username)) password: \(String(describing: self?.password))")
            if let error = error { self?.errorMessage = error.description; return }
            self?.errorMessage = "登录成功!"
        })
        
    }
    
    var errorMessage: String = "" {
        
        didSet {
            if oldValue != errorMessage {
                viewDelegate?.errorMessageDidChange(self, message: errorMessage)
            }
        }
        
    }
    
}

extension LoginModel {
    
    fileprivate func validateUserNameFormat(_ email: String) -> Bool {
        let REGEX: String
        REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,32}"
        return NSPredicate(format: "SELF MATCHES %@", REGEX).evaluate(with: email)
    }
    
    fileprivate func validatePasswordFormat(_ password: String) -> Bool {
        let trimmedString = password.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return trimmedString.count > 5
    }
    
}

