//
//  SectionStruct.swift
//  gameForTheFinalCut
//
//  Created by Enzhe Gaysina on 15.10.2023.
//

import UIKit

struct SectionStruct: Codable {
    let sectionTitle: String?
    let sectionType: SectionType
    var selectedItem: Int?
    var sectionItems: [String]?
    
    init(sectionType: SectionType, selectedItem: Int?) {
	   self.sectionType = sectionType
	   self.selectedItem = selectedItem
	   self.sectionTitle = MockData.sections[sectionType]?.sectionTitle
	   self.sectionItems = MockData.sections[sectionType]?.sectionItems
    }
}

struct MockData {
    static let sections: [SectionType: SettingsData] = [
	   .general: SettingsData(
		  sectionTitle: "Введите свое имя",
		  sectionItems: ["Имя игрока"]),
	   .character: SettingsData(
		  sectionTitle: "Персонаж",
		  sectionItems: [
			 "Отважная девочка",
			 "Смешной динозавр"]
	   ),
	   .obstacleColor: SettingsData(
		  sectionTitle: "Цвет препятствия",
		  sectionItems: [
			 "Зеленый",
			 "Оранжевый",
			 "Розовый"
		  ]
	   ),
	   .difficulty: SettingsData(
		  sectionTitle: "Сложность игры",
		  sectionItems: [
			 "Easy",
			 "Normal",
			 "Hard"]
	   )
    ]
}

enum SectionType: Int {
    case general, character, obstacleColor, difficulty
}

struct SettingsData {
    var sectionTitle: String
    var sectionItems: [String]
}

extension SectionType: Encodable, Decodable {
    
}

