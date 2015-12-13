//
//  UINavigationViewController+HAB.swift
//  chartfinder
//
//  Created by Alessio Borraccino on 14/12/15.
//  Copyright © 2015 Alessio Borraccino. All rights reserved.
//

import UIKit

class ABNavigationController : UINavigationController {

    // MARK: Initializers
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationBar.barTintColor = UIColor.ab_Orange()
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationBar.setBackgroundImage(UIImage(), forBarMetrics:.Default);
        self.navigationBar.shadowImage = UIImage();
        self.navigationBar.translucent = false
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
