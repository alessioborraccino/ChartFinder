//
//  TrackCoverCell.swift
//  chartfinder
//
//  Created by Alessio Borraccino on 14/12/15.
//  Copyright © 2015 Alessio Borraccino. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit
import Kingfisher

class TrackCoverCell: UITableViewCell {

    // MARK: Properties

    static let reuseIdentifier = "Cover me"
    static let cellHeight = UIUnit * 72 as CGFloat

    private lazy var cover: UIImageView = {
        let imageView = UIImageView()
        imageView.kf_showIndicatorWhenLoading = true
        return imageView
    }()

    private lazy var artistLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFontOfSize(24)
        label.textAlignment = .Center
        return label
    }()
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(20, weight: UIFontWeightLight)
        label.textAlignment = .Center
        return label
    }()

    private lazy var durationLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(18, weight: UIFontWeightLight)
        label.textAlignment = .Center
        return label
    }()

    // MARK: Initializers

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        contentView.addSubview(cover)
        contentView.addSubview(artistLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(durationLabel)
        setDefaultConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View Methods
    
    private func setDefaultConstraints() {
        
        cover.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(contentView.snp_top).offset(UIUnit * 2)
            make.centerX.equalTo(contentView.snp_centerX)
            make.height.equalTo(UIUnit * 50)
            make.width.equalTo(cover.snp_height)
        }

        artistLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(cover.snp_bottom).offset(UIUnit * 2)
            make.left.equalTo(contentView.snp_left).offset(UIUnit * 2)
            make.right.equalTo(contentView.snp_right).offset(-UIUnit * 2)
        }

        titleLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(artistLabel.snp_bottom)
            make.left.equalTo(artistLabel.snp_left)
            make.right.equalTo(artistLabel.snp_right)
        }

        durationLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(titleLabel.snp_bottom).offset(UIUnit * 2)
            make.left.equalTo(titleLabel.snp_left)
            make.right.equalTo(titleLabel.snp_right)
        }
    }

    func configure(track track: Track) {
        artistLabel.text = track.artist
        artistLabel.sizeToFit()

        titleLabel.text = track.title
        titleLabel.sizeToFit()

        if let seconds = track.duration {
            durationLabel.text = String(durationFormatWithSeconds: seconds)
            durationLabel.sizeToFit()
        }

        if let imageURLString = track.bigImageURL {
            cover.kf_setImageWithURL(NSURL(string: imageURLString)!)
        }
    }
}
