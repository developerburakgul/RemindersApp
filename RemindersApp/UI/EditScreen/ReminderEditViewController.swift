//
//  ReminderEditViewController.swift
//  RemindersApp
//
//  Created by Burak Gül on 31.07.2024.
//

import UIKit

class ReminderEditViewController : BaseReminderViewController<ReminderEditViewModel>,UITextViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Edit"
        self.doneBarButton.title = "Save"
        titleTextView.externalDelegate = self
        descriptionTextView.externalDelegate = self
        loadReminderData()
        self.doneBarButton.isEnabled = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadReminderData()
    }
    
    private func loadReminderData(){
        titleTextView.setText(viewModel.titleOfReminder)
        if let description = viewModel.descriptionOfReminder {
            descriptionTextView.setText(description)
        }
        if let date = viewModel.dateOfReminder {
            dateView.setDate(date,isOnlyShowMode: false)
        }
        if let time = viewModel.timeOfReminder {
            clockView.setTime(time,isOnlyShowMode: false)
        }

    }
    
    override func doneTapped() {
        super.doneTapped()
        viewModel.updateReminder(titleTextView.text, descriptionTextView.text, dateView.getDate, clockView.getDate)
    }
    
    // MARK: - UITextViewDelegate
    override func textViewDidChange(_ textView: UITextView) {
        let isTitleTextNotEmpty = !titleTextView.text.isEmpty
        doneBarButton.isEnabled = isTitleTextNotEmpty
    }

}
