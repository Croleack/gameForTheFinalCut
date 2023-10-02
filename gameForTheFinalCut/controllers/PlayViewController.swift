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
    
    var stopwatchView: StopwatchView!
    
    
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
	   
	   setupStopwatchView()
	   
	   
	   NSLayoutConstraint.activate([
		  gestureAreaView.topAnchor.constraint(equalTo: view.topAnchor),
		  gestureAreaView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
		  gestureAreaView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
		  gestureAreaView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
	   ])
	   
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
    private func setupGameFieldConstraints(gameFieldView: UIView, in view: UIView) {
	   NSLayoutConstraint.activate([
		  gameFieldView.topAnchor.constraint(equalTo: view.topAnchor),
		  gameFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
		  gameFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
		  gameFieldView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
	   ])
    }
    
    //MARK: - players functions
    private func createCharacterImageView() -> UIImageView {
	   let characterImageView = UIImageView(image: UIImage(named: "characterImage"))
	   characterImageView.contentMode = .scaleAspectFit
	   characterImageView.frame = CGRect(x: Constants.characterXandYView, y: Constants.characterXandYView, width: Constants.characterWidth, height: Constants.characterHeight)
	   return characterImageView
    }
    
    //MARK: - obstacle functions
    
    private func createRedView(width: CGFloat, height: CGFloat) {
	   let viewWidth = view.frame.size.width
	   redView = UIView(frame: CGRect(x: viewWidth / 2 - width / 2, y: -height, width: width, height: height))
	   redView.backgroundColor = UIColor.red
	   view.addSubview(redView)
    }
    
    @objc private func animateRedView() {
	   let viewHeight = view.frame.size.height
	   let redViewHeight: CGFloat = Constants.redViewWidth
	   
	   UIView.animate(withDuration: 1.0, animations: {
		  self.redView.frame.origin.y = viewHeight
		  
	   }) { (finished) in
		  self.redView.frame.origin.y = -redViewHeight
	   }
    }
    
//MARK: - all button functions
    
    @objc private func moveCharacterUp() {
	   let minY = gameFieldView.frame.minY
	   if characterImageView.frame.minY - Constants.movementStep >= minY {
		  characterImageView.center.y -= Constants.movementStep
	   }
    }
    
    @objc private func moveCharacterDown() {
	   let maxY = gameFieldView.frame.maxY
	   if characterImageView.frame.maxY + Constants.movementStep <= maxY {
		  characterImageView.center.y += Constants.movementStep
	   }
    }
    
    @objc private func moveCharacterLeft() {
	   let minX = gameFieldView.frame.minX
	   if characterImageView.frame.minX - Constants.movementStep >= minX {
		  characterImageView.center.x -= Constants.movementStep
	   }
	   characterImageView.transform = CGAffineTransform(scaleX: -1, y: 1)
    }
    
    @objc private func moveCharacterRight() {
	   let maxX = gameFieldView.frame.maxX
	   if characterImageView.frame.maxX + Constants.movementStep <= maxX {
		  characterImageView.center.x += Constants.movementStep
	   }
	   
	   characterImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
	   
    }
    //MARK: - setupStopwatchView
    private func setupStopwatchView() {
	   stopwatchView = StopwatchView()
	   stopwatchView.translatesAutoresizingMaskIntoConstraints = false
	   view.addSubview(stopwatchView)
	   
	   NSLayoutConstraint.activate([
		  stopwatchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.constraintsTopAnchorStopwatchView),
		  stopwatchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.constraintsTrailingAnchorStopwatchView)
	   ])
    }
}
// MARK: - Constants

fileprivate extension PlayViewController {
    
    enum Constants {
	   static let redViewWidth: CGFloat = 70.0
	   static let redViewHeight: CGFloat = 70.0
	   static let characterWidth: CGFloat = 100
	   static let characterHeight: CGFloat = 100
	   static let characterXandYView: CGFloat = 300
	   static let movementStep: CGFloat = 50.0
	   static let timeIntervalRedView = 1.5
	   static let constraintsTopAnchorStopwatchView: CGFloat = -20.0
	   static let constraintsTrailingAnchorStopwatchView: CGFloat = -10.0
    }
}

