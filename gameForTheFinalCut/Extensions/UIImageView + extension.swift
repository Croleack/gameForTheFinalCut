//
//  UIImageView + extension.swift
//  gameForTheFinalCut
//
//  Created by Enzhe Gaysina on 01.11.2023.
//

import UIKit

extension UIImageView {
    func load(url: URL) {
	   DispatchQueue.global().async { [weak self] in
		  if let data = try? Data(contentsOf: url) {
			 if let image = UIImage(data: data) {
				DispatchQueue.main.async {
				    self?.image = image
				}
			 }
		  }
	   }
    }
}
