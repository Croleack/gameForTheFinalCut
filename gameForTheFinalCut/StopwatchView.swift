//
//  StopwatchView.swift
//  gameForTheFinalCut
//
//  Created by Enzhe Gaysina on 02.10.2023.
//

import UIKit

class StopwatchView: UIView {
    private var timer: Timer?
    private var elapsedTime: TimeInterval = Constants.elapsedTimeInterval
    
    private let label: UILabel = {
	   let label = UILabel()
	   label.textColor = .white
	   label.font = UIFont.systemFont(ofSize: Constants.fontTextStyle)
	   label.text = Constants.textLabel
	   label.translatesAutoresizingMaskIntoConstraints = false
	   return label
    }()
    
    override init(frame: CGRect) {
	   super.init(frame: frame)
	   addSubview(label)
	   
	   NSLayoutConstraint.activate([
		  label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.constraintsTrailingAnchor),
		  label.topAnchor.constraint(equalTo: topAnchor, constant: Constants.constraintsTopAnchor)
	   ])
	   
	   startTimer()
    }
    
    required init?(coder: NSCoder) {
	   super.init(coder: coder)
	   addSubview(label)
	   
	   NSLayoutConstraint.activate([
		  label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.constraintsTrailingAnchor),
		  label.topAnchor.constraint(equalTo: topAnchor, constant: Constants.constraintsTopAnchor)
	   ])
	   
	   startTimer()
    }
    
    deinit {
	   stopTimer()
    }
    // MARK: - timer functions
    
    private func startTimer() {
	   timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
		  self?.elapsedTime += 1
		  self?.updateLabel()
	   }
    }
    
    private func stopTimer() {
	   timer?.invalidate()
	   timer = nil
    }
    
    private func updateLabel() {
	   let minutes = Int(elapsedTime) / Constants.translateOfTime
	   let seconds = Int(elapsedTime) % Constants.translateOfTime
	   let timeString = String(format: "Очки %02d:%02d", minutes, seconds)
	   label.text = timeString
    }
}

// MARK: - Constants

fileprivate extension StopwatchView {
    
    enum Constants {
	   static let translateOfTime = 60
	   static let elapsedTimeInterval = 0.0
	   static let textLabel = "Очки 00:00"
	   static let fontTextStyle: CGFloat = 20.0
	   static let constraintsTopAnchor: CGFloat = 10.0
	   static let constraintsTrailingAnchor: CGFloat = -10.0
    }
}
