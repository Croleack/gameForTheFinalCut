//
//  PlayViewController.swift
//  gameForTheFinalCut
//
//  Created by Enzhe Gaysina on 12.10.2023.
//

import UIKit

class PlayViewController: UIViewController {
    
    //MARK: - Variables
    let gameFieldView: GameFieldView = {
	   let view = GameFieldView()
	   view.translatesAutoresizingMaskIntoConstraints = false
	   return view
    }()
    let redView: RedView = {
	   let view = RedView()
	   return view
    }()
    
    var stopWatchView = StopWatchView()
    var timer: Timer?
   
    var isGameOver = false
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
	   super.viewDidLoad()
	   setupView()
    }
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
	   super.viewWillAppear(animated)
	   navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
											    style: .plain,
											    target: nil,
											    action: nil)
    }
    
    // MARK: - Setup methods
    
    private func setupView() {
	   
	   view.backgroundColor = UIColor(named: "secondaryColor") ?? .gray
	   
	   view.addSubview(gameFieldView)
	   gameFieldView.make()
	   
	   view.addSubview(redView)
	   redView.make()
	   
	   createDisplayLink()
	   startGame()
    }
    
    // MARK: - methods
    
    func startGame() {
	   timer = Timer.scheduledTimer(
		  timeInterval: Constants.timeIntervalRedView,
		  target: self,
		  selector: #selector(animateRedViewWithGameOverStatus),
		  userInfo: nil,
		  repeats: true
	   )

	   stopWatchView.startTimer()
    }
    
    @objc
    func animateRedViewWithGameOverStatus() {
	   redView.animateRedView(isGameOver)
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
	   if !isGameOver,
		 let squareFrame = view.layer.presentation()?.frame,
		 let characterFrame = gameFieldView.characterImageView.layer.presentation()?.frame
	   {
		  return squareFrame.intersects(characterFrame)
	   }
	   return false
    }
    
    private func handleCollision() {
	   isGameOver = true
	   timer?.invalidate()
	   stopWatchView.stop()
	   
	   let alertController = UIAlertController(
		  title: "Игра окончена,\n \(stopWatchView.getTimeString())",
		  message: nil, preferredStyle: .alert
	   )
	   alertController.addAction(
		  UIAlertAction(
			 title: "Начать заново",
			 style: .default,
			 handler: { [weak self] _ in
				self?.isGameOver = false
				self?.dismiss(animated: true, completion: nil)
				self?.startGame()
			 }
		  )
	   )
	   alertController.addAction(UIAlertAction(title: "Посмотреть рекорды",
									   style: .default,
									   handler: { [weak self] _ in
		  let highScoresViewController = HighScoreViewController()
		  self?.navigationController?.pushViewController(highScoresViewController, animated: true)
	   }))
	   present(alertController, animated: true, completion: nil)
    }
    
    //MARK: - setupStopwatchView
    
    private func setupStopwatchView() {
	   view.addSubview(stopWatchView)
	   
	   NSLayoutConstraint.activate([
		  stopWatchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.constraintsTopAnchorStopwatchView),
		  stopWatchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.constraintsTrailingAnchorStopwatchView)
	   ])
    }
}
// MARK: - Constants

fileprivate extension PlayViewController {
    
    enum Constants {
	   static let timeIntervalRedView = 1.5
	   static let constraintsTopAnchorStopwatchView: CGFloat = -20.0
	   static let constraintsTrailingAnchorStopwatchView: CGFloat = -10.0
    }
}
