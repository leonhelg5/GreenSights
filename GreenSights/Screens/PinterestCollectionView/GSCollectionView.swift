//
//  GSCollectionView.swift
//  GreenSights
//
//  Created by Leon Helg on 17.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit

enum cellType {
	case square
	case portrait
	case landscape
}

enum cellSize {
	case bigSquare
	case smallSquare
	case portrait
	case landscape
}

struct Datasource {
	var titel: String
	var subtitle: String
	var type: cellType
	var size: cellSize?
}

class GSCollectionView: UIView {
	
	let square  = Datasource(titel: "Square", subtitle: "Subtitle", type: .square, size: nil)
	let port    = Datasource(titel: "Portrait", subtitle: "subtitle", type: .portrait, size: .portrait)
	let land    = Datasource(titel: "landscape", subtitle: "subt", type: .landscape, size: .landscape)
	var dataSource = [Datasource]()
	
	var addedElements       = [Datasource]()
	var remainingElements   = [Datasource]()
	var lastItem:             Datasource?
	var secondLastItem:       Datasource?
	var thirdLastItem:        Datasource?
	
	
	var lastClickedCell				= GSPinterestCell()
	var copyOfSelectedView 			= UIImageView()
	var frameOfSelectedView			= CGRect()
	var copyOfSelectedViewMidX 		= NSLayoutConstraint()
	var copyOfSelectedViewMidY 		= NSLayoutConstraint()
	var copyOfSelectedViewHeight 	= NSLayoutConstraint()
	var copyOfSelectedViewWidth 	= NSLayoutConstraint()
	var blackView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.black.withAlphaComponent(1)
		return view
	}()
	
	let collectionViewLayout = GSCollectionViewLayout()
	lazy var collectionView: UICollectionView = {
		let collectionview = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
		collectionview.showsHorizontalScrollIndicator   = false
		collectionview.backgroundColor                  = .white
		collectionview.bounces                          = true
		collectionview.allowsSelection                  = true
		collectionview.delegate                         = self
		collectionview.dataSource                       = self
		collectionview.register(GSPinterestCell.self, forCellWithReuseIdentifier: GSPinterestCell.reuseIdentifier)
		return collectionview
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = .white
		dataSource = [square, square, port, square, land, square, port, land, square, square, port, land, square, square, land, land]
	}
	
	func parentVCDidAppear() {
		setupSubviews()
		setupConstraints()
		filterNextElementsOfDataSource(15)
	}
	
	func setupSubviews() {
		let gestureRec = UITapGestureRecognizer(target: self, action: #selector(putCellBackToOrigin))
		addSubview(collectionView)
		collectionViewLayout.delegate = self
		addSubview(blackView)
		blackView.addGestureRecognizer(gestureRec)
		blackView.alpha = 0
		blackView.isHidden = true
		addSubview(copyOfSelectedView)
		copyOfSelectedView.isHidden = true
	}
	
	func setupConstraints() {
		collectionView.fillSuperview(onlySafeArea: true)
		collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
		blackView.fillSuperview(onlySafeArea: true)
		copyOfSelectedView.translatesAutoresizingMaskIntoConstraints = false
		copyOfSelectedViewMidX = copyOfSelectedView.centerXAnchor.constraint(equalTo: centerXAnchor)
		copyOfSelectedViewMidY = copyOfSelectedView.centerYAnchor.constraint(equalTo: centerYAnchor)
	}
	
	func centerSelectedCell(screenshot: UIImage, frame: CGRect, size: cellSize) {
		copyOfSelectedView.image 	= screenshot
		copyOfSelectedView.frame 	= frameOfSelectedView
		copyOfSelectedView.isHidden = false
		
		//If its a big square or landscape it sould not do increase the size.
		switch size {
		case .bigSquare:
			copyOfSelectedViewWidth 	= copyOfSelectedView.widthAnchor.constraint(equalToConstant: frame.width)
			copyOfSelectedViewHeight 	= copyOfSelectedView.heightAnchor.constraint(equalToConstant: frame.height)
		case .landscape:
			copyOfSelectedViewWidth 	= copyOfSelectedView.widthAnchor.constraint(equalToConstant: frame.width)
			copyOfSelectedViewHeight 	= copyOfSelectedView.heightAnchor.constraint(equalToConstant: frame.height)
		case .portrait:
			copyOfSelectedViewWidth 	= copyOfSelectedView.widthAnchor.constraint(equalToConstant: frame.width * 1.5)
			copyOfSelectedViewHeight 	= copyOfSelectedView.heightAnchor.constraint(equalToConstant: frame.height * 1.5)
		case .smallSquare:
			copyOfSelectedViewWidth 	= copyOfSelectedView.widthAnchor.constraint(equalToConstant: frame.width * 2 + collectionViewLayout.cellPadding * 2)
			copyOfSelectedViewHeight 	= copyOfSelectedView.heightAnchor.constraint(equalToConstant: frame.height * 2 + collectionViewLayout.cellPadding * 2)
		}

		copyOfSelectedViewWidth.isActive 	= true
		copyOfSelectedViewHeight.isActive 	= true
		copyOfSelectedViewMidX.isActive 	= true
		copyOfSelectedViewMidY.isActive 	= true
		self.blackView.isHidden = false
		UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: { [weak self] in
			guard let self = self else { return }
			self.layoutIfNeeded()
			self.blackView.alpha = 0.7

		}) { (completed) in
			//TODO
		}
		
		UIView.transition(with: copyOfSelectedView, duration: 0.5, options: [.transitionFlipFromRight, .showHideTransitionViews], animations: {
			
		}) { (completed) in
			
		}
	}
	
	@objc func putCellBackToOrigin() {
		copyOfSelectedViewMidX.isActive 	= false
		copyOfSelectedViewMidY.isActive 	= false
		copyOfSelectedViewWidth.isActive 	= false
		copyOfSelectedViewHeight.isActive 	= false
		
		UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
			self.layoutIfNeeded()
			self.blackView.alpha = 0.0
			self.copyOfSelectedView.frame = self.frameOfSelectedView
		}) { (completed) in
			self.blackView.isHidden = true
			self.lastClickedCell.isHidden = false
			self.copyOfSelectedView.isHidden = true
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension GSCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return addedElements.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GSPinterestCell.reuseIdentifier, for: indexPath) as! GSPinterestCell
		cell.configure(dataSource: addedElements[indexPath.row])
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		guard let cell = collectionView.cellForItem(at: indexPath) as? GSPinterestCell else { return }
		guard let cellsView = cell.screenshotMyself() else { return }
		guard let size = cell.data?.size else { return }
		
		let theAttributes:UICollectionViewLayoutAttributes! = collectionView.layoutAttributesForItem(at: indexPath)
		let translatedFrame = collectionView.convert(theAttributes.frame, to: collectionView.superview)
		frameOfSelectedView = translatedFrame
		lastClickedCell = cell
		lastClickedCell.isHidden = true
		centerSelectedCell(screenshot: cellsView, frame: translatedFrame, size: size)
	}
}

extension GSCollectionView: GSCollectionViewLayoutDelegate {
	func somethingWentWrong() {
		print("SOMETHING WENT WRONG")
		resetLayout()
	}
	
	func collectionView(_ collectionView: UICollectionView, sizeForCellAtIndexPath indexPath: IndexPath) -> cellSize {
		return addedElements[indexPath.row].size ?? .smallSquare
	}
}
