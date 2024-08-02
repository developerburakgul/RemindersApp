//
//  ReminderDetailViewModel.swift
//  RemindersApp
//
//  Created by Burak Gül on 1.08.2024.
//

import Foundation


struct ReminderDetailViewModel {
    private var reminder : Reminder
    
    init(reminder: Reminder) {
        self.reminder = reminder
    }
    
    
    //MARK: - Getters
    
    var titleOfReminder : String {
        reminder.title
    }
    
    var descriptionOfReminder : String? {
        reminder.description
    }
    
    var dateOfReminder : Date? {
        reminder.date
    }
    
    var timeOfReminder : Date? {
        reminder.time
    }
    
    
}
