//
//  UIViewController+Error.swift
//  chartfinder
//
//  Created by Alessio Borraccino on 13/12/15.
//  Copyright © 2015 Alessio Borraccino. All rights reserved.
//

import UIKit

extension UIViewController {

    func showError(title title: String, body: String) {
        let alert = UIAlertController(title: title, message: body, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .Cancel, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
}