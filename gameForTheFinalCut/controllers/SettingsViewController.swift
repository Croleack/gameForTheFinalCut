//
//  SettingsViewController.swift
//  gameForTheFinalCut
//
//  Created by Enzhe Gaysina on 26.09.2023.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private let customTableView = CustomTableView()
    
    override func viewDidLoad() {
	   super.viewDidLoad()
	   
	   setupViews()
    }
    
    private func setupViews() {
	   view.backgroundColor = UIColor(named: "secondaryColor") ?? .gray
	   
	   customTableView.frame = view.frame
	   view.addSubview(customTableView)
    }
}
