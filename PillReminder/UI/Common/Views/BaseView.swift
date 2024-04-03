//
//  BaseView.swift
//  PillReminder
//
//  Created by Александр Ветряков on 28.11.2023.
//

import UIKit
import SnapKit

/// Base View for all custom views used in this module
open class BaseView: UIView {
    
    public init() {
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("Init is not implemented")
    }
    
}
