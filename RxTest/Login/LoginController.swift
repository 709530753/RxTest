//
//  LoginController.swift
//  RxTest
//
//  Created by myxc on 2018/8/13.
//  Copyright © 2018 myxc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var passWord: UITextField!
    
    @IBOutlet weak var commitBtn: UIButton!
    
    @IBOutlet weak var errorMessage: UILabel!
    
    fileprivate var isLoaded: Bool = false
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isLoaded = true
        viewModel = LoginModel()
        viewModel?.loginModel = LoginImpl()
        refreshDisplay()

        userName.rx.text.orEmpty.changed.subscribe(onNext:{[weak self] in
            print("changed--您输入的是: \($0)")
            self?.viewModel?.username = self?.userName.text ?? ""
        }).disposed(by: disposeBag)
        
        passWord.rx.text.orEmpty.changed.subscribe(onNext:{[weak self] in
            print("changed--您输入的是: \($0)")
           self?.viewModel?.password = self?.passWord.text ?? ""
        }).disposed(by: disposeBag)
        
        commitBtn.rx.tap
            .subscribe({ _ in
                print("点击了!")
                self.viewModel?.submit()
            })
            .disposed(by: disposeBag)
        
    }
    
    var viewModel: LoginModel? {
        willSet {
            viewModel?.viewDelegate = nil
        }
        didSet {
            viewModel?.viewDelegate = self
            refreshDisplay()
        }
    }
    
    fileprivate func refreshDisplay() {
       
        guard isLoaded else { return }

        if let viewModel = viewModel {
            userName.text = viewModel.username
            passWord.text = viewModel.password
            errorMessage.text = viewModel.errorMessage
            commitBtn.isEnabled = viewModel.canSubmit
        } else {
            userName.text = ""
            passWord.text = ""
            errorMessage.text = ""
            commitBtn.isEnabled = false
        }
    }

}

extension LoginController: LoginModelViewDelegate {
    func errorMessageDidChange(_ viewModel: LoginModelInterface, message: String) {
      
        self.errorMessage.text = message

    }
    
    func canSubmitStatusDidChange(_ viewModel: LoginModelInterface, status: Bool)
    {
        self.commitBtn.isEnabled = status
    }
}
