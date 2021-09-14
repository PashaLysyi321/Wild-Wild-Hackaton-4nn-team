//
//  CustomizeCoordinator.swift
//  Interective Learning App
//
//  Created by Prefect on 11.09.2021.
//

import Foundation
import UIKit

class CustomizeCoordinator: NSObject {
    
    private var navigationController: UINavigationController?
    
    init(_ navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        guard let viewController = makeViewController() else { return }
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension CustomizeCoordinator {
    
    func makeViewController() -> UIViewController? {
        let viewController = R.storyboard.customizeViewController.instantiateInitialViewController()
//        viewController?.configure(self, fileName)
        return viewController
    }
}

