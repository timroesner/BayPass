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
        collapse()
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

        dropView = DropDownView()
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
            expand()
        } else {
            collapse()
        }
    }

    func expand() {
        isOpen = true
        NSLayoutConstraint.deactivate([self.height])
        NSLayoutConstraint.activate([self.height])

        if dropView.tableView.numberOfRows(inSection: 0) <= 4 {
            height.constant = dropView.tableView.contentSize.height
        } else {
            height.constant = 190
        }

        arrow.rotate(isOpen ? 0.0 : .pi)
        expandAnimation()
    }

    func collapse() {
        isOpen = false

        NSLayoutConstraint.deactivate([self.height])
        height.constant = 0
        NSLayoutConstraint.activate([self.height])

        arrow.rotate(isOpen ? 0.0 : .pi)
        collapseAnimation()
    }

    func expandAnimation() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            self.dropView.layoutIfNeeded()
            self.dropView.center.y += self.dropView.frame.height / 2
        }, completion: nil)
    }

    func collapseAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.dropView.center.y -= self.dropView.frame.height / 2
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

    public init() {
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
        // let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
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
