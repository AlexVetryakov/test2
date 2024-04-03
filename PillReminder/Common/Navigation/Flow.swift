//
//  Flow.swift
//  PillReminder
//
//  Created by Александр Ветряков on 28.11.2023.
//

import UIKit

protocol Flow: AnyObject {
    
    // should be weak in realization
    var containerViewController: UIViewController? { get set }
    
    @discardableResult
    func createFlow() -> UIViewController
    
}

extension Flow {
    
    var navigationController: UINavigationController? {
        return containerViewController as? UINavigationController
    }
    
}

