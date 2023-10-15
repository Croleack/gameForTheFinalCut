//
//  SectionStruct.swift
//  gameForTheFinalCut
//
//  Created by Enzhe Gaysina on 15.10.2023.
//

import UIKit

struct SectionStruct {
    let section: String 
    let sectionType: SectionType
    var selectedItem: Int
    var items: [String]
}

enum SectionType {
    case general, character, obstacleColor, difficulty
}

struct SettingsData {
    var sections: [SectionStruct]
    var selectedOptions: [SectionType: Int] = [:]
    
    init() {
	   sections = [
		  SectionStruct(section: "Введите свое имя",
					 sectionType: .general,
					 selectedItem: 0,
					 items: ["Имя игрока"]),
		  SectionStruct(section: "Персонаж",
					 sectionType: .character,
					 selectedItem: 0,
					 items: ["Отважная девочка", "Смешной динозавр"]),
		  SectionStruct(section: "Цвет препятствия",
					 sectionType: .obstacleColor,
					 selectedItem: 0,
					 items: ["Зеленый", "Оранжевый", "Розовый"]),
		  SectionStruct(section: "Сложность игры",
					 sectionType: .difficulty,
					 selectedItem: 0,
					 items: ["Easy", "Normal", "Hard"])
	   ]
    }
}

extension SectionType: Encodable, Decodable {
    
}

