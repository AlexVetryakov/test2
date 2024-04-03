//
//  CreateReminderModel.swift
//  PillReminder
//
//  Created by Александр Ветряков on 03.12.2023.
//

import UIKit
import Combine

enum CreateReminderEvent: NavigationEvent {
    case showForm(completion: ((DrugFormType) -> Void)?)
    case showTimeChange(index: Int?, currentDate: Date, maxDate: Date, minDate: Date, mode: UIDatePicker.Mode, completion: ((Date, Int?) -> Void)?)
    case close
    case backToRoot
}

protocol ReminderInfoStepHandable {
    func finishStepAction(reminderInfo: ReminderInfoStepModel.ReminderInfo)
    func showTimeChange(index: Int?, currentDate: Date, maxDate: Date, minDate: Date, mode: UIDatePicker.Mode, completion: ((_ time: Date, _ index: Int?) -> Void)?)
}

protocol PillInfoStepHandable {
    func nextStepAction(pillInfo: PillInfoStepModel.PillInfo)
    func showForm(completion: ((DrugFormType) -> Void)?)
}

final class CreateReminderModel: NavigationNode {
    
    let nextStepSubject = PassthroughSubject<Void, Never>()
    let previousStepSubject = PassthroughSubject<Void, Never>()
    
    private var name: String = ""
    private var form: DrugFormType = .tablet
    private var dose: Double = 1
    private var photo: UIImage?
    
    private var isFirstStep: Bool = true
    private var pillInfo: PillInfoStepModel.PillInfo?
    private let navigationController = UINavigationController()
    private let reminderService: ReminderService
    
    init(parent: NavigationNode?, reminderService: ReminderService) {
        self.reminderService = reminderService
        super.init(parent: parent)
    }
    
    func close() {
        if isFirstStep {
            raise(event: CreateReminderEvent.close)
        } else {
            isFirstStep = true
            previousStepSubject.send(())
            navigationController.popViewController(animated: true)
        }
    }
    
    func createChild() -> UINavigationController {
        let model = PillInfoStepModel(handleEvents: self)
        let viewModel = PillInfoStepViewModel(model: model)
        let controller = PillInfoStepViewController(viewModel: viewModel)
        navigationController.addChild(controller)
        return navigationController
    }
    
    private func showReminderInfoStep() {
        let model = ReminderInfoStepModel(handleEvents: self)
        let viewModel = ReminderInfoStepViewModel(model: model)
        let controller = ReminderInfoStepViewController(viewModel: viewModel)
        navigationController.pushViewController(controller, animated: true)
    }
}

extension CreateReminderModel: PillInfoStepHandable {
    func nextStepAction(pillInfo: PillInfoStepModel.PillInfo) {
        self.pillInfo = pillInfo
        isFirstStep = false
        nextStepSubject.send(())
        showReminderInfoStep()
    }
    
    func showForm(completion: ((DrugFormType) -> Void)?) {
        raise(event: CreateReminderEvent.showForm(completion: completion))
    }
}

extension CreateReminderModel: ReminderInfoStepHandable {
    func showTimeChange(index: Int?, currentDate: Date, maxDate: Date, minDate: Date, mode: UIDatePicker.Mode, completion: ((Date, Int?) -> Void)?) {
        raise(event: CreateReminderEvent.showTimeChange(index: index, currentDate: currentDate, maxDate: maxDate, minDate: minDate, mode: mode, completion: completion))
    }
    
    func finishStepAction(reminderInfo: ReminderInfoStepModel.ReminderInfo) {
        guard let pillInfo = pillInfo else { return }
        
        reminderService.createReminds(reminderInfo: reminderInfo, pillInfo: pillInfo)
        raise(event: CreateReminderEvent.backToRoot)
    }
}
