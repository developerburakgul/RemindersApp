//
//  ListTableViewModel.swift
//  RemindersApp
//
//  Created by Burak Gül on 2.07.2024.
//

import Foundation


class ListTableViewCellModel {
    
    
    private var reminder : Reminder
    
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
        
//        guard let selectedDate = reminder.endDate else { return nil  }
//        
//        let calendar = Calendar.current
//        let today = Date()
//        
//        let components = calendar.dateComponents([.day], from: today, to: selectedDate)
//        guard let dayDifference = components.day else {
//            return nil
//        }
//        
//        switch dayDifference {
//        case -2:
//            return "Evvelsi gün"
//        case -1:
//            return "Dün"
//        case 0:
//            return "Bugün"
//        case 1:
//            return "Yarın"
//        case 2:
//            return "Öbür gün"
//        default:
//            return reminder.endDate?.toString()
//        }
        guard let date = reminder.date else { return nil }
        return date.getDateString + " " +  date.timeString
    
}

var doneButtonImageName : String {
    reminder.isDone ? "circle" : "circle.fill"
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
}





}
