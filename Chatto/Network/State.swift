
//
//  State.swift
//  We
//
//  Created by User on 1/21/20.
//  Copyright © 2020 Mahdy. All rights reserved.
//

import Foundation

public enum State {
    case loading
    case error
    case empty
    case populated
    case repeated
}

//
public enum ValidationError :String {
    case passwordEmpty = "password field is empty"
    case usernameEmpty = "username field is empty"
    case usernameNotValid = "username field is not valid"
    case PasswordNotValid = "password field is not valid"
    case empty = "username and password fields are empty"
    case success = "sucess"
}

