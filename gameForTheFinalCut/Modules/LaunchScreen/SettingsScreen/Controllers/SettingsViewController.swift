//
//  SettingsViewController.swift
//  gameForTheFinalCut
//
//  Created by Enzhe Gaysina on 26.09.2023.
//

import UIKit
    //MARK: - protocol
protocol SettingsDelegate: AnyObject {
    
    func settingsDidUpdate(
	   _ selectedItems: [SectionType: SectionStruct],
	   selectedCharacter: Int?,
	   selectedDifficulty: Int?,
	   selectedColor: Int?
    )
}

final class SettingsViewController: UIViewController {
    //MARK: - Variables
    
    weak var delegate: SettingsDelegate?
    var cellBuilder = SettingsScreenCellBuilder()
    var playerName: String = ""
    let backgroundColor: UIColor = UIColor(named: "secondaryColor") ?? .gray
    var selectedItems: [SectionType: SectionStruct] = [:]
    
    let imagePicker = UIImagePickerController()

    //MARK: - UI Components
    private let tableView: UITableView = {
	   let tableView = UITableView()
	   tableView.backgroundColor = .systemBackground
	   tableView.allowsSelection = true
	   tableView.register(CustomViewCell.self, forCellReuseIdentifier: CustomViewCell.identifier)
	   tableView.register(UITextFieldCell.self, forCellReuseIdentifier: UITextFieldCell.identifier)
	   tableView.register(CustomButtonViewCell.self, forCellReuseIdentifier: CustomButtonViewCell.identifier)
	   return tableView
    }()
    
    private let avatarImageView: UIImageView = {
	   let imageView = UIImageView()
	   imageView.image = UIImage(named: "avatar")
	   imageView.contentMode = .scaleAspectFit
	   imageView.clipsToBounds = true
	   imageView.translatesAutoresizingMaskIntoConstraints = false
	   return imageView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
	   super.viewDidLoad()
	   
	   setupUI()
	   tableView.delegate = self
	   tableView.dataSource = self
	   imagePicker.delegate = self
	   loadSelectedOptions()
	   
	   imagePicker.delegate = self
    }
    
    //MARK: - functions
    private func setupUI() {
	   tableView.backgroundColor = backgroundColor
	   
	   let stackView = UIStackView(arrangedSubviews: [tableView, avatarImageView])
	   stackView.axis = .vertical
	   
	   view.addSubview(stackView)
	   stackView.translatesAutoresizingMaskIntoConstraints = false
	   
	   NSLayoutConstraint.activate([
		  stackView.topAnchor.constraint(equalTo: self.view.topAnchor),
		  stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
		  stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
		  stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
		  avatarImageView.heightAnchor.constraint(equalToConstant: Constants.heightAndWidthAvatar),
	   ])
    }
 
    func saveImage(_ image: UIImage, withFileName fileName: String) {
	  
	   let uniqueFileName = UUID().uuidString
	   if let imageData = image.jpegData(compressionQuality: 1.0) {
		  UserDefaults.standard.set(imageData, forKey: uniqueFileName)
	   }
	   UserDefaults.standard.set(uniqueFileName, forKey: "avatarFileName")
    }
    
