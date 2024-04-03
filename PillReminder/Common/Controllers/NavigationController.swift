//
//  NavigationController.swift
//  PillReminder
//
//  Created by Александр Ветряков on 28.11.2023.
//

import UIKit

open class NavigationController: UINavigationController {
    
    private var isRootViewControllerSetup = false
    
    var isTabBarHidden: Bool { return false }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .lightContent
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        setup()
    }
    
    override open func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        
        manageAppearance(with: viewController)
    }
    
    override open func present(_ viewControllerToPresent: UIViewController,
                               animated flag: Bool, completion: (() -> Void)? = nil) {
        super.present(viewControllerToPresent, animated: flag, completion: completion)
        
        manageAppearance(with: viewControllerToPresent)
    }
    
    @discardableResult
    override open func popViewController(animated: Bool) -> UIViewController? {
        let popedViewController = super.popViewController(animated: animated)
        
        manageAppearance(with: topViewController)
        
        transitionCoordinator?.animate(alongsideTransition: nil) { [weak self] context in
            guard context.isCancelled else {
                return
            }
            
            self?.manageAppearance(with: self?.topViewController)
        }
        
        return popedViewController
    }
    
    open override var viewControllers: [UIViewController] {
        didSet {
            if viewControllers.count == 1 {
                manageAppearance(with: viewControllers.first)
            }
        }
    }
    
    private func setup() {
        if isRootViewControllerSetup {
            return
        }
        
        manageAppearance(with: viewControllers.first)
    }
    
    private func manageAppearance(with controller: UIViewController?) {
        /// at some point system disables animation while transitioning between controllers
        /// in order to fix that we manually enable it
        UIView.setAnimationsEnabled(true)
        
        guard let controller = controller else { return }
        
        controller.navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "", style: .plain, target: nil, action: nil
        )
    }

}
