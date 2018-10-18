//
//  GSPhotoSelectorCell.swift
//  GreenSights
//
//  Created by Leon Helg on 12.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit

class GSPhotoSelectorCell: UICollectionViewCell, ReusableView {
	
	let photoImageView: UIImageView = {
		let imageview = UIImageView()
		imageview.contentMode = .scaleAspectFill
		imageview.clipsToBounds = true
		return imageview
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = GSSettings.UI.Colors.backgroundWhite
		setupSubviews()
		setupContstraints()
	}
	
	func setupSubviews() {
		addSubview(photoImageView)
	}
	
	func setupContstraints() {
		photoImageView.fillSuperview(onlySafeArea: false)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
