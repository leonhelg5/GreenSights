//
//  GSSegmentedController.swift
//  GreenSights
//
//  Created by Leon Helg on 05.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit

protocol segmentDelegate: class {
	func segmentSelected(previous: Int, future: Int)
}

class GSSegmentController: UIView {
	weak var delegate: segmentDelegate?
	
	//MARK: - Variables & Properties
	let myBackColor = UIColor.white//GSSettings.UI.Colors.elementBackgroundColor
	let myTintColor = GSSettings.UI.Colors.tintColor
	
	var selectedSegment = 0
	var screenWidth:CGFloat = 0
	var sectionWidth: CGFloat = 0
	var numberOfSections: CGFloat = 0
	
	//MARK: - GUI Objects
	let segStackView: UIStackView = {
		let stackview = UIStackView()
		stackview.axis = .horizontal
		stackview.spacing = 0
		stackview.alignment = .leading
		stackview.distribution = .fillEqually
		return stackview
	}()
	
	let separatorView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.darkGray
		return view
	}()
	
	var selectionViewLeftConstraint = NSLayoutConstraint()
	lazy var selectionView: UIView = {
		let view = UIView()
		view.backgroundColor = myTintColor
		return view
	}()
	
	var segmentsString: [String]!
	var buttons = [segStackViewButton]()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		screenWidth = UIScreen.main.bounds.width
		sectionWidth = screenWidth
		self.backgroundColor = myBackColor
	}
	
	convenience init(segments: [String]) {
		self.init()
		self.segmentsString = segments
		setupSubViews()
		setupSegments()
		setupSelectionView()
	}
	
	func setupSubViews() {
		addSubview(separatorView)
		separatorView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0, width: 0, height: 1)
		
		addSubview(segStackView)
		segStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, paddingTop: 5, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0, width: 0, height: 30)
	}
	
	func setupSegments() {
		for (index, segment) in segmentsString.enumerated() {
			let button = segStackViewButton(labelText: segment, segment: index)
			button.addTarget(self, action: #selector(segTapped(sender:)), for: .touchUpInside)
			segStackView.addArrangedSubview(button)
			buttons.append(button)
		}
		setupScreenSize()
	}
	
	func setupSelectionView() {
		addSubview(selectionView)
		selectionView.widthAnchor.constraint(equalTo: segStackView.widthAnchor, multiplier: 1/numberOfSections).isActive = true
		selectionViewLeftConstraint = selectionView.leadingAnchor.constraint(equalTo: segStackView.leadingAnchor)
		selectionViewLeftConstraint.isActive = true
		selectionView.anchor(top: nil, leading: nil, bottom: separatorView.topAnchor, trailing: nil, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0, width: 0, height: 8)
		
	}
	
	func setupScreenSize() {
		self.numberOfSections = CGFloat(buttons.count)
		self.screenWidth = self.frame.width
		self.sectionWidth = screenWidth / numberOfSections
	}
	
	/**
	Animate the segment and tell the delegate it can switch views.
	*/
	@objc func segTapped(sender: segStackViewButton) {
		setupScreenSize()
		let futureSegment = sender.segmentID
		let constant = CGFloat(futureSegment) * (self.screenWidth / self.numberOfSections)
		self.selectionViewLeftConstraint.constant = constant
		delegate?.segmentSelected(previous: selectedSegment, future: futureSegment)
		UIView.animate(withDuration: GSSettings.UI.Animations.mySwipeDuration, delay: 0, options: .curveEaseOut, animations: {
			self.layoutIfNeeded()
		})
		selectedSegment = futureSegment
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

class segStackViewButton: UIButton {
	var segmentID = 0
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	convenience init(labelText: String, segment: Int) {
		self.init(type: .custom)
		self.segmentID = segment
		self.backgroundColor = UIColor.white
		self.setTitle(labelText, for: .normal)
		self.setTitleColor(GSSettings.UI.Colors.regularTextColor, for: .normal)
		self.titleLabel?.font = GSSettings.UI.Fonts.helveticaLight?.withSize(22)
		self.titleLabel?.textAlignment = .center
		self.tintColor = UIColor.black
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

