//
//  ObstaclesTableViewCell.swift
//  gameForTheFinalCut
//
//  Created by Enzhe Gaysina on 04.10.2023.
//

import UIKit

class ObstaclesTableViewCell: UITableViewCell {
    
    static let cellID = "SquareTableViewCell"
    
    private let nameLabel: UILabel = {
	   let label = UILabel()
	   label.translatesAutoresizingMaskIntoConstraints = false
	   return label
    }()
    
    private let descriptionLabel: UILabel = {
	   let label = UILabel()
	   label.font = .systemFont(ofSize: 12)
	   label.textColor = .gray
	   label.numberOfLines = 2
	   label.translatesAutoresizingMaskIntoConstraints = false
	   return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
	   super.init(style: style, reuseIdentifier: reuseIdentifier)
	   
	   setupViews()
	   setConstrains()
    }
    
    required init?(coder: NSCoder) {
	   fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
	   selectionStyle = .none
	   addSubview(nameLabel)
	   addSubview(descriptionLabel)
    }
    
    func configure(_ model: ObstaclesModel) {
	   nameLabel.text = model.name
	   descriptionLabel.text = model.describtion
    }
}

//MARK: - Set Constrains

extension ObstaclesTableViewCell {
    private func setConstrains() {
	   NSLayoutConstraint.activate([
		  nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
		  nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
		  nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
		  
		  descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3),
		  descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
		  descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
	   ])
    }
}
