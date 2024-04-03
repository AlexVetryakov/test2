//
//  BaseViewController.swift
//  PillReminder
//
//  Created by Александр Ветряков on 28.11.2023.
//

import UIKit
import Combine

class BaseViewController: UIViewController, CancellablesApplicable {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    var cancellables: [AnyCancellable] = []
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init is not implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

}
