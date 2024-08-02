//
//  DateViewModel.swift
//  RemindersApp
//
//  Created by Burak Gül on 29.07.2024.
//

import Foundation


struct DateViewModel {
    var imageName : String
    var titleLabelString : String
    var isShowDate : Bool
    var isClock : Bool
    
    
    init(imageName: String, titleLabelString: String, isShowDate: Bool, isClock: Bool) {
        self.imageName = imageName
        self.titleLabelString = titleLabelString
        self.isShowDate = isShowDate
        self.isClock = isClock
    }
    
    func dateLabelText(from date : Date) -> String {
        if isClock {
            return date.timeString
        }
        return date.getDateString ?? "No value"
        
    }

}
