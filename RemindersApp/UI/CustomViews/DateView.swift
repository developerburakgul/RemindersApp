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
    private let heigtOfScreen = UIScreen.main.bounds.height
    private let widthOfScreen = UIScreen.main.bounds.width
    
    //MARK: - UI Components
    
    private let imageView : UIImageView = {
    
        let imageView = UIImageView()
            imageView.backgroundColor = .red
            imageView.tintColor = .white
            imageView.layer.cornerRadius = 6
            imageView.layer.masksToBounds = true
        imageView.contentMode = .center

            return imageView
    }()
    
    private let titleLabel : UILabel = {
        let titleLabel = UILabel()
//        titleLabel.backgroundColor = .red
        titleLabel.text = "Title"
        titleLabel.textColor = .label
        return titleLabel
    }()
    
    private let dateLabel : UILabel = {
        let dateLabel  = UILabel()
//        dateLabel.backgroundColor = .green
        dateLabel.textColor = .systemBlue
        dateLabel.isHidden = true
        return dateLabel
    }()
    
    private let labelStackView : UIStackView = {
        let labelStackView = UIStackView()
        labelStackView.axis = .vertical
//        labelStackView.backgroundColor = .systemPink
        labelStackView.distribution = .fillEqually
        return labelStackView
    }()
    
    private let switchButton : UISwitch = {
        let switchButton  = UISwitch()
//        switchButton.backgroundColor = .systemOrange
        switchButton.addTarget(self, action: #selector(switchButtonChanged(_ :)), for: .valueChanged)
        return switchButton
    }()
    
    private var datePicker : UIDatePicker = {
        var datePicker = UIDatePicker()
        datePicker.isHidden = true
//                datePicker.backgroundColor = .white
//                datePicker.layer.cornerRadius = 10
//                datePicker.layer.masksToBounds = true
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
                
//                datePicker.layer.shadowColor = UIColor.black.cgColor
//                datePicker.layer.shadowOpacity = 0.2
//                datePicker.layer.shadowOffset = CGSize(width: 0, height: 2)
                
        
        return datePicker
    }()
    
    private let generalStackView : UIStackView = {
        let generalStackView  = UIStackView()
        generalStackView.axis = .vertical
        generalStackView.backgroundColor = UIColor(named: "BaseReminderComponentBackgroundColor")
        generalStackView.distribution = .fill
    
            generalStackView.layer.cornerRadius = 12
            generalStackView.layer.shadowColor = UIColor.black.cgColor
            generalStackView.layer.shadowOffset = CGSize(width: 0, height: 2)
            generalStackView.layer.shadowOpacity = 0.3
            generalStackView.layer.shadowRadius = 4
            generalStackView.layer.masksToBounds = false
        return generalStackView

    }()
    
    private let headerView : UIView = {
        let headerView = UIView()
        return headerView
//        let view = UIView()
//                view.layer.cornerRadius = 10
//                view.backgroundColor = .white
//                view.layer.shadowColor = UIColor.black.cgColor
//                view.layer.shadowOpacity = 0.1
//                view.layer.shadowOffset = CGSize(width: 0, height: 2)
//                view.layer.shadowRadius = 4
//                return view
      
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
    
    func setBackgroundColorOfImageView(_ color : UIColor) {
        imageView.backgroundColor = color
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
            make.top.equalToSuperview().inset(0)
            make.bottom.equalToSuperview().inset(0)
            make.leading.equalToSuperview().inset(0)
            make.trailing.equalToSuperview().inset(0)
        }
    }
    
    
    private func setupHeaderView() {
        headerView.addSubview(imageView)
        headerView.addSubview(labelStackView)
        headerView.addSubview(switchButton)
        
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(dateLabel)
        
        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(widthOfScreen * 0.025)
            make.centerY.equalToSuperview()
            make.top.equalToSuperview().offset(heigtOfScreen * 0.015)
            make.bottom.equalToSuperview().offset(heigtOfScreen * -0.015)
            make.width.equalTo(imageView.snp.height)
            

            
        }
        
        labelStackView.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(widthOfScreen * 0.025)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(switchButton.snp.leading).offset(widthOfScreen * -0.025)
            
            
        }
        
        switchButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(widthOfScreen * -0.025)
            make.centerY.equalToSuperview()
        }
        
        headerView.snp.makeConstraints { make in
            make.height.equalTo(heigtOfScreen * 0.075)
            
        }
        
        
    }
    
    @objc private  func datePickerValueChanged(_ sender:UIDatePicker)  {
        dateLabel.text = viewModel.dateLabelText(from: sender.date)
    }
    
    @objc private func switchButtonChanged(_ sender: UISwitch) {

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


//#Preview(""){
//    DateView(frame: .null, datePickerMode: .date, datePickerStyle: .inline,dateViewModel: DateViewModel(imageName: "star", titleLabelString: "Date", isShowDate: false,isClock: false))
//}

#Preview(""){
    UINavigationController(rootViewController: ReminderEditViewController(viewModel: ReminderEditViewModel(reminder: Reminder(title: "deneme", isDone: false))))
}
