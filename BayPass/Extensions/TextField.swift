//
//  TextField.swift
//  BayPass
//
//  Created by Tim Roesner on 4/5/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import UIKit

extension UITextField {
    func addDoneButtonToKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        doneToolbar.barStyle = UIBarStyle.default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(dismiss))

        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)

        doneToolbar.items = items
        doneToolbar.sizeToFit()

        inputAccessoryView = doneToolbar
    }

    @objc func dismiss() {
        resignFirstResponder()
    }
}
