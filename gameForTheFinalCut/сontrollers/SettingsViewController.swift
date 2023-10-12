//
//  SettingsViewController.swift
//  gameForTheFinalCut
//
//  Created by Enzhe Gaysina on 26.09.2023.
//

import UIKit

class SettingsViewController: UIViewController {
    
    //MARK: - Variables
    
    private let variablesSettings = [
	   "Имя игрока",
	   "Аватарка игрока",
	   "Цвет преграды",
	   "Выбор персонажа",
	   "Сложность игры"
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
	   view.backgroundColor = UIColor(named: "secondaryColor") ?? .gray
	   
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
	   return self.variablesSettings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
	   guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomViewCell.identifier, for: indexPath) as? CustomViewCell else {
		  fatalError("The TableView could not dequeue a CustomViewCell in SettingsViewController")
	   }
	   
	   let settings = self.variablesSettings[indexPath.row]
	   cell.configure(with: settings)
	   
	   return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
	   return UITableView.automaticDimension
    }
}
