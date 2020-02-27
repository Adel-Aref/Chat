//
//  StringExtention.swift
//  We
//
//  Created by User on 11/7/19.
//  Copyright © 2019 Mahdy. All rights reserved.
//

import Foundation
extension String{
    func getDate() -> Date? {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        dateFormatter.timeZone = TimeZone(abbreviation: "en_US_POSIX")
        
        let delimiter = "."
        
        let token = self.components(separatedBy: delimiter)
        
        let convertedDate = dateFormatter.date(from:token[0])!
        
        return convertedDate
        
    }
    
//        func isValidEmail() -> Bool {
//            // here, `try!` will always succeed because the pattern is valid
//            let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$+.com", options: .caseInsensitive)
//            return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
//        }
    func isValidEmail() -> Bool {
        let emailRegEx = "^(?:(?:(?:(?: )(?:(?:(?:\\t| )\\r\\n)?(?:\\t| )+))+(?: ))|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’+/=?^'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^'{|}~]+)*)|(?:\"(?:(?:(?:(?: )(?:(?:[!#-Z^-]|\\[|\\])|(?:\\\\(?:\\t|[ -]))))+(?: ))|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?))|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )[!-Z^-])(?: ))|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._!$&'()+,;=:]+))\\])))(?:(?:(?:(?: )(?:(?:(?:\\t| )\\r\\n)?(?:\\t| )+))+(?: ))|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: self)
        return result
    }
    
        func isValidCountryCode() -> Bool {
            let regex = try! NSRegularExpression(pattern: "^+[+0-9]*$", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
        }
        func isValidStringName() -> Bool {
            let regex = try! NSRegularExpression(pattern: "^(?!\\s)[a-zA-Z ]*$", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
        }
        func isValidMobile() -> Bool {
            let regex = try! NSRegularExpression(pattern: "^0[0-9]{8,15}$", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
        }
        func getMonth(month:String) -> String {
            if month == "1" || month == "01"{
                return "Jun"
            }else if month == "2" || month == "02"{
                return "Feb"
            }else if month == "3" || month == "03"{
                return "Mar"
            }else if month == "4" || month == "04"{
                return "Apr"
            }else if month == "5" || month == "05"{
                return "May"
            }else if month == "6" || month == "06"{
                return "Jun"
            }else if month == "7" || month == "07"{
                return "Jul"
            }else if month == "8" || month == "08"{
                return "Agu"
            }else if month == "9" || month == "09"{
                return "Sep"
            }else if month == "10"{
                return "Oct"
            }else if month == "11"{
                return "Nov"
            }else if month == "12"{
                return "Dec"
            }else{
                return month
            }
        }
        
    }


