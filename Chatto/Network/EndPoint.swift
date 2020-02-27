//
//  EndPoint.swift
//  We
//
//  Created by ahmed mahdy on 11/2/19.
//  Copyright © 2019 Mahdy. All rights reserved.
//

import Foundation

struct Endpoint {
    let type: EndPointType
    let path: String
}
extension Endpoint {
    static func regestration() -> Endpoint {
        return Endpoint(type: .base,
                        path: "ipmagix.studentsapi"
        )
    }
    
}
extension Endpoint {
    var url: URL? {
        switch type {
        case .base:
            let base = "https://demo6589417.mockable.io/"
            return URL(string: base + path)
        }
    }
}

enum EndPointType {
    case base
}

