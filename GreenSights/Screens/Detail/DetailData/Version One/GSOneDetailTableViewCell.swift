////
////  GSDetailTableViewCell.swift
////  GreenSights
////
////  Created by Leon Helg on 09.10.18.
////  Copyright © 2018 Leon Helg. All rights reserved.
////
//
//import UIKit
//
//class GSDetailTableViewCell: UITableViewCell, ReusableView {
//    //MARK: - GUI Objects
//    let titleLabel: UILabel = {
//        let label       = UILabel()
//        label.font      = GSSettings.UI.Fonts.helveticaRegular?.withSize(18)
//        label.text      = "Titel"
//        label.textColor = GSSettings.UI.Colors.regularTextColor
//        return label
//    }()
//
//
//    let valueLabel: UILabel = {
//        let label       = UILabel()
//        label.font      = GSSettings.UI.Fonts.helveticaRegularItalic?.withSize(16)
//        label.text      = "Value"
//        label.textColor = GSSettings.UI.Colors.regularTextColor
//        return label
//    }()
//
//    let chevronImageView: UIImageView = {
//        let imageview = UIImageView()
//        imageview.image = UIImage(named: GSSettings.UI.helperIcons.chevron)?.withRenderingMode(.alwaysOriginal)
//        imageview.tintColor = GSSettings.UI.Colors.lightGray
//        imageview.contentMode = .scaleAspectFit
//        return imageview
//    }()
//
//    //MARK: - Init & View Loading
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupSubviews()
//        setupContstraints()
//    }
//
//    //MARK: - Setup
//    func setupSubviews() {
//        addSubview(titleLabel)
//        addSubview(valueLabel)
//        addSubview(chevronImageView)
//    }
//
//    func setupContstraints() {
//        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0, width: 0, height: 0)
//        valueLabel.anchor(top: topAnchor, leading: nil, bottom: bottomAnchor, trailing: chevronImageView.leadingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 10, width: 0, height: 0)
//        chevronImageView.anchor(top: nil, leading: nil, bottom: nil, trailing: trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0, width: 30, height: 30)
//        chevronImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//    }
//
//    //MARK: - Do not change Methods
//    override func layoutSubviews() {
//        super.layoutSubviews()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
