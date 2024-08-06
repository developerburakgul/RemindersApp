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
    
    
    //MARK: - Public Attributes
    var reminderCount : Int {
        return reminders.count
    }
    
    //MARK: - Private functions
    private func getReminders() {
        reminders = reminderManager.getReminders()
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
