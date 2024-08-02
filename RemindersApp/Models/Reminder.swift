//
//  Reminder.swift
//  RemindersApp
//
//  Created by Burak Gül on 28.06.2024.
//

import Foundation

struct Reminder : Codable {
    var uuid: UUID
    var title : String
    var description : String?
    var isDone : Bool = false
    var date : Date?
    var time : Date?
    
    
    init( title: String, description: String? = nil, isDone: Bool, date: Date? = nil, time: Date? = nil) {
        self.uuid = UUID()
        self.title = title
        self.description = description
        self.isDone = isDone
        self.date = date
        self.time = time
    }
    
}
