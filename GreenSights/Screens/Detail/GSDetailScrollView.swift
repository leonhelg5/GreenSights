//
//  GSDetailScrollView.swift
//  GreenSights
//
//  Created by Leon Helg on 09.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit

protocol GSDetailScrollViewDelegate: class {
	func viewDidLayoutSubviews()
}

class GSDetailScrollView: UIScrollView {
	//MARK: - Properties & Variables
	weak var delegateDV: GSDetailScrollViewDelegate?
	
	//MARK: - GUI Objects
	var heightOfContent = NSLayoutConstraint()
	let containerView = UIView()
	
	let titleLabel: UILabel = {
		let label       = UILabel()
		label.font      = GSSettings.UI.Fonts.helveticaRegular?.withSize(28)
		label.text      = "Linde"
		label.textColor = GSSettings.UI.Colors.regularTextColor
		return label
	}()
	
	let locationLabel: UILabel = {
		let label           = UILabel()
		label.font          = GSSettings.UI.Fonts.helveticaRegular?.withSize(16)
		label.text          = "Obholz Frauenfeld"
		label.textColor     = GSSettings.UI.Colors.tintColor
		label.numberOfLines = 2
		label.lineBreakMode = .byWordWrapping
		label.isUserInteractionEnabled = true
		return label
	}()
	
	let subtitleLabel: UILabel = {
		let label       = UILabel()
		label.font      = GSSettings.UI.Fonts.helveticaRegular?.withSize(18)
		label.text      = "Traumhafte Aussicht - riesen Bänkli"
		label.textColor = GSSettings.UI.Colors.midGray
		label.numberOfLines = 2
		return label
	}()
	
	let addFriendView: GSInviteAFriendView = {
		let view = GSInviteAFriendView()
		view.mySize = 50
		return view
	}()
	
	let mapView: UIImageView = {
		let view                = UIImageView()
		view.clipsToBounds      = true
		view.layer.cornerRadius = GSSettings.UI.Sizes.cornerRadius
		view.contentMode        = .scaleAspectFill
		view.backgroundColor    = UIColor.lightGray
		view.isUserInteractionEnabled = true
		return view
	}()
	let mapActivityIndicatorView: UIActivityIndicatorView = {
		let indicator = UIActivityIndicatorView()
		indicator.hidesWhenStopped = true
		indicator.color = UIColor.gray
		return indicator
	}()
	
	let thumbnailImageView: UIImageView = {
		let imageview = UIImageView()
		imageview.image = UIImage(named: "testbild")
		imageview.layer.cornerRadius = GSSettings.UI.Sizes.cornerRadius
		imageview.contentMode = .scaleAspectFill
		imageview.clipsToBounds = true
		return imageview
	}()
	
	var heightOfDetailsTableView = NSLayoutConstraint()
	let detailsTableView = GSAltDetailTableView()
	let fotosCollectionView = GSSmallFotosGaleryCollectionView()
	
	//MARK: -
	//MARK: - Init & View Loading
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	func parentVCWillAppear() {
		setupContainerView()
		setupSubviews()
		setupContstraints()
		mapActivityIndicatorView.startAnimating()
	}
	
