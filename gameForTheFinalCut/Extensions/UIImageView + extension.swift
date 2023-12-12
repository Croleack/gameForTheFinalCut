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
		  guard let self = self,
			   let data = try? Data(contentsOf: url),
			   let image = UIImage(data: data) else {
			 print("Error loading image: Unable to load data or create image")
			 return
		  }
		  DispatchQueue.main.async {
			 self.image = image
		  }
	   }
    }
}
