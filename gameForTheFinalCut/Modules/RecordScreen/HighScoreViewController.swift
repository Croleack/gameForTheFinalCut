//
//  HighScoreViewController.swift
//  gameForTheFinalCut
//
//  Created by Enzhe Gaysina on 26.09.2023.
//

import UIKit

final class HighScoreViewController: UIViewController {
    //MARK: - Variables
    lazy var tableView: UITableView = {
	   let table = UITableView()
	   table.translatesAutoresizingMaskIntoConstraints = false
	   table.dataSource = self
	   table.delegate = self
	   table.register(UITableViewCell.self, forCellReuseIdentifier: "Identifier")
	   table.separatorStyle = .none
	   
	   return table
    }()
    
    var playerName: String?
    var playerTime: String?
    //вот
    var selectedImage: UIImage?
    
    var stopWatchView = StopWatchView()
    var highScores: [HighScore] = []
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
	   super.viewDidLoad()
	   
	   setupUI()
	   setupRecords()
    }
    
    //MARK: - functios
    
    private func setupRecords() {
	   if let savedPlayerName = UserDefaults.standard.string(forKey: "playerName") {
		  playerName = savedPlayerName
	   }
	   if let savedPlayerTime = UserDefaults.standard.string(forKey: "playerTime") {
		  playerTime = savedPlayerTime
	   }
	   if let savedHighScoresData = UserDefaults.standard.data(forKey: "highScores") {
		  if let savedHighScores = try? JSONDecoder().decode([HighScore].self, from: savedHighScoresData) {
			 highScores = savedHighScores
		  }
	   }
	   if let playerName = playerName, let playerTime = playerTime {
		  let newHighScore = HighScore(playerName: playerName, playerTime: playerTime)
		  highScores.append(newHighScore)
		  saveHighScores()
	   }
    }
    
    private func setupUI() {
	   
	   view.backgroundColor = UIColor(named: "secondaryColor") ?? .gray
	   
	   if let savedPlayerName = UserDefaults.standard.string(forKey: "playerName"),
		 let savedPlayerTime = UserDefaults.standard.string(forKey: "playerTime") {
		  let newHighScore = HighScore(playerName: savedPlayerName, playerTime: savedPlayerTime)
		  highScores.append(newHighScore)
	   }
	   
	   view.addSubview(tableView)
	   tableViewConstraint()
    }
    
    private func saveHighScores() {
	   if let highScoresData = try? JSONEncoder().encode(highScores) {
		  UserDefaults.standard.set(highScoresData, forKey: "highScores")
	   }
    }
    
    private func tableViewConstraint() {
	   NSLayoutConstraint.activate([
		  tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
		  tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
		  tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
		  tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
	   ])
    }
    
    func loadPlayerAvatar(forPlayerName playerName: String) -> UIImage? {
	   if let url = FileManager.default.urls(
		  for: .documentDirectory,
		  in: .userDomainMask)
		  .first?
		  .appendingPathComponent(playerName + ".png"),
		 let data = try? Data(contentsOf: url) {
		  return UIImage(data: data)
	   }
	   return nil
    }
}

//MARK: - UITableViewDelegate
extension HighScoreViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
	   return highScores.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
	   let cell = tableView.dequeueReusableCell(withIdentifier: "Identifier", for: indexPath)
	   var listConfiguration = cell.defaultContentConfiguration()
	   var backgroundConfiguration = cell.defaultBackgroundConfiguration()
	   
	   if indexPath.row == 0 {
		  let playerNameText = playerName ?? "Player"
		  let playerTimeText = playerTime ?? "00"
		  listConfiguration.text = "Игрок: \(playerNameText) Время: \(playerTimeText)"
		  //здесь
		  if let image = selectedImage {
			 listConfiguration.image = image
		  }
	   } else {
		  let highScore = highScores[indexPath.row - 1]
		  listConfiguration.text = "Игрок: \(highScore.playerName) Время: \(highScore.playerTime)"
		  //здесь
		  if let playerAvatar = loadPlayerAvatar(forPlayerName: highScore.playerName) {
			 listConfiguration.image = playerAvatar
		  }
	   }
	   
	   backgroundConfiguration.backgroundColor = UIColor(named: "secondaryColor")
	   backgroundConfiguration.cornerRadius = Constants.cellCornerRadius
	   backgroundConfiguration.backgroundInsets = .init(
		  top: Constants.cellCornerRadius,
		  leading: Constants.cellCornerRadius,
		  bottom: Constants.cellCornerRadius,
		  trailing: Constants.cellCornerRadius
	   )
	   
	   cell.contentConfiguration = listConfiguration
	   cell.backgroundConfiguration = backgroundConfiguration
	   
	   return cell
    }
}

// MARK: - Constants

fileprivate extension HighScoreViewController {
    enum Constants {
	   static let cellCornerRadius = 10.0
	   static let cellBackgroundInsets: CGFloat = 5.0
    }
}
