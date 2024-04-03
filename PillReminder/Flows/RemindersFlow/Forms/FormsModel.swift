//
//  FormsModel.swift
//  PillReminder
//
//  Created by Александр Ветряков on 29.12.2023.
//

import UIKit

enum FormsEvent: NavigationEvent {
    case close
}

final class FormsModel: NavigationNode {
    
    let forms: [DrugFormType] = [.capsule, .tablet, .injection, .drops, .sachet, .spray, .solution, .suppository, .gel, .inhaler]
    
    private let completion: ((DrugFormType) -> Void)?
    
    init(parent: NavigationNode?, completion: ((DrugFormType) -> Void)?) {
        self.completion = completion
        
        super.init(parent: parent)
    }
    
    func select(at index: Int) {
        completion?(forms[index])
        raise(event: FormsEvent.close)
    }
    
    func close() {
        raise(event: FormsEvent.close)
    }

}
