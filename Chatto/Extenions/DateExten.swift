//
//  DateExten.swift
//  Chatto
//
//  Created by User on 2/24/20.
//  Copyright © 2020 Adel. All rights reserved.
//

import Foundation
extension TimeZone {
    static let gmt = TimeZone(secondsFromGMT: 0)!
}
extension Formatter {
    static let date = DateFormatter()
}
extension Date {
    func localizedDescription(dateStyle: DateFormatter.Style = .medium,
                              timeStyle: DateFormatter.Style = .medium,
                              in timeZone : TimeZone = .current,
                              locale   : Locale = .current) -> String {
        Formatter.date.locale = locale
        Formatter.date.timeZone = timeZone
        Formatter.date.dateStyle = dateStyle
        Formatter.date.timeStyle = timeStyle
        return Formatter.date.string(from: self)
    }
    var localizedDescription: String { return localizedDescription() }
}
extension Date {
    
    var fullDate: String   { return localizedDescription(dateStyle: .full,   timeStyle: .none) }
    var longDate: String   {return localizedDescription(dateStyle: .long,   timeStyle: .none) }
    var mediumDate: String {return localizedDescription(dateStyle: .medium, timeStyle: .none) }
    var shortDate: String  {return localizedDescription(dateStyle: .short,  timeStyle: .none) }
    
    var fullTime: String   {return localizedDescription(dateStyle: .none,   timeStyle: .full) }
    var longTime: String   {return localizedDescription(dateStyle: .none,   timeStyle: .long) }
    var mediumTime: String {return localizedDescription(dateStyle: .none,   timeStyle: .medium) }
    var shortTime: String  {return localizedDescription(dateStyle: .none,   timeStyle: .short) }
    
    var fullDateTime: String   {return localizedDescription(dateStyle: .full,   timeStyle: .full) }
    var longDateTime: String   {return localizedDescription(dateStyle: .long,   timeStyle: .long) }
    var mediumDateTime: String {return localizedDescription(dateStyle: .medium, timeStyle: .medium) }
    var shortDateTime: String  {return localizedDescription(dateStyle: .short,  timeStyle: .short) }
}
