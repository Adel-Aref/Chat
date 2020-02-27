//
//  RegisterationViewModel.swift
//  Chatto
//
//  Created by User on 2/17/20.
//  Copyright © 2020 Adel. All rights reserved.
//

import Foundation
import RxSwift

class registerationViewModel{
    
    let isSuccess : PublishSubject<Bool> = PublishSubject()
    let isLoading : PublishSubject<Bool> = PublishSubject()
    let isError: PublishSubject<ErroeMessage> = PublishSubject()
    
//    var showValidationAlert: (()->())?
//    var updateLoadingStatus: (()->())?
//    var showNetworkError: (()->())?
   var userClinet :UserClientProtocol?
//
    init(userClient :UserClientProtocol = UserClient()) {
        self.userClinet = userClient
    }
//
//    var errorMessage :String? {
//        didSet{
//            self.showNetworkError?()
//        }
//    }
//    var state: State = .empty {
//        didSet {
//            self.updateLoadingStatus?()
//        }
//    }
//    var stateValid :ValidationError = .empty{
//        didSet{
//            self.showValidationAlert?()
//        }
//    }
//    func validateLoginDate(txtUsername :String? , txtPassword :String?){
//        if txtUsername?.isEmpty ?? false && txtPassword?.isEmpty ?? false{
//            stateValid = .empty
//        }
//        else if txtUsername?.isEmpty ?? false {
//            stateValid = .usernameEmpty
//        }
//        else if txtPassword?.isEmpty ?? false{
//            stateValid = .passwordEmpty
//        }
//        else if !(txtUsername?.isValidEmail() ?? false){
//            stateValid = .usernameNotValid
//        }
//        else if txtPassword?.count ?? 0 < 6 {
//            stateValid = .PasswordNotValid
//        }
//        else {
//            stateValid = .success
//        }
//    }
    func createUser(dic :[String :String]){
         isLoading.onNext(true)
            userClinet?.registerNewUser(with: dic, completionHandler: {[weak self] (result) in
                self?.isLoading.onNext(false)
                switch result{
                case .success(let user) :
                    self?.saveToUserDefault(displayName: dic["displayName"] ?? "")
                       self?.isSuccess.onNext(true)
                case .failure(let error) :
                    let error = ErroeMessage(title: "we", message: "Internal error", action: nil)
                    self?.isError.onNext(error)
                }
            })
    }
    func saveToUserDefault(displayName :String){
        UserDefaults.standard.displayName = displayName
    }
}


