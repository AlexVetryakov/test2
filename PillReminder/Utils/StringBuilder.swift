//
//  StringBuilder.swift
//  PillReminder
//
//  Created by Александр Ветряков on 09.01.2024.
//

import UIKit
import Foundation

struct StringBuilder {
    
    struct Plural {
        static func countForm(count: Int, word: String) -> String {
            let remainder10 = count % 10
            let remainder100 = count % 100

            if remainder10 == 1 && remainder100 != 11 {
                return "\(self) \(word)"
            } else if remainder10 >= 2 && remainder10 <= 4 && (remainder100 < 10 || remainder100 >= 20) {
                return "\(self) \(word)и"
            } else {
                return "\(self) \(word)ів"
            }
        }
        
        static func countByDay(count: Int) -> String {
            guard count == 0 else {
                return countForm(count: count, word: R.string.localizable.stringBuilderCount())
            }
            return R.string.localizable.reminderInfoCountQuestionTitle()
        }
    }
    
    struct Time {
        static func timeFrom(component: DateComponents) -> String {
            "\(String(format: "%02d", component.hour ?? 0)):\(String(format: "%02d", component.minute ?? 0))"
        }
    }
    
    struct Dose {
        static func doseFrom(drugFormType: DrugFormType, count: Double) -> String {
            "\(doseToString(count: count)), \(drugFormType.title)"
        }
        
        static func doseToString(count: Double) -> String {
            if count == 0.25 {
                return "1/4"
            } else if count == 0.5 {
                return "1/2"
            } else {
                return "\(Int(count))"
            }
        }
    }

}
