//
//  ChannelsListViewModel.swift
//  Chatto
//
//  Created by User on 2/18/20.
//  Copyright © 2020 Adel. All rights reserved.
//

import Foundation
import RxSwift

class ChannelsListViewModel{
    let isSuccess : PublishSubject<[Channel]> = PublishSubject()
    let isLoading : PublishSubject<Bool> = PublishSubject()
    let isError: PublishSubject<ErroeMessage> = PublishSubject()
    
    var channelClient :ChannelClientProtocol?
    
    init(client :ChannelClientProtocol = ChannelClient()) {
        self.channelClient = client
    }
    func observeChannels(){
        isLoading.onNext(true)
        channelClient?.observeChannels(with: "Users", completion: { [weak self](result) in
            guard let self = self else {return}
            self.isLoading.onNext(false)
            switch result{
            case .success(let channels):
                    if let channelList = channels as? [Channel]{
                        self.isSuccess.onNext(channelList)
                }
                case .failure(let error):
                    let error = ErroeMessage(title: "Error", message: error.localizedDescription, action: nil)
                    self.isError.onNext(error)
                }
        })
    }
        
}
