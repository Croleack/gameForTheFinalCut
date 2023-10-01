//
//  ViewController.swift
//  gameForTheFinalCut
//
//  Created by Enzhe Gaysina on 26.09.2023.
//

import UIKit

class ViewController: UIViewController {
    
    enum ButtonType: String {
	   
	   case play = "Играть"
	   case highScore = "Таблица рекордов"
	   case settings = "Настройки"
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
	   super.viewDidLoad()
	   
	   let backgroundImage = UIImageView(image: UIImage(named: "backgroundImage"))
	   backgroundImage.contentMode = .scaleAspectFill
	   backgroundImage.frame = view.bounds
	   view.addSubview(backgroundImage)
	   
	   let buttonTypes: [ButtonType] = [.play, .highScore, .settings]
	   
	   // Создаем кнопки из массива
	   let buttons = buttonTypes.map { createButton(withTitle: $0.rawValue, backgroundColor: UIColor(named: "mainColor") ?? .gray) }
	   
	   buttons.forEach { view.addSubview($0) }
	   
	   setupConstraints(for: buttons)
	   
	   buttons[0].addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
	   buttons[0].tag = 0
	   
	   buttons[1].addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
	   buttons[1].tag = 1
	   
	   buttons[2].addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
	   buttons[2].tag = 2
    }
    
    
    //MARK: - all button functions
    func createButton(withTitle title: String, backgroundColor: UIColor) -> UIButton {
	   let button = UIButton()
	   button.translatesAutoresizingMaskIntoConstraints = false
	   button.setTitle(title, for: .normal)
	   button.setTitleColor(.white, for: .normal)
	   button.backgroundColor = backgroundColor
	   button.layer.cornerRadius = Constants.cornerRadiusButton
	   return button
    }
    
    
    func setupConstraints(for buttons: [UIButton]) {
	   for (index, button) in buttons.enumerated() {
		  NSLayoutConstraint.activate([
			 button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			 button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Constants.buttonWidthMultiplier),
			 button.heightAnchor.constraint(equalToConstant: Constants.buttonHeight)
		  ])
		  
		  if index == 0 {
			 button.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.initialTopMargin).isActive = true
		  } else {
			 button.topAnchor.constraint(equalTo: buttons[index - 1].bottomAnchor, constant: Constants.verticalSpacing).isActive = true
		  }
	   }
    }
    
    
    @objc func playButtonTapped(sender: UIButton) {
	   switch sender.tag {
	   case 0:
		  let playViewController = PlayViewController()
		  navigationController?.pushViewController(playViewController, animated: true)
	   case 1:
		  let highScoreViewController = HighScoreViewController()
		  navigationController?.pushViewController(highScoreViewController, animated: true)
	   case 2:
		  let settingsViewController = SettingsViewController()
		  navigationController?.pushViewController(settingsViewController, animated: true)
	   default:
		  break
	   }
    }
}

// MARK: - Constants

fileprivate extension ViewController {
    
    enum Constants {
	   static let cornerRadiusButton: CGFloat = 10.0
	   static let buttonWidthMultiplier: CGFloat = 0.5
	   static let buttonHeight: CGFloat = 50
	   static let verticalSpacing: CGFloat = 40
	   static let initialTopMargin: CGFloat = 200
    }
}

