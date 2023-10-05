//
//  TableViewModels.swift
//  gameForTheFinalCut
//
//  Created by Enzhe Gaysina on 04.10.2023.
//

import Foundation

enum ExampleSection: CaseIterable {
    case obstacles
    case gameSpeed
    case name
    case photo
}

enum ExampleRow: Hashable {
    case obstacles(ObstaclesModel)
    case gameSpeed(GameSpeedModel)
    case name(NameModel)
    case photo(PhotoModel)
}

struct ObstaclesModel: Hashable {
    let name: String
    let describtion: String
    var isSelected: Bool = false
    
    static var betaObstacles: Self {
	   return Self(name: "Девчонка", describtion: "Отважная амазонка")
    }
    static var betaTwoObstacles: Self {
	   return Self(name: "Динозавр", describtion: "Ловкий стендапер")
    }
}

struct GameSpeedModel: Hashable {
    let name: String
    var isSelected: Bool = false
    
    static var first: Self {
	   return Self(name: "first speed")
    }
    static var second: Self {
	   return Self(name: "second speed")
    }
    static var third: Self {
	   return Self(name: "third speed")
    }
}

struct NameModel: Hashable {
    let name: String
    var userInput: String = ""
    
    static var beta: Self {
	   return Self(name: "Введите своем имя")
    }
}

struct PhotoModel: Hashable {
    let image: String
    var isSelected: Bool = false
    
    static var beta: Self {
	   return Self(image: "characterImage")
    }
}
