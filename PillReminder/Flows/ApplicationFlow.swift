//
//  ApplicationFlow.swift
//  PillReminder
//
//  Created by Александр Ветряков on 28.11.2023.
//

import UIKit
import Swinject
import SwinjectAutoregistration

final class ApplicationFlow: NavigationNode {
    
    private let window: UIWindow
    private let container: Swinject.Container
    
    init(window: UIWindow) {
        self.window = window
        self.container = Container { ApplicationFlowAssembly().assemble(container: $0) }
        
        super.init(parent: nil)
        
        observeEvents()
    }
    
    func execute() {
        presentRemindersFlow()
    }
    
    // MARK: - Events handling
    
    private func observeEvents() {

    }
    
    // MARK: - Routing
    
    private func presentRemindersFlow() {
        let flow =  RemindersFlow(parentNode: self, parentContainer: container)
        let controller = flow.createFlow()
        let navigationController = NavigationController(rootViewController: controller)
        
        navigationController.isNavigationBarHidden = true
        flow.containerViewController = navigationController
        setRootViewController(navigationController)
    }
    
    private func setRootViewController(_ viewController: UIViewController, completion: (() -> Void)? = nil) {
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        
        UIView.transition(
            with: self.window,
            duration: 0.2,
            options: .transitionCrossDissolve,
            animations: {},
            completion: { _ in
                completion?()
            }
        )
    }
    
}

