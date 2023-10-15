//
//  UITextFieldCell.swift
//  gameForTheFinalCut
//
//  Created by Enzhe Gaysina on 12.10.2023.
//

import UIKit

class UITextFieldCell: UITableViewCell {
    
    //MARK: - Variables
    static var identifier: String {"\(Self.self)"}
    
    let textField: UITextField = {
	   let textField = UITextField()
	   return textField
    }()
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
	   super.init(style: style, reuseIdentifier: reuseIdentifier)
	   setupUI()
    }
    
    required init?(coder: NSCoder) {
	   fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - functions
    private func setupUI() {
	   contentView.addSubview(textField)
	   textField.translatesAutoresizingMaskIntoConstraints = false
	   
	   NSLayoutConstraint.activate([
		  textField.topAnchor.constraint(
			 equalTo: contentView.topAnchor, constant: Constants.constraintsTopAnchorUITextFieldCell),
		  textField.leadingAnchor.constraint(
			 equalTo: contentView.leadingAnchor, constant: Constants.constraintsLeadingAnchorUITextFieldCell),
		  textField.trailingAnchor.constraint(
			 equalTo: contentView.trailingAnchor, constant: Constants.constraintsTrailingAnchorUITextFieldCell),
		  textField.bottomAnchor.constraint(
			 equalTo: contentView.bottomAnchor, constant: Constants.constraintsBottomAnchorUITextFieldCell),
	   ])
    }
    func configure(with text: String) {
	   textField.text = text
    }
}

// MARK: - Constants

fileprivate extension UITextFieldCell {
    
    enum Constants {
	   static let constraintsTopAnchorUITextFieldCell: CGFloat = 8.0
	   static let constraintsBottomAnchorUITextFieldCell: CGFloat = -8.0
	   static let constraintsTrailingAnchorUITextFieldCell: CGFloat = -16.0
	   static let constraintsLeadingAnchorUITextFieldCell: CGFloat = 16.0
    }
}
