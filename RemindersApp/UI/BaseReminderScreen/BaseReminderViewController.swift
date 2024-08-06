//
//  BaseReminderViewController.swift
//  RemindersApp
//
//  Created by Burak Gül on 1.08.2024.
//

import UIKit

class BaseReminderViewController<ViewModelType>: UIViewController {
    //MARK: - Sizes of Screen
    private let heigtOfScreen = UIScreen.main.bounds.height
    private let widthOfScreen = UIScreen.main.bounds.width
    
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
        titleTextView.backgroundColor = UIColor(named: "BaseReminderComponentBackgroundColor")
        titleTextView.font = UIFont.systemFont(ofSize: 24)
        titleTextView.isScrollEnabled = false
        return titleTextView
    }()
    
    var descriptionTextView: PlaceHolderTextView = {
        let descriptionTextView = PlaceHolderTextView(frame: .null, textContainer: .none, placeholder: "Description...", placeholderColor: .secondaryLabel)
        descriptionTextView.backgroundColor = UIColor(named: "BaseReminderComponentBackgroundColor")
        descriptionTextView.isScrollEnabled = false
        descriptionTextView.font = UIFont.systemFont(ofSize: 24)
        return descriptionTextView
    }()
    
    var dateView: DateView = {
        let dateView = DateView(frame: .null, datePickerMode: .date, datePickerStyle: .inline, dateViewModel: DateViewModel(imageName: "calendar", titleLabelString: "Date", isShowDate: false, isClock: false))
        dateView.setSelectable(minDate: Date())
        return dateView
    }()
    
    var clockView: DateView = {
        let clockView = DateView(frame: .null, datePickerMode: .time, datePickerStyle: .wheels, dateViewModel: DateViewModel(imageName: "clock.fill", titleLabelString: "Clock", isShowDate: false, isClock: true))
        clockView.setBackgroundColorOfImageView(.systemBlue)
        
        return clockView
    }()
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BaseReminderBackgroundColor")
        setup()
        titleTextView.externalDelegate = self as? any UITextViewDelegate
        descriptionTextView.externalDelegate = self as? any UITextViewDelegate
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.post(name: .baseReminderViewControllerWillDissAppear, object: nil)
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
        setupGestureRecognizer()
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
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(heigtOfScreen * 0.025 )
            make.left.equalToSuperview().offset(widthOfScreen * 0.05)
            make.right.equalToSuperview().offset(widthOfScreen * -0.05)
            make.height.greaterThanOrEqualTo(heigtOfScreen * 0.075)
        }
    }
    
    private func setupDescriptionTextView() {
        contentView.addSubview(descriptionTextView)
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(titleTextView.snp.bottom).offset(heigtOfScreen * 0.025)
            make.left.equalTo(titleTextView.snp.left)
            make.right.equalTo(titleTextView.snp.right)
            make.height.greaterThanOrEqualTo(heigtOfScreen * 0.075)
        }
    }
    
    private func setupDateView() {
        contentView.addSubview(dateView)
        dateView.translatesAutoresizingMaskIntoConstraints = false
        dateView.snp.makeConstraints { make in
            make.top.equalTo(descriptionTextView.snp.bottom).offset(heigtOfScreen * 0.05)
            make.left.equalTo(descriptionTextView.snp.left)
            make.right.equalTo(descriptionTextView.snp.right)
        }
    }
    
    private func setupClockView() {
        contentView.addSubview(clockView)
        clockView.translatesAutoresizingMaskIntoConstraints = false
        clockView.snp.makeConstraints { make in
            make.top.equalTo(dateView.snp.bottom).offset(heigtOfScreen * 0.025)
            make.left.equalTo(descriptionTextView.snp.left)
            make.right.equalTo(descriptionTextView.snp.right)
            make.bottom.equalTo(contentView.snp.bottom).offset(-16)
        }
    }
    
    private func setupGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false  // Diğer dokunmatik olayları iptal etmeyecek.
        view.addGestureRecognizer(tapGesture)  // Ana view'e gesture ekleniyor.
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)  // Tüm aktif text field veya text view'ları kapatır.
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
    
    func textViewDidChange(_ textView: UITextView) {
        // Base class, textView changes should be handled in derived classes if needed
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        textView.snp.updateConstraints { make in
            make.height.equalTo(estimatedSize.height)
        }
    }
}







#Preview(""){
    UINavigationController(rootViewController: ReminderEditViewController(viewModel: ReminderEditViewModel(reminder: Reminder(title: "deneme", isDone: false))))
}


