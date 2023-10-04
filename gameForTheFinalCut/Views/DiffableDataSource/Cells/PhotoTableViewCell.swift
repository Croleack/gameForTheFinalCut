//
//  PhotoTableViewCell.swift
//  gameForTheFinalCut
//
//  Created by Enzhe Gaysina on 04.10.2023.
//

import UIKit

class PhotoModelTableViewCell: UITableViewCell {
    
    static let cellID = "PhotoModelTableViewCell"
    
    private let photoImageView: UIImageView = {
	   let imageView = UIImageView()
	   imageView.translatesAutoresizingMaskIntoConstraints = false
	   return imageView
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
	   addSubview(photoImageView)
    }
    
    func configure(with model: PhotoModel) {
	   photoImageView.image = UIImage(named: model.image)
    }
    
    //MARK: - Set Constraints
    
    private func setConstraints() {
	   NSLayoutConstraint.activate([
		  photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
		  photoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
		  photoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
		  photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
	   ])
    }
}
