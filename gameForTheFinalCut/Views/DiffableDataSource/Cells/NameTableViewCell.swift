//
//  NameTableViewCell.swift
//  gameForTheFinalCut
//
//  Created by Enzhe Gaysina on 04.10.2023.
//

import UIKit

class NameModelTableViewCell: UITableViewCell {
    
    static let cellID = "NameModelTableViewCell"
    
    private let nameImageView: UIImageView = {
	   let imageView = UIImageView()
	   imageView.translatesAutoresizingMaskIntoConstraints = false
	   return imageView
    }()
    
    private let nameLabel: UILabel = {
	   let label = UILabel()
	   label.translatesAutoresizingMaskIntoConstraints = false
	   return label
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
	   addSubview(nameImageView)
	   addSubview(nameLabel)
    }
    
    func configure(with model: NameModel) {
	   nameImageView.image = UIImage(named: model.image)
	   nameLabel.text = model.name
    }
    
    //MARK: - Set Constraints
    
    private func setConstraints() {
	   NSLayoutConstraint.activate([
		  nameImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
		  nameImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
		  nameImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
		  nameImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9),
		  
		  nameLabel.leadingAnchor.constraint(equalTo: nameImageView.trailingAnchor, constant: 10),
		  nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
		  nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
	   ])
    }
}
