//
//  GestureAreaView.swift
//  gameForTheFinalCut
//
//  Created by Enzhe Gaysina on 02.10.2023.
//

import UIKit

class GestureAreaView: UIView {
    
    // Области для разделения экрана
    var topAreaView: UIView!
    var bottomAreaView: UIView!
    var leftAreaView: UIView!
    var rightAreaView: UIView!
    
    // Обработчики жестов
    var topAreaTapHandler: (() -> Void)?
    var bottomAreaTapHandler: (() -> Void)?
    var leftAreaTapHandler: (() -> Void)?
    var rightAreaTapHandler: (() -> Void)?
    
    override init(frame: CGRect) {
	   super.init(frame: frame)
	   
	   // Создание областей и жестов
	   createGestureAreas()
    }
    
    required init?(coder aDecoder: NSCoder) {
	   super.init(coder: aDecoder)
	   
	   // Создание областей и жестов
	   createGestureAreas()
    }
    
    //MARK: - Создание областей и жестов
    
    private func createGestureAreas() {
	   let stackView = UIStackView()
	   stackView.axis = .vertical
	   stackView.distribution = .fillEqually
	   stackView.translatesAutoresizingMaskIntoConstraints = false
	   
	   topAreaView = UIView()
	   bottomAreaView = UIView()
	   leftAreaView = UIView()
	   rightAreaView = UIView()
	   
	   // Настройка обработчиков жестов для областей
	   let topGesture = UITapGestureRecognizer(target: self, action: #selector(handleTopAreaTap))
	   topAreaView.addGestureRecognizer(topGesture)
	   
	   let bottomGesture = UITapGestureRecognizer(target: self, action: #selector(handleBottomAreaTap))
	   bottomAreaView.addGestureRecognizer(bottomGesture)
	   
	   let leftGesture = UITapGestureRecognizer(target: self, action: #selector(handleLeftAreaTap))
	   leftAreaView.addGestureRecognizer(leftGesture)
	   
	   let rightGesture = UITapGestureRecognizer(target: self, action: #selector(handleRightAreaTap))
	   rightAreaView.addGestureRecognizer(rightGesture)
	   
	   // Добавление областей в stackView
	   stackView.addArrangedSubview(topAreaView)
	   stackView.addArrangedSubview(leftAreaView)
	   stackView.addArrangedSubview(rightAreaView)
	   stackView.addArrangedSubview(bottomAreaView)
	   
	   // Добавление stackView на представление
	   addSubview(stackView)
	   
	   // Ограничения для stackView
	   NSLayoutConstraint.activate([
		  stackView.topAnchor.constraint(equalTo: topAnchor),
		  stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
		  stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
		  stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
	   ])
    }
    
    //MARK: - Обработчики жестов
    
    @objc private func handleTopAreaTap() {
	   topAreaTapHandler?()
    }
    
    @objc private func handleBottomAreaTap() {
	   bottomAreaTapHandler?()
    }
    
    @objc private func handleLeftAreaTap() {
	   leftAreaTapHandler?()
    }
    
    @objc private func handleRightAreaTap() {
	   rightAreaTapHandler?()
    }
}
