//
//  Date+Extension.swift
//  RemindersApp
//
//  Created by Burak Gül on 28.06.2024.
//

import Foundation

extension Date {
    func toString(_ format: String = "dd.MM.yyyy") -> String {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "tr_TR")  // Türkçe dilini ayarla
            formatter.dateFormat = format
            return formatter.string(from: self)
        }
    
    var  getDateString : String{
        
        
        let calendar = Calendar.current
        let today = Date()
        
        let components = calendar.dateComponents([.day], from: today, to: self)
        guard let dayDifference = components.day else {
            fatalError("sanane")
        }
        
        
        switch dayDifference {
        case -2:
            return "Evvelsi gün"
        case -1:
            return "Dün"
        case 0:
            return "Bugün"
        case 1:
            return "Yarın"
        case 2:
            return "Öbür gün"
        default:
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "tr_TR")
            formatter.dateFormat = "dd MMMM yyyy EEEE"
            return formatter.string(from: self)
        }
    }
    var timeString : String {
        let dateFormatter = DateFormatter()

        // Formatı belirle
        dateFormatter.dateFormat = "HH:mm" // Saat: Dakika: Saniye formatı

        // Tarih nesnesini formatlayarak stringe çevir
        let timeString = dateFormatter.string(from: self)
        print("timestring is : \(timeString)")
        return timeString
    }
}
