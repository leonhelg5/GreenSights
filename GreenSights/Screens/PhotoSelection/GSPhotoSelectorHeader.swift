//
//  PhotoSelectorHeader.swift
//  GreenSights
//
//  Created by Leon Helg on 12.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit

class GSPhotoSelectorHeader: UICollectionViewCell, ReusableView {
	
	var currentOrientation: cellType = .square
	var imageIsLandscape = true
	
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
			imageIsLandscape = imageSize.width > imageSize.height
			startSizeUpdateSequence()
		}
	}
	
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
		sender.isSelected = true
		switch sender {
		case landscapeButton:
			currentOrientation = .landscape
			setLandscapeMode()
		case portraitButton:
			currentOrientation = .portrait
			setPortraitMode()
		default:
			currentOrientation = .square
			photoScrollView.contentInset = .zero
		}
		startSizeUpdateSequence()
	}
	
	fileprivate func startSizeUpdateSequence() {
		updateImageConstraints()
		updateScrollViewContentSize()
		layoutSubviews()
		updateScrollViewContentSize()
	}
	
	fileprivate func updateImageConstraints() {
		var width: CGFloat 	= 0
		var height: CGFloat = 0
		let aspectRatio = imageSize.width / imageSize.height
		switch currentOrientation {
		case .landscape:
			width = frame.width
			height = width / aspectRatio
		case .portrait:
			height = frame.height
			width = height * aspectRatio
		default:
			width = imageSize.width
			height = imageSize.height
		}
		setNeedsUpdateConstraints()
		photoImageViewWidthConstraint.constant = width
		photoImageViewHeightConstraint.constant = height
		updateConstraints()
	}
	
	fileprivate func updateScrollViewContentSize() {
		let contentWidth 	= photoImageViewWidthConstraint.constant //imageSize.width - (photoScrollViewTopConstraint.constant - photoScrollViewBottomConstraint.constant)
		let contentHeight 	= photoImageViewHeightConstraint.constant//imageSize.height - (photoScrollViewLeadingConstraint.constant - photoScrollViewTrailingConstraint.constant)
		let offset = CGPoint(x: (contentWidth - photoScrollView.frame.width) * 0.5 - photoScrollViewLeadingConstraint.constant, y: (contentHeight - photoScrollView.frame.height) * 0.5 - photoScrollViewTopConstraint.constant)
		let offsetSquare = CGPoint(x: (contentWidth - photoScrollView.frame.width) * 0.5, y: (contentHeight - photoScrollView.frame.height) * 0.5)
		
		print("_____")
		print(imageSize)
		print(photoScrollView.frame.width, photoScrollView.frame.width)
		print(contentWidth, contentHeight)
		print(offset)
		
		layoutIfNeeded()
		photoScrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
		if currentOrientation != .square {
			photoScrollView.setContentOffset(offset, animated: true)
		} else {
			photoScrollView.setContentOffset(offsetSquare, animated: true)
		}
		
		layoutIfNeeded()
	}
	
	@objc fileprivate func shouldPrintSizes() {
		print("_________")
		print("ImageFrame: ",photoImageView.frame)
		print("Imagesize: ",imageSize)
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
		setNeedsUpdateConstraints()
		photoScrollViewTopConstraint.constant 		= 0
		photoScrollViewBottomConstraint.constant 	= 0
		photoScrollViewLeadingConstraint.constant 	= 0
		photoScrollViewTrailingConstraint.constant 	= 0
		updateConstraints()
	}
	
	fileprivate func setLandscapeMode() {
		landscapeSideUp.isHidden 	= false
		landscapeSideDown.isHidden 	= false
		setNeedsUpdateConstraints()
		photoScrollViewTopConstraint.constant 		= orientationWidthHeight
		photoScrollViewBottomConstraint.constant 	= -orientationWidthHeight
		updateConstraints()
		photoScrollView.contentInset = UIEdgeInsets(top: orientationWidthHeight, left: 0, bottom: -orientationWidthHeight, right: 0)
	}
	
	fileprivate func setPortraitMode() {
		portraitSideRight.isHidden 	= false
		portraitSideLeft.isHidden 	= false
		setNeedsUpdateConstraints()
		photoScrollViewLeadingConstraint.constant 	= orientationWidthHeight
		photoScrollViewTrailingConstraint.constant 	= -orientationWidthHeight
		updateConstraints()
		photoScrollView.contentInset = UIEdgeInsets(top: 0, left: orientationWidthHeight, bottom: 0, right: -orientationWidthHeight)
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		updateMinZoomScaleForSize(frame.size)
	}
	
	fileprivate func updateMinZoomScaleForSize(_ size: CGSize) {
		let widthScale = size.width / photoImageViewWidthConstraint.constant//imageSize.width
		let heightScale = size.height / photoImageViewHeightConstraint.constant//imageSize.height
		let minScale = min(widthScale, heightScale)
		let maxScale = max(widthScale, heightScale)
		
		photoScrollView.minimumZoomScale = 1
		photoScrollView.maximumZoomScale = maxScale * 2.5
		
		switch currentOrientation {
		case .landscape:
			photoScrollView.zoomScale = 1
		case .portrait:
			photoScrollView.zoomScale = 1
		default:
			photoScrollView.minimumZoomScale = maxScale
			photoScrollView.zoomScale = 1
		}
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
