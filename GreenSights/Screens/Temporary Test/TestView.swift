//
//  TestView.swift
//  GreenSights
//
//  Created by Leon Helg on 10.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit

class TestView: UIView {
    
	let BIGaddFriendButton: UIButton = {
		let button = UIButton()
		button.backgroundColor = GSSettings.ui.colors.tintColor
		button.setImage(UIImage(named: "plusGreen2")?.withRenderingMode(.alwaysOriginal), for: .normal)
		button.imageView?.contentMode = .scaleAspectFit
		button.layer.cornerRadius = GSSettings.ui.sizes.cornerRadius
		return button
	}()
	
	let switcher: UISwitch = {
		let switcher = UISwitch()
		switcher.tintColor      = GSSettings.ui.colors.tintColor.withAlphaComponent(0.6)
		switcher.onTintColor    = GSSettings.ui.colors.tintColor.withAlphaComponent(0.6)
		switcher.thumbTintColor = GSSettings.ui.colors.tintColor.withAlphaComponent(0.6)
		switcher.isOn           = false
		return switcher
	}()
	
	let stepper: UIStepper = {
		let stepper = UIStepper()
		stepper.minimumValue = 0
		stepper.stepValue = 1
		stepper.tintColor = .green
		
		return stepper
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupSubviews()
		setupConstraints()
		
		firstView = UIView(frame: CGRect(x: 32, y: 32, width: 128, height: 128))
		secondView = UIView(frame: CGRect(x: 32, y: 32, width: 128, height: 128))
		
		firstView.backgroundColor = UIColor.red
		secondView.backgroundColor = UIColor.blue
		
		secondView.isHidden = true
		
		addSubview(firstView)
		addSubview(secondView)
		
		perform(#selector(flip), with: nil, afterDelay: 15)
	}
	
	func setupSubviews() {
		//        addSubview(BIGaddFriendButton)
		//        addSubview(switcher)
		//        addSubview(stepper)
	}
	
	func setupConstraints() {
		//                BIGaddFriendButton.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, paddingTop: 10, paddingLeading: GSSettings.UI.Sizes.sidePadding, paddingBottom: 0, paddingTrailing: GSSettings.UI.Sizes.sidePadding, width: 0, height: GSSettings.UI.Sizes.addFriendButtonSize)
		//                switcher.anchor(top: bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, paddingTop: 10, paddingLeading: 16, paddingBottom: 0, paddingTrailing: 16, width: 0, height: 40)
		//                stepper.anchor(top: fotosView.bottomAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, paddingTop: 10, paddingLeading: 16, paddingBottom: 0, paddingTrailing: 16, width: 0, height: 40)
	}
	
	var firstView: UIView!
	var secondView: UIView!
	
	@objc func flip() {
		let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
		
		UIView.transition(with: firstView, duration: 1.0, options: transitionOptions, animations: {
			self.firstView.isHidden = true
		})
		
		UIView.transition(with: secondView, duration: 1.0, options: transitionOptions, animations: {
			self.secondView.isHidden = false
		})
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
