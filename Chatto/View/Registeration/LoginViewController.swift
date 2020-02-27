//
//  LoginViewController.swift
//  Chatto
//
//  Created by User on 2/18/20.
//  Copyright © 2020 Adel. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SkyFloatingLabelTextField

class LoginViewController: UIViewController {

     @IBOutlet weak var txtEmail :UITextField!
     @IBOutlet weak var txtPassword :UITextField!
     @IBOutlet weak var btnSignIn :UIButton!

    let disposeBag = DisposeBag()
    let viewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

       signUpDidPressed()
       setCallBack()
    }
    func signUpDidPressed(){
        btnSignIn.rx.tap
            .`do`(onNext:  { [unowned self] in
                self.txtEmail.resignFirstResponder()
                self.txtPassword.resignFirstResponder()
            }).subscribe(onNext: { [unowned self] in
                self.viewModel.login(with: self.txtEmail.text ?? "", and: self.txtPassword.text ?? "")
            }).disposed(by: disposeBag)
    }
    func setCallBack(){
        viewModel
            .isSuccess
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (value) in

                self?.performSegue(withIdentifier: "channels", sender: nil)
            }).disposed(by: disposeBag)

        viewModel.isLoading
            .bind(to: self.rx.isAnimating)
            .disposed(by: disposeBag)

        viewModel
            .isError
            .bind(to: self.rx.isError)
            .disposed(by: disposeBag)
    }

}
