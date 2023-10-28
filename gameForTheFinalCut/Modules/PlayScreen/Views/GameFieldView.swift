//
//  GameFieldView.swift
//  gameForTheFinalCut
//
//  Created by Enzhe Gaysina on 14.10.2023.
//

import UIKit

class GameFieldView: UIView {
    
    //MARK: - Variables
    
    let characterImageView: UIImageView = {
	   let characterImageView = UIImageView(image: UIImage(named: "characterImage"))
	   characterImageView.contentMode = .scaleAspectFit
	   characterImageView.frame = CGRect(
		  x: Constants.characterXandYView,
		  y: Constants.characterXandYView,
		  width: Constants.characterWidth,
		  height: Constants.characterHeight
	   )
	   return characterImageView
    }()
    
    //MARK: - public methods
    
    func make() {
	   setupViews()
	   setupConstraints()
	   setupGesture()
    }
    
    func setupGesture() {
	   let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
	   addGestureRecognizer(gesture)
    }
    
    func moveCharacterUp() {
	   let minY = frame.minY
	   if characterImageView.frame.minY - Constants.movementStep >= minY {
		  characterImageView.center.y -= Constants.movementStep
	   }
    }
    
    func moveCharacterDown() {
	   let maxY = frame.maxY
	   if characterImageView.frame.maxY + Constants.movementStep <= maxY {
		  characterImageView.center.y += Constants.movementStep
	   }
    }
    
    func moveCharacterLeft() {
	   let minX = frame.minX
	   if characterImageView.frame.minX - Constants.movementStep >= minX {
		  characterImageView.center.x -= Constants.movementStep
	   }
	   characterImageView.transform = CGAffineTransform(scaleX: -1, y: 1)
    }
    
    func moveCharacterRight() {
	   let maxX = frame.maxX
	   if characterImageView.frame.maxX + Constants.movementStep <= maxX {
		  characterImageView.center.x += Constants.movementStep
	   }
	   characterImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
    }
    
    func updateImage(_ selectedImageNumber: Int) {
		  if selectedImageNumber == 0 {
			characterImageView.image = UIImage(named: "characterImage")
		  } else if selectedImageNumber == 1 {
			characterImageView.image = UIImage(named: "characterSecondImage")
		  } else if selectedImageNumber == 2 {
			 characterImageView.image = UIImage(named: "characterThirdImage")
		  }
	   }
}

private extension GameFieldView {
    
    func setupViews() {
	   addSubview(characterImageView)
    }
    
    func setupConstraints() {
	   guard let superView = superview else {
		  return
	   }
	   NSLayoutConstraint.activate([
		  topAnchor.constraint(equalTo: superView.topAnchor),
		  leadingAnchor.constraint(equalTo: superView.leadingAnchor),
		  trailingAnchor.constraint(equalTo: superView.trailingAnchor),
		  bottomAnchor.constraint(equalTo: superView.bottomAnchor)
	   ])
    }
    
    @objc
    private func handleTap(_ sender: UITapGestureRecognizer) {
	   
	   let characterPosition = characterImageView.frame
	   let tapPosition = sender.location(in: self)
	   
	   if characterPosition.maxX < tapPosition.x {
		  moveCharacterRight()
	   } else if characterPosition.minX > tapPosition.x {
		  moveCharacterLeft()
	   }
	   
	   if characterPosition.minY > tapPosition.y {
		  moveCharacterUp()
	   } else if characterPosition.maxY < tapPosition.y {
		  moveCharacterDown()
	   }
    }
}

// MARK: - Constants

fileprivate extension GameFieldView {
    
    enum Constants {
	   static let characterWidth: CGFloat = 70
	   static let characterHeight: CGFloat = 70
	   static let characterXandYView: CGFloat = 300
	   static let movementStep: CGFloat = 50.0
    }
}
