//
//  InputCell.swift
//  chartfinder
//
//  Created by Alessio Borraccino on 13/12/15.
//  Copyright © 2015 Alessio Borraccino. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class InputCell: UITableViewCell {

    // MARK: Properties

    static let reuseIdentifier = "Tell me"
    static let cellHeight = UIUnit * 13 as CGFloat

    var disposeBag = DisposeBag()

    private lazy var fieldLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFontOfSize(22)
        return label
    }()

    private lazy var valueLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(17, weight: UIFontWeightMedium)
        return label
    }()

    // MARK: Initializers

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        contentView.addSubview(fieldLabel)
        contentView.addSubview(valueLabel)
        setDefaultConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View Methods

    private func setDefaultConstraints() {
        fieldLabel.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(contentView.snp_centerY)
            make.left.equalTo(contentView.snp_left).offset(UIUnit * 4)
        }
        valueLabel.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(contentView.snp_centerY)
            make.right.equalTo(contentView.snp_right).offset(-UIUnit * 4)
        }
    }

    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }

    func configure(field: String, value: String) {
        fieldLabel.text = field
        fieldLabel.sizeToFit()
        valueLabel.text = value
        valueLabel.sizeToFit()
    }

    func configure(field: String, observableValue: Observable<String>) {
        fieldLabel.text = field
        fieldLabel.sizeToFit()
        observableValue.observeOn(MainScheduler.sharedInstance).subscribeNext { [unowned self] (value) -> Void in
            self.valueLabel.text = value
            self.valueLabel.sizeToFit()
        }.addDisposableTo(disposeBag)
    }
}
