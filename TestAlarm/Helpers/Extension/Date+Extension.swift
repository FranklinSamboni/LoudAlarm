//
//  Date+Extension.swift
//  TestAlarm
//
//  Created by Franklin Samboni on 3/11/20.
//

import Foundation

extension Date {
    
    func dateFormatted(format: String) -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: self)
        
        guard let year = components.year, year > 1970 else {
            return ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT-05:00")
        dateFormatter.locale = Locale(identifier: "es_CO")
        dateFormatter.dateFormat = format
        dateFormatter.amSymbol = "am"
        dateFormatter.pmSymbol = "pm"
        return dateFormatter.string(from: self)
    }
    
}
