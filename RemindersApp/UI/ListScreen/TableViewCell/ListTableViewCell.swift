//
//  ReminderListTableViewCell.swift
//  RemindersApp
//
//  Created by Burak Gül on 29.06.2024.
//

import UIKit
import SnapKit

class ListTableViewCell: UITableViewCell {
    
    static let identifier = "ReminderListTableViewCell"
    
    var doneButtonTappedAction: (() -> Void)?
    
    //MARK: - Private Attributes
    private var viewModel : ListTableViewCellModel? {
        didSet {
            updateUI()
        }
    }
    
    
    //MARK: - Private UI Components
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
    
    
    
    //MARK: - İnit Functions
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
    
    
    
    private func updateUI() {
        guard let viewModel = self.viewModel else { return  }
        self.titleLabel.text = viewModel.title
        self.descriptionLabel.text = viewModel.description
        self.dateLabel.text = viewModel.dateString
        self.dateLabel.textColor = viewModel.isLateDate ? .red : .label
        self.doneButton.setImage(UIImage(systemName: viewModel.doneButtonImageName), for: .normal)
    }
    
    
    //MARK: - Public Functions
    
    func configure(with viewModel: ListTableViewCellModel) {
        self.viewModel = viewModel
        
    }
    
    @objc private func doneButtonTapped() {
        viewModel?.toggleDone()
        doneButtonTappedAction?()
        
    }
    
    
    
}

#Preview(""){
    ListTableViewCell(style: .default, reuseIdentifier: ListTableViewCell.identifier)
    
}

