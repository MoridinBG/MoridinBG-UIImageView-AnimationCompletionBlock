//
//  ViewController.swift
//  UIImageView+AnimationCompletionBlock
//
//  Created by Ivan Dilchovski on 10/26/15.
//  Copyright © 2015 Ivan Dilchovski. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
	@IBOutlet weak var imageView: UIImageView!
	
	override func viewWillAppear(animated: Bool)
	{
		super.viewWillAppear(animated)
		var images = [UIImage]()
		var image: UIImage?
		
		for i in 0...29
		{
			image = UIImage(named: "Globe-\(i)")
			
			if let image = image
			{
				images.append(image)
			}
		}
		
		imageView.animationImages = images
		imageView.animationDuration = Double(images.count) / 25.0
		imageView.animationRepeatCount = 2
		
		imageView.startAnimatingWithCompletionBlock { () -> () in
			self.imageView.image = UIImage(named: "success")!
		}
		
	}
}

