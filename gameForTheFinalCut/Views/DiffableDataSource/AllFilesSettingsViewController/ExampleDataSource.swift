//
//  ExampleDataSource.swift
//  gameForTheFinalCut
//
//  Created by Enzhe Gaysina on 04.10.2023.
//

import UIKit

class ExampleDataSource: UITableViewDiffableDataSource<ExampleSection, ExampleRow> {
    
    init(tableView: UITableView) {
	   super.init(tableView: tableView) { tableView, indexPath, itemIdentifier in
		  switch itemIdentifier {
		  case .obstacles(let model):
			 let cell = tableView.dequeueReusableCell(withIdentifier: ObstaclesTableViewCell.cellID, for: indexPath) as! ObstaclesTableViewCell
			 cell.configure(model)
			 return cell
		  case .gameSpeed(let model):
			 let cell = tableView.dequeueReusableCell(withIdentifier: GameSpeedTableViewCell.cellID, for: indexPath) as! GameSpeedTableViewCell
			 cell.configure(with: model)
			 return cell
		  case .name(let model):
			 let cell = tableView.dequeueReusableCell(withIdentifier: NameModelTableViewCell.cellID, for: indexPath) as! NameModelTableViewCell
			 cell.configure(with: model)
			 return cell
		  case .photo(let model):
			 let cell = tableView.dequeueReusableCell(withIdentifier: PhotoModelTableViewCell.cellID, for: indexPath) as! PhotoModelTableViewCell
			 cell.configure()
			 cell.uploadAction = {
				//временный код
				print("hi")
			 }
			 return cell
		  }
	   }
    }
}
