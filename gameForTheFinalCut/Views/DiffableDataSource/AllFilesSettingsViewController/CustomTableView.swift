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
    //назначаем делегата
    private func setDelegate() {
	   delegate = self
    }
    
    func applySnapshot() {
	   var snapshot = NSDiffableDataSourceSnapshot<ExampleSection, ExampleRow>()
	   snapshot.appendSections([.obstacles, .gameSpeed, .name, .photo])
	   snapshot.appendItems(obstacles, toSection: .obstacles)
	   if !gameSpeed.isEmpty {
		  snapshot.appendItems(gameSpeed, toSection: .gameSpeed)
	   }
	   if !name.isEmpty {
		  snapshot.appendItems(name, toSection: .name)
	   }
	   if !photo.isEmpty {
		  snapshot.appendItems(photo, toSection: .photo)
	   }
	   
	   exampleDataSource.apply(snapshot, animatingDifferences: true)
    }
    
}

//MARK: - UITableViewDelegate

extension CustomTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
	   guard let item = exampleDataSource.itemIdentifier(for: indexPath) else { return }
	   
	   switch item {
	   case .obstacles(let model):
		  obstacles = obstacles.map {
			 if case .obstacles(let obstacleModel) = $0 {
				var mutableObstacle = obstacleModel
				mutableObstacle.isSelected = (obstacleModel == model)
				return .obstacles(mutableObstacle)
			 } else {
				return $0
			 }
		  }
		  if indexPath.row == 0 {
			 gameSpeed = [GameSpeedModel.first, GameSpeedModel.second, GameSpeedModel.third].map { .gameSpeed($0) }
		  }
	   case .gameSpeed(let model):
		  gameSpeed = gameSpeed.map {
			 if case .gameSpeed(let speedModel) = $0 {
				var mutableSpeed = speedModel
				mutableSpeed.isSelected = (speedModel == model)
				return .gameSpeed(mutableSpeed)
			 } else {
				return $0
			 }
		  }
		  name = [NameModel.beta].map { .name($0) }
	   case .name(let model):
		  name = name.map {
			 if case .name(let nameModel) = $0 {
				var mutableName = nameModel
				return .name(mutableName)
			 } else {
				return $0
			 }
		  }
		  photo = [PhotoModel.beta].map { .photo($0) }
	   case .photo(let model):
		  photo = photo.map {
			 if case .photo(let photoModel) = $0 {
				var mutablePhoto = photoModel
				mutablePhoto.isSelected = (photoModel == model)
				return .photo(mutablePhoto)
			 } else {
				return $0
			 }
		  }
	   }
	   
	   applySnapshot()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
	   switch indexPath.section {
	   case 0: return 60
	   case 1: return 40
	   case 2: return 50
	   default: return 60
	   }
    }
}

extension NameModel {
    var isSelected: Bool {
	   get { return !userInput.isEmpty }
	   set { userInput = newValue ? "Selected" : "" }
    }
}
