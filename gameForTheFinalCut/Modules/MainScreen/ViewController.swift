//
//  ViewController.swift
//  gameForTheFinalCut
//
//  Created by Enzhe Gaysina on 12.10.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var selectedItems: [SectionType: SectionStruct] = [:]
    
    enum ButtonType: String {
	   case play = "Играть"
	   case highScore = "Таблица рекордов"
	   case settings = "Настройки"
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
	   super.viewDidLoad()
	   
	   setupView()
    }
    
    // MARK: - Setup View
    private func setupView() {
	   let backgroundImage = UIImageView(image: UIImage(named: "backgroundImage"))
	   backgroundImage.contentMode = .scaleAspectFill
	   backgroundImage.frame = view.bounds
	   view.addSubview(backgroundImage)
	   
	   let buttonTypes: [ButtonType] = [.play, .highScore, .settings]
	   
	   let buttons = buttonTypes.map {
		  createButton(withTitle: $0.rawValue, backgroundColor: UIColor(named: "mainColor") ?? .gray)
	   }
	   
	   let stackView = UIStackView(arrangedSubviews: buttons)
	   stackView.axis = .vertical
	   stackView.alignment = .center
	   stackView.spacing = Constants.verticalSpacing
	   stackView.translatesAutoresizingMaskIntoConstraints = false
	   
	   view.addSubview(stackView)
	   
	   NSLayoutConstraint.activate([
		  stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
		  stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
		  stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Constants.buttonWidthMultiplier)
	   ])
	   
	   buttons[0].addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
	   buttons[0].tag = 0
	   
	   buttons[1].addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
	   buttons[1].tag = 1
	   
	   buttons[2].addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
	   buttons[2].tag = 2
    }
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
	   super.viewWillAppear(animated)
	   
	   navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    //MARK: - all button functions
    func createButton(withTitle title: String, backgroundColor: UIColor) -> UIButton {
	   var configuration = UIButton.Configuration.plain()
	   configuration.title = title
	   configuration.baseBackgroundColor = backgroundColor
	   configuration.cornerStyle = .large
	   let button = UIButton(configuration: configuration)
	   
	   button.translatesAutoresizingMaskIntoConstraints = false
	   button.setTitleColor(.white, for: .normal)
	   
	   return button
    }
    
    @objc
    func playButtonTapped(sender: UIButton) {
	   switch sender.tag {
	   case 0:
		  let playViewController = PlayViewController()
		  playViewController.setDataStorage(items: selectedItems)
		  navigationController?.pushViewController(playViewController, animated: true)
	   case 1:
		  let highScoreViewController = HighScoreViewController()
		  navigationController?.pushViewController(highScoreViewController, animated: true)
	   case 2:
		  let settingsViewController = SettingsViewController()
		  settingsViewController.delegate = self
		  navigationController?.pushViewController(settingsViewController, animated: true)
	   default:
		  break
	   }
    }
}


extension ViewController: SettingsDelegate {
    func settingsDidUpdate(_ selectedItems: [SectionType: SectionStruct], selectedCharacter: Int?) {
	   self.selectedItems = selectedItems
	   print("\(selectedCharacter!)")
	   
    }
}
// MARK: - Constants

fileprivate extension ViewController {
    
    enum Constants {
	   static let cornerRadiusButton: CGFloat = 8.0
	   static let buttonWidthMultiplier: CGFloat = 0.5
	   static let buttonHeight: CGFloat = 50
	   static let verticalSpacing: CGFloat = 40
	   static let initialTopMargin: CGFloat = 200
    }
}
