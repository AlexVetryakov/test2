//
//  Reusable.swift
//  PillReminder
//
//  Created by Александр Ветряков on 01.12.2023.
//

import UIKit

// Inspired by https://github.com/AliSoftware/Reusable

/// Protocol for `UITableViewCell` and `UICollectionViewCell` subclasses when they are code-based.
/// Conform cells to `Reusable` to be able to dequeue them in a type-safe manner.
public protocol Reusable: AnyObject {
    
    static var reuseIdentifier: String { get }
    
}

public extension Reusable {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
}

