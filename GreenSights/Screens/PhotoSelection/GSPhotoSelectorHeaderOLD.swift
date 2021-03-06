//
//  PhotoSelectorHeader.swift
//  GreenSights
//
//  Created by Leon Helg on 12.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit

class GSPhotoSelectorHeader: UICollectionViewCell, ReusableView {
	
	var photoScrollViewTopConstraint 		= NSLayoutConstraint()
	var photoScrollViewBottomConstraint 	= NSLayoutConstraint()
	var photoScrollViewLeadingConstraint 	= NSLayoutConstraint()
	var photoScrollViewTrailingConstraint 	= NSLayoutConstraint()
	lazy var photoScrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.bounces = false
		scrollView.showsVerticalScrollIndicator = false
		scrollView.showsHorizontalScrollIndicator = false
		scrollView.delegate = self
		scrollView.clipsToBounds = false
		return scrollView
	}()
	
	var imageSize = CGSize(width: 500, height: 500) {
		didSet {
			adjustedImageSize = imageSize
			startSizeUpdateSequence()
		}
	}
	var adjustedImageSize = CGSize(width: 500, height: 500)
	
	var photoImageViewHeightConstraint = NSLayoutConstraint()
	var photoImageViewWidthConstraint = NSLayoutConstraint()
	let photoImageView: UIImageView = {
		let imageview = UIImageView()
		imageview.contentMode = .scaleAspectFit
		imageview.clipsToBounds = false
		return imageview
	}()
    
    let squareButton		= GSPostOrientationButton(iconName: GSSettings.ui.otherIcons.squareIcon)
    let portraitButton		= GSPostOrientationButton(iconName: GSSettings.ui.otherIcons.portraitIcon)
    let landscapeButton 	= GSPostOrientationButton(iconName: GSSettings.ui.otherIcons.landscapeIcon)
	var buttons 			= [GSPostOrientationButton]()
	
	let landscapeSideUp 	= UIView()
	let landscapeSideDown 	= UIView()
	let portraitSideLeft 	= UIView()
	let portraitSideRight 	= UIView()
	
	var orientationWidthHeight: CGFloat = 80
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.clipsToBounds = true
		self.backgroundColor = GSSettings.ui.colors.backgroundWhite
		buttons = [squareButton, portraitButton, landscapeButton]
		setupSubviews()
		setupContstraints()
		orientationWidthHeight = frame.width / 5
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
		photoScrollView.translatesAutoresizingMaskIntoConstraints = false
		photoScrollViewTopConstraint 		= photoScrollView.topAnchor.constraint(equalTo: topAnchor)
		photoScrollViewBottomConstraint 	= photoScrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
		photoScrollViewLeadingConstraint 	= photoScrollView.leadingAnchor.constraint(equalTo: leadingAnchor)
		photoScrollViewTrailingConstraint 	= photoScrollView.trailingAnchor.constraint(equalTo: trailingAnchor)
		
		photoImageView.translatesAutoresizingMaskIntoConstraints = false
		photoImageViewHeightConstraint 	= photoImageView.heightAnchor.constraint(equalToConstant: imageSize.height)
		photoImageViewWidthConstraint 	= photoImageView.widthAnchor.constraint(equalToConstant: imageSize.width)
		NSLayoutConstraint.activate([photoScrollViewTopConstraint, photoScrollViewBottomConstraint, photoScrollViewLeadingConstraint, photoScrollViewTrailingConstraint, photoImageViewWidthConstraint, photoImageViewHeightConstraint])

		let padding: CGFloat = 12
		portraitButton.anchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: padding, paddingTrailing: padding, width: 40, height: 40)
		squareButton.anchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: portraitButton.leadingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: padding, paddingTrailing: padding, width: 40, height: 40)
		landscapeButton.anchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: squareButton.leadingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: padding, paddingTrailing: padding, width: 40, height: 40)
		
		landscapeSideUp.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0, width: 0, height: 0)
		landscapeSideDown.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0, width: 0, height: 0)
		landscapeSideUp.heightAnchor.constraint(equalToConstant: orientationWidthHeight).isActive = true
		landscapeSideDown.heightAnchor.constraint(equalToConstant: orientationWidthHeight).isActive = true
		portraitSideLeft.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0, width: 0, height: 0)
		portraitSideRight.anchor(top: topAnchor, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0, width: 0, height: 0)
		portraitSideLeft.widthAnchor.constraint(equalToConstant: orientationWidthHeight).isActive = true
		portraitSideRight.widthAnchor.constraint(equalToConstant: orientationWidthHeight).isActive = true
	}
	
	@objc func handleOrientationTap(sender: GSPostOrientationButton) {
		resetButtons()
		resetOrientationViews()
		resetOrientationConstraints()
		adjustedImageSize = imageSize
		sender.isSelected = true
		switch sender {
		case landscapeButton:
			setLandscapeMode()
			//adjustedImageSize.height = imageSize.height - 2 * (imageSize.height / 5)
		case portraitButton:
			setPortraitMode()
			//adjustedImageSize.width = imageSize.width - 2 * (imageSize.width / 5)
		default:
			break
		}
		startSizeUpdateSequence()
		print(photoImageView.center)
		print(photoScrollView.center)
		print(photoScrollView.contentSize.width)
		photoImageView.center = CGPoint(x: photoScrollView.contentSize.width / 2 - frame.width / 5, y: photoScrollView.contentSize.height / 2 - frame.height / 5)
		print(photoImageView.center)
	}
	
	fileprivate func startSizeUpdateSequence() {
		updateImageConstraints()
		updateScrollViewContentSize()
		layoutSubviews()
	}
	
	fileprivate func updateMinZoomScaleForSize(_ size: CGSize) {
		let widthScale = size.width / imageSize.width
		let heightScale = size.height / imageSize.height
		let minScale = min(widthScale, heightScale)
		let maxScale = max(widthScale, heightScale)
		
		photoScrollView.minimumZoomScale = maxScale
		photoScrollView.maximumZoomScale = maxScale * 2.5
		photoScrollView.zoomScale = maxScale
	}
	
	fileprivate func updateImageConstraints() {
		setNeedsUpdateConstraints()
		photoImageViewWidthConstraint.constant = imageSize.width
		photoImageViewHeightConstraint.constant = imageSize.height
		updateConstraints()
	}
	
	fileprivate func updateScrollViewContentSize() {
		setNeedsLayout()
		let contentWidth 	= photoImageView.frame.width - (photoScrollViewLeadingConstraint.constant + -photoScrollViewTrailingConstraint.constant)
		let contentHeight 	= photoImageView.frame.height - (photoScrollViewTopConstraint.constant + -photoScrollViewBottomConstraint.constant)
		photoScrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
		layoutIfNeeded()
	}
	
	@objc fileprivate func shouldPrintSizes() {
		print("_________")
		print("ImageFrame: ",photoImageView.frame)
		print("ScrollviewFrame: ",photoScrollView.frame)
		print("ContentSize: ",photoScrollView.contentSize)
	}
	
	fileprivate func resetButtons() {
		for button in buttons {
			button.isSelected = false
		}
	}
	
	fileprivate func resetOrientationViews() {
		portraitSideRight.isHidden 	= true
		portraitSideLeft.isHidden 	= true
		landscapeSideUp.isHidden 	= true
		landscapeSideDown.isHidden 	= true
	}
	
	fileprivate func resetOrientationConstraints() {
		photoScrollViewTopConstraint.constant 		= 0
		photoScrollViewBottomConstraint.constant 	= 0
		photoScrollViewLeadingConstraint.constant 	= 0
		photoScrollViewTrailingConstraint.constant 	= 0
	}
	
	fileprivate func setLandscapeMode() {
		landscapeSideUp.isHidden 	= false
		landscapeSideDown.isHidden 	= false
		photoScrollViewTopConstraint.constant 		= orientationWidthHeight
		photoScrollViewBottomConstraint.constant 	= -orientationWidthHeight
	}
	
	fileprivate func setPortraitMode() {
		portraitSideRight.isHidden 	= false
		portraitSideLeft.isHidden 	= false
		photoScrollViewLeadingConstraint.constant 	= orientationWidthHeight
		photoScrollViewTrailingConstraint.constant 	= -orientationWidthHeight
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
	
//	func scrollViewDidZoom(_ scrollView: UIScrollView) {
//		let offsetX = max((scrollView.bounds.size.width - scrollView.contentSize.width) * CGFloat(0.5), 0.0)
//		let offsetY = max((scrollView.bounds.size.height - scrollView.contentSize.height) * CGFloat(0.5), 0.0)
//		photoImageView.center = CGPoint(x: scrollView.contentSize.width * 0.5 + offsetX, y: scrollView.contentSize.height * 0.5 + offsetY)
//	}
}
