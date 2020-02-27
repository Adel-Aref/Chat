
//
//  RegisterationViewController.swift
//  Chatto
//
//  Created by User on 2/17/20.
//  Copyright © 2020 Adel. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SkyFloatingLabelTextField

class RegisterationViewController: UIViewController {

    @IBOutlet weak var btnSignUp :UIButton!
    @IBOutlet weak var txtName :SkyFloatingLabelTextField!
    @IBOutlet weak var txtEmail :SkyFloatingLabelTextField!
    @IBOutlet weak var txtPassword :SkyFloatingLabelTextField!
    
    let viewModel = registerationViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCallBack()
        signUpDidPressed()
    }
    func signUpDidPressed(){
        btnSignUp.rx.tap
            .`do`(onNext:  { [unowned self] in
                self.txtEmail.resignFirstResponder()
                self.txtPassword.resignFirstResponder()
            }).subscribe(onNext: { [unowned self] in
                let dic = [
                    "email":self.txtEmail.text ?? "",
                    "password": self.txtPassword.text ?? "",
                    "displayName" : self.txtName.text ?? ""
                    ] as [String : String]
                self.viewModel.createUser(dic: dic)
            }).disposed(by: disposeBag)
    }
    func setCallBack(){
        viewModel
            .isSuccess
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (value) in
            
            self?.performSegue(withIdentifier: "signIn", sender: nil)
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
