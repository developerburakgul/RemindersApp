//
//  ListViewModel.swift
//  RemindersApp
//
//  Created by Burak Gül on 28.06.2024.
//

import Foundation

class ListViewModel {
    
    //MARK: - Closure
    var remindersDidRefresh : (() -> Void)?
    
    
    //MARK: - Private attributes
    
    private var reminders : [Reminder] = []
    
    
    //MARK: - Private functions
    private func getMockData() {
        reminders = [
            Reminder(title: "Burak", description: "Learns MVVM", isDone: false, endDate: nil),
            Reminder(title: "Burak", description: "Learnt MVC", isDone: true, endDate: Date.now),
            Reminder(title: "Burak", description: "is a studentb", isDone: true, endDate: nil),
            Reminder(title: "Yahya",endDate:Date.now),
            Reminder(title: "Peykiye")
        ]
        
        
    }
    
    //MARK: - Public Attributes
    var reminderCount : Int {
        return reminders.count
    }
    
    
    
    
    
    //MARK: - Public Functions
    
    func getReminder(_ index : Int) -> Reminder {
        return reminders[index]
    }
    
    func refreshReminders() {
        remindersDidRefresh?()
        getMockData()
    }
    
    func toggleReminderDone(at index: Int) {
        reminders[index].isDone.toggle()
        remindersDidRefresh?()
    }
    
}
