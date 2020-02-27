//
//  LoginViewModel.swift
//  Chatto
//
//  Created by User on 2/18/20.
//  Copyright © 2020 Adel. All rights reserved.
//

import Foundation
import RxSwift
import Firebase

class LoginViewModel {
    let isSuccess : PublishSubject<Bool> = PublishSubject()
    let isLoading : PublishSubject<Bool> = PublishSubject()
    let isError: PublishSubject<ErroeMessage> = PublishSubject()
    var userClient :UserClientProtocol?
    init(client :UserClientProtocol = UserClient()) {
        self.userClient = client
    }
    func login(with email: String, and password: String){
        isLoading.onNext(true)
        userClient?.login(with: email, and: password, completion: { [weak self](result) in
            self?.isLoading.onNext(false)
            switch result{
            case .success(_):
                let userID = Auth.auth().currentUser?.uid
                self?.didSucess(email: email, userId:userID ?? "" )
                self?.isSuccess.onNext(true)
            case .failure(_):
                
                let error = ErroeMessage(title: "Error", message: "Internal Error", action: nil)
                self?.isError.onNext(error)
            }
        })
    }
    func signOut(){
        isLoading.onNext(true)
        userClient?.signOut(completion: { [weak self](res) in
            self?.isLoading.onNext(false)
            switch res{
            case .success(_):
                self?.isSuccess.onNext(true)
            case .failure(_):
                let error = ErroeMessage(title: "Error", message: "Internal error", action: nil)
                self?.isError.onNext(error)
            }
        })
    }
    func didSucess(email :String , userId :String){
        UserDefaults.standard.userEmail = email
        UserDefaults.standard.userID = userId
        UserDefaults.standard.isLoggedIn = true
    }
    
    
}
