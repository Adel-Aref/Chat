//
//  MessageViewModel.swift
//  Chatto
//
//  Created by User on 2/20/20.
//  Copyright © 2020 Adel. All rights reserved.
//

import Foundation
import RxSwift

class MessageViewModel {
    let isSuccess : PublishSubject<[Message]> = PublishSubject()
    let isSendSuccess : PublishSubject<Bool> = PublishSubject()
    let isLoading : PublishSubject<Bool> = PublishSubject()
    let isError: PublishSubject<ErroeMessage> = PublishSubject()
    let isChecked : PublishSubject<Bool> = PublishSubject()
    
    let messageClient :MessageClientProtocol?
    var changeChannelIdClousre :  (()->())?
    var channelId :String = ""
    {
        didSet{
            changeChannelIdClousre?()
        }
    }
    init(client :MessageClientProtocol = MessageClient()) {
        self.messageClient = client
    }
    
    func sendMEssage(message :[String:Any] , channelID :String){
        self.isLoading.onNext(true)
        messageClient?.sendMessage(with: message, and: channelID, completion: {[weak self] (result) in
            self?.isLoading.onNext(false)
            switch result {
            case .success(_):
                self?.isSendSuccess.onNext(true)
            case .failure(_):
                let error = ErroeMessage(title: "Error", message: "Internal Error", action: nil)
                self?.isError.onNext(error)
            }
        })
    }
    func getMessageHistory(chId :String){
        isLoading.onNext(true)
        messageClient?.getAllChatMessages(with: chId, completion: { [weak self](res) in
            self?.isLoading.onNext(false)
            switch res{
            case .success(let msgs):
                    if let conversation = msgs as? [Message]{
                    self?.isSuccess.onNext(conversation)
                }
            case .failure(_):
                let error = ErroeMessage(title: "error", message: "Internal error", action: nil)
                self?.isError.onNext(error)
            }
        })
    }
  
    func getChannelId(freindId :String)
    {
        let userId = UserDefaults.standard.userID ?? ""
        if freindId.stringAt(0) < userId.stringAt(0)
        {
            channelId = freindId + userId
        }
        else {
            channelId = userId + freindId
        }
       getMessageHistory(chId: channelId)

    }

    
}
