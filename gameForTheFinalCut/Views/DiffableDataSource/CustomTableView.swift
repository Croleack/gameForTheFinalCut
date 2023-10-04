//
//  CustomTableView.swift
//  gameForTheFinalCut
//
//  Created by Enzhe Gaysina on 03.10.2023.
//

import UIKit

class CustomTableView: UITableView {
    
    private var obstacles: [ExampleRow] = [.obstacles(ObstaclesModel.betaObstacles),
								   .obstacles(ObstaclesModel.betaTwoObstacles)]
    private var gameSpeed: [ExampleRow] = []
    private var name: [ExampleRow] = []
    private var photo: [ExampleRow] = []
    
    private lazy var exampleDataSource = ExampleDataSource(tableView: self)
    
    override init(frame: CGRect, style: UITableView.Style) {
	   super.init(frame: frame, style: style)
	   
	   registerCell()
	   self.dataSource = exampleDataSource
	   applySnapshot()

    }
    
    required init?(coder: NSCoder) {
	   fatalError("init(coder:) has not been implemented")
    }
    
    private func registerCell() {
	   register(ObstaclesTableViewCell.self, forCellReuseIdentifier: ObstaclesTableViewCell.cellID)
	   register(GameSpeedTableViewCell.self, forCellReuseIdentifier: GameSpeedTableViewCell.cellID)
	   register(NameModelTableViewCell.self, forCellReuseIdentifier: NameModelTableViewCell.cellID)
	   register(PhotoModelTableViewCell.self, forCellReuseIdentifier: PhotoModelTableViewCell.cellID)
    }
    
    func applySnapshot() {
	   var snapshot = NSDiffableDataSourceSnapshot<ExampleSection, ExampleRow>()
	   snapshot.appendSections([.obstacles, .gameSpeed,.name,.photo])
	   snapshot.appendItems(obstacles, toSection: .obstacles)
	   snapshot.appendItems(gameSpeed, toSection: .gameSpeed)
	   snapshot.appendItems(name, toSection: .name)
	   snapshot.appendItems(photo, toSection: .photo)
	   
	   exampleDataSource.apply(snapshot, animatingDifferences: true)
    }
}
