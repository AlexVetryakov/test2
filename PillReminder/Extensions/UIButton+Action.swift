//
//  UIButton+Action.swift
//  PillReminder
//
//  Created by Александр Ветряков on 01.12.2023.
//

import Combine
import UIKit

extension UIButton {
  func tap() -> AnyPublisher<Void, Never> {
    publisher(for: .touchUpInside).map { _ in }.eraseToAnyPublisher()
  }
}
