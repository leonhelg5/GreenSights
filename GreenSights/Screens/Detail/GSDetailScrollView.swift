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
	var containerViewHeightConstraint = NSLayoutConstraint()
	let containerView = UIView()
	
	let titleLabel: UILabel = {
		let label       = UILabel()
		label.font      = GSSettings.ui.fonts.helveticaRegular?.withSize(28)
		label.text      = "Linde"
		label.textColor = GSSettings.ui.colors.regularTextColor
		return label
	}()
	
	let locationLabel: UILabel = {
		let label           = UILabel()
		label.font          = GSSettings.ui.fonts.helveticaRegular?.withSize(16)
		label.text          = "Obholz Frauenfeld"
		label.textColor     = GSSettings.ui.colors.tintColor
		label.numberOfLines = 2
		label.lineBreakMode = .byWordWrapping
		label.isUserInteractionEnabled = true
		return label
	}()
	
	let subtitleLabel: UILabel = {
		let label       = UILabel()
		label.font      = GSSettings.ui.fonts.helveticaRegular?.withSize(18)
		label.text      = "Traumhafte Aussicht - riesen Bänkli"
		label.textColor = GSSettings.ui.colors.midGray
		label.numberOfLines = 2
		return label
	}()
	
	//TODO: size or type for this buton with mySize
	let addFriendView: GSInviteAFriendView = {
		let view = GSInviteAFriendView()
		view.radius = 50
		return view
	}()
	
	let mapView: UIImageView = {
		// TODO: change name to more specific type (ImageView if is UIImageView, )
		let view                = UIImageView()
		view.clipsToBounds      = true
		view.layer.cornerRadius = GSSettings.ui.sizes.cornerRadius
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
		imageview.layer.cornerRadius = GSSettings.ui.sizes.cornerRadius
		imageview.contentMode = .scaleAspectFill
		imageview.clipsToBounds = true
		return imageview
	}()
	
	var detailsTableViewHeightConstraint = NSLayoutConstraint()
	let detailsTableView = GSTwoDetailTableView()
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
		containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: 2000)
		containerViewHeightConstraint.isActive = true
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
		detailsTableViewHeightConstraint = detailsTableView.heightAnchor.constraint(equalToConstant: calcHeightOfDetailTableView())
		detailsTableViewHeightConstraint.isActive = true
	}
	
	func setupContstraints() {
		titleLabel.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, paddingTop: GSSettings.ui.sizes.sidePadding, paddingLeading: GSSettings.ui.sizes.sidePadding, paddingBottom: 0, paddingTrailing: GSSettings.ui.sizes.sidePadding, width: 0, height: 0)
		
		locationLabel.anchor(top: titleLabel.bottomAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: addFriendView.leadingAnchor, paddingTop: 0, paddingLeading: GSSettings.ui.sizes.sidePadding, paddingBottom: 0, paddingTrailing: GSSettings.ui.sizes.sidePadding, width: 0, height: 0)
		
		subtitleLabel.anchor(top: locationLabel.bottomAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, paddingTop: 20, paddingLeading: GSSettings.ui.sizes.sidePadding, paddingBottom: 0, paddingTrailing: GSSettings.ui.sizes.sidePadding, width: 0, height: 0)
		
		addFriendView.anchor(top: titleLabel.topAnchor, leading: nil, bottom: nil, trailing: containerView.trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: GSSettings.ui.sizes.sidePadding, width: GSSettings.ui.sizes.addFriendButtonSize, height: GSSettings.ui.sizes.addFriendButtonSize)
		
		thumbnailImageView.anchor(top: subtitleLabel.bottomAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, paddingTop: 10, paddingLeading: GSSettings.ui.sizes.sidePadding, paddingBottom: 0, paddingTrailing: GSSettings.ui.sizes.sidePadding, width: 0, height: 0)
		thumbnailImageView.heightAnchor.constraint(equalTo: thumbnailImageView.widthAnchor, multiplier: 9/16).isActive = true
		
		detailsTableView.anchor(top: thumbnailImageView.bottomAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, paddingTop: 16, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0, width: 0, height: 0)

		fotosCollectionView.anchor(top: detailsTableView.bottomAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, paddingTop: 20, paddingLeading: GSSettings.ui.sizes.sidePadding, paddingBottom: 0, paddingTrailing: GSSettings.ui.sizes.sidePadding, width: 0, height: 300)
		
		mapView.anchor(top: fotosCollectionView.bottomAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, paddingTop: 50, paddingLeading: GSSettings.ui.sizes.sidePadding, paddingBottom: GSSettings.ui.sizes.sidePadding, paddingTrailing: GSSettings.ui.sizes.sidePadding, width: 0, height: 80)
		
		mapActivityIndicatorView.centerXAnchor.constraint(equalTo: mapView.centerXAnchor).isActive = true
		mapActivityIndicatorView.centerYAnchor.constraint(equalTo: mapView.centerYAnchor).isActive = true
		mapActivityIndicatorView.fixHeightAndWidth(width: 60, height: 60)
	}
	
	@objc func updateHeightOfDetailTableView() {
		detailsTableViewHeightConstraint.constant = calcHeightOfDetailTableView()
		UIView.animate(withDuration:0.4, animations: { [weak self] in
			guard let self = self else { return }
			self.layoutIfNeeded()
		}) { (result: Bool) in
			if self.detailsTableView.currentNumberOfRows == self.detailsTableView.numberOfRowsWhenUnexpanded {
				self.detailsTableView.deleteRows()
			}
		}
		delegateDV?.viewDidLayoutSubviews()
	}
	
	func calcHeightOfDetailTableView() -> CGFloat {
		return detailsTableView.headerHeight + detailsTableView.footerHeight + CGFloat(detailsTableView.currentNumberOfRows) * detailsTableView.rowHeight
	}
	
	func showVotingView() {
		if let keyWindow = UIApplication.shared.keyWindow {
			let votingView = GSVotingView()
			votingView.tag = 42
			keyWindow.rootViewController?.view.addSubview(votingView) //tabbarcontroller
			votingView.delegate = self
			votingView.frame = keyWindow.frame
			votingView.alpha = 0
			UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
				votingView.frame = keyWindow.frame
				votingView.alpha = 1
			}, completion: { (completedAnimation) in
				UIApplication.shared.setStatusBarHidden(true, with: .fade)
				keyWindow.bringSubviewToFront(votingView)
			})
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
				votingView.viewDidAppear()
			}
		}
	}
	
	func hideVotingView() {
		if let keyWindow = UIApplication.shared.keyWindow {
			let votingView = keyWindow.rootViewController?.view.viewWithTag(42)
			UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
				votingView?.alpha = 0
			}, completion: { (completedAnimation) in
				votingView?.removeFromSuperview()
			})
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension GSDetailScrollView: altDetailsTableViewDelegate {
	func detailRowPressed(index: Int) {
		showVotingView()
	}
	
	func needsToUpdateDetailsTableViewHeight() {
		updateHeightOfDetailTableView()
	}
}

extension GSDetailScrollView: GSVotingViewDelegate {
	func dismissVotingView() {
		hideVotingView()
	}
	
	
}
