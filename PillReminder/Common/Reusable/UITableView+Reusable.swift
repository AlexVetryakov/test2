//
//  UITableView+Reusable.swift
//  PillReminder
//
//  Created by Александр Ветряков on 01.12.2023.
//

import UIKit

public extension UITableView {
    
    // MARK: - UITableViewCell
    
    /// Register a Class-Based `UITableViewCell` subclass (conforming to `Reusable`)
    final func registerReusableCell<T: UITableViewCell>(cellType: T.Type) where T: Reusable {
        register(cellType.self, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
    
    /// Returns a reusable `UITableViewCell` object for the class inferred by the return-type
    final func dequeueReusableCell<T: UITableViewCell>(_ indexPath: IndexPath, cellType: T.Type = T.self) -> T
        where T: Reusable {
            guard let cell = dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
                fatalError(
                    """
                    Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self).
                    Check that the reuseIdentifier is set properly and that you registered the cell beforehand.
                    """
                )
            }
            cell.isAccessibilityElement = true
            cell.accessibilityIdentifier = "\(cellType.self)\(indexPath.section)(\(indexPath.row))"

            return cell
    }
    
    // MARK: - UITableViewHeaderFooterView
    
    /// Register a Class-Based `UITableViewHeaderFooterView` subclass (conforming to `Reusable`)
    final func registerReusableHeaderFooterView<T: UITableViewHeaderFooterView>(viewType: T.Type) where T: Reusable {
        register(viewType.self, forHeaderFooterViewReuseIdentifier: viewType.reuseIdentifier)
    }
    
    /// Returns a reusable `UITableViewHeaderFooterView` object for the class inferred by the return-type
    final func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(
        _ section: Int,
        viewType: T.Type = T.self) -> T? where T: Reusable {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: viewType.reuseIdentifier) as? T? else {
            fatalError(
                """
                Failed to dequeue a header/footer with identifier \(viewType.reuseIdentifier)
                matching type \(viewType.self).
                Check that the reuseIdentifier is set properly and that you registered the header/footer beforehand.
                """
            )
        }
        view?.accessibilityIdentifier = "\(viewType.self)\(section))"
        
        return view
    }
    
}
