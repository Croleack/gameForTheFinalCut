//
//  PlayViewController.swift
//  gameForTheFinalCut
//
//  Created by Enzhe Gaysina on 12.10.2023.
//

import UIKit
import AVFoundation

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
    
    var audioPlayer = AVAudioPlayer()
    
    var redViews: [RedView] = []
    
    var stopWatchView = StopWatchView()
    var timer: Timer?
    var time: Double = 0
    var isGameOver = false {
	   didSet {
		  self.redViews = []
	   }
    }
    
   private var gameDifficulty: GameDifficulty = .easy
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
	   super.viewDidLoad()
	   setupView()
	   
	   NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
	   super.viewWillAppear(animated)
	   navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
											    style: .plain,
											    target: nil,
											    action: nil)
    }
    //MARK: - viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
	   super.viewWillDisappear(animated)
	   audioPlayer.stop()
    }
    //MARK: - functions
    
    private func setupView() {
	   view.backgroundColor = UIColor(named: "secondaryColor") ?? .gray
	   view.addSubview(gameFieldView)
	   gameFieldView.make()
	   createDisplayLink()
	   startGame()
    }
    
    private func startGame() {
	   timer = Timer.scheduledTimer(
		  timeInterval: Constants.timeIntervalRedView,
		  target: self,
		  selector: #selector(animateRedViewWithGameOverStatus),
		  userInfo: nil,
		  repeats: true
	   )
	   stopWatchView.startTimer()
	   startMusic()
    }
    
    private func startMusic() {
	   do {
		  if let url = Bundle.main.url(forResource: "music", withExtension: "mp3") {
			 audioPlayer = try AVAudioPlayer(contentsOf: url)
			 audioPlayer.prepareToPlay()
			 audioPlayer.play()
		  } else {
			 print("Audio file not found.")
		  }
	   } catch {
		  print("Error playing audio: \(error.localizedDescription)")
	   }
    }
    
    private func updateDifficulty(_ selectedDifficultyNumber: Int) {
	   if selectedDifficultyNumber == 0 {
		  gameDifficulty = .easy
	   } else if selectedDifficultyNumber == 1 {
		  gameDifficulty = .normal
	   } else if selectedDifficultyNumber == 2 {
		  gameDifficulty = .hard
	   }
    }
    
    @objc
    func animateRedViewWithGameOverStatus() {
	   
	   time += Constants.timeIntervalRedView
	   if time >= 3 {
		  let redView = RedView()
		  view.addSubview(redView)
		  redView.make(CGFloat.random(in: 0...view.frame.width))
		  redViews.append(redView)
	   }
	   
	   time += 1
	   redViews.enumerated().forEach { index, value in
		  DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) + 1) { [weak self] in
			 guard let self = self else { return }
			 value.animateRedView(self.isGameOver, self.gameDifficulty.speed)
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
		  redViews.forEach({ value in
			 if detectCollision(view: value)  {
				handleCollision()
			 }
		  })
	   }
    }
    
    private func detectCollision(view: UIView) -> Bool {
	   if !isGameOver,
		 let squareFrame = view.layer.presentation()?.frame,
		 let characterFrame = gameFieldView.characterImageView.layer.presentation()?.frame {
		  return squareFrame.intersects(characterFrame)
	   }
	   return false
    }
    
    private func handleCollision() {
	   isGameOver = true
	   timer?.invalidate()
	   stopWatchView.stop()
	   audioPlayer.stop()
	   
	   let playerTime = stopWatchView.getTimeString()
	   UserDefaults.standard.set(playerTime, forKey: "playerTime")
	   
	   let alertController = UIAlertController(
		  title: "Игра окончена,\n Время \(stopWatchView.getTimeString())",
		  message: nil, preferredStyle: .alert
		  
	   )
	   alertController.addAction(
		  UIAlertAction(
			 title: "Начать заново",
			 style: .default,
			 handler: { [weak self] _ in
				self?.isGameOver = false
//				self?.dismiss(animated: true, completion: nil)
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
		  stopWatchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
									  constant: Constants.constraintsTopAnchorStopwatchView),
		  stopWatchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
										  constant: Constants.constraintsTrailingAnchorStopwatchView)
	   ])
    }
    
    func setDataStorage(items:[SectionType: SectionStruct]) {
	   if let selectedCharacter = items[.character]?.selectedItem {
		  gameFieldView.updateImage(selectedCharacter)
		  
		  if let selectedDifficulty = items[.difficulty]?.selectedItem {
			 updateDifficulty(selectedDifficulty)
			 
			 if let selectedColor = items[.obstacleColor]?.selectedItem {
				redView.updateColor(selectedColor)
			 }
		  }
	   }
    }
}

// MARK: - Constants

fileprivate extension PlayViewController {
    
    enum Constants {
	   static var timeIntervalRedView = 1.5
	   static let constraintsTopAnchorStopwatchView: CGFloat = -20.0
	   static let constraintsTrailingAnchorStopwatchView: CGFloat = -10.0
    }
    
    enum GameDifficulty: Double {
	   case easy, normal, hard
	   
	   var speed: Double {
		  switch self {
		  case .easy:
			 return 3.6
		  case .normal:
			 return 2.4
		  case .hard:
			 return 1.2
		  }
	   }
    }
}
