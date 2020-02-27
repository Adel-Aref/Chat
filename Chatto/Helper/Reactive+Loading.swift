//
//  Reactive+Loading.swift
//  NearBy-Places
//
//  Created by ahmed mahdy on 11/2/19.
//  Copyright © 2019 Mahdy. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension UIViewController: loadingViewable {}

extension Reactive where Base: UIViewController {

    /// Bindable sink for `startAnimating()`, `stopAnimating()` methods.
    public var isAnimating: Binder<Bool> {
        return Binder(self.base, binding: { (vc, active) in
            if active {
                vc.startAnimating()
            } else {
                vc.stopAnimating()
            }
        })
    }

}
