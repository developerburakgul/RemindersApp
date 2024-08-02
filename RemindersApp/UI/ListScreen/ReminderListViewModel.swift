//
//  ListViewModel.swift
//  RemindersApp
//
//  Created by Burak Gül on 28.06.2024.
//

import Foundation

class ReminderListViewModel {
    
    //MARK: - Closure
    var remindersDidRefresh : (() -> Void)?
    
    
    
    
    
    //MARK: - Private attributes
    
    private var reminders : [Reminder] = []
    private var reminderManager : ReminderManager = ReminderManager.shared
    
    
    //MARK: - Private functions
    private func getReminders() {
//        let dateFormatter  = DateFormatter()
//        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
//        reminders = [
//            Reminder(title: "Burak", description: "Learns MVVM", isDone: false, endDate: nil),
//            Reminder(title: "Burak", description: "Learnt MVC", isDone: true, endDate : dateFormatter.date(from: "2024/07/02 10:00")),
//            Reminder(title: "Burak", description: "is a student", isDone: true, endDate: nil),
//            Reminder(title: "Yahya",endDate:dateFormatter.date(from: "2024/08/02 22:00")),
//            Reminder(title: "Peykiye")
//        ]
        reminders = reminderManager.getReminders()
        
        
        
        
        
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
        getReminders()
        remindersDidRefresh?()
    }
    
    func updateReminder(at index: Int) {
        reminders[index].isDone.toggle()
        remindersDidRefresh?()
    }
    
    
    
    func delete(_ reminder : Reminder) {
        reminderManager.deleteReminder(reminder)
        refreshReminders()
        
    }
}
