//
//  CreateReminderViewController.swift
//  PillReminder
//
//  Created by Александр Ветряков on 03.12.2023.
//

import UIKit
import Combine

final class CreateReminderViewController: BaseViewController, HasCustomView {

    typealias CustomView = CreateReminderView
    
    private let viewModel: CreateReminderViewModel
    
    var navigation: UINavigationController?
    
    // MARK: - Lifecycle
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .default }
    
    init(viewModel: CreateReminderViewModel) {
        self.viewModel = viewModel
        
        super.init()
    }
    
    override func loadView() {
        view = CustomView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        initializeBindings()
    }
    
    // MARK: - Initialize bindings
    
    private func initializeBindings() {
        viewModel.nextStepSubject
            .sink { [weak self] in
                guard let self = self else { return }
                
                self.customView.stepsProgressView.nextStep()
            }
            .store(in: &cancellables)
        
        viewModel.previousStepSubject
            .sink { [weak self] in
                guard let self = self else { return }
                
                self.customView.stepsProgressView.previousStep()
            }
            .store(in: &cancellables)
        
        customView.backButton.tap()
            .sink { [weak self] in
                guard let self = self else { return }
                
                self.viewModel.backAction()
            }
            .store(in: &cancellables)
    }
    
    private func setupViews() {
        navigation = viewModel.createChild()
        addViewController(navigation, view: customView)
    }
    
    private func addViewController(_ controller: UIViewController?, view: UIView) {
        guard let controller = controller else { return }
        
        if (!view.subviews.contains(controller.view)) {
            addChild(controller)
            view.addSubview(controller.view)
            controller.view.snp.makeConstraints {
                $0.leading.trailing.bottom.equalToSuperview()
                $0.top.equalTo(customView.navigationView.snp.bottom)
            }
            controller.didMove(toParent: self)
        }
    }
}
