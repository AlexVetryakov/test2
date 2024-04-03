//
//  TimePickerViewController.swift
//  PillReminder
//
//  Created by Александр Ветряков on 16.01.2024.
//

import UIKit
import Combine

final class TimePickerViewController: BaseViewController, HasCustomView {

    typealias CustomView = TimePickerView
    
    private let viewModel: TimePickerViewModel
        
    // MARK: - Lifecycle
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .default }
    
    init(viewModel: TimePickerViewModel) {
        self.viewModel = viewModel
        
        super.init()
    }
    
    override func loadView() {
        view = CustomView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupPickerView()
        initializeBindings()
    }
    
    private func setupPickerView() {
        customView.datePickerView.calendar = Calendar.current
        customView.datePickerView.minimumDate = viewModel.minDate()
        customView.datePickerView.maximumDate = viewModel.maxDate()
        customView.datePickerView.date = viewModel.currentDate() ?? Date()
        customView.datePickerView.datePickerMode = viewModel.mode()
        customView.datePickerView.preferredDatePickerStyle = .wheels
        customView.datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
    }
    
    private func initializeBindings() {
        customView.closeAction = { [weak self] in
            self?.viewModel.close()
        }
        
        customView.actionButton.tap()
            .sink { [weak self] in
                self?.viewModel.acceptSelected()
            }
            .store(in: &cancellables)
    }
    
    @objc
    private func handleDatePicker(sender: UIDatePicker) {
        viewModel.select(date: sender.date)
     }
}

