//
//  RemindersFlow.swift
//  PillReminder
//
//  Created by Александр Ветряков on 28.11.2023.
//

import Swinject

final class RemindersFlow: NavigationNode, Flow {
    
    weak var containerViewController: UIViewController?
        
    private let container: Container
    
    // MARK: - Init
    
    init(parentNode: NavigationNode, parentContainer: Container?) {
        self.container = Container(parent: parentContainer)
        
        super.init(parent: parentNode)

        observeEvents()
    }
    
    func createFlow() -> UIViewController {
        let model = RemindersListModel(parent: self, reminderService: container.autoresolve())
        let viewModel = RemindersListViewModel(model: model)
        let viewController = RemindersListViewController(viewModel: viewModel)
        
        return viewController
    }
    
    // MARK: - Events observering
    
    private func observeEvents() {
        addHandler { [weak self] (event: RemindersListEvent) in
            guard let self = self else { return }
            
            switch event {
            case .showCreateRemind:
                self.openCreateRemind()
                
            case .showDateChange(let currentDate, let mode, let completion):
                self.showTimePicker(index: nil, currentDate: currentDate, maxDate: nil, minDate: nil, mode: mode, completion: completion)
            }
        }
        
        addHandler { [weak self] (event: CreateReminderEvent) in
            guard let self = self else { return }
            
            switch event {
            case .showForm(let completion):
                self.showForms(completion: completion)
                
            case .close:
                navigationController?.popViewController(animated: true)
                
            case .showTimeChange(let index, let currentDate, let maxDate, let minDate, let mode, let completion):
                self.showTimePicker(index: index, currentDate: currentDate, maxDate: maxDate, minDate: minDate, mode: mode, completion: completion)
                
            case .backToRoot:
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
        
        addHandler { [weak self] (event: FormsEvent) in
            guard let self = self else { return }
            
            switch event {
            case .close:
                self.navigationController?.dismiss(animated: true)
            }
        }
        
        addHandler { [weak self] (event: TimePickerEvent) in
            guard let self = self else { return }
            
            switch event {
            case .close:
                self.navigationController?.dismiss(animated: true)
            }
        }
    }
    
    private func openCreateRemind() {
        let model = CreateReminderModel(parent: self, reminderService: container.autoresolve())
        let viewModel = CreateReminderViewModel(model: model)
        let controller = CreateReminderViewController(viewModel: viewModel)
        
        controller.navigationItem.hidesBackButton = true

        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func showForms(completion: ((DrugFormType) -> Void)?) {
        let model = FormsModel(parent: self, completion: completion)
        let viewModel = FormsViewModel(model: model)
        let controller = FormsViewController(viewModel: viewModel)
        controller.modalPresentationStyle = .overCurrentContext
        controller.modalTransitionStyle = .crossDissolve

        navigationController?.present(controller, animated: false)
    }
    
    private func showTimePicker(index: Int?, currentDate: Date?, maxDate: Date?, minDate: Date?, mode: UIDatePicker.Mode, completion: ((Date, Int?) -> Void)?) {
        let model = TimePickerModel(
            parent: self,
            index: index,
            currentDate: currentDate,
            maxDate: maxDate,
            minDate: minDate, 
            mode: mode,
            completion: completion
        )
        let viewModel = TimePickerViewModel(model: model)
        let controller = TimePickerViewController(viewModel: viewModel)
        controller.modalPresentationStyle = .overCurrentContext
        controller.modalTransitionStyle = .crossDissolve

        navigationController?.present(controller, animated: false)
    }
}

