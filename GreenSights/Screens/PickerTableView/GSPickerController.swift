//
//  GSPickerController.swift
//  GreenSights
//
//  Created by Leon Helg on 14.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit

class GSPickerController: GSBaseViewController {
	let containerView = TestView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupSubview()
		updateViewConstraints()
	}
	
	func setupSubview() {
		self.view.addSubview(self.containerView)
	}
	
	func setupConstraints() {
		self.containerView.fillSuperview(onlySafeArea: true)
	}
	
	override func updateViewConstraints() {
		super.updateViewConstraints()
		self.setupConstraints()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
}
