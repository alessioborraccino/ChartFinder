//
//  TrackCell.swift
//  chartfinder
//
//  Created by Alessio Borraccino on 13/12/15.
//  Copyright © 2015 Alessio Borraccino. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit
import Kingfisher

class TrackCell: UITableViewCell {

    // MARK: Properties

    static let reuseIdentifier = "Track me"
    static let cellHeight = UIUnit * 13 as CGFloat

    private lazy var coverThumbnail : UIImageView = {
        let imageView = UIImageView()
        imageView.kf_showIndicatorWhenLoading = true
        return imageView
    }()

    private lazy var positionLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(13, weight: UIFontWeightMedium)
        return label
    }()

    private lazy var artistLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFontOfSize(15)
        return label
    }()

    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(13, weight: UIFontWeightLight)
        return label
    }()

    // MARK: Initializers

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(positionLabel)
        contentView.addSubview(coverThumbnail)
        contentView.addSubview(artistLabel)
        contentView.addSubview(titleLabel)
        setDefaultConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View Methods

    private func setDefaultConstraints() {

        positionLabel.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(contentView.snp_centerY)
            make.left.equalTo(contentView.snp_left).offset(UIUnit * 2)
            make.width.equalTo(UIUnit * 3)
            make.height.equalTo(UIUnit * 3)
        }

        coverThumbnail.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(contentView.snp_top).offset(UIUnit * 2)
            make.bottom.equalTo(contentView.snp_bottom).offset(-UIUnit * 2)
            make.left.equalTo(positionLabel.snp_right).offset(UIUnit * 2)
            make.width.equalTo(coverThumbnail.snp_height)
        }

        artistLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(coverThumbnail.snp_top)
            make.left.equalTo(coverThumbnail.snp_right).offset(UIUnit * 2)
        }
        titleLabel.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(coverThumbnail.snp_bottom)
            make.left.equalTo(coverThumbnail.snp_right).offset(UIUnit * 2)
        }
    }

    func configure(track track: Track, position: Int) {

        positionLabel.text = String(position)

        artistLabel.text = track.artist
        artistLabel.sizeToFit()

        titleLabel.text = track.title
        titleLabel.sizeToFit()

        if let imageURLString = track.imageURL {
            coverThumbnail.kf_setImageWithURL(NSURL(string: imageURLString)!)
        }
    }
}
