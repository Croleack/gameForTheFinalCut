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
	   ("Общие настройки", ["Имя игрока"]),
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
	   tableView.register(UITextFieldCell.self, forCellReuseIdentifier: UITextFieldCell.identifier)
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
	   
	   if item == "Имя игрока" {
		  let cell = tableView.dequeueReusableCell(
			 withIdentifier: UITextFieldCell.identifier, for: indexPath) as! UITextFieldCell
		  cell.configure(with: "Введите свое имя")
		  cell.textField.delegate = self
		  return cell
	   } else {
		  guard let cell = tableView.dequeueReusableCell(
			 withIdentifier: CustomViewCell.identifier, for: indexPath) as? CustomViewCell else {
			 fatalError("The TableView could not dequeue a CustomViewCell in SettingsViewController")
		  }
		  cell.configure(with: item)
		  return cell
	   }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
	   return settingsData[section].section
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
	   let headerView = UIView()
	   // Фон заголовка (сюда надо вернуться)
	   headerView.backgroundColor = .clear
	   
	   let titleLabel = UILabel()
	   titleLabel.text = settingsData[section].section
	   titleLabel.font = .boldSystemFont(ofSize: Constants.titleLabelFont)
	   titleLabel.textColor = .darkGray
	   titleLabel.translatesAutoresizingMaskIntoConstraints = false
	   headerView.addSubview(titleLabel)
	   
	   NSLayoutConstraint.activate([
		  titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: Constants.constraintsTitleLabelLeadingAnchor),
		  titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: Constants.constraintsTitleLabelBottomAnchor)
	   ])
	   
	   return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
	   return Constants.tableViewHeightForHeaderInSection
    }
}

extension SettingsViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
	   // Обработка ввода имени игрока и сохранение данных СЮДА НАДО ВЕРНУТЬСЯ
	   return true
    }
}

// MARK: - Constants

fileprivate extension SettingsViewController {
    
    enum Constants {
	   static let titleLabelFont: CGFloat = 16.0
	   static let constraintsTitleLabelLeadingAnchor: CGFloat = 16.0
	   static let constraintsTitleLabelBottomAnchor: CGFloat = -8.0
	   static let tableViewHeightForHeaderInSection: CGFloat = 20.0
    }
}
