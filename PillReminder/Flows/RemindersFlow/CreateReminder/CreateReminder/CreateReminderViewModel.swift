//
//  CreateReminderViewModel.swift
//  PillReminder
//
//  Created by Александр Ветряков on 03.12.2023.
//

import UIKit
import Combine

final class CreateReminderViewModel {
    
    var nextStepSubject: PassthroughSubject<Void, Never> { model.nextStepSubject }
    var previousStepSubject: PassthroughSubject<Void, Never> { model.previousStepSubject }
    
    private let model: CreateReminderModel
    
    init(model: CreateReminderModel) {
        self.model = model
        
        initializeBindings()
    }
    
    func createChild() -> UINavigationController {
        model.createChild()
    }
    
    func backAction() {
        model.close()
    }
    
    private func initializeBindings() {
        
    }
}
