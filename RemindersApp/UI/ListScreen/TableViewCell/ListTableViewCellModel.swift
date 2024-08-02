//
//  ListTableViewModel.swift
//  RemindersApp
//
//  Created by Burak Gül on 2.07.2024.
//

import Foundation


class ListTableViewCellModel {
    
    
    private var reminder : Reminder
    private var reminderManager : ReminderManager = ReminderManager.shared
    
    init(reminder: Reminder) {
        self.reminder = reminder
    }
    
    
    //MARK: - Public
    
    var title : String {
        reminder.title
    }
    
    var description : String? {
        reminder.description
    }
    var dateString : String? {
        guard let date = reminder.date else { return nil }
        if let time = reminder.time {
            return date.getDateWithDot + " " + time.timeString
        }
        return date.getDateWithDot
        
    }
    
    var doneButtonImageName : String {
        reminder.isDone ? "circle.fill" : "circle"
    }
    var isLateDate : Bool {
        guard let date = reminder.date else {return false}
        if date.compare(Date.now) == .orderedAscending  {
            return true
        }
        return false
    }
    
    
    func toggleDone() {
        reminder.isDone.toggle()
        reminderManager.toggleReminder(reminder)
    }
    
    
    
    
    
}
