//
//  UIImageView+AnimationCompletionBlock.swift
//  AnimatedKeyboard
//
//  Created by Ivan Dilchovski on 10/25/15.
//  Copyright © 2015 TechLight. All rights reserved.
//

import UIKit

extension UIImageView
{
	//The key is a static variable, hidden in a private struct to keep the scope clean
	private struct AssociatedKeys
	{
		static var completionBlock = "completionBlockAssociatedKey"
	}
	
	//Closure can not be directly stored as associated objects, as associated objects must be objects
	//So wrap the closure in a class
	private class ClosureWrapper
	{
		var closure: (() -> ())?
		
		init(closure: (() -> ())?)
		{
			self.closure = closure
		}
	}
	
	//Wrap or extract the closure from the wrapper class in computed property's accessors
	var completionBlock: (() -> ())?
	{
		get
		{
			let cw = objc_getAssociatedObject(self, &AssociatedKeys.completionBlock) as? ClosureWrapper
			return cw?.closure
		}
		
		set
		{
			objc_setAssociatedObject(
				self,
				&AssociatedKeys.completionBlock,
				ClosureWrapper(closure: newValue),
				.OBJC_ASSOCIATION_RETAIN_NONATOMIC
			)
		}
	}
	
	public func startAnimatingWithCompletionBlock(block: (() -> ()))
	{
		guard let animationImages = self.animationImages else
		{
			block()
			return
		}
		
		self.completionBlock = block
		
		var cgImages = [CGImage]()
		for image in animationImages
		{
			if let cgImage = image.CGImage
			{
				cgImages.append(cgImage)
			}
		}
		
		let animation = CAKeyframeAnimation()
		animation.keyPath = "contents"
		animation.values = cgImages
		animation.repeatCount = Float(self.animationRepeatCount)
		animation.duration = self.animationDuration
		animation.delegate = self
		
		self.layer.addAnimation(animation, forKey: nil)
	}
	
	public override func animationDidStop(anim: CAAnimation, finished flag: Bool)
	{
		if let block = self.completionBlock, anim = anim as? CAKeyframeAnimation where anim.keyPath == "contents"
		{
			block()
			self.completionBlock = nil
		}
	}
}
