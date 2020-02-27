//
//  ImgExten.swift
//  ElShar
//
//  Created by User on 9/8/19.
//  Copyright © 2019 Adel. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView{
    func setCircleImg(){
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
        self.layer.masksToBounds = true

        //self.layer.borderWidth = 1.0
        //self.layer.borderColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
    }
}
