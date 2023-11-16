//
//  View.swift
//  alomafire21-magicApi
//
//  Created by 1234 on 11.10.2023.
//

import UIKit

public final class MainView: UIView {
    
    // MARK: - Outlets
    
    var data: [Cards] = []
    
    public lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .systemGray2
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupHierarhy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error in Cell")
    }
    
    // MARK: - Setup
    
    private func setupHierarhy() {
        self.addSubview(tableView)
        
    }
    
    private func setupLayout() {
        tableView.frame = self.bounds
        tableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}



