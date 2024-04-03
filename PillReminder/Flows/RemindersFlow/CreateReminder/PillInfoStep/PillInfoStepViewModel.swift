//
//  PillInfoStepViewModel.swift
//  PillReminder
//
//  Created by Александр Ветряков on 03.12.2023.
//

import UIKit
import Combine

final class PillInfoStepViewModel: CancellablesApplicable {
    
    @Published private(set) var name: String = ""
    @Published private(set) var currentDose: String = "1"
    @Published private(set) var currentForm: DrugFormType = .tablet
    
    var cancellables: [AnyCancellable] = []

    private let model: PillInfoStepModel
    
    init(model: PillInfoStepModel) {
        self.model = model
        
        initializeBindings()
    }
    
    func update(name: String) {
        model.update(name: name)
    }
    
    func update(photo: UIImage?) {
        model.update(photo: photo)
    }
    
    func incrementDose() {
        model.incrementDose()
    }
    
    func decrimentDose() {
        model.decrimentDose()
    }
    
    func showForms() {
        model.showForms()
    }
    
    func showNext() {
        model.showNext()
    }
    
    private func initializeBindings() {
        model.$name
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                guard let self = self else { return }
                
                self.name = data
            }.store(in: &cancellables)
        
        model.$currentDose
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                guard let self = self else { return }
                
                self.currentDose = StringBuilder.Dose.doseToString(count: value)
            }.store(in: &cancellables)
        
        model.$currentForm
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                guard let self = self else { return }
                
                self.currentForm = data
            }.store(in: &cancellables)
    }
    
}
