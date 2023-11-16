//
//  ViewController.swift
//  alomafire21-magicApi
//
//  Created by 1234 on 11.10.2023.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    private var mainView = MainView()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .webSearch
        textField.placeholder = " Search..."
        textField.backgroundColor = .systemFill
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .always
        return textField
    }()
    
    private lazy var barButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 23, weight: UIImage.SymbolWeight.thin), forImageIn: .normal)
        button.imageView?.tintColor = .black
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var textFieldStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [textField, barButton])
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.spacing = 8
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var data: [Cards] = []
    
    var dataHandler: [Model] = []
    
    //  MARK: - Lifecycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewConfiguration()

        title = "Magic cards"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.titleView = textFieldStack
    }
    
    // MARK: - Setup
    
    
    private func setupView() {
        APIFetchHandler.sharedInstance.fetchAPIData(queryItemValue: nil ){ apiData in
            self.dataHandler = apiData

            DispatchQueue.main.async{
                self.mainView.tableView.reloadData()
            }
        }
    }
    private func viewConfiguration() {
        textField.delegate = self
        
        mainView.tableView.register(CastomTableViewCell.self, forCellReuseIdentifier: "cell")
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        
        NSLayoutConstraint.activate([
            textFieldStack.widthAnchor.constraint(equalToConstant: 320),
            textFieldStack.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    // MARK: - Actions
       
    @objc func buttonAction() {
        
        APIFetchHandler.sharedInstance.fetchAPIData(queryItemValue: self.textField.text ){ apiData in
            self.dataHandler = apiData

            DispatchQueue.main.async{
                self.mainView.tableView.reloadData()
            }
        }
        
        }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataHandler.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CastomTableViewCell
        cell?.character = dataHandler[indexPath.row]
        cell?.contentView.backgroundColor = .systemGray6
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = DetailViewController()
        present(viewController, animated: true)
        viewController.character = dataHandler[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController: UITextFieldDelegate {
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        buttonAction()
        DispatchQueue.main.async{
            self.mainView.tableView.reloadData()
        }
        
        return true
    }
}
