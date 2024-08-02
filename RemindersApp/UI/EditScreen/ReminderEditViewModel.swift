//
//  ReminderEditViewModel.swift
//  RemindersApp
//
//  Created by Burak Gül on 1.08.2024.
//

import Foundation


class ReminderEditViewModel {
    private var reminder : Reminder
    private var reminderManager : ReminderManager = ReminderManager.shared
    
    init(reminder: Reminder) {
        self.reminder = reminder
    }
    
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
    
    
    func updateReminder(_ title : String , _ description : String?,_ calendarDate : Date? ,_ clockDate : Date?)  {
        print("\(calendarDate)" + "calendar ")
        print("\(clockDate)" + "clock ")
        let clockDate = getHourAndMinute(clockDate)
        let calendarDate = getDayMonthAndYear(calendarDate)
        let newReminder = Reminder(title: title, description: description, isDone: false,date: calendarDate,time: clockDate)
        reminderManager.update(old: reminder, new: newReminder)
        
    }
    
    
    
    
    
    private func getDayMonthAndYear(_ date : Date?) -> Date? {
        guard let date = date else {
            print("Calendar date is missing")
            return nil
        }
        
        // Create a Calendar instance
        let calendar = Calendar.current
        
        // Extract year, month, day from calendarDate
        let calendarComponents = calendar.dateComponents([.year, .month, .day], from: date)
        
        // Create a new date from the combined components
        var combinedComponents = DateComponents()
        combinedComponents.year = calendarComponents.year
        combinedComponents.month = calendarComponents.month
        combinedComponents.day = calendarComponents.day
        
        if let combinedDate = calendar.date(from: combinedComponents) {
            print("Combined Date: \(combinedDate)")
            // Here you can use the combinedDate as needed
            return combinedDate
        } else {
            print("Failed to create date")
            return nil
        }
    }
    
    private func getHourAndMinute(_ date : Date?) -> Date? {
        guard let date = date else {
            print("Calendar date is missing")
            return nil
        }
        
        // Create a Calendar instance
        let calendar = Calendar.current
        
        // Extract year, month, day from calendarDate
        let clockComponents = calendar.dateComponents([.hour,.minute], from: date)
        
        // Create a new date from the combined components
        var combinedComponents = DateComponents()
        combinedComponents.hour = clockComponents.hour
        combinedComponents.minute = clockComponents.minute
        
        
        if let combinedDate = calendar.date(from: combinedComponents) {
            print("Combined Date: \(combinedDate)")
            // Here you can use the combinedDate as needed
            return combinedDate
        } else {
            print("Failed to create date")
            return nil
        }
    }
    
}
