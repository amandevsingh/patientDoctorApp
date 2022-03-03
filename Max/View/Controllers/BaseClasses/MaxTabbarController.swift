//
//  MaxTabbarController.swift
//  Max
//
//  Created by Rahul on 16/12/21.
//

import UIKit

class MaxTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
    }
    
    //MARK: UI Loader method
    func loadUI() {
        tabBar.autoresizesSubviews = true;
        tabBar.clipsToBounds = true;
        for (_,itemTemp) in self.tabBar.items!.enumerated() {
            let unselectedItem: NSDictionary = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.0862745098, green: 0.231372549, blue: 0.4274509804, alpha: 1) ]
            let selectedItem: NSDictionary = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.0862745098, green: 0.231372549, blue: 0.4274509804, alpha: 1)]
            itemTemp.setTitleTextAttributes(unselectedItem as? [NSAttributedString.Key : Any] , for: .normal)
            itemTemp.setTitleTextAttributes(selectedItem as? [NSAttributedString.Key : Any] , for: .selected)
        }
    }
}
