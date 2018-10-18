//
//  AddThumbnailController.swift
//  GreenSights
//
//  Created by Leon Helg on 12.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit

class GSPhotoSelectorController: GSBaseViewController {
	let containerView = GSPhotoSelectorCollectionView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupNavBar()
		setupSubview()
		updateViewConstraints()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		containerView.parentVCDidAppear()
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
	
	func setupNavBar() {
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(handleNext))
	}
	
	@objc func handleNext() {
		let sharePhotoController = TestVC()
		navigationController?.pushViewController(sharePhotoController, animated: true)
	}
	
	@objc func handleCancel() {
		dismiss(animated: true, completion: nil)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
}
