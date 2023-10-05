//
//  PhotoTableViewCell.swift
//  gameForTheFinalCut
//
//  Created by Enzhe Gaysina on 04.10.2023.
//

import UIKit

class PhotoModelTableViewCell: UITableViewCell {
    
    static let cellID = "PhotoModelTableViewCell"
    
    private let uploadButton: UIButton = {
	   let button = UIButton()
	   button.translatesAutoresizingMaskIntoConstraints = false
	   button.setTitle("Загрузить изображение", for: .normal)
	   button.setTitleColor(.blue, for: .normal)
	   button.addTarget(self, action: #selector(uploadButtonTapped), for: .touchUpInside)
	   return button
    }()
    
    var uploadAction: (() -> Void)?
    
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
	   addSubview(uploadButton)
    }
    
    @objc private func uploadButtonTapped() {
	   uploadAction?()
    }
    
    func configure() {
	   // Здесь вы можете установить изображение, если необходимо
    }
    
    //MARK: - Set Constraints
    
    private func setConstraints() {
	   NSLayoutConstraint.activate([
		  uploadButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
		  uploadButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
		  uploadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
	   ])
    }
}
