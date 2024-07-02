//
//  Reminder.swift
//  RemindersApp
//
//  Created by Burak Gül on 28.06.2024.
//

import Foundation

struct Reminder {
    var title : String
    var description : String?
    var isDone : Bool = false
    var endDate : Date?
    
    
    init(title: String, description: String? = nil, isDone: Bool = false, endDate: Date? = nil) {
        self.title = title
        self.description = description
        self.isDone = isDone
        self.endDate = endDate
    }
    
}
