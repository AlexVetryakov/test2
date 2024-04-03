//
//  ReminderInfoStepViewController.swift
//  PillReminder
//
//  Created by Александр Ветряков on 03.12.2023.
//

import UIKit

final class ReminderInfoStepViewController: BaseViewController, HasCustomView {

    typealias CustomView = ReminderInfoStepView
    
    private let viewModel: ReminderInfoStepViewModel
    
    // MARK: - Lifecycle
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .default }
    
    init(viewModel: ReminderInfoStepViewModel) {
        self.viewModel = viewModel
        
        super.init()
    }
    
    override func loadView() {
        view = CustomView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initializeBindings()
        initializeClosures()
        setupDefaultValues()
        
        NotificationCenter.default.addObserver(self,
           selector: #selector(self.keyboardNotification(notification:)),
           name: UIResponder.keyboardWillChangeFrameNotification,
           object: nil)
    }
    
    private func setupDefaultValues() {
        customView.scheduleCardView.weekDaysView.apply(selectedDays: viewModel.selectedWeekDayCalendarIndexes)
        customView.periodCardView.daysPeriodInputField.textField.text = viewModel.daysCount
        customView.dailyPillsCardView.apply(
            title: StringBuilder.Plural.countByDay(count: viewModel.selectedTimeSlots.count)
        )
    }
    
    // MARK: - Initialize bindings
    
    private func initializeBindings() {
        customView.scheduleCardView.daysSelectableView.actionButton.tap()
            .sink { [weak self] in
                self?.viewModel.select(schedulePatternType: .weekDays)
                self?.customView.dailyPillsCardView.isHidden = false
            }
            .store(in: &cancellables)
        
        customView.scheduleCardView.cycleSelectableView.actionButton.tap()
            .sink { [weak self] in
                self?.viewModel.select(schedulePatternType: .cycles)
                self?.customView.dailyPillsCardView.isHidden = false
            }
            .store(in: &cancellables)
        
        customView.actionButton.tap()
            .sink { [weak self] in
                self?.viewModel.createReminder()
            }
            .store(in: &cancellables)
        
        customView.dailyPillsCardView.plusButton.tap()
            .sink { [weak self] in
                guard let self = self else { return }
                
                self.viewModel.appendTimeSlot()
                self.customView.periodCardView.isHidden = false
                self.customView.actionButton.isHidden = false
            }
            .store(in: &cancellables)
        
        viewModel.$schedulePatternType
            .sink { [weak self] type in
                guard let self = self, let type = type else { return }
                
                customView.update(schedulePatternType: type)
            }
            .store(in: &cancellables)
        
        viewModel.timeSlotAppended
            .sink { [weak self] component in
                guard let self = self, let _ = component else { return }
                
                self.customView.dailyPillsCardView.append(
                    time: viewModel.timeSlotTitle(at: self.viewModel.selectedTimeSlots.count - 1),
                    index: self.viewModel.selectedTimeSlots.count - 1)
            }
            .store(in: &cancellables)
        
        viewModel.changeTimeAtIndex
            .receive(on: DispatchQueue.main)
            .sink { [weak self] dateComponent, index in
                guard let self = self else { return }
                
                self.customView.dailyPillsCardView.update(time: viewModel.timeSlotTitle(at: index), index: index)
            }
            .store(in: &cancellables)
        
        viewModel.$startDate
            .sink { [weak self] date in
                guard let self = self else { return }
                
                self.customView.periodCardView.startPeriodInputField.textField.text = date
            }
            .store(in: &cancellables)
        
        viewModel.$endDate
            .sink { [weak self] date in
                guard let self = self else { return }
                
                self.customView.periodCardView.endPeriodInputField.textField.text = date
            }
            .store(in: &cancellables)
    }
    
    private func initializeClosures() {
        customView.scheduleCardView.weekDaysView.daySelectedHandler = { [weak self] calendarIndex in
            self?.viewModel.selectWeekDay(at: calendarIndex)
        }
        
        customView.dailyPillsCardView.changeTimeAction = { [weak self] index in
            self?.viewModel.showTimePIcker(for: index)
        }
        
        customView.dailyPillsCardView.deleteTimeAction = { [weak self] index in
            guard let self = self else { return }
            
            self.customView.dailyPillsCardView.remove(at: index)
            self.viewModel.removeTimeSlot(at: index)
        }
        
        customView.periodCardView.startPeriodInputField.didSelectDateHandler = { [weak self] date in
            guard let self = self else { return }
            
            self.viewModel.update(startDate: date)
        }
        
        customView.periodCardView.daysPeriodInputField.onTextChanged = { [weak self] text in
            guard let self = self else { return }
            
            self.viewModel.update(daysCount: text)
        }
    }
    
    @objc private func keyboardNotification(notification: NSNotification) {
      guard let userInfo = notification.userInfo else { return }

      let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
      let endFrameY = endFrame?.origin.y ?? 0
      let duration: TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0

      if endFrameY >= UIScreen.main.bounds.size.height {
          customView.animateKayboard(duration: duration, keyboardHeight: 0.0)
      } else {
          customView.animateKayboard(duration: duration, keyboardHeight: endFrame?.size.height ?? 0.0)
      }
    }

}
