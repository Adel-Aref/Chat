//
//  Message.swift
//  Chatto
//
//  Created by User on 2/20/20.
//  Copyright © 2020 Adel. All rights reserved.
//

import Foundation
struct Conversation: Codable, Hashable {
    var messages: [Message] = [Message]()
    
    init(messages: [Message]) {
        self.messages = messages
    }
    mutating func appendMessage(msg: String, timeStamp: String, first_member: String,second_member:String) {
        self.messages.append(Message(msg: msg, timeStamp: timeStamp, first_member: first_member,second_member:second_member))
    }
}

struct Message: Codable, Hashable {
    var msg: String?
    var timeStamp: String?
    var first_member :String?
    var second_member:String?
    
    init(msg: String, timeStamp: String,first_member :String,second_member :String) {
        self.msg = msg
        self.timeStamp = timeStamp
        self.first_member = first_member
        self.second_member = second_member
    }
}
