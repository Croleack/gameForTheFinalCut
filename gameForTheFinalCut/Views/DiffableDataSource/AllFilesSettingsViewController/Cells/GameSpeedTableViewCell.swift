//
//  GameSpeedTableViewCell.swift
//  gameForTheFinalCut
//
//  Created by Enzhe Gaysina on 04.10.2023.
//

import UIKit

class GameSpeedTableViewCell: UITableViewCell {
    
    static let cellID = "GameSpeedTableViewCell"
    
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
	   addSubview(nameLabel)
    }
    
    func configure(with model: GameSpeedModel) {
	   nameLabel.text = model.name
    }
    
    //MARK: - Set Constraints
    
    private func setConstraints() {
	   NSLayoutConstraint.activate([
		  nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
		  nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
		  nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
		  nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
	   ])
    }
}
