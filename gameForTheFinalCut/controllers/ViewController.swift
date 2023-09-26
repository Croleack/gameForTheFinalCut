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
    
    override func viewDidLoad() {
	   super.viewDidLoad()
	   
	   let backgroundImage = UIImageView(image: UIImage(named: "backgroundImage"))
	   backgroundImage.contentMode = .scaleAspectFill
	   backgroundImage.frame = view.bounds
	   view.addSubview(backgroundImage)
	   
	   let buttonTypes: [ButtonType] = [.play, .highScore, .settings]
	   
	   // Создаем кнопки из массива
	   let buttons = buttonTypes.map { createButton(withTitle: $0.rawValue, backgroundColor: UIColor(named: "mainColor") ?? .gray) }
	   
	   // Добавляем кнопки на экран
	   buttons.forEach { view.addSubview($0) }
	   
	   // Устанавливаем констрейнты для кнопок
	   setupConstraints(for: buttons)
	   
	   buttons[0].addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
	   buttons[0].tag = 0
	   
	   buttons[1].addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
	   buttons[1].tag = 1
	   
	   buttons[2].addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
	   buttons[2].tag = 2
    }
    
    

    func createButton(withTitle title: String, backgroundColor: UIColor) -> UIButton {
	   let button = UIButton()
	   button.translatesAutoresizingMaskIntoConstraints = false
	   button.setTitle(title, for: .normal)
	   button.setTitleColor(.white, for: .normal)
	   button.backgroundColor = backgroundColor
	   button.layer.cornerRadius = 10
	   return button
    }
    

    func setupConstraints(for buttons: [UIButton]) {
	   for (index, button) in buttons.enumerated() {
		  NSLayoutConstraint.activate([
			 button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			 button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
			 button.heightAnchor.constraint(equalToConstant: 50)
		  ])
		  
		  if index == 0 {
			 // Если это первая кнопка, то устанавливаем отступ от верхнего края
			 button.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
		  } else {
			 // Для остальных кнопок устанавливаем отступ от предыдущей кнопки
			 button.topAnchor.constraint(equalTo: buttons[index - 1].bottomAnchor, constant: 40).isActive = true
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

