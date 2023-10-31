//
//  UITableViewDelegate.swift
//  gameForTheFinalCut
//
//  Created by Enzhe Gaysina on 31.10.2023.
//

import UIKit

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
	   return MockData.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
	   guard let sectionType = SectionType(rawValue: section) else {
		  return .zero
	   }
	   return MockData.sections[sectionType]?.sectionItems.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
	   guard let sectionType = SectionType(rawValue: indexPath.section) else {
		  return UITextFieldCell()
	   }
	   let sectionData = MockData.sections[sectionType]
	   let item = sectionData?.sectionItems[indexPath.row]
	   
	   if sectionType == .general {
		  let cell = tableView.dequeueReusableCell(
			 withIdentifier: UITextFieldCell.identifier, for: indexPath) as! UITextFieldCell
		  cell.textField.text = playerName
		  cell.textField.delegate = self
		  return cell
	   } else {
		  let cell = tableView.dequeueReusableCell(withIdentifier: CustomViewCell.identifier,
										   for: indexPath) as! CustomViewCell
		  cell.configure(with: item ?? "error")
		  let selectedItem = selectedItems[sectionType]?.selectedItem
		  if indexPath.row == selectedItem {
			 cell.accessoryType = .checkmark
		  } else {
			 cell.accessoryType = .none
		  }
		  
		  return cell
	   }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
	   guard let sectionType = SectionType(rawValue: section) else {
		  return nil
	   }
	   return MockData.sections[sectionType]?.sectionTitle
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
	   guard let sectionType = SectionType(rawValue: section) else {
		  return nil
	   }
	   let headerView = UIView()
	   // Фон заголовка (сюда надо вернуться)
	   headerView.backgroundColor = .clear
	   
	   let titleLabel = UILabel()
	   titleLabel.text = MockData.sections[sectionType]?.sectionTitle
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
	   guard let sectionType = SectionType(rawValue: indexPath.section) else {
		  return
	   }
	   selectedItems[sectionType]?.selectedItem = indexPath.row
	   
	   let sectionData = MockData.sections[sectionType]
	   selectedItems[sectionType] = SectionStruct(sectionType: sectionType, selectedItem: indexPath.row)
	   
	   tableView.reloadData()
	   
	   saveSelectedOptions()
	   
	   let selectedCharacter = selectedItems[.character]?.selectedItem
	   let selectedDifficulty = selectedItems[.difficulty]?.selectedItem
	   let selectedColor = selectedItems[.obstacleColor]?.selectedItem
	   delegate?.settingsDidUpdate(selectedItems,
							 selectedCharacter: selectedCharacter,
							 selectedDifficulty: selectedDifficulty,
							 selectedColor: selectedColor)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
	   return Constants.tableViewHeightForHeaderInSection
    }
    // MARK: - userDefaults
    
    func loadSelectedOptions() {
	   if let selectedOptionsData = UserDefaults.standard.data(forKey: "selectedOptions") {
		  if let selectedOptions = try? JSONDecoder().decode([SectionType: SectionStruct].self,
												   from: selectedOptionsData) {
			 selectedItems = selectedOptions
		  }
	   }
	   if let playerName = UserDefaults.standard.string(forKey: "playerName") {
		  self.playerName = playerName
	   }
    }
    
    func saveSelectedOptions() {
	   if let selectedOptionsData = try? JSONEncoder().encode(selectedItems) {
		  UserDefaults.standard.set(selectedOptionsData, forKey: "selectedOptions")
	   }
	   UserDefaults.standard.set(playerName, forKey: "playerName")
    }
}
// MARK: - extension UITextFieldDelegate
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
