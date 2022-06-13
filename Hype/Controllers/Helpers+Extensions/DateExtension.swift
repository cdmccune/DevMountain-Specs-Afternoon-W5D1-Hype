//
//  DateExtension.swift
//  Hype
//
//  Created by Curt McCune on 6/13/22.
//

import Foundation

extension Date {
    func formatDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        return formatter.string(from: self)
    }
}
