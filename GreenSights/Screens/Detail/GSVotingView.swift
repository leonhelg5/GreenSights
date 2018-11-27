//
//  GSVotingView.swift
//  GreenSights
//
//  Created by Leon Helg on 01.11.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit

protocol GSVotingViewDelegate: class {
	func dismissVotingView()
}

class GSVotingView: UIView {
	let contentView = UIView()
	var delegate: GSVotingViewDelegate?
	let title = "Test"
	let optionText = ["Very Bad", "Bad", "Okay", "Nice", "Very Nice"]
	let widthOfObjects: CGFloat = 50
	
	let blurryBackGround: UIVisualEffectView = {
		let effectView = UIVisualEffectView()
		effectView.effect = UIBlurEffect(style: .regular)
		return effectView
	}()
	
	let pointsContainerView: UIView = {
		let view = UIView()
		//stackView.backgroundColor = UIColor.red.withAlphaComponent(0.5)
		return view
	}()
	
	var optionsBackViewHeightConstraint = NSLayoutConstraint()
	let optionsBackView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(named: GSSettings.ui.otherIcons.roundedBG)
		return imageView
	}()
	
	let dismissButton: UIButton = {
		let button = UIButton()
		button.backgroundColor = .clear
		button.imageView?.image = UIImage(named: GSSettings.ui.otherIcons.dismissIcon)
		button.setImage(UIImage(named: GSSettings.ui.otherIcons.dismissIcon)?.withRenderingMode(.alwaysOriginal), for: .normal)
		button.imageView?.contentMode = .scaleAspectFit
		return button
	}()
	
	let labelContainerView : UIView = {
		let view = UIView()
		view.clipsToBounds = true
		return view
	}()
	
	
	var optionPoints = [GSVotingOptionBulletPoint(), GSVotingOptionBulletPoint(), GSVotingOptionBulletPoint(), GSVotingOptionBulletPoint(), GSVotingOptionBulletPoint()]
	let optionLabels = [GSVotingOptionLabel(), GSVotingOptionLabel(), GSVotingOptionLabel(), GSVotingOptionLabel(), GSVotingOptionLabel()]
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupSubviews()
		setupConstraints()
		populateLabels()
	}
	
	func viewDidAppear() {
		startShowAnimation()
	}
	
	func setupSubviews() {
		addSubview(blurryBackGround)
		addSubview(optionsBackView)
		addSubview(pointsContainerView)
		pointsContainerView.layer.cornerRadius = widthOfObjects / 2
		addSubview(labelContainerView)
		addSubview(dismissButton)
		dismissButton.addTarget(self, action: #selector(handleDismissAction), for: .touchUpInside)
		dismissButton.alpha = 0
		
		for index in 0..<optionPoints.count {
			let point = optionPoints[index]
			pointsContainerView.addSubview(point)
			point.alpha = 0
			
			let label = optionLabels[index]
			labelContainerView.addSubview(label)
			label.alpha = 0
		}
	}
	
	
	func setupConstraints() {
		blurryBackGround.fillSuperview(onlySafeArea: false)
		pointsContainerView.anchor(top: nil, leading: nil, bottom: nil, trailing: trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 8, width: widthOfObjects, height: 270)
		pointsContainerView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -100).isActive = true
		labelContainerView.anchor(top: pointsContainerView.topAnchor, leading: leadingAnchor, bottom: pointsContainerView.bottomAnchor, trailing: pointsContainerView.leadingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0, width: 0, height: 0)
		

		dismissButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
		dismissButton.anchor(top: pointsContainerView.bottomAnchor, leading: pointsContainerView.leadingAnchor, bottom: nil, trailing: pointsContainerView.trailingAnchor, paddingTop: 20, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0, width: 0, height: widthOfObjects)
		
		for index in 0..<optionPoints.count {
			let point = optionPoints[index]
			let bottomPadding:CGFloat = CGFloat(index) * 50 + 10
			point.anchor(top: nil, leading: nil, bottom: pointsContainerView.bottomAnchor, trailing: pointsContainerView.trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: bottomPadding, paddingTrailing: 0, width: widthOfObjects, height: widthOfObjects)
			
			let label = optionLabels[index]
			label.translatesAutoresizingMaskIntoConstraints = false
			label.anchor(top: nil, leading: nil, bottom: labelContainerView.bottomAnchor, trailing: pointsContainerView.trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: bottomPadding+17, paddingTrailing: -100, width: 0, height: 0)
		}
		
		optionsBackView.anchor(top: nil, leading: nil, bottom: pointsContainerView.bottomAnchor, trailing: pointsContainerView.trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0, width: widthOfObjects, height: 0)
		optionsBackViewHeightConstraint = optionsBackView.heightAnchor.constraint(equalToConstant: 0)
		optionsBackViewHeightConstraint.isActive = true
	}
	
	func populateLabels() {
		for (index, label) in optionLabels.enumerated() {
			label.text = optionText[index]
		}
	}
	
	func startShowAnimation() {
		let duration = 0.075
		
		//Points
		for (index, point) in optionPoints.enumerated() {
			UIView.animate(withDuration: duration, delay: duration*Double(index) + duration, options: .curveEaseOut, animations: {
				point.alpha = 1
				self.optionLabels[index].alpha = 0.75
			})
		}
		//Labels
		for (index, label) in optionLabels.enumerated() {
			let translation = label.transform.translatedBy(x: -200, y: 0)
			UIView.animate(withDuration: duration*2, delay: duration*Double(index) + duration, options: .curveEaseOut, animations: {
				label.alpha = 1
				label.transform = translation
			})
		}
		//Background
		self.optionsBackViewHeightConstraint.constant = pointsContainerView.frame.height
//		UIView.animate(withDuration: duration * Double(optionPoints.count), delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//			self.layoutSubviews()
//		})
		UIView.animate(withDuration: duration * Double(optionPoints.count), delay: 0, options: .curveEaseOut, animations: {
			self.layoutSubviews()
		})
		//Cancel Button
		UIView.animate(withDuration: duration * Double(optionPoints.count), delay: 0, options: [], animations: {
			self.dismissButton.alpha = 1
		})
	}
	
	@objc func handleDismissAction() {
		let duration = 0.075
		
		//Points
		for index in 0..<optionPoints.count {
			let point = optionPoints[(optionPoints.count - 1) - index]
			UIView.animate(withDuration: duration, delay: duration*Double(index + 1), options: .curveEaseOut, animations: {
				point.alpha = 0
			})
		}
		for index in 0..<optionLabels.count {
			let label = optionLabels[(optionLabels.count - 1) - index]
			let translation = label.transform.translatedBy(x: 200, y: 0)
			UIView.animate(withDuration: duration*2, delay: duration*Double(index), options: .curveEaseOut, animations: {
				label.alpha = 0.75
				label.transform = translation
			})
		}
		//Background & Cancel Button
		self.optionsBackViewHeightConstraint.constant = 0
		let rotate = CGAffineTransform(rotationAngle: 360)
		UIView.animate(withDuration: duration * Double(optionPoints.count), delay: 0.2, options: .curveEaseOut, animations: {
			self.layoutSubviews()
			self.dismissButton.transform = rotate
			self.dismissButton.alpha = 0.9
		}) { (_) in
			self.dismissButton.alpha = 0
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
				self.delegate?.dismissVotingView()
			}
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

class GSVotingOptionBulletPoint: UIView {
	
	let point: UIView = {
		let view = UIView()
		view.backgroundColor = .gray
		return view
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupSubviews()
		setupConstraints()
	}
	
	func setupSubviews() {
		addSubview(point)
	}
	
	func setupConstraints() {
		point.fixHeightAndWidth(width: 10, height: 10)
		point.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
		point.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		point.layer.cornerRadius = 5
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

class GSVotingOptionLabel: UILabel {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.textAlignment = .right
		self.font = GSSettings.ui.fonts.helveticaMedium?.withSize(16)
		self.textColor = .gray
		self.text = "Ich bin ein Text"
		self.sizeToFit()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
