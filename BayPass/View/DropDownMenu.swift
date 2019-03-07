//
//  DropDownMenu.swift
//  BayPass
//
//  Created by Zhe Li on 3/5/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import UIKit

protocol DropDownProtocol {
    func dropDownPressed(string: String)
}

class DropDownMenu: UIButton, DropDownProtocol {
    var dropView = DropDownView()
    var height = NSLayoutConstraint()
    var titleLbl = UILabel()
    var selectedItemLbl = UILabel()
    let arrow = UIImageView(image: UIImage(named: "arrow")!)
    var isOpen = false
    private var selectedItem = ""

    func dropDownPressed(string: String) {
        selectedItem = string
        selectedItemLbl.text = string
        dismissDropDown()
    }

    func getSelectedItem() -> String {
        return selectedItem
    }

    public init(title: String, items: [String]) {
        super.init(frame: CGRect.zero)

        backgroundColor = UIColor.white

        arrow.rotate(isOpen ? 0.0 : .pi)

        selectedItem = items[0]

        addSubview(titleLbl)
        titleLbl.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        titleLbl.text = title.uppercased()
        titleLbl.textColor = UIColor(red: 0.61, green: 0.61, blue: 0.61, alpha: 1.00)
        titleLbl.snp.makeConstraints({ (make) -> Void in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
        })

        addSubview(selectedItemLbl)
        selectedItemLbl.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        selectedItemLbl.text = selectedItem
        selectedItemLbl.textColor = UIColor.black
        selectedItemLbl.snp.makeConstraints({ (make) -> Void in
            make.top.equalTo(titleLbl.snp.bottom).offset(2)
            make.left.equalToSuperview().offset(10)
        })

        dropView = DropDownView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        dropView.delegate = self
        dropView.dropDownOptions = items
        dropView.tableView.isScrollEnabled = dropView.tableView.numberOfRows(inSection: 0) <= 4 ? false : true
        dropView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(arrow)
        arrow.tintColor = UIColor(red: 0.61, green: 0.61, blue: 0.61, alpha: 1.00)
        arrow.snp.makeConstraints({ (make) -> Void in
            make.width.height.equalTo(15)
            make.top.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-10)
        })
    }

    override func didMoveToSuperview() {
        superview?.addSubview(dropView)
        superview?.bringSubviewToFront(dropView)

        dropView.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        dropView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        dropView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        height = dropView.heightAnchor.constraint(equalToConstant: 0)
    }

    override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
        if isOpen == false {
            isOpen = true

            NSLayoutConstraint.deactivate([self.height])
            NSLayoutConstraint.activate([self.height])

            if dropView.tableView.numberOfRows(inSection: 0) <= 4 {
                height.constant = dropView.tableView.contentSize.height
                // dropView.tableView.isScrollEnabled = false
            } else {
                height.constant = 190
                // dropView.tableView.isScrollEnabled = true
            }

            arrow.rotate(isOpen ? 0.0 : .pi)
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
                self.dropView.layoutIfNeeded()
                self.dropView.center.y += self.dropView.frame.height / 2
            }, completion: nil)
        } else {
            isOpen = false

            NSLayoutConstraint.deactivate([self.height])
            height.constant = 0
            NSLayoutConstraint.activate([self.height])

            arrow.rotate(isOpen ? 0.0 : .pi)
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
                self.dropView.center.y -= self.dropView.frame.height / 2
                self.dropView.layoutIfNeeded()
            }, completion: nil)
        }
    }

    func dismissDropDown() {
        isOpen = false

        arrow.rotate(isOpen ? 0.0 : .pi)

        NSLayoutConstraint.deactivate([self.height])
        height.constant = 0
        NSLayoutConstraint.activate([self.height])

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: { self.dropView.center.y -= self.dropView.frame.height / 2
            self.dropView.layoutIfNeeded()
        }, completion: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DropDownView: UIView, UITableViewDelegate, UITableViewDataSource {
    var dropDownOptions = [String]()
    var tableView = UITableView()
    var delegate: DropDownProtocol!

    override init(frame _: CGRect) {
        super.init(frame: CGRect.zero)

        tableView.backgroundColor = UIColor.white
        backgroundColor = UIColor.white

        tableView.delegate = self
        tableView.dataSource = self

        tableView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(tableView)
        tableView.separatorColor = UIColor.clear
        tableView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return dropDownOptions.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = dropDownOptions[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        cell.backgroundColor = UIColor.white
        return cell
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.dropDownPressed(string: dropDownOptions[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
