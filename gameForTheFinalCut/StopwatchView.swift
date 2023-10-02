//
//  StopwatchView.swift
//  gameForTheFinalCut
//
//  Created by Enzhe Gaysina on 02.10.2023.
//

import UIKit

class StopwatchView: UIView {
    private var timer: Timer?
    private var elapsedTime: TimeInterval = 0.0
    
    private let label: UILabel = {
	   let label = UILabel()
	   label.textColor = .white
	   label.font = UIFont.systemFont(ofSize: 16)
	   label.text = "00:00"
	   label.translatesAutoresizingMaskIntoConstraints = false
	   return label
    }()
    
    override init(frame: CGRect) {
	   super.init(frame: frame)
	   addSubview(label)
	   
	   NSLayoutConstraint.activate([
		  label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
		  label.topAnchor.constraint(equalTo: topAnchor, constant: 10)
	   ])
	   
	   startTimer()
    }
    
    required init?(coder: NSCoder) {
	   super.init(coder: coder)
	   addSubview(label)
	   
	   NSLayoutConstraint.activate([
		  label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
		  label.topAnchor.constraint(equalTo: topAnchor, constant: 10)
	   ])
	   
	   startTimer()
    }
    
    deinit {
	   stopTimer()
    }
    
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
	   let minutes = Int(elapsedTime) / 60
	   let seconds = Int(elapsedTime) % 60
	   let timeString = String(format: "%02d:%02d", minutes, seconds)
	   label.text = timeString
    }
}
