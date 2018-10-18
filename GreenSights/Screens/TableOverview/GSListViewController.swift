//
//  ViewController.swift
//  GreenSights
//
//  Created by Leon Helg on 05.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit

class GSListViewController: GSBaseViewController {
	let containerView = GSListView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupSubview()
		updateViewConstraints()
	}
	
	func setupSubview() {
		self.view.addSubview(self.containerView)
		containerView.delegate = self
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

extension GSListViewController: listViewDelegate {
	func pushTo() {
		let detailViewController = GSDetailViewController()
		self.navigationController?.pushViewController(detailViewController, animated: true)
	}
}
