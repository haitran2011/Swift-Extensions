//
//  UISearchBar+Ex.swift
//
//  Created by Augus on 10/20/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import UIKit

public extension UISearchBar {

    public func selectAll() {

        loopViews("UISearchBarTextField", shouldReturn: false, execute: {

            // do not use `value(forKey: "searchField") as? UITextField`, may rejected by Apple
            guard let tf = $0 as? UITextField else { return }

            guard tf.responds(to: #selector(selectAll(_:))) else { return }

            // ensure texts can be selected
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                tf.selectAll(nil)
            }
        })
    }


    public func changeTextFieldTintColor(_ color: UIColor) {

        loopViews() {
            if let tf = $0 as? UITextField {
                tf.tintColor = color
                return
            }
        }
    }

    public func customMode(with color: UIColor, placeholder: String?) {

        loopViews() {

            if let tf = $0 as? UITextField {
                tf.tintColor = color
                tf.textColor = color

                if let ph = placeholder {
                    let str = NSAttributedString(string: ph, attributes: [NSForegroundColorAttributeName: color.withAlphaComponent(0.5)])
                    tf.attributedPlaceholder = str
                }
            }
        }
    }
}


