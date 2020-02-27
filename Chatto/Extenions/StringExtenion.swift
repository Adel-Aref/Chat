
//
//  StringExtenion.swift
//  ElShar
//
//  Created by User on 10/25/19.
//  Copyright © 2019 Adel. All rights reserved.
//

import Foundation
extension String {
    var isInt: Bool {
        return Int(self) != nil
    }
}
extension String {
    
    func stringAt(_ i: Int) -> String {
        return String(Array(self)[i])
    }
    
    func charAt(_ i: Int) -> Character {
        return Array(self)[i]
    }
}