    func loadImage(withFileName fileName: String) -> UIImage? {
	   if let imageData = UserDefaults.standard.data(forKey: fileName), let image = UIImage(data: imageData) {
		  return image
	   }
	   return nil
    }
}
//MARK: - extension
extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
						 didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
	   if let pickedImage = info[.editedImage] as? UIImage {
		  avatarImageView.image = pickedImage
		  saveImage(pickedImage, withFileName: "avatarImage")
	   }
	   dismiss(animated: true, completion: nil)
    }
}

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
	   let cell = cellBuilder.buildCell(
		  tableView: tableView,
		  indexPath: indexPath,
		  delegate: self
	   )
	   
	   let data = getCellData(indexPath)
	   cell.configure(data)
	   
	   if let cell = cell as? CustomViewCell {
		  let selectedItem = selectedItems[SectionType(rawValue: indexPath.section) ?? .general]?.selectedItem
		  if indexPath.row == selectedItem {
			 cell.accessoryType = .checkmark
		  } else {
			 cell.accessoryType = .none
		  }
	   }
	   
	   return cell as? UITableViewCell ?? UITableViewCell()
    }
    
    func getCellData(_ indexPath: IndexPath) -> SettingsCellCommonDataProtocol? {
	   let sectionType = SectionType(rawValue: indexPath.section)
	   if let sectionType = sectionType {
		  switch sectionType {
		  case .general:
			 return UITextFieldCellData(text: playerName)
		  case .updateImage:
			 return nil
		  default:
			 if let text = MockData.sections[sectionType]?.sectionItems[indexPath.row] {
				return CustomViewCellData(text: text)
			 }
		  }
	   }
	   return nil
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
	   guard let sectionType = SectionType(rawValue: section) else {
		  return nil
	   }
	   return MockData.sections[sectionType]?.sectionTitle
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
	   guard let sectionType = SectionType(rawValue: section) else { return nil }
	   let headerView = UIView()
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
	   guard let sectionType = SectionType(rawValue: indexPath.section) else { return }
	   
	   selectedItems[sectionType] = SectionStruct(sectionType: sectionType, selectedItem: indexPath.row)
	   tableView.reloadData()
	   saveSelectedOptions()
	   
	   delegate?.settingsDidUpdate(
		  selectedItems,
		  selectedCharacter: selectedItems[.character]?.selectedItem,
		  selectedDifficulty: selectedItems[.difficulty]?.selectedItem,
		  selectedColor: selectedItems[.obstacleColor]?.selectedItem
	   )
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
	   return Constants.tableViewHeightForHeaderInSection
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
	   return Constants.heightForRowAt
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
    
    func textField(
	   _ textField: UITextField,
	   shouldChangeCharactersIn range: NSRange,
	   replacementString string: String) -> Bool {
	   if let text = textField.text, let textRange = Range(range, in: text) {
		  playerName = text.replacingCharacters(in: textRange, with: string)
		  UserDefaults.standard.set(playerName, forKey: "playerName")
	   }
	   return true
    }
}

extension SettingsViewController: CustomButtonViewCellDelegateProtocol {
    
    func didTapLoadImageButton() {
	   let alert = UIAlertController(title: "Откуда грузим", message: nil, preferredStyle: .actionSheet)
	   
	   let actionPhoto = UIAlertAction(title: "C галереи", style: .default) { (alert) in
		  self.imagePicker.sourceType = .photoLibrary
		  self.imagePicker.allowsEditing = true
		  self.present(self.imagePicker, animated: true)
	   }
	   let actionCamera = UIAlertAction(title: "C камеры", style: .default) { (alert) in
		  self.imagePicker.sourceType = .camera
		  self.present(self.imagePicker, animated: true)
	   }
	   let actionCansel = UIAlertAction(title: "Отмена", style: .cancel)
	   
	   alert.addAction(actionPhoto)
	   alert.addAction(actionCamera)
	   alert.addAction(actionCansel)
	   present(alert, animated: true)
    }
     
    func saveSelectedImage(_ image: UIImage) {
	   if let imageData = image.jpegData(compressionQuality: 1.0) {
		  UserDefaults.standard.set(imageData, forKey: "selectedImage")
	   }
    }
}

// MARK: - Constants

fileprivate extension SettingsViewController {
    
    enum Constants {
	   static let titleLabelFont: CGFloat = 16.0
	   static let constraintsTitleLabelLeadingAnchor: CGFloat = 16.0
	   static let constraintsTitleLabelBottomAnchor: CGFloat = -8.0
	   static let tableViewHeightForHeaderInSection: CGFloat = 20.0
	   static let heightAndWidthAvatar: CGFloat = 40.0
	   static let heightForRowAt: CGFloat = 44.0
    }
}

