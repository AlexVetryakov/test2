//
//  FormsViewModel.swift
//  PillReminder
//
//  Created by Александр Ветряков on 29.12.2023.
//

import UIKit

final class FormsViewModel {
    
    var forms: [DrugFormType] { model.forms }
    
    private let model: FormsModel
    
    init(model: FormsModel) {
        self.model = model
        
    }
    
    func select(at index: Int) {
        model.select(at: index)
    }
    
    func close() {
        model.close()
    }

}
