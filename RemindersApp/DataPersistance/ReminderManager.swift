//
//  UserDefaultsManager.swift
//  RemindersApp
//
//  Created by Burak Gül on 29.07.2024.
//

import Foundation



class ReminderManager {
    //MARK: - Private Variables
    private let defaults: UserDefaults = .standard
    private let reminderKey = "reminders"
    private var reminders: [Reminder] = []
    
    //MARK: - İnitializer
    
    static let shared: ReminderManager = .init()
    
    private init() {
        loadData()
    }
    
    
    
    
    func addReminder(_ reminder : Reminder) {
        reminders.append(reminder)
        saveData()
    }
    
    func deleteReminder(_ reminder : Reminder) {
        reminders.removeAll { element in
            if element.uuid ==  reminder.uuid {
                return true
            }
            return false
        }
        
        saveData()
    }
    
    func getReminders() -> [Reminder] {
        return reminders
    }
    func toggleReminder(_ reminder : Reminder) {
        for (index, element) in reminders.enumerated() {
            if element.uuid == reminder.uuid {
                reminders[index].isDone = !element.isDone
            }
        }
        saveData()
    }
    
    func update(old oldReminder : Reminder, new newReminder : Reminder) {
        for (index, element) in reminders.enumerated() {
            if element.uuid == oldReminder.uuid {
                reminders[index] = newReminder
            }
        }
        saveData()
    }
    
    //MARK: - Private Functions
    private func loadData() {
        guard let data =  defaults.data(forKey: reminderKey) else {return}
        
        do {
            reminders = try JSONDecoder().decode([Reminder].self ,from: data)
        } catch  {
            print("Reminderler yüklenirken hata oldu")
        }
    }
    
    private func saveData()  {
        do {
            let encoded = try JSONEncoder().encode(reminders)
            defaults.set(encoded, forKey: reminderKey)
        } catch {
            print("Hata: Reminders kaydedilirken bir sorun oluştu: \(error)")
        }
        
    }
    
    
}
