//
//  LaunchScreenViewController.swift
//  gameForTheFinalCut
//
//  Created by Enzhe Gaysina on 13.11.2023.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    private let imageView: UIImageView = {
	   let imageView = UIImageView(frame: CGRect(
		  x: Constants.imagePositionX,
		  y: Constants.imagePositionY,
		  width: Constants.imageWidth,
		  height: Constants.imageHeight))
	   imageView.image = UIImage(named: "logo")
	   return imageView
    }()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
	   super.viewDidLoad()
	   view.addSubview(imageView)
	   view.backgroundColor = .white
	   
	   imageView.center = view.center
	   
	   DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
		  self.animate()
	   }
    }
    
    //MARK: - functios
    private func animate() {
	   UIView.animate(withDuration: Constants.animationDuration, animations: {
		  let size = self.view.frame.size.width * Constants.animationSizeMultiplier
		  let diffX = size - self.view.frame.size.width
		  let diffY = self.view.frame.size.height - size
		  
		  self.imageView.frame = CGRect(
			 x: -(diffX/2),
			 y: diffY/2,
			 width: size,
			 height: size
		  )
	   })
	   
	   UIView.animate(withDuration: Constants.fadeOutDuration, animations: {
		  self.imageView.alpha = 0
	   }, completion: { done in
		  if done {
			 DispatchQueue.main.asyncAfter(deadline: .now() + Constants.delayBeforeTransition) {
				let viewController = ViewController()
				let navigationController = UINavigationController(rootViewController: viewController)
				navigationController.modalTransitionStyle = .crossDissolve
				navigationController.modalPresentationStyle = .fullScreen
				self.present(navigationController, animated: true)
			 }
		  }
	   })
    }
}

// MARK: - Constants

fileprivate extension LaunchScreenViewController {
    
    enum Constants {
	   static let imagePositionX: CGFloat = 0.0
	   static let imagePositionY: CGFloat = 0.0
	   static let imageWidth: CGFloat = 150.0
	   static let imageHeight: CGFloat = 150.0
	   static let animationSizeMultiplier: CGFloat = 2.0
	   static let animationDuration: TimeInterval = 1.0
	   static let fadeOutDuration: TimeInterval = 0.5
	   static let delayBeforeTransition: TimeInterval = 0.3
    }
}