	//MARK: - Setup
	func setupContainerView() {
		self.addSubview(containerView)
		heightOfContent = containerView.heightAnchor.constraint(equalToConstant: 2000)
		heightOfContent.isActive = true
		containerView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0, width: 0, height: 0)
		containerView.widthAnchor.constraint(equalTo: self.frameLayoutGuide.widthAnchor).isActive = true
	}
	
	func setupSubviews() {
		containerView.addSubview(titleLabel)
		containerView.addSubview(locationLabel)
		containerView.addSubview(subtitleLabel)
		containerView.addSubview(addFriendView)
		containerView.addSubview(thumbnailImageView)
		containerView.addSubview(detailsTableView)
		containerView.addSubview(fotosCollectionView)
		containerView.addSubview(mapView)
		containerView.addSubview(mapActivityIndicatorView)
		
		detailsTableView.delegate = self
		heightOfDetailsTableView = detailsTableView.heightAnchor.constraint(equalToConstant: calcHeightOfDetailTableView())
		heightOfDetailsTableView.isActive = true
	}
	
	func setupContstraints() {
		titleLabel.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, paddingTop: GSSettings.UI.Sizes.sidePadding, paddingLeading: GSSettings.UI.Sizes.sidePadding, paddingBottom: 0, paddingTrailing: GSSettings.UI.Sizes.sidePadding, width: 0, height: 0)
		
		locationLabel.anchor(top: titleLabel.bottomAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, paddingTop: 0, paddingLeading: GSSettings.UI.Sizes.sidePadding, paddingBottom: 0, paddingTrailing: GSSettings.UI.Sizes.sidePadding, width: 0, height: 0)
		//TODO maybe set width
		
		subtitleLabel.anchor(top: locationLabel.bottomAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, paddingTop: 20, paddingLeading: GSSettings.UI.Sizes.sidePadding, paddingBottom: 0, paddingTrailing: GSSettings.UI.Sizes.sidePadding, width: 0, height: 0)
		
		addFriendView.anchor(top: titleLabel.topAnchor, leading: nil, bottom: nil, trailing: containerView.trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: GSSettings.UI.Sizes.sidePadding, width: GSSettings.UI.Sizes.addFriendButtonSize, height: GSSettings.UI.Sizes.addFriendButtonSize)
		
		thumbnailImageView.anchor(top: subtitleLabel.bottomAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, paddingTop: 10, paddingLeading: GSSettings.UI.Sizes.sidePadding, paddingBottom: 0, paddingTrailing: GSSettings.UI.Sizes.sidePadding, width: 0, height: 0)
		thumbnailImageView.heightAnchor.constraint(equalTo: thumbnailImageView.widthAnchor, multiplier: 9/16).isActive = true
		
		detailsTableView.anchor(top: thumbnailImageView.bottomAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, paddingTop: 16, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0, width: 0, height: 0)

		fotosCollectionView.anchor(top: detailsTableView.bottomAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, paddingTop: 20, paddingLeading: GSSettings.UI.Sizes.sidePadding, paddingBottom: 0, paddingTrailing: GSSettings.UI.Sizes.sidePadding, width: 0, height: 300)
		
		mapView.anchor(top: fotosCollectionView.bottomAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, paddingTop: 50, paddingLeading: GSSettings.UI.Sizes.sidePadding, paddingBottom: GSSettings.UI.Sizes.sidePadding, paddingTrailing: GSSettings.UI.Sizes.sidePadding, width: 0, height: 80)
		
		mapActivityIndicatorView.centerXAnchor.constraint(equalTo: mapView.centerXAnchor).isActive = true
		mapActivityIndicatorView.centerYAnchor.constraint(equalTo: mapView.centerYAnchor).isActive = true
		mapActivityIndicatorView.fixHeightAndWidth(width: 60, height: 60)
	}
	
	@objc func updateHeightOfDetailTableView() {
		heightOfDetailsTableView.constant = calcHeightOfDetailTableView()
		UIView.animate(withDuration:0.4, animations: {
			self.layoutIfNeeded()
		}) { (result: Bool) in
			if self.detailsTableView.currentNumberOfRows == self.detailsTableView.numberOfRowsWhenUnexpanded {
				self.detailsTableView.deleteRows()
			}
		}
		delegateDV?.viewDidLayoutSubviews()
	}
	
	func calcHeightOfDetailTableView() -> CGFloat{
		return detailsTableView.headerHeight + detailsTableView.footerHeight + CGFloat(detailsTableView.currentNumberOfRows) * detailsTableView.rowHeight
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension GSDetailScrollView: altDetailsTableViewDelegate {
	func needsToUpdateDetailsTableViewHeight() {
		updateHeightOfDetailTableView()
	}
}
