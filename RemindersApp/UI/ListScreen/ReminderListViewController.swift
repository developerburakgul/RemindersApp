//
//  ViewController.swift
//  RemindersApp
//
//  Created by Burak Gül on 24.06.2024.
//

import UIKit
import SnapKit

class ReminderListViewController: UIViewController {
    
    
    //MARK: - ViewModel
    private var viewModel : ReminderListViewModel
    
    //MARK: - UI Components
    private var tableView : UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private var addButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.addTarget(self, action: #selector(createNewReminder), for: .touchUpInside)
        return button
    }()
    
    private var label : UILabel = {
        let label = UILabel()
        label.text = "Create a new reminder"
        
        
        
        return label
    }()
    
    private var ellipsisCircleBarButton : UIBarButtonItem =  {
        let barButton = UIBarButtonItem(
            image: UIImage(systemName: "ellipsis.circle"),
            style: .done,
            target: ReminderListViewController.self,
            action: nil)
        return barButton
    }()
    
    //MARK: - İnit
    
    init(listViewModel : ReminderListViewModel = ReminderListViewModel()){
        self.viewModel = listViewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        setup()
        viewModel.remindersDidRefresh = {
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.refreshReminders()
    }

    
    
    
    //MARK: - Setup
    private func setup(){
        setupViews()
        setupTableViewDelegates()
    }
    
    //MARK: - Setup Views
    private func setupViews(){
        setupTableView()
        setupAddButton()
        setupLabel()
        setupNavigationBar()
    }
    
    private func setupTableView(){
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.9)
        }
    }
    
    private func setupAddButton(){
        view.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(16)
            make.top.equalTo(tableView.snp.bottom).offset(16)
            make.height.equalTo(view.snp.height).multipliedBy(0.05)
            make.width.equalTo(addButton.snp.height)
        }
    }
    
    private func setupLabel(){
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.leading.equalTo(addButton.snp.trailing).offset(16)
            make.top.equalTo(addButton.snp.top)
            make.centerY.equalTo(addButton.snp.centerY)
            make.bottom.equalTo(addButton.snp.bottom)
            make.width.equalTo(view.snp.width).multipliedBy(0.5)
        }
        
    }
    
    private func setupNavigationBar(){
        self.navigationItem.title = "Reminder"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItem = ellipsisCircleBarButton
        
    }
    
    
    //MARK: - Private Functions
    
    @objc private func createNewReminder()  {
        let createViewController = ReminderCreateViewController(viewModel: ReminderCreateViewModel())
        
        
        let navigationController = UINavigationController(rootViewController: createViewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
        
        
    }
    
    private func editReminder() {
        let reminderEditViewController = ReminderEditViewController(viewModel: ReminderEditViewModel())
        
        
        let navigationController = UINavigationController(rootViewController: reminderEditViewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }
    
    private func showDetail(of reminder : Reminder) {
        let reminderDetailViewController = ReminderDetailViewController(viewModel: ReminderDetailViewModel(reminder: reminder))
        
        
        let navigationController = UINavigationController(rootViewController: reminderDetailViewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }
    

    
    //MARK: - Setup TableView Delegates
    
    private func setupTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
        
    }
}


//MARK: - TableView DataSource
extension ReminderListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.reminderCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reminder = viewModel.getReminder(indexPath.row)
        let cell = ListTableViewCell(style: .default, reuseIdentifier: ListTableViewCell.identifier)
        cell.configure(with: ListTableViewCellModel(reminder: reminder))
        cell.doneButtonTappedAction = {
            self.viewModel.updateReminder(at: indexPath.row)
            self.tableView.reloadData()
        }
        
        return cell
    }
    
}

//MARK: - TableView Delegate
extension ReminderListViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let reminder = viewModel.getReminder(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
        showDetail(of: reminder)
        
        
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Remove") {  (action, view, completionHandler) in
            // Silme işlemini burada gerçekleştir
            self.viewModel.delete(self.viewModel.getReminder(indexPath.row))
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash")
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
    
        let editAction = UIContextualAction(style: .normal, title: "Edit") {  (action, view, completionHandler) in
            
            self.editReminder()
            completionHandler(true)
        }
        editAction.image = UIImage(systemName: "pencil")
        editAction.backgroundColor = .systemBlue
        return UISwipeActionsConfiguration(actions: [editAction])
        
    }
    
}
#Preview(""){
    UINavigationController(rootViewController: ReminderListViewController())
}

