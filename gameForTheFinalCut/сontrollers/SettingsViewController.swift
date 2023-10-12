//
//  SettingsViewController.swift
//  gameForTheFinalCut
//
//  Created by Enzhe Gaysina on 26.09.2023.
//

import UIKit

class SettingsViewController: UIViewController {
    
    //MARK: - Variables
    
    private let backgroundColor: UIColor = UIColor(named: "secondaryColor") ?? .gray
    
    private var settingsData: [(section: String, items: [String])] = [
	   ("Общие настройки", ["Имя игрока", "Аватарка игрока"]),
	   ("Персонаж", ["Отважная девочка", "Смешной динозавр"]),
	   ("Цвет препятствия", ["Зеленый", "Оранжевый", "Розовый"]),
	   ("Сложность игры", ["Easy", "Normal", "Hard"]),
    ]
    
    //MARK: - UI Components
    private let tableView: UITableView = {
	   let tableView = UITableView()
	   tableView.backgroundColor = .systemBackground
	   tableView.allowsSelection = true
	   tableView.register(CustomViewCell.self, forCellReuseIdentifier: CustomViewCell.identifier)
	   return tableView
    }()
    //MARK: - Lifecycle
    override func viewDidLoad() {
	   super.viewDidLoad()
	   self.setupUI()
	   
	   self.tableView.delegate = self
	   self.tableView.dataSource = self
    }
    
    //MARK: - Setup UI
    private func setupUI() {
	   tableView.backgroundColor = backgroundColor
	   
	   self.view.addSubview(tableView)
	   tableView.translatesAutoresizingMaskIntoConstraints = false
	   
	   NSLayoutConstraint.activate([
		  tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
		  tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
		  tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
		  tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
		  
	   ])
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
	   return settingsData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
	   return settingsData[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
	   let sectionData = settingsData[indexPath.section]
	   let item = sectionData.items[indexPath.row]
	   
	   guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomViewCell.identifier, for: indexPath) as? CustomViewCell else {
		  fatalError("The TableView could not dequeue a CustomViewCell in SettingsViewController")
	   }
	   
	   cell.configure(with: item)
	   
	   return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
	   return settingsData[section].section
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
	   let footerView = UIView()
	   let subTitleLabel = UILabel()
	   subTitleLabel.font = .boldSystemFont(ofSize: 16)
	   subTitleLabel.textColor = .darkGray
	   footerView.addSubview(subTitleLabel)
	   
	   subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
	   NSLayoutConstraint.activate([
		  subTitleLabel.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 16),
		  subTitleLabel.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
	   ])
	   
	   return footerView
    }
}
