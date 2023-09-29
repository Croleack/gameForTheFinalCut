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
    
    
    let redViewWidth: CGFloat = 50.0
    let redViewHeight: CGFloat = 50.0
    var redView: UIView!
    
  
    var characterImageView: UIImageView!
    var characterWidth: CGFloat = 100
    var characterHeight: CGFloat = 100
    var characterXandYView:CGFloat = 300
    var isMovingLeft = false
    var movementStep: CGFloat = 50.0
    
    //создал для борьбы с магическими числами
    var timeIntervalRedView = 1.5
    
    var locationOfControlArrowsOnTheScreen: CGFloat = 50.0
    var secondLocationOfControlArrowsOnTheScreen: CGFloat = 0
    
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
	   super.viewDidLoad()
	   
	   view.backgroundColor = UIColor(named: "secondaryColor") ?? .gray
	   
	   view.addSubview(gameFieldView)
	   setupGameFieldConstraints(gameFieldView: gameFieldView, in: view)
	   
	   createRedView(width: redViewWidth, height: redViewHeight)
	   Timer.scheduledTimer(timeInterval: timeIntervalRedView, target: self, selector: #selector(animateRedView), userInfo: nil, repeats: true)
	   

	   self.characterImageView = createCharacterImageView()
	   gameFieldView.addSubview(self.characterImageView)
	   
	   //все что касается кнопок
	   let upButton = createAndConfigureButton(systemName: "arrow.up", action: #selector(moveCharacterUp))
	   let downButton = createAndConfigureButton(systemName: "arrow.down", action: #selector(moveCharacterDown))
	   let leftButton = createAndConfigureButton(systemName: "arrow.left", action: #selector(moveCharacterLeft))
	   let rightButton = createAndConfigureButton(systemName: "arrow.right", action: #selector(moveCharacterRight))
	   
	   gameFieldView.addSubview(upButton)
	   gameFieldView.addSubview(downButton)
	   gameFieldView.addSubview(leftButton)
	   gameFieldView.addSubview(rightButton)
	   
	   createConstraintButton(upButton, in: gameFieldView, xOffset: secondLocationOfControlArrowsOnTheScreen, yOffset: -(locationOfControlArrowsOnTheScreen))
	   createConstraintButton(downButton, in: gameFieldView, xOffset: secondLocationOfControlArrowsOnTheScreen, yOffset: locationOfControlArrowsOnTheScreen)
	   createConstraintButton(leftButton, in: gameFieldView, xOffset: -(locationOfControlArrowsOnTheScreen), yOffset: secondLocationOfControlArrowsOnTheScreen)
	   createConstraintButton(rightButton, in: gameFieldView, xOffset: locationOfControlArrowsOnTheScreen, yOffset: secondLocationOfControlArrowsOnTheScreen)
    }
    
    //MARK: - Game Field functions
    func setupGameFieldConstraints(gameFieldView: UIView, in view: UIView) {
	   NSLayoutConstraint.activate([
		  gameFieldView.topAnchor.constraint(equalTo: view.topAnchor),
		  gameFieldView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
		  gameFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
		  gameFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
	   ])
    }
    
    //MARK: - players functions
    func createCharacterImageView() -> UIImageView {
	   let characterImageView = UIImageView(image: UIImage(named: "characterImage"))
	   characterImageView.contentMode = .scaleAspectFit
	   characterImageView.frame = CGRect(x: characterXandYView, y: characterXandYView, width: characterWidth, height: characterHeight)
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
	   let redViewHeight: CGFloat = redViewWidth
	   
	   UIView.animate(withDuration: 1.0, animations: {
		  self.redView.frame.origin.y = viewHeight
		  
	   }) { (finished) in
		  self.redView.frame.origin.y = -redViewHeight
	   }
    }
    
    //MARK: - all button functions
    func createConstraintButton(_ button: UIButton, in containerView: UIView, xOffset: CGFloat, yOffset: CGFloat) {
	   NSLayoutConstraint.activate([
		  button.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: xOffset),
		  button.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: yOffset)
	   ])
    }
    
    func createAndConfigureButton(systemName: String, action: Selector) -> UIButton {
	   let button = UIButton(type: .system)
	   button.setImage(UIImage(systemName: systemName), for: .normal)
	   button.tintColor = .black
	   button.addTarget(self, action: action, for: .touchUpInside)
	   button.translatesAutoresizingMaskIntoConstraints = false
	   return button
    }
    
    @objc func moveCharacterUp() {
	   let minY = gameFieldView.frame.minY
	   if characterImageView.frame.minY - movementStep >= minY {
		  characterImageView.center.y -= movementStep
	   }
    }
    
    @objc func moveCharacterDown() {
	   let maxY = gameFieldView.frame.maxY
	   if characterImageView.frame.maxY + movementStep <= maxY {
		  characterImageView.center.y += movementStep
	   }
    }
    
    @objc func moveCharacterLeft() {
	   let minX = gameFieldView.frame.minX
	   if characterImageView.frame.minX - movementStep >= minX {
		  characterImageView.center.x -= movementStep
	   }
	   characterImageView.transform = CGAffineTransform(scaleX: -1, y: 1)
	   isMovingLeft = true
    }
    
    @objc func moveCharacterRight() {
	   let maxX = gameFieldView.frame.maxX
	   if characterImageView.frame.maxX + movementStep <= maxX {
		  characterImageView.center.x += movementStep
	   }
	   
	   characterImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
	   isMovingLeft = true
	   
    }
    
}
