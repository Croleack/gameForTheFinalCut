//
//  CustomViewCell.swift
//  gameForTheFinalCut
//
//  Created by Enzhe Gaysina on 12.10.2023.
//

import UIKit

final class CustomViewCell: UITableViewCell {

    //MARK: - Variables
    static var identifier: String {"\(Self.self)"}
    
    private let myLabelView: UILabel = {
	   let lv = UILabel()
	   lv.textColor = .label
	   lv.textAlignment = .left
	   lv.text = "Error"
	   lv.numberOfLines = .zero
	   
	   return lv
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
    public func configure(with label: String) {
	   self.myLabelView.text = label
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
