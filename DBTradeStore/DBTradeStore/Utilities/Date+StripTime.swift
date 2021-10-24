//
//  Date+StripTime.swift
//  DBTradeStore
//
//  Created by rakeshj on 24/10/21.
//

import Foundation


extension Date {

    func stripTime() -> Date {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        let date = Calendar.current.date(from: components)
        return date!
    }

    func dateToString(date: Date) -> String {
        
        // Create Date Formatter
        let dateFormatter = DateFormatter()
        
        // Set Date Format
        dateFormatter.dateFormat = "YY/MM/dd"
        
        // Convert Date to String
        return dateFormatter.string(from: date)
    }
}
