//
//  ExtensionsSwift.swift
//  Followers
//
//  Created by Aleksandr Kurdiukov on 16.05.21.
//

import Foundation

extension String {
    
    func isEmtyOrWhiteSpace() -> Bool {
         return self.filter({$0 != " "}).isEmpty
    }
    
    func convertToDate() -> Date? {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        df.locale = Locale(identifier: "en_US_POSIX")
        df.timeZone = .current
        
        return df.date(from: self)
    }
    
    func convertDateToDisplayFormat() -> String? {
        guard let date = self.convertToDate() else { return nil}
        return date.convertToMmmYyyyFormat()
    }
    
}



extension Date {
    
    func convertToMmmYyyyFormat() -> String {
        let df = DateFormatter()
        df.dateFormat = "MMM d, yyyy"
        
        return df.string(from: self)
    }
}



//MARK: - Link to dateFormats
// https://nsdateformatter.com/

