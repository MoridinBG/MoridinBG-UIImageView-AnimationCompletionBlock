#UIImageView+AnimationCompletionBlock
Execute UIImageView image animations with completion handler

Implemented in Swift with some hints from NSHipster (http://nshipster.com/swift-objc-runtime/)

###Installation
Add UIImageView+AnimationCompletionBlock.swift to your project

###Usage
Setup your UIImageView animation as usual, but instead of startAnimating use startAnimatingWithCompletionBlock:

    imageView.animationImages = images
    imageView.animationDuration = 0.5
    imageView.animationRepeatCount = 2
		
    imageView.startAnimatingWithCompletionBlock { () -> () in
        print("Animation completed!")
    }

###License
Use however it pleases you. Credit would be nice.
