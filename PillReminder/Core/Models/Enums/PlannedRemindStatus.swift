//
//  PlannedRemindStatus.swift
//  PillReminder
//
//  Created by Александр Ветряков on 24.01.2024.
//

import UIKit

enum PlannedRemindStatus: Int {
    case planed, skipped, confirmed, rejected
    
    var backgroundColor: UIColor? {
        switch self {
        case .planed:
            return R.color.backgroundSecondary()
            
        case .confirmed:
            return R.color.backgroundSelected()
            
        case .skipped, .rejected:
            return R.color.backgroundError()
        }
    }
}
