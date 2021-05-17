//
//  Extensions.swift
//  Followers
//
//  Created by Aleksandr Kurdiukov on 16.05.21.
//

import Foundation

extension String {
    
    func isEmtyOrWhiteSpace() -> Bool {
         return self.filter({$0 != " "}).isEmpty
    }
}
