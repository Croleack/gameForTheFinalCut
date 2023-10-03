//
//  CustomTableView.swift
//  gameForTheFinalCut
//
//  Created by Enzhe Gaysina on 03.10.2023.
//

import UIKit

class CustomTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
	   super.init(frame: frame, style: style)
	   
	   configure()
    }
    
    required init?(coder: NSCoder) {
	   fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
	   register(UITableViewCell.self, forCellReuseIdentifier: "firstCell")
	   register(UITableViewCell.self, forCellReuseIdentifier: "secondCell")
	   
	   //назначаем делегата
	   dataSource = self
    }
}

//MARK: - UITableViewDataSource

extension CustomTableView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
	   4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
	   switch section {
	   case 0, 1:
		  return 3
	   default:
		  return 1
	   }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
	   let cell: UITableViewCell
	   if indexPath.section == 0 {
		  cell = tableView.dequeueReusableCell(withIdentifier: "firstCell", for: indexPath)
		  cell.textLabel?.text = "First"
	   } else {
		  cell = tableView.dequeueReusableCell(withIdentifier: "secondCell", for: indexPath)
		  cell.textLabel?.text = "Second"
	   }
	   return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
	   switch section {
	   case 0:
		  return "Выбор препятствия"
	   case 1:
		  return "Скорость игры"
	   case 2:
		  return "Имя"
	   case 3:
		  return "Фотография"
	   default:
		  return nil
	   }
    }
}
