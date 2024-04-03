//
//  RemindersListViewModel.swift
//  PillReminder
//
//  Created by Александр Ветряков on 28.11.2023.
//

import UIKit
import Combine

final class RemindersListViewModel: CancellablesApplicable {
    
    var cancellables: [AnyCancellable] = []
    
    var reloadData: PassthroughSubject<[[RemindPresentable]], Never> { model.reloadData }
    var appendDataToEndOfSection: PassthroughSubject<[IndexPath], Never> { model.appendDataToEndOfSection }
    var appendNextData: PassthroughSubject<[IndexPath], Never> { model.appendNextData }
    var appendPreviousData: PassthroughSubject<[IndexPath], Never> { model.appendPreviousData }
    
    @Published private(set) var date: String = ""
    
    private let model: RemindersListModel
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }

    init(model: RemindersListModel) {
        self.model = model
        
        initializeBindings()
    }
    
    func itemsCount(for section: Int) -> Int {
        model.itemsCount(for: section)
    }
    
    func items(for section: Int) -> [RemindPresentable] {
        model.items(for: section)
    }
    
    func sectionsCount() -> Int {
        model.sectionsCount()
    }
    
    func loadNextPage() {
        model.fetchNextRemindes()
    }
    
    func loadPreviousPage() {
        model.fetchPreviousRemindes()
    }
    
    func indexPathOfCalculatedDate() -> IndexPath {
        model.indexPathOfCalculatedDate()
    }
    
    func headerTitle(for section: Int) -> String {
        let date = model.date(at: section)
        if date.isToday {
            return R.string.localizable.commonTodayTitle()
        } else {
            return  DateFormatter.weekDayMonthYearDate.string(from: date)
        }
    }
    
    func isCurrentDay(section: Int) -> Bool {
        model.date(at: section).isToday
    }
    
    func fetchNextRemindes() {
        model.fetchNextRemindes()
    }
    
    func fetchDefaultReminders() {
        model.fetchDefaultReminders()
    }
    
    func showAddRemind() {
        model.showAddRemind()
    }
    
    func showMenu() {
        model.showMenu()
    }
    
    func showDatePicker() {
        model.showDatePicker()
    }
    
    func showDetail(at indexPath: IndexPath) {
        model.showDetail(at: indexPath)
    }
    
    private func initializeBindings() {
                
        model.$targetDate
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                guard let self = self else { return }
                
                self.date = DateFormatter.monthDate.string(from: value).capitalized
            }.store(in: &cancellables)
    }

}
