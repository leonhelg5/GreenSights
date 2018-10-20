//
//  GSPinterestCekk.swift
//  GreenSights
//
//  Created by Leon Helg on 19.10.18.
//  Copyright © 2018 Leon Helg. All rights reserved.
//

import UIKit


class GSPinterestCell: UICollectionViewCell, ReusableView {
    
    var data: Datasource?
    
    let photoImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
        imageview.clipsToBounds = true
        return imageview
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
		label.font = GSSettings.ui.fonts.helveticaBold
        label.textAlignment = .center
		label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = GSSettings.ui.colors.backgroundWhite
        setupSubviews()
        setupContstraints()
        layer.cornerRadius = GSSettings.ui.sizes.cornerRadius
//        layer.borderColor = UIColor.white.cgColor
//        layer.borderWidth = 0
		
		//addGradient()
    }
    
    func setupSubviews() {
        addSubview(photoImageView)
        addSubview(titleLabel)
    }
    
    func setupContstraints() {
        photoImageView.fillSuperview(onlySafeArea: true)
        photoImageView.layer.cornerRadius = GSSettings.ui.sizes.cornerRadius
		titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, paddingTop: 8, paddingLeading: 8, paddingBottom: 0, paddingTrailing: 8, width: 0, height: 0)
    }
    
    func configure(dataSource: Datasource?) {
        guard let dataSource = dataSource else { return }
        data = dataSource
        guard let type = data?.type else { return }
		
        if type == .landscape {
            photoImageView.image = UIImage(named: "landscape")
        } else if type == .portrait {
            photoImageView.image = UIImage(named: "portrait")
        } else {
            photoImageView.image = UIImage(named: "square")
        }
		
		if let title = data?.titel {
			titleLabel.text = title
		}
		//titleLabel.text = "\(self.frame.width, self.frame.height)"
//		delay(bySeconds: 0.1) {
//			self.addGradient()
//		}
		
    }
	
	func addGradient() {
		let gradientLayer = CAGradientLayer()
		gradientLayer.colors = [UIColor.black.withAlphaComponent(0.3).cgColor, UIColor.black.withAlphaComponent(0).cgColor]
		gradientLayer.startPoint = CGPoint(x: 1, y: 0)
		gradientLayer.endPoint = CGPoint(x: 0, y: 1)
		gradientLayer.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 100)
		layer.addSublayer(gradientLayer)
		gradientLayer.cornerRadius = GSSettings.ui.sizes.cornerRadius
		bringSubviewToFront(titleLabel)
	}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = ""
    }
}
