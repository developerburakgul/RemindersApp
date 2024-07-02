//
//  ReminderListTableViewCell.swift
//  RemindersApp
//
//  Created by Burak Gül on 29.06.2024.
//

import UIKit
import SnapKit

class ReminderListTableViewCell: UITableViewCell {
    
    static let identifier = "ReminderListTableViewCell"
    
    var doneButtonAction : (() -> Void)?
    
    private var reminder : Reminder? {
        didSet {
            updateDoneButton()
        }
    }
    
    
    //MARK: - Private attributes
    private var doneButton : UIButton = {
        var button = UIButton()
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        button.configuration?.cornerStyle = .capsule
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        
        
        return button
    }()
    
    private var titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Burak"
        label.numberOfLines = 0
        
        
        return label
    }()
    
    private var descriptionLabel : UILabel = {
        let label = UILabel()
        label.text = "description"
        label.numberOfLines = 0
        
        
        return label
    }()
    
    private var dateLabel : UILabel = {
        let label = UILabel()
        label.text = Date.now.toString()
        label.numberOfLines = 0
        return label
    }()
    
    private var stackView : UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK: - Setup Functions
    
    
    private func setup() {
        setupViews()
    }
    
    private func setupViews() {
        setupDoneButton()
        setupStackView()
    }
    
    private func setupDoneButton() {
        contentView.addSubview(doneButton)
        doneButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.top.equalToSuperview().offset(8)
            make.width.equalToSuperview().multipliedBy(0.1)
            make.height.equalTo(doneButton.snp.width)
        }
        
    }
    
    private func setupStackView() {
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(doneButton.snp.trailing).offset(16)
            make.top.equalTo(contentView.snp.top).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
        }
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(dateLabel)
        
    }
    
    //MARK: - Private Functions
    
    @objc private func updateDoneButton() {
        
        var imageName = "circle"
        if reminder?.isDone == true {
            imageName = "circle.fill"
        }
        doneButton.setImage(UIImage(systemName: imageName), for: .normal)
        
    }
    
    
    //MARK: - Public Functions
    
    func configure(with reminder : Reminder) {
        self.reminder = reminder
        titleLabel.text = reminder.title
        descriptionLabel.text = reminder.description
        dateLabel.text = reminder.endDate?.toString()
        
    }
    
    @objc private func doneButtonTapped() {
        doneButtonAction?()
    }
    
    
    
}

#Preview(""){
    ReminderListTableViewCell(style: .default, reuseIdentifier: ReminderListTableViewCell.identifier)
    
}

