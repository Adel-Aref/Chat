//
//  UserDefaults+Keys.swift
//  We
//
//  Created by ahmed mahdy on 11/5/19.
//  Copyright © 2019 Mahdy. All rights reserved.
//

import Foundation

extension UserDefaults {
    private struct Keys {
        static let isLoggedIn: String = "isLoggedIn"
        static let userEmail: String = "userEmail"
        static let userID: String = "userID"
        static let displayName: String = "displayName"
        static let userImagePath: String = "userImagePath"
       
    }
    public var isLoggedIn: Bool {
        set {
            set(newValue, forKey: Keys.isLoggedIn)
        }
        get {
            guard let isLoggedIn = value(forKey: Keys.isLoggedIn) as? Bool else { return false }
            return isLoggedIn
        }
    }
  
  
    public var userEmail: String? {
        set {
            set(newValue, forKey: Keys.userEmail)
        }
        get {
            guard let email = value(forKey: Keys.userEmail) as? String else { return nil }
            return email
        }
    }

    public var userID: String? {
        set {
            set(newValue, forKey: Keys.userID)
        }
        get {
            guard let userID = value(forKey: Keys.userID) as? String else { return nil }
            return userID
        }
    }
  
  
 
    public var userImagePath: String? {
        set {
            set(newValue, forKey: Keys.userImagePath)
        }
        get {
            guard let image = value(forKey: Keys.userImagePath) as? String else { return nil }
            return image
        }
    }
    public var displayName: String? {
        set {
            set(newValue, forKey: Keys.displayName)
        }
        get {
            guard let displayName = value(forKey: Keys.displayName) as? String else { return nil }
            return displayName
        }
    }
}
