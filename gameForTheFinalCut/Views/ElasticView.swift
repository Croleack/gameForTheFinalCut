//
//  ElasticView.swift
//  gameForTheFinalCut
//
//  Created by Enzhe Gaysina on 26.09.2023.
//

import UIKit

class ElasticView: UIView {
    
    private let topControlPointView = UIView()
    private let leftControlPointView = UIView()
    private let rightControlPointView = UIView()
    private let bottomControlPointView = UIView()
    
    private let elasticShare = CAShapeLayer()
    
    override init(frame: CGRect) {
	   super.init(frame: frame)
	   setupComponents()
    }
    
    required init?(coder: NSCoder) {
	   super.init(coder: coder)
	   setupComponents()
    }
    
    private func setupComponents() {
	   elasticShare.fillColor = UIColor.white.cgColor
	   elasticShare.path = UIBezierPath(rect: bounds).cgPath
	   layer.addSublayer(elasticShare)
	   
	   for controlPoint in [
		  topControlPointView,
		  leftControlPointView,
		  rightControlPointView,
		  bottomControlPointView] {
		  addSubview(controlPoint)
		  controlPoint.frame = CGRect(x: 0 , y: 0, width: 5, height: 5)
		  controlPoint.backgroundColor = .blue
	   }
	   positionControlPoint()
    }
    
    private func positionControlPoint() {
	   topControlPointView.center = CGPoint(x: bounds.midX, y: 0)
	   leftControlPointView.center = CGPoint(x: 0, y: bounds.midY)
	   rightControlPointView.center = CGPoint(x: bounds.maxX, y: bounds.midY)
	   bottomControlPointView.center = CGPoint(x: bounds.midX, y: bounds.maxY)
    }
}
