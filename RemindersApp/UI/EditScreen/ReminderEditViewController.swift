//
//  ReminderEditViewController.swift
//  RemindersApp
//
//  Created by Burak Gül on 31.07.2024.
//

import UIKit

class ReminderEditViewController : BaseReminderViewController<ReminderEditViewModel> {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Edit"
        self.doneBarButton.title = "Save"

    }
    
    override func doneTapped() {
        
    }

}
