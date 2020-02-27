//
//  Connectivity.swift
//  We
//
//  Created by User on 11/14/19.
//  Copyright © 2019 Mahdy. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class var isConnected:Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
