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
                let todayStart = calendar.startOfDay(for: Date())
                let selfStart = calendar.startOfDay(for: self)
                
                let components = calendar.dateComponents([.day], from: todayStart, to: selfStart)
                guard let dayDifference = components.day else {
                    fatalError()
                }
                
        switch dayDifference {

                case -1:
                    return "Yesterday"
                case 0:
                    return "Today"
                case 1:
                    return "Tomorrow"
                default:
                    let formatter = DateFormatter()
                    formatter.locale = Locale(identifier: "en_US")
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
        return timeString
    }
    
    var getDateWithDot : String {
        let calendar = Calendar.current
            let todayStart = calendar.startOfDay(for: Date())
            let selfStart = calendar.startOfDay(for: self)
            
            let components = calendar.dateComponents([.day], from: todayStart, to: selfStart)
            guard let dayDifference = components.day else {
                fatalError()
            }
            
            switch dayDifference {
            case -1:
                return "Yesterday"
            case 0:
                return "Today"
            case 1:
                return "Tomorrow"
            default:
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "en_US")
                formatter.dateFormat = "dd.MM.yyyy"
                return formatter.string(from: self)
            }
    }
}
