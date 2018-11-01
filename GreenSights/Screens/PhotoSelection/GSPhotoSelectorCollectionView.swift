//
//  AddThumbnailCollectionView.swift
//  GreenSights
//
//  Created by Leon Helg on 12.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit
import Photos

class GSPhotoSelectorCollectionView: UIView {
	
	var screenWidth = UIScreen.main.bounds.width
	var itemSize = CGSize()
	var numberOfItemsPerRow: CGFloat = 4
	var aspectRatio = GSSettings.ui.sizes.aspectRatio
	
	var selectedImage: UIImage?
	var images = [UIImage]()
	var assets = [PHAsset]()
	
	var header: GSPhotoSelectorHeader?
	
	lazy var collectionView: UICollectionView = {
		let collectionview = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
		collectionview.backgroundColor = GSSettings.ui.colors.backgroundWhite
		collectionview.delegate = self
		collectionview.dataSource = self
		collectionview.register(GSPhotoSelectorCell.self, forCellWithReuseIdentifier: GSPhotoSelectorCell.reuseIdentifier)
		collectionview.register(GSPhotoSelectorHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: GSPhotoSelectorHeader.reuseIdentifier)
		return collectionview
	}()
	
	lazy var flowLayout: UICollectionViewFlowLayout = {
		let layout = UICollectionViewFlowLayout()
		layout.minimumInteritemSpacing = 1
		layout.minimumLineSpacing = 1
		layout.sectionInset = UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0) //space between header and cells
		return layout
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = GSSettings.ui.colors.backgroundWhite
	}
	
	func parentVCDidAppear() {
		images.removeAll()
		assets.removeAll()
		setupDynamicLayout()
		setupSubview()
		setupConstraints()
		fetchAllPhotos()
	}
	
	func setupDynamicLayout() {
		screenWidth = self.frame.width
		let itemWidth = (screenWidth - flowLayout.minimumInteritemSpacing * (numberOfItemsPerRow - 1)) / numberOfItemsPerRow
		itemSize = CGSize(width: itemWidth, height: itemWidth)
	}
	
	func setupSubview() {
		self.addSubview(self.collectionView)
	}
	
	func setupConstraints() {
		self.collectionView.fillSuperview(onlySafeArea: true)
	}
	
	fileprivate func getAssetsFetchOptions() -> PHFetchOptions {
		let fetchOptions = PHFetchOptions()
		fetchOptions.fetchLimit = 30
		fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
		return fetchOptions
	}
	
	/**
	fetches All photos from the users device to show them as a small preview
	*/
	fileprivate func fetchAllPhotos() {
		let allPhotos = PHAsset.fetchAssets(with: .image, options: getAssetsFetchOptions())
		
		DispatchQueue.global(qos: .background).async { [weak self] in
			guard let self = self else { return }
			allPhotos.enumerateObjects({ [weak self] (asset, count, stop) in
				guard let self = self else { return }
				let imageManager = PHImageManager.default()
				let options = PHImageRequestOptions()
				options.isSynchronous = true
				imageManager.requestImage(for: asset, targetSize: self.itemSize, contentMode: .aspectFit, options: options, resultHandler: { [weak self] (image, info) in
					guard let self = self else { return }
					if let image = image {
						self.images.append(image)
						self.assets.append(asset)
						if self.selectedImage == nil {
							self.selectedImage = image
						}
					}
					if count == allPhotos.count - 1 {
						self.reloadCollectionView()
					}
				})
			})
		}
	}
	
	func reloadCollectionView() {
		print("will reload now")
		let width = (screenWidth - flowLayout.minimumInteritemSpacing * (numberOfItemsPerRow - 1)) / numberOfItemsPerRow
		flowLayout.itemSize = CGSize(width: width, height: width)
		flowLayout.headerReferenceSize = CGSize(width: screenWidth, height: screenWidth)
		DispatchQueue.main.async {
			self.collectionView.reloadData()
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension GSPhotoSelectorCollectionView: UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return images.count
	}
	
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: GSPhotoSelectorHeader.reuseIdentifier, for: indexPath) as! GSPhotoSelectorHeader
		header.photoImageView.image = selectedImage
		if let selectedImage = selectedImage {
			if let index = self.images.index(of: selectedImage) {
				let selectedAsset = self.assets[index]
				let imageManager = PHImageManager.default()
				let targetSize = CGSize(width: self.screenWidth, height: self.screenWidth)
				print(targetSize)
				imageManager.requestImage(for: selectedAsset, targetSize: targetSize, contentMode: .default, options: nil) { (image, info) in
					header.photoImageView.image = image
					self.selectedImage = image
					if let size = image?.size {
						header.imageSize = size
					}
				}
			}
		}
		self.header = header
		return header
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GSPhotoSelectorCell.reuseIdentifier, for: indexPath) as! GSPhotoSelectorCell
		cell.photoImageView.image = images[indexPath.item]
		return cell
	}
}

extension GSPhotoSelectorCollectionView: UICollectionViewDelegate {
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		self.selectedImage = images[indexPath.item]
		self.collectionView.reloadData()
		
		let indexPath = IndexPath(item: 0, section: 0)
		collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
	}
}
