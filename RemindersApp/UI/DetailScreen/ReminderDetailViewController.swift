//
//  ViewController.swift
//  RemindersApp
//
//  Created by Burak Gül on 1.08.2024.
//

import UIKit

class ReminderDetailViewController: BaseReminderViewController<ReminderDetailViewModel> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Detail"
        self.doneBarButton.isHidden = true
        self.titleTextView.isEditable = false
        self.descriptionTextView.isEditable = false
//        self.dateView.setOnlyShowMode()
//        self.clockView.setOnlyShowMode()
        
        // Mevcut reminder verilerini yükleyin ve UI bileşenlerine atayın.
        loadReminderData()
    }
    
    private func loadReminderData() {

        
        titleTextView.setText(viewModel.titleOfReminder)
        if let description = viewModel.descriptionOfReminder {
            descriptionTextView.setText(description)
        }
        if let date = viewModel.dateOfReminder {
            dateView.setDate(date)
            print("date")
        }
        if let time = viewModel.timeOfReminder {
            clockView.setTime(time)
            print(time)
            print("time")
        }
    
    }
    
    @objc override func doneTapped() {
        // doneTapped fonksiyonunu override etmemize gerek yok çünkü detay görüntüleme ekranında bu fonksiyon kullanılmayacak.
    }
}
