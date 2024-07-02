//
//  ViewController.swift
//  RemindersApp
//
//  Created by Burak Gül on 24.06.2024.
//

import UIKit
import SnapKit

class ListViewController: UIViewController {
    
    
    //MARK: - ViewModel
    private var listViewModel : ListViewModel
    
    //MARK: - UI Components
    private var tableView : UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    private var addButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.addTarget(ListViewController.self, action: #selector(addNewReminder), for: .touchUpInside)
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
            target: ListViewController.self,
            action: nil)
        return barButton
    }()
    
    //MARK: - İnit
    
    init(listViewModel : ListViewModel = ListViewModel()){
        self.listViewModel = listViewModel
        
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
        listViewModel.remindersDidRefresh = {
            self.tableView.reloadData()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listViewModel.refreshReminders()
        
        
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
    
    @objc private func addNewReminder()  {
        print("Add New Reminder")
    }
    
    //MARK: - Setup TableView Delegates
    
    private func setupTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self

    }
}

extension ListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.reminderCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reminder = listViewModel.getReminder(indexPath.row)
        let cell = ReminderListTableViewCell(style: .default, reuseIdentifier: ReminderListTableViewCell.identifier)
        cell.configure(with: reminder)
        cell.doneButtonAction = { [weak self] in
            self?.listViewModel.toggleReminderDone(at: indexPath.row)
        }
        return cell
    }
    
}

extension ListViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = listViewModel.getReminder(indexPath.row)
        
    }
    
}
#Preview(""){
    UINavigationController(rootViewController: ListViewController())
}

