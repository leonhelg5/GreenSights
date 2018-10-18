//
//  GSFotoCell.swift
//  GreenSights
//
//  Created by Leon Helg on 09.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit

class GSFotoCell: UICollectionViewCell, ReusableView {
	let fotoView: UIImageView = {
		let imageview = UIImageView()
		imageview.image = UIImage(named: "testbild")
		imageview.contentMode = .scaleAspectFill
		imageview.clipsToBounds = true
		imageview.layer.cornerRadius = GSSettings.UI.Sizes.cornerRadius
		return imageview
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = GSSettings.UI.Colors.backgroundWhite
		setupSubviews()
		setupContstraints()
	}
	
	func setupSubviews() {
		addSubview(fotoView)
	}
	
	func setupContstraints() {
		fotoView.fillSuperview(onlySafeArea: false)
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
