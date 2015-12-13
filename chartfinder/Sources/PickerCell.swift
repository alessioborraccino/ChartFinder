//
//  PickerCell.swift
//  chartfinder
//
//  Created by Alessio Borraccino on 13/12/15.
//  Copyright © 2015 Alessio Borraccino. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit

class PickerCell: UITableViewCell {

    // MARK: Properties

    static let reuseIdentifier = "Pick me"
    static let cellHeight = UIUnit * 44 as CGFloat

    private(set) lazy var picker : UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()

    // MARK: Initializers

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        contentView.addSubview(picker)
        setDefaultConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View Methods

    private func setDefaultConstraints() {
        picker.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(contentView)
        }
    }

    override func prepareForReuse() {
        picker.dataSource = nil
        picker.delegate = nil
    }

    // MARK: External Commands

    func setPickerViewDataSource(dataSource: UIPickerViewDataSource) {
        picker.dataSource = dataSource
    }
    func setPickerViewDelegate(delegate: UIPickerViewDelegate) {
        picker.delegate = delegate
    }
    func setPickerSelected(row row: Int, component: Int) {
        picker.selectRow(row, inComponent: component, animated: false)
    }
}
