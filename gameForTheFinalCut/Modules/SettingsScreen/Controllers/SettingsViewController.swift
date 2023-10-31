//
//  SettingsViewController.swift
//  gameForTheFinalCut
//
//  Created by Enzhe Gaysina on 26.09.2023.
//

import UIKit
//MARK: - protocol
protocol SettingsDelegate: AnyObject {
    
    func settingsDidUpdate(_ selectedItems: [SectionType: SectionStruct],
					  selectedCharacter: Int?,
					  selectedDifficulty: Int?,
					  selectedColor: Int?)
}

final class SettingsViewController: UIViewController {
    //MARK: - Variables
    
    weak var delegate: SettingsDelegate?
    //здесь
    var selectedImage: UIImage?
    
    var playerName: String = ""
    private let backgroundColor: UIColor = UIColor(named: "secondaryColor") ?? .gray
    var selectedItems: [SectionType: SectionStruct] = [:]
    
    //MARK: - UI Components
    private let tableView: UITableView = {
	   let tableView = UITableView()
	   tableView.backgroundColor = .systemBackground
	   tableView.allowsSelection = true
	   tableView.register(CustomViewCell.self, forCellReuseIdentifier: CustomViewCell.identifier)
	   tableView.register(UITextFieldCell.self, forCellReuseIdentifier: UITextFieldCell.identifier)
	   return tableView
    }()
    //сюда надо вернуться
    private let imageUploadButton: UIButton = {
	   let button = UIButton(type: .system)
	   button.setTitle("Загрузить изображение", for: .normal)
	   button.addTarget(self, action: #selector(uploadImage), for: .touchUpInside)
	   button.translatesAutoresizingMaskIntoConstraints = false
	   return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
	   super.viewDidLoad()
	   
	   self.setupUI()
	   self.tableView.delegate = self
	   self.tableView.dataSource = self
	   self.loadSelectedOptions()
    }
    
    //MARK: - functios
    private func setupUI() {
	   tableView.backgroundColor = backgroundColor
	   
	   let stackView = UIStackView(arrangedSubviews: [tableView, imageUploadButton])
	   stackView.axis = .vertical
	   
	   view.addSubview(stackView)
	   stackView.translatesAutoresizingMaskIntoConstraints = false
	   
	   NSLayoutConstraint.activate([
		  stackView.topAnchor.constraint(equalTo: self.view.topAnchor),
		  stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
		  stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
		  stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
	   ])
    }
    //здесь
    @objc
    private func uploadImage() {
	   let imagePicker = UIImagePickerController()
	   imagePicker.delegate = self
	   imagePicker.sourceType = .photoLibrary
	   present(imagePicker, animated: true, completion: nil)
    }
}
//MARK: - extension
//здесь
extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
						 didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
	   if let image = info[.originalImage] as? UIImage {
		  if let image = info[.originalImage] as? UIImage {
			 selectedImage = image
			 tableView.reloadData()
		  }
		  }
	   dismiss(animated: true, completion: nil)
    }
	   //здесь какая то ошибка 
    func saveImage(_ image: UIImage, withFileName fileName: String) {
	   if let data = image.pngData(),
		 let url = FileManager.default.urls(
		  for: .documentDirectory,
		  in: .userDomainMask)
		  .first?
		  .appendingPathComponent(fileName) {
		  try? data.write(to: url)
	   }
    }
}


