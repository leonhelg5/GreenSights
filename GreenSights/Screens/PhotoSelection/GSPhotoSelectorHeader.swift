//
//  PhotoSelectorHeader.swift
//  GreenSights
//
//  Created by Leon Helg on 12.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit

class GSPhotoSelectorHeader: UICollectionViewCell, ReusableView {
	
	lazy var photoScrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.bounces = false
		scrollView.showsVerticalScrollIndicator = false
		scrollView.showsHorizontalScrollIndicator = false
		scrollView.delegate = self
		return scrollView
	}()
	
	var imageSize = CGSize(width: 500, height: 500) {
		didSet {
			photoScrollView.contentSize = imageSize
			photoImageViewWidthConstraint.constant = imageSize.width
			photoImageViewHeightConstraint.constant = imageSize.height
			layoutSubviews()
			scrollViewDidZoom(photoScrollView)
		}
	}
	var photoImageViewHeightConstraint = NSLayoutConstraint()
	var photoImageViewWidthConstraint = NSLayoutConstraint()
	let photoImageView: UIImageView = {
		let imageview = UIImageView()
		imageview.contentMode = .scaleAspectFill
		imageview.clipsToBounds = false
		return imageview
	}()
    
    let squareButton     = GSPostOrientationButton(iconName: GSSettings.ui.otherIcons.squareIcon)
    let portraitButton     = GSPostOrientationButton(iconName: GSSettings.ui.otherIcons.portraitIcon)
    let landscapeButton = GSPostOrientationButton(iconName: GSSettings.ui.otherIcons.landscapeIcon)
	var buttons = [GSPostOrientationButton]()
	
	let landscapeSideUp = UIView()
	let landscapeSideDown = UIView()
	let portraitSideLeft = UIView()
	let portraitSideRight = UIView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = GSSettings.ui.colors.backgroundWhite
		buttons = [squareButton, portraitButton, landscapeButton]
		setupSubviews()
		setupContstraints()
		//updateMinZoomScaleForSize(self.frame.size)
	}
	
	func setupSubviews() {
		addSubview(photoScrollView)
		photoScrollView.addSubview(photoImageView)
		for view in [landscapeSideUp, landscapeSideDown, portraitSideLeft, portraitSideRight] {
			addSubview(view)
			view.backgroundColor = .white
			view.isHidden = true
			view.isUserInteractionEnabled = false
			view.alpha = 0.8
		}
		for button in buttons {
			self.addSubview(button)
			button.addTarget(self, action: #selector(handleOrientationTap(sender:)), for: .touchUpInside)
		}
	}
	
	func setupContstraints() {
		photoScrollView.fillSuperview(onlySafeArea: true)
		
		photoImageView.translatesAutoresizingMaskIntoConstraints = false
		photoImageViewHeightConstraint = photoImageView.heightAnchor.constraint(equalToConstant: imageSize.height)
		photoImageViewHeightConstraint.isActive = true
		photoImageViewWidthConstraint = photoImageView.widthAnchor.constraint(equalToConstant: imageSize.width)
		photoImageViewWidthConstraint.isActive = true

		
		let padding: CGFloat = 8
		portraitButton.anchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: padding, paddingTrailing: padding, width: 45, height: 45)
		squareButton.anchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: portraitButton.leadingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: padding, paddingTrailing: padding, width: 45, height: 45)
		landscapeButton.anchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: squareButton.leadingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: padding, paddingTrailing: padding, width: 45, height: 45)
		
		landscapeSideUp.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0, width: 0, height: 0)
		landscapeSideDown.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0, width: 0, height: 0)
		landscapeSideUp.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2).isActive = true
		landscapeSideDown.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2).isActive = true
		portraitSideLeft.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0, width: 0, height: 0)
		portraitSideRight.anchor(top: topAnchor, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0, width: 0, height: 0)
		portraitSideLeft.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2).isActive = true
		portraitSideRight.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2).isActive = true
	}
	
	@objc func handleOrientationTap(sender: GSPostOrientationButton) {
		switch sender {
		case landscapeButton:
			print("land")
			portraitSideRight.isHidden = true
			portraitSideLeft.isHidden = true
			landscapeSideUp.isHidden = false
			landscapeSideDown.isHidden = false
//			let sideHeight = landscapeSideDown.frame.height
//			photoScrollView.contentInset = UIEdgeInsets(top: sideHeight, left: 0, bottom: sideHeight, right: 0)
		case portraitButton:
			print("port")
			landscapeSideUp.isHidden = true
			landscapeSideDown.isHidden = true
			portraitSideRight.isHidden = false
			portraitSideLeft.isHidden = false
//			let sideWidth = landscapeSideDown.frame.width
//			photoScrollView.contentInset = UIEdgeInsets(top: 0, left: sideWidth, bottom: 0, right: sideWidth)
		default:
			print("square")
			portraitSideRight.isHidden = true
			portraitSideLeft.isHidden = true
			landscapeSideUp.isHidden = true
			landscapeSideDown.isHidden = true
//			photoScrollView.contentInset = .zero
		}
	}
	
	fileprivate func updateMinZoomScaleForSize(_ size: CGSize) {
//		print("______")
//		print("HeaderSize: ",size)
//		print("ImageSize: ",imageSize)

		let widthScale = size.width / imageSize.width
		let heightScale = size.height / imageSize.height
		let minScale = min(widthScale, heightScale)
		let maxScale = max(widthScale, heightScale)
		
//		print("Minscale: ",minScale)
		photoScrollView.minimumZoomScale = maxScale
		photoScrollView.maximumZoomScale = maxScale * 2.5
		photoScrollView.zoomScale = maxScale
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		updateMinZoomScaleForSize(frame.size)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension GSPhotoSelectorHeader: UIScrollViewDelegate {
	func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		return self.photoImageView
	}
	
	func scrollViewDidZoom(_ scrollView: UIScrollView) {
		print("didscroll")
		print(scrollView.bounds)
		print(scrollView.contentSize)
		let offsetX = max((scrollView.bounds.size.width - scrollView.contentSize.width) * CGFloat(0.5), 0.0)
		let offsetY = max((scrollView.bounds.size.height - scrollView.contentSize.height) * CGFloat(0.5), 0.0)
		photoImageView.center = CGPoint(x: scrollView.contentSize.width * 0.5 + offsetX, y: scrollView.contentSize.height * 0.5 + offsetY)
	}
}
