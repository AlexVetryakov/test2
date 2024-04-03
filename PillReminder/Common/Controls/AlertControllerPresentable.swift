//
//  AlertControllerPresentable.swift
//  PillReminder
//
//  Created by Александр Ветряков on 29.12.2023.
//

import UIKit

protocol AlertControllerPresentable {
    
    func presentAlertController(title: String?, message: String?, cancelTitle: String?, actionTitle: String?, actionHandler: (() -> (Void))?)
    func presentActionSheetAlertController(title: String?, message: String?, cancelTitle: String?, actionTitles: [String], actionHandlers: [(() -> ()?)])
}

extension AlertControllerPresentable where Self: UIViewController {
    
    func presentAlertController(title: String?, message: String? = nil, cancelTitle: String?, actionTitle: String? = nil, actionHandler: (() -> (Void))? = nil) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        if let cancelTitle = cancelTitle {
            alertController.addAction(UIAlertAction(title: cancelTitle, style: .cancel))
        }
        if let actionTitle = actionTitle {
            alertController.addAction(UIAlertAction(title: actionTitle, style: .default) { _ in
                actionHandler?()
                alertController.dismiss(animated: true)
            })

        }
         present(alertController, animated: true)
    }
    
    func presentActionSheetAlertController(title: String?, message: String? = nil, cancelTitle: String?, actionTitles: [String], actionHandlers: [(() -> ()?)]) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .actionSheet
        )
        if let cancelTitle = cancelTitle {
            alertController.addAction(UIAlertAction(title: cancelTitle, style: .cancel))
        }
        
        actionTitles.enumerated().forEach { index, value in
            alertController.addAction(UIAlertAction(title: value, style: .default, handler: { _ in
                actionHandlers[index]()
                alertController.dismiss(animated: true)
            }))
        }

         present(alertController, animated: true)
    }
}
