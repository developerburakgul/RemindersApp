//
//  Date+Extension.swift
//  RemindersApp
//
//  Created by Burak Gül on 28.06.2024.
//

import Foundation

extension Date {
    func toString(_ format : String = "dd-MM-yyyy") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
