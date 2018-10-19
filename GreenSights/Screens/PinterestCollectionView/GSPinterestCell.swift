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
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = GSSettings.ui.colors.backgroundWhite
        setupSubviews()
        setupContstraints()
        layer.cornerRadius = 10
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 5
    }
    
    func setupSubviews() {
        //addSubview(photoImageView)
        addSubview(typeLabel)
    }
    
    func setupContstraints() {
        //photoImageView.fillSuperview(onlySafeArea: false)
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        typeLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func configure(dataSource: Datasource?) {
        guard let dataSource = dataSource else { return }
        data = dataSource
        guard let type = data?.type else { return }
        typeLabel.text = "\(type)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.typeLabel.text = ""
    }
}