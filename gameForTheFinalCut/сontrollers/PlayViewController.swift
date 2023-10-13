//
//  PlayViewController.swift
//  gameForTheFinalCut
//
//  Created by Enzhe Gaysina on 12.10.2023.
//

import UIKit

class PlayViewController: UIViewController {
    
    //MARK: - Variables
    let gameFieldView: UIView = {
	   let view = UIView()
	   view.translatesAutoresizingMaskIntoConstraints = false
	   return view
    }()
    
    var redView: UIView!
    var characterImageView: UIImageView!
    var gestureAreaView: GestureAreaView!
    var stopwatchView: StopwatchView!
    
    var isGameOver = false
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
	   super.viewDidLoad()
	   setupView()
    }
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
	   super.viewWillAppear(animated)
	   navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    // MARK: - Setup methods
    
    private func setupView() {
	   
	   view.backgroundColor = UIColor(named: "secondaryColor") ?? .gray
	   
	   view.addSubview(gameFieldView)
	   setupGameFieldConstraints(gameFieldView: gameFieldView, in: view)
	   
	   createRedView(width: Constants.redViewWidth, height: Constants.redViewHeight)
	   createDisplayLink()
	   Timer.scheduledTimer(timeInterval: Constants.timeIntervalRedView, target: self, selector: #selector(
		  animateRedView), userInfo: nil, repeats: true)
	   
	   self.characterImageView = createCharacterImageView()
	   gameFieldView.addSubview(self.characterImageView!)
	   

	   setupStopwatchView()
	  
	   gestureAreaView = GestureAreaView()
	   gestureAreaView?.translatesAutoresizingMaskIntoConstraints = false
	   view.addSubview(gestureAreaView!)
	   
	   NSLayoutConstraint.activate([
		  gestureAreaView?.topAnchor.constraint(equalTo: view.topAnchor),
		  gestureAreaView?.leadingAnchor.constraint(equalTo: view.leadingAnchor),
		  gestureAreaView?.trailingAnchor.constraint(equalTo: view.trailingAnchor),
		  gestureAreaView?.bottomAnchor.constraint(equalTo: view.bottomAnchor)
	   ].compactMap { $0 })
	   
	   gestureAreaView?.topAreaTapHandler = { [weak self] in
		  self?.moveCharacterUp()
	   }
	   
	   gestureAreaView?.leftAreaTapHandler = { [weak self] in
		  self?.moveCharacterLeft()
	   }
	   
	   gestureAreaView?.rightAreaTapHandler = { [weak self] in
		  self?.moveCharacterRight()
	   }
	   
	   gestureAreaView?.bottomAreaTapHandler = { [weak self] in
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
	   characterImageView.frame = CGRect(
		  x: Constants.characterXandYView,
		  y: Constants.characterXandYView,
		  width: Constants.characterWidth,
		  height: Constants.characterHeight
	   )
	   return characterImageView
    }
    
    //MARK: - obstacle functions
    
    private func createRedView(width: CGFloat, height: CGFloat) {
	   let viewWidth = view.frame.size.width
	   redView = UIView(frame: CGRect(x: viewWidth / 2 - width / 2, y: -height, width: width, height: height))
	   redView.backgroundColor = UIColor.red
	   view.addSubview(redView)
    }
    
    @objc
    private func animateRedView() {
	   
	   guard !isGameOver else { return }
	   
	   let viewHeight = view.frame.size.height
	   let redViewHeight: CGFloat = Constants.redViewWidth
	   
	   UIView.animate(withDuration: Constants.timeIntervalRedView, animations: {
		  self.redView.frame.origin.y = viewHeight
	   }) { (finished) in
		  self.redView.frame.origin.y = -redViewHeight
		  if !self.isGameOver {
		  }
	   }
    }
    
    private func createDisplayLink() {
	   let displayLink = CADisplayLink(target: self, selector: #selector(step))
	   displayLink.add(to: .current, forMode: .default)
    }
    
    @objc
    private func step(displayLink:CADisplayLink) {
	   if isGameOver {
		  return
	   } else {
		  if detectCollision(view: redView)  {
			 handleCollision()
		  }
	   }
    }
    
    private func detectCollision(view: UIView) -> Bool {
	   if !isGameOver, let squareFrame = view.layer.presentation()?.frame, let characterFrame = characterImageView.layer.presentation()?.frame {
		  return squareFrame.intersects(characterFrame)
	   }
	   return false
    }
    
    private func handleCollision() {
	   isGameOver = true
	   redView.layer.removeAllAnimations()
	   stopwatchView.stop()
	   gestureAreaView?.isUserInteractionEnabled = false
	   
	   let alertController = UIAlertController(title: "Игра окончена,\n \(stopwatchView.getTimeString())", message: nil, preferredStyle: .alert)
	   alertController.addAction(UIAlertAction(title: "Начать заново", style: .default, handler: { [weak self] _ in
//здесь надо придумать логику перезапуска
		  self?.isGameOver = false

		  // Закрытие алертКонтроллера
		  self?.dismiss(animated: true, completion: nil)
	   }))
	   alertController.addAction(UIAlertAction(title: "Посмотреть рекорды", style: .default, handler: { [weak self] _ in
		  let highScoresViewController = HighScoreViewController()
		  self?.navigationController?.pushViewController(highScoresViewController, animated: true)
	   }))
	   present(alertController, animated: true, completion: nil)
    }
    
    //MARK: - all button functions
    
    @objc
    private func moveCharacterUp() {
	   let minY = gameFieldView.frame.minY
	   if characterImageView.frame.minY - Constants.movementStep >= minY {
		  characterImageView.center.y -= Constants.movementStep
	   }
    }
    
    @objc
    private func moveCharacterDown() {
	   let maxY = gameFieldView.frame.maxY
	   if characterImageView.frame.maxY + Constants.movementStep <= maxY {
		  characterImageView.center.y += Constants.movementStep
	   }
    }
    
    @objc
    private func moveCharacterLeft() {
	   let minX = gameFieldView.frame.minX
	   if characterImageView.frame.minX - Constants.movementStep >= minX {
		  characterImageView.center.x -= Constants.movementStep
	   }
	   characterImageView.transform = CGAffineTransform(scaleX: -1, y: 1)
    }

    @objc
    private func moveCharacterRight() {
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
	   static let characterWidth: CGFloat = 70
	   static let characterHeight: CGFloat = 70
	   static let characterXandYView: CGFloat = 300
	   static let movementStep: CGFloat = 50.0
	   static let timeIntervalRedView = 1.5
	   static let constraintsTopAnchorStopwatchView: CGFloat = -20.0
	   static let constraintsTrailingAnchorStopwatchView: CGFloat = -10.0
    }
}
