//
//  ReminderCreateViewController.swift
//  RemindersApp
//
//  Created by Burak Gül on 1.08.2024.
//

import UIKit

class ReminderCreateViewController: BaseReminderViewController<ReminderCreateViewModel> ,UITextViewDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Create"
        titleTextView.externalDelegate = self
                descriptionTextView.externalDelegate = self
        
    }
    
    override func doneTapped() {
        super.doneTapped()
        viewModel.saveReminder(titleTextView.text, descriptionTextView.text, dateView.getDate, clockView.getDate)
    }
    
    // MARK: - UITextViewDelegate
    override func textViewDidChange(_ textView: UITextView) {
        let isTitleTextNotEmpty = !titleTextView.text.isEmpty
        doneBarButton.isEnabled = isTitleTextNotEmpty
    }
    
}


#Preview(""){
    UINavigationController(rootViewController: ReminderCreateViewController(viewModel: ReminderCreateViewModel()))
}
