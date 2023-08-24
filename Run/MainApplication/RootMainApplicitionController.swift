//
//  RootMainApplicitionController.swift
//  Run
//
//  Created by Лукичев Сергей on 24.08.2023.
//

import UIKit
import SnapKit

final class RootMainApplicitionController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        modalPresentationStyle = .fullScreen
        modalTransitionStyle = .coverVertical

        let stopwatchViewController = StopwatchConfigurator().configure()
        let profileViewController = ProfileConfigurator().configure()

        stopwatchViewController.title = "Секундомер"
        profileViewController.title = "Профиль"

        viewControllers = [stopwatchViewController, profileViewController]

        guard let items = self.tabBar.items else { return }

        let imageStopwatch = UIImage(systemName: "clock.arrow.circlepath")!
        let imageProfile = UIImage(systemName: "person.crop.circle")!
        let views = [imageStopwatch, imageProfile]

        for item in 0..<items.count {
            items[item].image = views[item]
        }

        let customTabBar = UITabBar()
        customTabBar.items = items
        customTabBar.tintColor = .black
        
        selectedIndex = 0

        view.addSubview(customTabBar)
        customTabBar.snp.makeConstraints { make in
            make.bottom.right.left.equalToSuperview()
            make.height.equalTo(90)
        }
    }
}
