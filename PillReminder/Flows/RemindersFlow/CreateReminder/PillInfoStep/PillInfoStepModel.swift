//
//  PillInfoStepModel.swift
//  PillReminder
//
//  Created by Александр Ветряков on 03.12.2023.
//

import UIKit
import Combine


final class PillInfoStepModel {
    
    struct PillInfo {
        let name: String
        let form: DrugFormType
        let dose: Double
        let photo: UIImage?
    }
    
    private let handleEvents: PillInfoStepHandable
    @Published private(set) var name: String = ""
    @Published private(set) var currentDose: Double = 1
    @Published private(set) var currentForm: DrugFormType = .tablet
    
    private var doses: [Double] = DrugFormType.tablet.doses
    private var currentDoseIndex: Int = 2
    private var currentPhoto: UIImage?
    
    init(handleEvents: PillInfoStepHandable) {
        self.handleEvents = handleEvents
        
    }
    
    func update(name: String) {
        self.name = name
    }
    
    func update(photo: UIImage?) {
        currentPhoto = photo
    }
    
    func showNext() {
        let pillInfo = PillInfo(
            name: name,
            form: currentForm,
            dose: currentDose,
            photo: currentPhoto
        )
        handleEvents.nextStepAction(pillInfo: pillInfo)
    }
    
    func showForms() {
        handleEvents.showForm { [weak self] form in
            guard let self = self else { return }
            
            self.currentForm = form
            self.doses = form.doses
            self.currentDoseIndex = currentForm.defaultDoseIndex
            self.currentDose = form.doses[currentDoseIndex]
        }
    }
    
    func incrementDose() {
        if currentDoseIndex < doses.count - 1 {
            currentDoseIndex = currentDoseIndex + 1
        }
        currentDose = doses[currentDoseIndex]
    }
    
    func decrimentDose() {
        if currentDoseIndex > 0 {
            currentDoseIndex = currentDoseIndex - 1
        }
        currentDose = doses[currentDoseIndex]
    }
    
}
