//
//  PlayViewController.swift
//  gameForTheFinalCut
//
//  Created by Enzhe Gaysina on 26.09.2023.
//

import UIKit

class PlayViewController: UIViewController {
    
    //игровое поле
    let gameFieldView: UIView = {
	   let view = UIView()
	   view.translatesAutoresizingMaskIntoConstraints = false
	   return view
    }()
    
    var redView: UIView!
    
    var characterImageView: UIImageView!
    
    var gestureAreaView: GestureAreaView!
    
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
	   super.viewDidLoad()
	   
	   view.backgroundColor = UIColor(named: "secondaryColor") ?? .gray
	   
	   view.addSubview(gameFieldView)
	   setupGameFieldConstraints(gameFieldView: gameFieldView, in: view)
	   
	   createRedView(width: Constants.redViewWidth, height: Constants.redViewHeight)
	   Timer.scheduledTimer(timeInterval: Constants.timeIntervalRedView, target: self, selector: #selector(animateRedView), userInfo: nil, repeats: true)
	   
	   
	   self.characterImageView = createCharacterImageView()
	   gameFieldView.addSubview(self.characterImageView)
	   
	   gestureAreaView = GestureAreaView()
	   gestureAreaView.translatesAutoresizingMaskIntoConstraints = false
	   view.addSubview(gestureAreaView)
	   
	   
	   // Ограничения для GestureAreaView
	   NSLayoutConstraint.activate([
		  gestureAreaView.topAnchor.constraint(equalTo: view.topAnchor),
		  gestureAreaView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
		  gestureAreaView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
		  gestureAreaView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
	   ])
	   
	   // Назначьте обработчики жестов
	   gestureAreaView.topAreaTapHandler = { [weak self] in
		  self?.moveCharacterUp()
	   }
	   
	   gestureAreaView.leftAreaTapHandler = { [weak self] in
		  self?.moveCharacterLeft()
	   }
	   
	   gestureAreaView.rightAreaTapHandler = { [weak self] in
		  self?.moveCharacterRight()
	   }
	   
	   gestureAreaView.bottomAreaTapHandler = { [weak self] in
		  self?.moveCharacterDown()
	   }
    }
    
    //MARK: - Game Field functions
    func setupGameFieldConstraints(gameFieldView: UIView, in view: UIView) {
	   NSLayoutConstraint.activate([
		  gameFieldView.topAnchor.constraint(equalTo: view.topAnchor),
		  gameFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
		  gameFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
		  gameFieldView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
	   ])
    }
    
    //MARK: - players functions
    func createCharacterImageView() -> UIImageView {
	   let characterImageView = UIImageView(image: UIImage(named: "characterImage"))
	   characterImageView.contentMode = .scaleAspectFit
	   characterImageView.frame = CGRect(x: Constants.characterXandYView, y: Constants.characterXandYView, width: Constants.characterWidth, height: Constants.characterHeight)
	   return characterImageView
    }
    
    //MARK: - obstacle functions
    
    func createRedView(width: CGFloat, height: CGFloat) {
	   let viewWidth = view.frame.size.width
	   redView = UIView(frame: CGRect(x: viewWidth / 2 - width / 2, y: -height, width: width, height: height))
	   redView.backgroundColor = UIColor.red
	   view.addSubview(redView)
    }
    
    @objc func animateRedView() {
	   let viewHeight = view.frame.size.height
	   let redViewHeight: CGFloat = Constants.redViewWidth
	   
	   UIView.animate(withDuration: 1.0, animations: {
		  self.redView.frame.origin.y = viewHeight
		  
	   }) { (finished) in
		  self.redView.frame.origin.y = -redViewHeight
	   }
    }
    
    //    //MARK: - all button functions
    
    @objc func moveCharacterUp() {
	   let minY = gameFieldView.frame.minY
	   if characterImageView.frame.minY - Constants.movementStep >= minY {
		  characterImageView.center.y -= Constants.movementStep
	   }
    }
    
    @objc func moveCharacterDown() {
	   let maxY = gameFieldView.frame.maxY
	   if characterImageView.frame.maxY + Constants.movementStep <= maxY {
		  characterImageView.center.y += Constants.movementStep
	   }
    }
    
    @objc func moveCharacterLeft() {
	   let minX = gameFieldView.frame.minX
	   if characterImageView.frame.minX - Constants.movementStep >= minX {
		  characterImageView.center.x -= Constants.movementStep
	   }
	   characterImageView.transform = CGAffineTransform(scaleX: -1, y: 1)
    }
    
    @objc func moveCharacterRight() {
	   let maxX = gameFieldView.frame.maxX
	   if characterImageView.frame.maxX + Constants.movementStep <= maxX {
		  characterImageView.center.x += Constants.movementStep
	   }
	   
	   characterImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
	   
    }
}
// MARK: - Constants

fileprivate extension PlayViewController {
    
    enum Constants {
	   static let redViewWidth: CGFloat = 50.0
	   static let redViewHeight: CGFloat = 50.0
	   static var characterWidth: CGFloat = 100
	   static var characterHeight: CGFloat = 100
	   static var characterXandYView:CGFloat = 300
	   static var movementStep: CGFloat = 50.0
	   static var timeIntervalRedView = 1.5
    }
}

