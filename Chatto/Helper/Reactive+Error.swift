//
//  Reactive+Error.swift
//  FlickrImageSearch
//
//  Created by ahmed mahdy on 11/10/19.
//  Copyright © 2019 Mahdy. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension UIViewController: errorViewable {}

extension Reactive where Base: UIViewController {

    /// Bindable sink for isError() method.
    public var isError: Binder<ErroeMessage> {
        return Binder(self.base, binding: { (vc, error) in
            vc.showError(with: error)
        })
    }
}


protocol errorViewable {
    func showError(with: ErroeMessage)
}
extension errorViewable where Self : UIViewController {
    func showError(with: ErroeMessage) {
        let alertController = UIAlertController(title: with.title, message: with.message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title:NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {(action) in
            if let action = with.action {
                action()
            }
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

public struct ErroeMessage {
    let title: String?
    let message: String?
    let action: (()->())?
}
