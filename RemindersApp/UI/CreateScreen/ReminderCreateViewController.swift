//
//  ReminderCreateViewController.swift
//  RemindersApp
//
//  Created by Burak Gül on 1.08.2024.
//

import UIKit

class ReminderCreateViewController: BaseReminderViewController<ReminderCreateViewModel> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Create"
    }
    
    override func doneTapped() {
        super.doneTapped()
        viewModel.saveReminder(titleTextView.text, descriptionTextView.text, dateView.getDate, clockView.getDate)
    }
}
//extension ReminderCreateViewController: UITextViewDelegate {
//    func textViewDidChange(_ textView: UITextView) {
//        if textView == titleTextView {
//            doneBarButton.isEnabled = !textView.text.isEmpty
//        }
//    }
//}

#Preview(""){
    UINavigationController(rootViewController: ReminderCreateViewController(viewModel: ReminderCreateViewModel()))
}
