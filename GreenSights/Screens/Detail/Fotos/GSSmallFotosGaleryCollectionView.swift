//
//  GSFotosView.swift
//  GreenSights
//
//  Created by Leon Helg on 09.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit

protocol GSFotosViewDelegate: Any {
	func viewDidLayoutSubviews()
}

class GSSmallFotosGaleryCollectionView: UIView, UICollectionViewDelegateFlowLayout {
	var delegateFV: GSFotosViewDelegate?
	
	let paddingBetweenLabelAndCV: CGFloat = 4
	
	let fotosLabel: UILabel = {
		let label       = UILabel()
		label.font      = GSSettings.UI.Fonts.helveticaRegular?.withSize(20)
		label.text      = "Fotos:"
		label.textColor = GSSettings.UI.Colors.regularTextColor
		label.numberOfLines = 1
		return label
	}()
	
	let showAllOrHideButton = GSShowAllOrHideButton()
	
	lazy var collectionView: UICollectionView = {
		let collectionview = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
		collectionview.showsHorizontalScrollIndicator   = false
		collectionview.backgroundColor                  = GSSettings.UI.Colors.backgroundWhite
		collectionview.bounces                          = true
		collectionview.allowsSelection                  = false
		collectionview.delegate                         = self
		collectionview.dataSource                       = self
		collectionview.register(GSFotoCell.self, forCellWithReuseIdentifier: GSFotoCell.reuseIdentifier)
		collectionview.register(GSAddCell.self, forCellWithReuseIdentifier: GSAddCell.reuseIdentifier)
		return collectionview
	}()
	
	var flowLayout: UICollectionViewFlowLayout = {
		let layout = UICollectionViewFlowLayout()
		layout.minimumInteritemSpacing = 8
		layout.minimumLineSpacing = 8
		layout.itemSize = CGSize(width: 100, height: 100)
		layout.scrollDirection = .horizontal
		layout.sectionInset = .zero
		return layout
	}()
	
	//MARK: -
	//MARK: - Init & View Loading
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupSubviews()
		setupContstraints()
	}
	
	//MARK: - Setup
	func setupSubviews() {
		addSubview(fotosLabel)
		addSubview(showAllOrHideButton)
		addSubview(collectionView)
		fotosLabel.underline()
		showAllOrHideButton.addTarget(self, action: #selector(handleShowAll), for: .touchUpInside)
	}
	
	func setupContstraints() {
		fotosLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0, width: 0, height: 0)
		showAllOrHideButton.anchor(top: nil, leading: nil, bottom: fotosLabel.bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0, width: 0, height: 0)
		showAllOrHideButton.heightAnchor.constraint(equalTo: fotosLabel.heightAnchor).isActive = true
		
		collectionView.anchor(top: fotosLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, paddingTop: paddingBetweenLabelAndCV, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0, width: 0, height: 208)
		
		delegateFV?.viewDidLayoutSubviews()
	}
	
	@objc func handleShowAll() {
		showAllOrHideButton.isSelected.toggle()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}


extension GSSmallFotosGaleryCollectionView: UICollectionViewDelegate {
	
}

extension GSSmallFotosGaleryCollectionView: UICollectionViewDataSource {
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 2 //TODO: 2 sections: one for existing fotos, one for new fotos /maybe one for thumbnail
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if section == 0 {
			return 8
		}
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		//Fotos
		if indexPath.section == 0 {
			let cell: UICollectionViewCell = {
				if let customCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: GSFotoCell.reuseIdentifier, for: indexPath) as? GSFotoCell {
					//config
					return customCell
				}
				
				return self.collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
			}()
			return cell
		} else {
			
			//Add Foto
			let cell: UICollectionViewCell = {
				if let customCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: GSAddCell.reuseIdentifier, for: indexPath) as? GSAddCell {
					//config
					return customCell
				}
				
				return self.collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
			}()
			return cell
		}
	}
}
