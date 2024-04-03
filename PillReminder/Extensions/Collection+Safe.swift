//
//  Collection+Safe.swift
//  PillReminder
//
//  Created by Александр Ветряков on 02.12.2023.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
