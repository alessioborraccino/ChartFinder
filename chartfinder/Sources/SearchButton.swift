//
//  SearchButton.swift
//  chartfinder
//
//  Created by Alessio Borraccino on 14/12/15.
//  Copyright © 2015 Alessio Borraccino. All rights reserved.
//

import UIKit
import SnapKit

class SearchButton : UIButton {

    // MARK: Properties

    private var title : String
    private lazy var activityIndicator : UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .White)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()

    // MARK: Initializers

    init(title: String) {
        self.title = title
        super.init(frame: CGRectZero)
        self.setTitle(title, forState: .Normal)
        self.addSubview(activityIndicator)
        self.backgroundColor = UIColor.ab_Yellow()
        setDefaultConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View Methods
    
    private func setDefaultConstraints() {
        activityIndicator.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self)
        }
    }

    func setIsLoading() {
        activityIndicator.startAnimating()
        self.setTitle("", forState: .Normal)
        self.userInteractionEnabled = false
    }

    func setReady() {
        activityIndicator.stopAnimating()
        self.setTitle(title, forState: .Normal)
        self.userInteractionEnabled = true
    }
}
