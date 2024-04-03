//
//  FormType.swift
//  PillReminder
//
//  Created by Александр Ветряков on 02.01.2024.
//

import UIKit

enum DrugFormType: Int {
    
    case capsule, tablet, injection, drops, sachet, spray, solution, suppository, gel, inhaler
    
    var title: String {
        switch self {
        case .capsule:
            return R.string.localizable.drugFormCapsuleTitle()
            
        case .tablet:
            return R.string.localizable.drugFormTabletTitle()
            
        case .injection:
            return R.string.localizable.drugFormInjectionTitle()
            
        case .drops:
            return R.string.localizable.drugFormDropsTitle()
            
        case .sachet:
            return R.string.localizable.drugFormSachetTitle()
            
        case .spray:
            return R.string.localizable.drugFormSprayTitle()
            
        case .solution:
            return R.string.localizable.drugFormSolutionTitle()
            
        case .suppository:
            return R.string.localizable.drugFormSuppositoryTitle()
            
        case .gel:
            return R.string.localizable.drugFormGelTitle()
            
        case .inhaler:
            return R.string.localizable.drugFormInhalerTitle()
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .capsule:
            return R.image.capsule()
            
        case .tablet:
            return R.image.tablet()
            
        case .injection:
            return R.image.injection()
            
        case .drops:
            return R.image.drops()
            
        case .sachet:
            return R.image.sachet()
            
        case .spray:
            return R.image.spray()
            
        case .solution:
            return R.image.solution()
            
        case .suppository:
            return R.image.suppository()
            
        case .gel:
            return R.image.gel()
            
        case .inhaler:
            return R.image.inhaler()
        }
    }
    
    var doses: [Double] {
        switch self {
        case .capsule:
            return Array(1...10).map { Double($0) }
            
        case .tablet:
            return [0.25, 0.5, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
            
        case .injection:
            return  Array(1...20).map { Double($0) }
            
        case .drops, .solution:
            return Array(1...50).map { Double($0) }
            
        case .sachet, .spray, .inhaler:
            return Array(1...5).map { Double($0) }
            
        case .suppository:
            return Array(1...2).map { Double($0) }
            
        case .gel:
            return [0.5, 1, 2, 3, 4, 5]
        }
    }
    
    var defaultDoseIndex: Int {
        switch self {
        case .capsule, .injection, .drops, .solution, .sachet, .spray, .inhaler, .suppository:
            return 0
            
        case .tablet:
            return 2
            
        case .gel:
            return 1
        }
    }
}
