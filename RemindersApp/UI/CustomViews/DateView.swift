//
//  DateView.swift
//  RemindersApp
//
//  Created by Burak Gül on 29.07.2024.
//

import UIKit

class DateView: UIView {
    
    
    private var viewModel : DateViewModel
    private var datePickerMode : UIDatePicker.Mode
    private var datePickerStyle : UIDatePickerStyle
    
    //MARK: - UI Components
    
    private let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.image = UIImage(systemName: "star")
        return imageView
    }()
    
    private let titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.backgroundColor = .red
        titleLabel.text = "Title"
        return titleLabel
    }()
    
    private let dateLabel : UILabel = {
        let dateLabel  = UILabel()
        dateLabel.backgroundColor = .green
        dateLabel.textColor = .systemBlue
        dateLabel.isHidden = true
        return dateLabel
    }()
    
    private let labelStackView : UIStackView = {
        let labelStackView = UIStackView()
        labelStackView.axis = .vertical
        labelStackView.backgroundColor = .systemPink
        labelStackView.distribution = .fillEqually
        return labelStackView
    }()
    
    private let switchButton : UISwitch = {
        let switchButton  = UISwitch()
        switchButton.backgroundColor = .systemOrange
        switchButton.addTarget(self, action: #selector(switchButtonChanged(_ :)), for: .valueChanged)
        return switchButton
    }()
    
    private var datePicker : UIDatePicker = {
        var datePicker = UIDatePicker()
        datePicker.isHidden = true
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
        return datePicker
    }()
    
    private let generalStackView : UIStackView = {
        let generalStackView  = UIStackView()
        generalStackView.axis = .vertical
        generalStackView.backgroundColor = .purple
        generalStackView.distribution = .fill
        generalStackView.spacing = 16
        return generalStackView
    }()
    
    private let headerView : UIView = {
        let headerView = UIView()
        headerView.backgroundColor = .darkGray
        return headerView
    }()
    
    //MARK: - Getter
    
    var getDate : Date? {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: datePicker.date)
        if !datePicker.isHidden {
            if datePickerMode == .date {
                // return year month and day
                var components = DateComponents()
                components.year = dateComponents.year
                components.month = dateComponents.month
                components.day = dateComponents.day
                
                return calendar.date(from: components)
            }else if datePickerMode == .time {
                // return time and hpur
                var components = DateComponents()
                components.hour = dateComponents.hour
                components.minute = dateComponents.minute
                
                return calendar.date(from: components)
            }
            return datePicker.date
        }
        return nil
    }
    
    //MARK: - Public Function
    
    func setSelectable(minDate date : Date )  {
        datePicker.minimumDate = date
    }
    
    func setDate(_ date: Date) {

        if !viewModel.isClock {
            datePicker.date = date
            dateLabel.text = viewModel.dateLabelText(from: date)
            dateLabel.isHidden = false
            datePicker.isHidden = false
        }
        
        switchButton.isOn = true
        setOnlyShowMode()
    }
    
    func setTime(_ time: Date) {
        if viewModel.isClock {
            datePicker.date = time
            dateLabel.text = viewModel.dateLabelText(from: time)
            dateLabel.isHidden = false
            datePicker.isHidden = false
        }
        
        switchButton.isOn = true
        setOnlyShowMode()
        
        
    }
    
    
    func setOnlyShowMode() {
        datePicker.isUserInteractionEnabled = false
        switchButton.isUserInteractionEnabled = false
        
    }

    
    
    //MARK: - Init Functions
    
    init(frame: CGRect,datePickerMode : UIDatePicker.Mode,datePickerStyle : UIDatePickerStyle,dateViewModel : DateViewModel) {
        self.datePickerMode = datePickerMode
        self.datePickerStyle = datePickerStyle
        self.viewModel = dateViewModel
        super.init(frame: frame)
        
        setup()
        
        config()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK: - Setup
    
    
    
    private func config() {
        self.imageView.image = UIImage(systemName: viewModel.imageName)
        self.titleLabel.text = viewModel.titleLabelString
        self.datePicker.datePickerMode = datePickerMode
        if #available(iOS 14.0, *) {
            self.datePicker.preferredDatePickerStyle = datePickerStyle
        }
        
    }
    
    private func setup() {
        setupGeneralStackView()
        setupHeaderView()
        
    }
    
    
    private func setupGeneralStackView() {
        self.addSubview(generalStackView)
        generalStackView.addArrangedSubview(headerView)
        generalStackView.addArrangedSubview(datePicker)
        generalStackView.translatesAutoresizingMaskIntoConstraints = false
        generalStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
        }
    }
    
    
    private func setupHeaderView() {
        headerView.addSubview(imageView)
        headerView.addSubview(labelStackView)
        headerView.addSubview(switchButton)
        
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(dateLabel)
        
        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(4)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(32)
        }
        
        labelStackView.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(switchButton.snp.leading).offset(-8)
            
            
        }
        
        switchButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-8)
            make.centerY.equalToSuperview()
        }
        
        headerView.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        
    }
    
    @objc private  func datePickerValueChanged(_ sender:UIDatePicker)  {
        dateLabel.text = viewModel.dateLabelText(from: sender.date)
    }
    
    @objc private func switchButtonChanged(_ sender: UISwitch) {
//        viewModel.isShowDate = sender.isOn
//        datePicker.isHidden = !viewModel.isShowDate
//        if viewModel.isShowDate {
//            dateLabel.isHidden = false
//            dateLabel.text = viewModel.dateLabelText(from: datePicker.date)
//        }else {
//            dateLabel.isHidden = true
//        }
        DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.viewModel.isShowDate = sender.isOn
                self.datePicker.isHidden = !self.viewModel.isShowDate
                if self.viewModel.isShowDate {
                    self.dateLabel.isHidden = false
                    self.dateLabel.text = self.viewModel.dateLabelText(from: self.datePicker.date)
                } else {
                    self.dateLabel.isHidden = true
                }
            }
        
    }
    
        
}


#Preview(""){
    DateView(frame: .null, datePickerMode: .date, datePickerStyle: .inline,dateViewModel: DateViewModel(imageName: "star", titleLabelString: "Date", isShowDate: false,isClock: false))
}
