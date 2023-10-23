//
//  RedView.swift
//  gameForTheFinalCut
//
//  Created by Enzhe Gaysina on 14.10.2023.
//

import UIKit

class RedView: UIView {
    
    var customBackgroundColor: UIColor?
    
        init() {
    	   self.customBackgroundColor = UIColor(named: "pincColor") ?? .blue
    	   super.init(frame: .zero)
    	   self.backgroundColor = customBackgroundColor
        }
    
        required init?(coder: NSCoder) {
    	   fatalError("init(coder:) has not been implemented")
        }
    
    func make(_ xPosition: CGFloat) {
	   guard let viewWidth = superview?.frame.size.width else {
		  return
	   }
	   
	   let x = xPosition - Constants.redViewWidth
	   frame = CGRect(
		  x: x < 0 ? xPosition : x,
		  y: -Constants.redViewHeight,
		  width: Constants.redViewWidth,
		  height: Constants.redViewHeight
	   )
    }
    
    func updateColor(_ selectedImageNumber: Int) {
	   if selectedImageNumber == 0 {
		  customBackgroundColor = UIColor(named: "greenColor")
		  print("green")
	   } else if selectedImageNumber == 1 {
		  customBackgroundColor = UIColor(named: "orangeColor")
		  print("orange")
	   } else if selectedImageNumber == 2 {
		  customBackgroundColor = UIColor(named: "pincColor")
		  print("pinc")
	   }
    }
    
    @objc
    func animateRedView(_ isGameOver: Bool, _ speed: Double) {
	   
	   guard !isGameOver, let superView = superview else { return }
	   
	   let viewHeight = superView.frame.size.height
	   let redViewHeight: CGFloat = Constants.redViewWidth
	   
	   UIView.animate(withDuration: Constants.timeIntervalRedView, animations: {
		  self.frame.origin.y = viewHeight
	   }) { (finished) in
		  self.frame.origin.y = -redViewHeight
	   }
    }
}
// MARK: - Constants
fileprivate extension RedView {
    
    enum Constants {
	   static let timeIntervalRedView = 1.5
	   static let redViewWidth: CGFloat = 70.0
	   static let redViewHeight: CGFloat = 70.0
    }
}
