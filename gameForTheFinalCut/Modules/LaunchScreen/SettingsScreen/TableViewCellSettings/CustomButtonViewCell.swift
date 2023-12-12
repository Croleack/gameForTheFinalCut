//
//  CustomButtonViewCell.swift
//  gameForTheFinalCut
//
//  Created by Enzhe Gaysina on 01.11.2023.
//

import UIKit

struct CustomButtonViewCellData: SettingsCellCommonDataProtocol {
    let text: String
}

protocol CustomButtonViewCellDelegateProtocol {
    func didTapLoadImageButton()
    
}

final class CustomButtonViewCell: UITableViewCell, SettingsCellCommonProtocol {
    
    static var identifier: String { "\(Self.self)" }
    
    var delegate: CustomButtonViewCellDelegateProtocol?
    
    private let myLabelView: UILabel = {
	   let label = UILabel()
	   label.textColor = .label
	   label.textAlignment = .left
	   label.text = "Ава"
	   label.numberOfLines = 0
	   
	   return label
    }()
    
    private let myButton: UIButton = {
	   let button = UIButton()
	   button.setTitle("Загрузить изображение", for: .normal)
	   button.setTitleColor(.systemBlue, for: .normal)
	   button.isEnabled = true
	   
	   return button
    }()
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
	   super.init(style: style, reuseIdentifier: reuseIdentifier)
	   self.setupUI()
    }
    
    required init?(coder: NSCoder) {
	   fatalError("init(coder:) has not been implemented")
    }
    //MARK: - functions
    
    func configure(_ model: SettingsCellCommonDataProtocol?) {
	   guard let model = model as? CustomButtonViewCellData else {
		  return
	   }
	   myLabelView.text = model.text
    }
    
    private func setupUI() {
	   self.contentView.addSubview(myLabelView)
	   self.contentView.addSubview(myButton)
	   
	   myLabelView.translatesAutoresizingMaskIntoConstraints = false
	   myButton.translatesAutoresizingMaskIntoConstraints = false
	   
	   NSLayoutConstraint.activate([
		  myLabelView.topAnchor.constraint(equalTo:  self.contentView.layoutMarginsGuide.topAnchor),
		  myLabelView.leadingAnchor.constraint(equalTo:  self.contentView.layoutMarginsGuide.leadingAnchor),
		  myLabelView.trailingAnchor.constraint(equalTo:  self.contentView.layoutMarginsGuide.trailingAnchor),
		  
		  myButton.leadingAnchor.constraint(equalTo:  myLabelView.leadingAnchor, constant: Constants.constraintsLeadingMyLabel),
		  myButton.trailingAnchor.constraint(equalTo:  self.contentView.layoutMarginsGuide.trailingAnchor),
	   ])
	   
	   myButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func playButtonTapped() {
	   delegate?.didTapLoadImageButton()
    }
    
    var cellHeight: CGFloat {
	   let labelSize = myLabelView.sizeThatFits(CGSize(width: myLabelView.frame.width, height: CGFloat.greatestFiniteMagnitude))
	   let buttonSize = myButton.sizeThatFits(CGSize(width: myButton.frame.width, height: CGFloat.greatestFiniteMagnitude))
	   return labelSize.height + buttonSize.height + Constants.forСellHeight
    }
}

// MARK: - Constants

fileprivate extension CustomButtonViewCell {
    
    enum Constants {
	   static let forСellHeight: CGFloat = 8.0
	   static let constraintsLeadingMyLabel: CGFloat = 24
    }
}
