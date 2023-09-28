//
//  PlayViewController.swift
//  gameForTheFinalCut
//
//  Created by Enzhe Gaysina on 26.09.2023.
//

import UIKit

class PlayViewController: UIViewController {
    
    
    let redViewWidth: CGFloat = 50.0
    let redViewHeight: CGFloat = 50.0
    
    //игровое поле
    let gameFieldView: UIView = {
	   let view = UIView()
	   view.translatesAutoresizingMaskIntoConstraints = false
	   return view
    }()
    
    var characterImageView: UIImageView!
    
    // Создаем переменные для отслеживания положения персонажа
    var initialTouchPoint: CGPoint = .zero
    var characterWidth: CGFloat = 100
    var characterHeight: CGFloat = 100
    var isMovingLeft = false
    
    
    var redView: UIView!
    
    var movementStep: CGFloat = 50.0
    
    override func viewDidLoad() {
	   super.viewDidLoad()
	   
//	   view.backgroundColor = UIColor(named: "secondaryColor") ?? .gray
	   
	   view.addSubview(gameFieldView)
	   //это для проверки, не забудь удалитьб
	   gameFieldView.backgroundColor = .blue
	   
	   createRedView(width: redViewWidth, height: redViewHeight) // Исправлен вызов функции
	   
	   Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(animateGreenView), userInfo: nil, repeats: true)
	   
	   setupGameFieldConstraints(gameFieldView: gameFieldView, in: view)
	   
	   self.characterImageView = createCharacterImageView()
	   gameFieldView.addSubview(self.characterImageView)
	   
	   let upButton = createAndConfigureButton(systemName: "arrow.up", action: #selector(moveCharacterUp))
	   let downButton = createAndConfigureButton(systemName: "arrow.down", action: #selector(moveCharacterDown))
	   let leftButton = createAndConfigureButton(systemName: "arrow.left", action: #selector(moveCharacterLeft))
	   let rightButton = createAndConfigureButton(systemName: "arrow.right", action: #selector(moveCharacterRight))
	   
	   gameFieldView.addSubview(upButton)
	   gameFieldView.addSubview(downButton)
	   gameFieldView.addSubview(leftButton)
	   gameFieldView.addSubview(rightButton)
	   
	   NSLayoutConstraint.activate([
		  upButton.centerXAnchor.constraint(equalTo: gameFieldView.centerXAnchor),
		  upButton.centerYAnchor.constraint(equalTo: gameFieldView.centerYAnchor, constant: -50),
		  
		  downButton.centerXAnchor.constraint(equalTo: gameFieldView.centerXAnchor),
		  downButton.centerYAnchor.constraint(equalTo: gameFieldView.centerYAnchor, constant: 50),
		  
		  leftButton.centerXAnchor.constraint(equalTo: gameFieldView.centerXAnchor, constant: -50),
		  leftButton.centerYAnchor.constraint(equalTo: gameFieldView.centerYAnchor),
		  
		  rightButton.centerXAnchor.constraint(equalTo: gameFieldView.centerXAnchor, constant: 50),
		  rightButton.centerYAnchor.constraint(equalTo: gameFieldView.centerYAnchor)
	   ])
    }
    
    
    
    func createRedView(width: CGFloat, height: CGFloat) {
	   let viewWidth = view.frame.size.width
	   redView = UIView(frame: CGRect(x: viewWidth / 2 - width / 2, y: -height, width: width, height: height))
	   redView.backgroundColor = UIColor.red
	   view.addSubview(redView)
    }

    func setupGameFieldConstraints(gameFieldView: UIView, in view: UIView) {
	   NSLayoutConstraint.activate([
		  gameFieldView.topAnchor.constraint(equalTo: view.topAnchor),
		  gameFieldView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
		  gameFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
		  gameFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
	   ])
    }
    
    func createCharacterImageView() -> UIImageView {
	   let characterImageView = UIImageView(image: UIImage(named: "characterImage"))
	   characterImageView.contentMode = .scaleAspectFit
	   characterImageView.frame = CGRect(x: 300, y: 300, width: characterWidth, height: characterHeight)
	   return characterImageView
    }
    
    
    @objc func animateGreenView() {
	   let viewHeight = view.frame.size.height
	   let greenViewHeight: CGFloat = 50.0
	   
	   UIView.animate(withDuration: 1.0, animations: {
		  self.redView.frame.origin.y = viewHeight
		  
		  }) { (finished) in
		  self.redView.frame.origin.y = -greenViewHeight
	   }
    }
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
	   let translation = gesture.translation(in: gameFieldView)
	   
	   switch gesture.state {
	   case .began:
		  initialTouchPoint = characterImageView.center
	   case .changed:
		  // Определите направление движения
		  if translation.x < 0 {
			 // Персонаж двигается влево
			 if !isMovingLeft {
				// Отразите изображение по горизонтали (симметрично)
				characterImageView.transform = characterImageView.transform.scaledBy(x: -1, y: 1)
				isMovingLeft = true
			 }
		  } else {
			 // Персонаж двигается вправо
			 if isMovingLeft {
				// Верните изображение в исходное состояние
				characterImageView.transform = .identity
				isMovingLeft = false
			 }
		  }
		  
		  // Вычисляем новую позицию персонажа
		  let newCenterX = initialTouchPoint.x + translation.x
		  let newCenterY = initialTouchPoint.y + translation.y
		  
		  // Ограничиваем перемещение персонажа в пределах игрового поля, учитывая размеры персонажа
		  let maxX = gameFieldView.bounds.width - characterImageView.bounds.width / 2
		  let maxY = gameFieldView.bounds.height - characterImageView.bounds.height / 2
		  let minX = characterImageView.bounds.width / 2
		  let minY = characterImageView.bounds.height / 2
		  
		  // Ограничиваем перемещение персонажа в пределах игрового поля
		  characterImageView.center = CGPoint(x: max(minX, min(maxX, newCenterX)),
									   y: max(minY, min(maxY, newCenterY)))
		  
	   default:
		  break
	   }
    }
    
    func createAndConfigureButton(systemName: String, action: Selector) -> UIButton {
	   let button = UIButton(type: .system)
	   button.setImage(UIImage(systemName: systemName), for: .normal)
	   button.tintColor = .systemGreen
	   button.addTarget(self, action: action, for: .touchUpInside)
	   button.translatesAutoresizingMaskIntoConstraints = false
	   return button
    }
    
    @objc func moveCharacterUp() {
	   // Измените позицию персонажа, чтобы он двигался вверх
	   characterImageView.center.y -= movementStep
    }
    
    @objc func moveCharacterDown() {
	   // Измените позицию персонажа, чтобы он двигался вниз
	   characterImageView.center.y += movementStep
    }
    
    @objc func moveCharacterLeft() {
	   // Измените позицию персонажа, чтобы он двигался влево
	   characterImageView.center.x -= movementStep
    }
    
    @objc func moveCharacterRight() {
	   // Измените позицию персонажа, чтобы он двигался вправо
	   characterImageView.center.x += movementStep
    }
}
