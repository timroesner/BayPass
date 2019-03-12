//
//  TicketViewController.swift
//  BayPass
//
//  Created by Tim Roesner on 10/18/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import CoreLocation
import UIKit

class TicketViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Tickets"

        //scroll view
        let scrollView : UIScrollView = UIScrollView(frame: CGRect(x: 0, y: 180, width: 350, height: 200))
        view.addSubview(scrollView)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.backgroundColor = .orange
        let numberOfPages :Int = 5
        let padding : CGFloat = 20
        //let viewWidth = scrollView.frame.size.width - 2 * padding
        let viewWidth = CGFloat(150)
        let viewHeight = scrollView.frame.size.height - 2 * padding
        
        var x : CGFloat = 0
        
        for _ in 0...numberOfPages{
            let view: UIView = UIView(frame: CGRect(x: x + padding, y: padding, width: viewWidth, height: viewHeight))
            view.backgroundColor = UIColor.black
            scrollView .addSubview(view)
            
            x = view.frame.origin.x + viewWidth + padding
        }
        
        scrollView.contentSize = CGSize(width:x+padding, height:scrollView.frame.size.height)
        
        
        // button to ticket checkout page
        let button = UIButton()
        button.backgroundColor = UIColor(red: 221, green: 84, blue: 65)
        button.layer.cornerRadius = 10
        button.setTitle("Ticket Checkout", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        view.addSubview(button)

        // Make SnapKit contraints for button here
        button.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.view.snp.bottomMargin).inset(20)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(self.view.snp.width).multipliedBy(0.15)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    @objc func buttonAction(sender _: UIButton!) {
        navigationController?.pushViewController(TicketCheckoutViewController(), animated: true)
    }
}
