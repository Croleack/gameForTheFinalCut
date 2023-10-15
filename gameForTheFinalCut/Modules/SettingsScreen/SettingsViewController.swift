//
//  SettingsViewController.swift
//  gameForTheFinalCut
//
//  Created by Enzhe Gaysina on 26.09.2023.
//

import UIKit

class SettingsViewController: UIViewController {
    
    //MARK: - Variables
    
    private var playerName: String = ""
    private let backgroundColor: UIColor = UIColor(named: "secondaryColor") ?? .gray
    private var settingsData: SettingsData = SettingsData()
    
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
	   self.loadSelectedOptions()
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
	   return settingsData.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
	   return settingsData.sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
	   let sectionData = settingsData.sections[indexPath.section]
	   let item = sectionData.items[indexPath.row]
	   
	   if item == "Имя игрока" {
		  let cell = tableView.dequeueReusableCell(
			 withIdentifier: UITextFieldCell.identifier, for: indexPath) as! UITextFieldCell
		  cell.textField.text = playerName
		  cell.textField.delegate = self
		  return cell
	   } else {
		  let cell = tableView.dequeueReusableCell(withIdentifier: CustomViewCell.identifier,
										   for: indexPath) as! CustomViewCell
		  cell.configure(with: item)
		  
		  if let selectedOptionIndex = settingsData.selectedOptions[sectionData.sectionType],
			selectedOptionIndex == indexPath.row {
			 cell.accessoryType = .checkmark
		  } else {
			 cell.accessoryType = .none
		  }
		  return cell
	   }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
	   return settingsData.sections[section].section
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
	   let headerView = UIView()
	   // Фон заголовка (сюда надо вернуться)
	   headerView.backgroundColor = .clear
	   
	   let titleLabel = UILabel()
	   titleLabel.text = settingsData.sections[section].section
	   titleLabel.font = .boldSystemFont(ofSize: Constants.titleLabelFont)
	   titleLabel.textColor = .darkGray
	   titleLabel.translatesAutoresizingMaskIntoConstraints = false
	   headerView.addSubview(titleLabel)
	   
	   NSLayoutConstraint.activate([
		  titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor,
									   constant: Constants.constraintsTitleLabelLeadingAnchor),
		  titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor,
									  constant: Constants.constraintsTitleLabelBottomAnchor)
	   ])
	   
	   return headerView
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
	   let sectionData = settingsData.sections[indexPath.section]
	   
	   settingsData.selectedOptions[sectionData.sectionType] = indexPath.row
	   
	   tableView.reloadData()
	   
	   self.saveSelectedOptions()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
	   return Constants.tableViewHeightForHeaderInSection
    }
    // MARK: - userDefaults
    
    func loadSelectedOptions() {
	   if let selectedOptionsData = UserDefaults.standard.data(forKey: "selectedOptions") {
		  if let selectedOptions = try? JSONDecoder().decode([SectionType: Int].self, from: selectedOptionsData) {
			 settingsData.selectedOptions = selectedOptions
		  }
	   }
	   if let playerName = UserDefaults.standard.string(forKey: "playerName") {
		  self.playerName = playerName
	   }
    }
    
    func saveSelectedOptions() {
	   if let selectedOptionsData = try? JSONEncoder().encode(settingsData.selectedOptions) {
		  UserDefaults.standard.set(selectedOptionsData, forKey: "selectedOptions")
	   }
	   UserDefaults.standard.set(playerName, forKey: "playerName")
    }
}

extension SettingsViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
			    shouldChangeCharactersIn range: NSRange,
			    replacementString string: String) -> Bool {
	   if let text = textField.text, let textRange = Range(range, in: text) {
		  playerName = text.replacingCharacters(in: textRange, with: string)
		  UserDefaults.standard.set(playerName, forKey: "playerName")
	   }
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
