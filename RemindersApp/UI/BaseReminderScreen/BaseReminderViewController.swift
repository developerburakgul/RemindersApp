//
//  BaseReminderViewController.swift
//  RemindersApp
//
//  Created by Burak Gül on 1.08.2024.
//

import UIKit

class BaseReminderViewController<ViewModelType>: UIViewController {
    
    //MARK: - ViewModel
    var viewModel: ViewModelType
    
    //MARK: - UI Components
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var cancelBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(
            title: "Cancel",
            style: .done,
            target: self,
            action: #selector(cancelTapped))
        return barButton
    }()
    
    lazy var doneBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(doneTapped))
        barButton.isEnabled = false
        return barButton
    }()
    
    var titleTextView: PlaceHolderTextView = {
        let titleTextView = PlaceHolderTextView(frame: .null, textContainer: .none, placeholder: "Title", placeholderColor: .secondaryLabel)
        titleTextView.backgroundColor = .gray
        return titleTextView
    }()
    
    var descriptionTextView: PlaceHolderTextView = {
        let descriptionTextView = PlaceHolderTextView(frame: .null, textContainer: .none, placeholder: "Description...", placeholderColor: .secondaryLabel)
        descriptionTextView.backgroundColor = .gray
        return descriptionTextView
    }()
    
    var dateView: DateView = {
        let dateView = DateView(frame: .null, datePickerMode: .date, datePickerStyle: .inline, dateViewModel: DateViewModel(imageName: "calendar", titleLabelString: "Date", isShowDate: false, isClock: false))
        dateView.setSelectable(minDate: Date())
        return dateView
    }()
    
    var clockView: DateView = {
        let clockView = DateView(frame: .null, datePickerMode: .time, datePickerStyle: .wheels, dateViewModel: DateViewModel(imageName: "clock", titleLabelString: "Clock", isShowDate: false, isClock: true))
        return clockView
    }()
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setup()
        titleTextView.externalDelegate = self as? any UITextViewDelegate
        print("base reminder view controller view did load")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        print("base reminder view controller view will appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("base reminder view controller view will disappear")
    }
    
    // MARK: - Init Functions
    init(viewModel: ViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Functions
    private func setup() {
        setupUIComponents()
    }
    
    private func setupUIComponents() {
        setupScrollView()
        setupNavigationBar()
        setupTitleTextView()
        setupDescriptionTextView()
        setupDateView()
        setupClockView()
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        self.navigationItem.leftBarButtonItem = cancelBarButton
        self.navigationItem.rightBarButtonItem = doneBarButton
    }
    
    private func setupTitleTextView() {
        contentView.addSubview(titleTextView)
        titleTextView.translatesAutoresizingMaskIntoConstraints = false
        
        titleTextView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(32)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.greaterThanOrEqualTo(50)
        }
    }
    
    private func setupDescriptionTextView() {
        contentView.addSubview(descriptionTextView)
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(titleTextView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.greaterThanOrEqualTo(50)
        }
    }
    
    private func setupDateView() {
        contentView.addSubview(dateView)
        dateView.translatesAutoresizingMaskIntoConstraints = false
        dateView.snp.makeConstraints { make in
            make.top.equalTo(descriptionTextView.snp.bottom).offset(64)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    private func setupClockView() {
        contentView.addSubview(clockView)
        clockView.translatesAutoresizingMaskIntoConstraints = false
        clockView.snp.makeConstraints { make in
            make.top.equalTo(dateView.snp.bottom).offset(16)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(contentView.snp.bottom).offset(-16)
        }
    }
    
    @objc func cancelTapped() {
        self.dismiss(animated: true, completion: nil)
        print(#function)
    }
    
    @objc func doneTapped() {
        self.dismiss(animated: true, completion: nil)
        print(#function)
        // Bu fonksiyon alt sınıflarda override edilecektir.
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        // Resign first responder for other views
        view.endEditing(true)
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView == titleTextView {
            doneBarButton.isEnabled = !textView.text.isEmpty
        }
    }
    
    
    
    
}





