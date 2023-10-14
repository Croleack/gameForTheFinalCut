//
//  RedView.swift
//  gameForTheFinalCut
//
//  Created by Enzhe Gaysina on 14.10.2023.
//

import UIKit

class RedView: UIView {
    
    func make() {
	   guard let viewWidth = superview?.frame.size.width else {
		  return
	   }
	   frame = CGRect(
		  x: viewWidth / 2 - Constants.redViewWidth / 2,
		  y: -Constants.redViewHeight,
		  width: Constants.redViewWidth,
		  height: Constants.redViewHeight
	   )
	   backgroundColor = UIColor.red
    }
    
    @objc
    func animateRedView(_ isGameOver: Bool) {
	   
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

fileprivate extension RedView {
    
    enum Constants {
	   static let timeIntervalRedView = 1.5
	   static let redViewWidth: CGFloat = 70.0
	   static let redViewHeight: CGFloat = 70.0
    }
}
