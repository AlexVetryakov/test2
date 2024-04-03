//
//  RemindersListModel.swift
//  PillReminder
//
//  Created by Александр Ветряков on 28.11.2023.
//

import UIKit
import Combine

enum RemindersListEvent: NavigationEvent {
    case showCreateRemind
    case showDateChange(currentDate: Date?, mode: UIDatePicker.Mode, completion: ((_ time: Date, _ index: Int?) -> Void)?)
}

final class RemindersListModel: NavigationNode {
    
    @Published private(set) var targetDate: Date = Date().startOfDay
    
    private var dataSource: [[RemindPresentable]] = []
    
    let reloadData = PassthroughSubject<[[RemindPresentable]], Never>()
    let appendNextData = PassthroughSubject<[IndexPath], Never>()
    let appendPreviousData = PassthroughSubject<[IndexPath], Never>()
    let appendDataToEndOfSection = PassthroughSubject<[IndexPath], Never>()
    
    private let perPage: Int = 30
    private var nextPage = 0
    private var backPage = 0
    
    private let reminderService: ReminderService
    
    init(parent: NavigationNode?, reminderService: ReminderService) {
        self.reminderService = reminderService
        
        super.init(parent: parent)
    }
    
    func indexPathOfCalculatedDate() -> IndexPath {
        guard let section = dataSource.firstIndex(where: { $0.first?.date.startOfDay == targetDate.startOfDay }) else {
            return IndexPath(row: 0, section: 0)
        }
        return IndexPath(row: 0, section: section)
    }
    
    func fetchNextRemindes() {
        let result = reminderService.getPlannedRemindersAfter(controlDate: targetDate, page: nextPage, perPage: 30)
        
        guard !result.isEmpty else { return }
        nextPage += 1

        let presentables = result.map { RemindPresentable(plannedRemind: $0) }
        var dictionary = Dictionary(grouping: presentables, by: { $0.date.startOfDay })
        
        if let lastSection = dataSource.last, let firstDate = lastSection.first?.date.startOfDay, let sectionArray = dictionary[firstDate] {
            let nextIndex = dataSource[dataSource.count - 1].count - 1
            var indexPathes: [IndexPath] = []
            sectionArray.enumerated().forEach { index, _ in
                indexPathes.append(IndexPath(row: nextIndex + index, section: dataSource.count - 1))
            }
            dataSource[dataSource.count - 1].append(contentsOf: sectionArray)
            dictionary.removeValue(forKey: firstDate)
            appendDataToEndOfSection.send(indexPathes)
        }
        
        var indexPathes: [IndexPath] = []
        dictionary.keys.sorted().forEach { key in
            if let sectionArray = dictionary[key] {
                sectionArray.enumerated().forEach { index, _ in
                    indexPathes.append(IndexPath(row: index, section: (dataSource.count)))
                }
                dataSource.append(sectionArray)
            }
        }
        appendNextData.send(indexPathes)
    }
    
    func fetchPreviousRemindes() {
        let result = reminderService.getPlannedRemindersBefore(controlDate: targetDate, page: backPage, perPage: perPage)

        guard !result.isEmpty else { return }
        backPage += 1
        
        let presentables = result.map { RemindPresentable(plannedRemind: $0) }
        var dictionary = Dictionary(grouping: presentables, by: { $0.date.startOfDay })
        
        if let firstSection = dataSource.first, let firstDate = firstSection.first?.date.startOfDay, let sectionArray = dictionary[firstDate] {
            dataSource[0].insert(contentsOf: sectionArray, at: 0)
            dictionary.removeValue(forKey: firstDate)
        }
        
        var indexPathes: [IndexPath] = []
        var section: Int = 0
        dictionary.keys.sorted().forEach { key in
            if let sectionArray = dictionary[key] {
                sectionArray.enumerated().forEach { index, _ in
                    indexPathes.append(IndexPath(row: index, section: section))
                }
                dataSource.insert(sectionArray, at: section)
                section += 1
            }
        }
        appendPreviousData.send(indexPathes)
    }
    
    func fetchDefaultReminders() {
        let result = reminderService.getDefaultPlannedReminders(controlDate: targetDate)
        nextPage = 1
        backPage = 1
        let presentables = result.map { RemindPresentable(plannedRemind: $0) }
        let dictionary = Dictionary(grouping: presentables, by: { $0.date.startOfDay })
        dictionary.forEach { dataSource.append($0.value) }

        dataSource.sort { (array1, array2) -> Bool in
            guard let firstDate1 = array1.first?.date, let firstDate2 = array2.first?.date else {
                return false
            }
            return firstDate1 < firstDate2
        }
        reloadData.send(dataSource)
    }
    
    func showAddRemind() {
        raise(event: RemindersListEvent.showCreateRemind)
    }
    
    func showDatePicker() {
        raise(event: RemindersListEvent.showDateChange(currentDate: targetDate, mode: .init(rawValue: 4269)!, completion: { [weak self] date, _ in
            guard let self = self else { return }
            
            self.targetDate = date.startOfMonth ?? Date()
        }))
    }
    
    func showMenu() {
        print("showMenu")
    }
    
    func showDetail(at indexPath: IndexPath) {
        print("showDetail")
    }
    
    func sectionsCount() -> Int {
        dataSource.count
    }
    
    func itemsCount(for section: Int) -> Int {
        dataSource[section].count
    }
    
    func items(for section: Int) -> [RemindPresentable] {
        dataSource[section]
    }
    
    func date(at section: Int) -> Date {
        dataSource[section].first?.date ?? Date()
    }
}
