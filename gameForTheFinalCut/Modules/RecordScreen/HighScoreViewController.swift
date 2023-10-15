//
//  HighScoreViewController.swift
//  gameForTheFinalCut
//
//  Created by Enzhe Gaysina on 26.09.2023.
//

import UIKit

class HighScoreViewController: UIViewController {
    
    lazy var tableView: UITableView = {
	   
	   let table = UITableView()
	   table.translatesAutoresizingMaskIntoConstraints = false
	   table.dataSource = self
	   table.delegate = self
	   table.register(UITableViewCell.self, forCellReuseIdentifier: "Identifier")
	   table.separatorStyle = .none
	   
	   return table
    }()
    
    var dataSource: [String] = []
    var playerName: String?
    var playerTime: String?
    var stopWatchView = StopWatchView()
    var highScores: [(playerName: String, playerTime: String)] = []
    //MARK: - viewDidLoad
    override func viewDidLoad() {
	   super.viewDidLoad()
	   
	   setupUI()
	   
	   if let savedPlayerName = UserDefaults.standard.string(forKey: "playerName") {
		  playerName = savedPlayerName
	   }
	   if let savedPlayerTime = UserDefaults.standard.string(forKey: "playerTime") {
		  playerTime = savedPlayerTime
	   }
    }
    
    //MARK: - methods
    
    fileprivate func setupUI() {
	   view.backgroundColor = UIColor(named: "secondaryColor") ?? .gray
	   
	   dataSource = ["Player1", "Player2", "Player3", "Player4"]
	   
	   view.addSubview(tableView)
	   tableViewConstraint()
	   
	   
    }
    
    fileprivate func tableViewConstraint() {
	   NSLayoutConstraint.activate([
		  tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
		  tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
		  tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
		  tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
	   ])
    }
}

extension HighScoreViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
	   return dataSource.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
	   let cell = tableView.dequeueReusableCell(withIdentifier: "Identifier", for: indexPath)
	   var listConfiguration = cell.defaultContentConfiguration()
	   var backgroundConfiguration = cell.defaultBackgroundConfiguration()
	   
	   if indexPath.row == 0 {
		  let playerNameText = playerName ?? "Player"
		  let playerTimeText = playerTime ?? "00"
		  listConfiguration.text = "Игрок: \(playerNameText) Время: \(playerTimeText)"
	   } else {
		  let model = dataSource[indexPath.row - 1]
		  listConfiguration.text = model
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
