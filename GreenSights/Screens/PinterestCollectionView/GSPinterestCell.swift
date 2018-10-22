//
//  GSPinterestCekk.swift
//  GreenSights
//
//  Created by Leon Helg on 19.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit


class GSPinterestCell: UICollectionViewCell, ReusableView, Flipable {
	
	var data: Datasource?
	
	let photoImageView: UIImageView = {
		let imageview = UIImageView()
		imageview.contentMode = .scaleAspectFill
		imageview.clipsToBounds = true
		imageview.isUserInteractionEnabled = true
		return imageview
	}()
	
	let titleLabel: UILabel = {
		let label = UILabel()
		label.textColor = .white
		label.font = GSSettings.ui.fonts.helveticaBold
		label.textAlignment = .center
		label.numberOfLines = 0
		return label
	}()
	
	let friendsImageView: UIImageView = {
		let imageview = UIImageView()
		imageview.clipsToBounds = true
		imageview.contentMode = .scaleAspectFit
		imageview.image = UIImage(named: GSSettings.ui.otherIcons.friends)?.withRenderingMode(.alwaysTemplate)
		imageview.tintColor = .white
		return imageview
	}()
	
	let gradientLayer: CAGradientLayer = {
		let gradientLayer = CAGradientLayer()
		gradientLayer.frame = .zero
		gradientLayer.colors = [UIColor.black.withAlphaComponent(0.4).cgColor, UIColor.black.withAlphaComponent(0).cgColor]
		gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
		gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
		gradientLayer.cornerRadius = GSSettings.ui.sizes.cornerRadius
		return gradientLayer
	}()
	
	var isFlipped: Bool = false
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = GSSettings.ui.colors.backgroundWhite
		self.layer.cornerRadius = GSSettings.ui.sizes.cornerRadius
		setupSubviews()
		setupContstraints()
	}
	
	func setupSubviews() {
		contentView.addSubview(photoImageView)
		contentView.addSubview(titleLabel)
		photoImageView.layer.addSublayer(gradientLayer)
		contentView.bringSubviewToFront(titleLabel)
		photoImageView.addSubview(friendsImageView)
		bringSubviewToFront(friendsImageView)
		friendsImageView.isHidden = true
	}
	
	func setupContstraints() {
		photoImageView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0, width: 0, height: 0)
		photoImageView.layer.cornerRadius = GSSettings.ui.sizes.cornerRadius
		titleLabel.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, paddingTop: 8, paddingLeading: 8, paddingBottom: 0, paddingTrailing: 8, width: 0, height: 0)
		friendsImageView.anchor(top: photoImageView.topAnchor, leading: photoImageView.leadingAnchor, bottom: nil, trailing: nil, paddingTop: 8, paddingLeading: 8, paddingBottom: 0, paddingTrailing: 0, width: 30, height: 30)
	}
	
	func configure(dataSource: Datasource?) {
		guard let dataSource = dataSource else { return }
		data = dataSource
		guard let type = data?.type else { return }
		
		if type == .landscape {
			photoImageView.image = UIImage(named: "landscape")
		} else if type == .portrait {
			photoImageView.image = UIImage(named: "portrait")
		} else {
			photoImageView.image = UIImage(named: "square")
		}
		
		if let title = data?.titel {
			titleLabel.text = title
		}
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		let cellsFrame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
		updateGradientLayer(frame: cellsFrame)
	}
	
	func updateGradientLayer(frame: CGRect) {
		gradientLayer.frame = CGRect(x: 0, y: 0, width: frame.width, height: 80)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		self.titleLabel.text = ""
	}
}
