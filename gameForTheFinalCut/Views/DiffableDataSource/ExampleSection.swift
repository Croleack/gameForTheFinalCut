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

enum ExampleRow:Hashable {
    case obstacles(ObstaclesModel)
    case gameSpeed(GameSpeedModel)
    case name(NameModel)
    case photo(PhotoModel)
}

struct ObstaclesModel: Hashable {
    let image: String
    let name: String
    let describtion: String
    
    static let betaObstacles: Self = .init(image: "characterImage",
								   name: "beta-test",
								   describtion: "отважная амазонка")
    static let betaTwoObstacles: Self = .init(image: "dino_run1",
								   name: "beta-test",
								   describtion: "динозавр стендапер")
}

struct GameSpeedModel: Hashable {
    let image: String
    let name: String
    
    static let beta: Self = .init(image: "characterImage", name: "beta-test")
}

struct NameModel: Hashable {
    let image: String
    let name: String
    
    static let beta: Self = .init(image: "characterImage", name: "beta-test")
}

struct PhotoModel: Hashable {
    let image: String
    
    static let beta: Self = .init(image: "characterImage")
}

