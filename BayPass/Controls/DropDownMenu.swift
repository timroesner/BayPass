import SnapKit
import UIKit

class DropDownMenu: UIView, UITableViewDelegate, UITableViewDataSource {
    var tableView = UITableView()
    var titleLbl = UILabel()
    var selectedItemButton = UILabel()
    let arrow = UIImageView(image: #imageLiteral(resourceName: "arrow"))
    var isOpen = false
    
    var delegate: DropDownDelegate?
    var tableViewOpenConstraint: Constraint?
    var tableViewClosedConstraint: Constraint?
    
    private var dropDownOptions = [String]()
    private var selectedItem: String = "" {
        didSet {
            selectedItemButton.text = selectedItem
        }
    }

    func getSelectedItem() -> String {
        return selectedItem
    }

    public init(title: String, items: [String]) {
        super.init(frame: CGRect.zero)

        backgroundColor = UIColor.white

        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.clear

        arrow.rotate(isOpen ? .pi : 0.0)
        titleLbl.text = title.uppercased()

        selectedItem = items[safe: 0] ?? ""
        dropDownOptions = items

        setupView()
    }

    func setupView() {
        addSubview(titleLbl)
        titleLbl.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        titleLbl.textColor = UIColor(red: 0.61, green: 0.61, blue: 0.61, alpha: 1.00)
        titleLbl.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview().offset(5)
            make.height.equalTo(14)
        }

        addSubview(selectedItemButton)
        selectedItemButton.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        selectedItemButton.text = selectedItem
        selectedItemButton.textColor = .black
        selectedItemButton.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        selectedItemButton.addGestureRecognizer(tapRecognizer)
        selectedItemButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(titleLbl.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(5)
            make.height.equalTo(24)
        }

        addSubview(arrow)
        arrow.tintColor = UIColor(red: 0.70, green: 0.70, blue: 0.70, alpha: 1.00)
        arrow.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(15)
            make.centerY.equalTo(selectedItemButton)
            make.right.equalToSuperview().offset(-5)
            make.left.equalTo(selectedItemButton.snp.right).offset(8)
        }

        let border = UILabel()
        border.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1.00)
        addSubview(border)
        border.snp.makeConstraints { make in
            make.height.equalTo(1.5)
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.top.equalTo(selectedItemButton.snp.bottom).offset(8)
        }

        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(border.snp.bottom)
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(-10)
            //tableViewOpenConstraint = make.height.lessThanOrEqualTo(190).constraint
            switch tableView.numberOfRows(inSection: 0) {
            case 0:
                tableViewOpenConstraint = make.height.equalTo(0).constraint
            case 1:
                tableViewOpenConstraint = make.height.equalTo(47.5).constraint
            case 2:
                tableViewOpenConstraint = make.height.equalTo(95).constraint
            case 3:
                tableViewOpenConstraint = make.height.equalTo(142.5).constraint
            default:
                tableViewOpenConstraint = make.height.equalTo(190).constraint
            }
            tableViewClosedConstraint = make.height.equalTo(0).constraint
        }
        tableView.isScrollEnabled = tableView.numberOfRows(inSection: 0) <= 4 ? false : true
        tableViewOpenConstraint?.deactivate()
        tableViewClosedConstraint?.activate()
    }

    @objc func handleTap() {
        isOpen.toggle()
        isOpen ? expandAnimation() : collapseAnimation()
        arrow.rotate(isOpen ? .pi : 0.0)
    }

    func expandAnimation() {
        tableView.setContentOffset(.zero, animated: false)
        tableViewOpenConstraint?.activate()
        tableViewClosedConstraint?.deactivate()
        layoutIfNeeded()

        /* UIView.animate(withDuration: 0.4, animations: {
         self.center.y -= self.frame.height
         self.layoutIfNeeded()
         }) */

        tableView.flashScrollIndicators()
    }

    func collapseAnimation() {
        tableViewOpenConstraint?.deactivate()
        tableViewClosedConstraint?.activate()
        layoutIfNeeded()

        /* UIView.animate(withDuration: 0.4, animations: {
         self.layoutIfNeeded()
         self.center.y += self.frame.height
         }) */
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return dropDownOptions.filter { $0 != selectedItem }.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = dropDownOptions.filter { $0 != selectedItem }[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        cell.backgroundColor = UIColor.white
        return cell
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItem = dropDownOptions.filter { $0 != selectedItem }[indexPath.row]
        handleTap()
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didChangeSelectedItem(self)
    }

    required init?(coder _: NSCoder) {
        print("NSCoder not supported in DropDownMenu")
        return nil
    }
}
