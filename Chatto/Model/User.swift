//
//  User.swift
//  Chatto
//
//  Created by User on 2/17/20.
//  Copyright © 2020 Adel. All rights reserved.
//

import Foundation


struct User: Codable,Equatable {
    let username: String?
    let password: String?
    let email :String?
    let userImage :String?
}
struct UserViewModel :Codable{
    let displayName :String?
    let channelId :String?
}

