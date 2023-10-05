//
//  NameTableViewCell.swift
//  gameForTheFinalCut
//
//  Created by Enzhe Gaysina on 04.10.2023.
//

import UIKit

class NameModelTableViewCell: UITableViewCell {
    
    static let cellID = "NameModelTableViewCell"
    
    private let nameTextField: UITextField = {
	   let textField = UITextField()
	   textField.translatesAutoresizingMaskIntoConstraints = false
	   textField.placeholder = "Введите имя"
	   return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
	   super.init(style: style, reuseIdentifier: reuseIdentifier)
	   
	   setupViews()
	   setConstraints()
    }
    
    required init?(coder: NSCoder) {
	   fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
	   selectionStyle = .none
	   addSubview(nameTextField)
    }
    
    func configure(with model: NameModel) {
	   nameTextField.text = model.userInput
    }
    
    //MARK: - Set Constraints
    
    private func setConstraints() {
	   NSLayoutConstraint.activate([
		  nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
		  nameTextField.topAnchor.constraint(equalTo: topAnchor, constant: 10),
		  nameTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
		  nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
	   ])
    }
}
