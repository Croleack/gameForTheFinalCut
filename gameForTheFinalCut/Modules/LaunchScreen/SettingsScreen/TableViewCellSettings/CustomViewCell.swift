//
//  CustomViewCell.swift
//  gameForTheFinalCut
//
//  Created by Enzhe Gaysina on 12.10.2023.
//

import UIKit

struct CustomViewCellData: SettingsCellCommonDataProtocol {
    let text: String
}

final class CustomViewCell: UITableViewCell, SettingsCellCommonProtocol {
    
    //MARK: - Variables
    static var identifier: String {"\(Self.self)"}
    
    private let myLabelView: UILabel = {
	   let labelView = UILabel()
	   labelView.textColor = .label
	   labelView.textAlignment = .left
	   labelView.text = "Error"
	   labelView.numberOfLines = .zero
	   
	   return labelView
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
	   guard let model = model as? CustomViewCellData else {
		  return
	   }
	   myLabelView.text = model.text
    }
    
    private func setupUI() {
	   self.contentView.addSubview(myLabelView)
	   
	   myLabelView.translatesAutoresizingMaskIntoConstraints = false
	   
	   NSLayoutConstraint.activate([
		  myLabelView.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
		  myLabelView.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor),
		  myLabelView.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
		  myLabelView.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor),
	   ])
    }
    var cellHeight: CGFloat {
	   let labelSize = myLabelView.sizeThatFits(
		  CGSize(width: myLabelView.frame.width, height: CGFloat.greatestFiniteMagnitude))
	   return labelSize.height
    }
}
