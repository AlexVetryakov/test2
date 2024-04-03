//
//  RemindersListViewController.swift
//  PillReminder
//
//  Created by Александр Ветряков on 28.11.2023.
//

import UIKit
import Combine

final class RemindersListViewController: BaseViewController, HasCustomView {
    
    typealias CustomView = RemindersListView
    
    private let viewModel: RemindersListViewModel
    
    // MARK: - Lifecycle
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .default }
    
    init(viewModel: RemindersListViewModel) {
        self.viewModel = viewModel
        
        super.init()
    }
    
    override func loadView() {
        view = CustomView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        initializeBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.fetchDefaultReminders()
    }
    
    // MARK: - Initialize bindings
    
    private func initializeBindings() {
        customView.dateButton.tap()
            .sink { [weak self] in
                self?.viewModel.showDatePicker()
            }
            .store(in: &cancellables)
        
        customView.addButton.tap()
            .sink { [weak self] in
                self?.viewModel.showAddRemind()
            }
            .store(in: &cancellables)
        
        customView.placeholderView.proceedButton.tap()
            .sink { [weak self] in
                self?.viewModel.showAddRemind()
            }
            .store(in: &cancellables)
        
        customView.menuButton.tap()
            .sink { [weak self] in
                self?.viewModel.showMenu()
            }
            .store(in: &cancellables)
        
        viewModel.reloadData
            .receive(on: DispatchQueue.main)
            .map { !$0.isEmpty }
            .sink { [weak self] isHidden in
                guard let self = self else { return }
                
                if !isHidden {
                    self.customView.setPlaceholderHidden(isHidden)
                    return
                }
                self.customView.tableView.reloadData()
                let toIndexPath = self.viewModel.indexPathOfCalculatedDate()
                self.customView.tableView.scrollToRow(at: toIndexPath, at: .top, animated: false)
            }.store(in: &cancellables)
        
        viewModel.appendDataToEndOfSection
            .receive(on: DispatchQueue.main)
            .sink { [weak self] indexPathes in
                guard let self = self else { return }

                self.customView.tableView.insertRows(at: indexPathes, with: .automatic)
            }.store(in: &cancellables)
        
        viewModel.appendNextData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] indexPathes in
                guard let self = self else { return }

                self.customView.tableView.reloadData()
            }.store(in: &cancellables)
        
        viewModel.appendPreviousData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] indexPathes in
                guard let self = self else { return }

                self.customView.tableView.performBatchUpdates({
                    indexPathes.enumerated().forEach { index, value in
                        self.customView.tableView.insertSections(IndexSet(integer: indexPathes[index].section), with: .bottom)
                    }
                    self.customView.tableView.insertRows(at: indexPathes, with: .bottom)
                })
            }.store(in: &cancellables)
        
        viewModel.$date
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink { [weak self] date in
                guard let self = self else { return }
                
                self.customView.apply(title: date)
              //  self.viewModel.fetchRemindes()
            }.store(in: &cancellables)
    }
    
    // MARK: - SetupViews
    private func setupTableView() {
        customView.tableView.registerReusableCell(cellType: RemindTableViewCell.self)
        customView.tableView.contentInsetAdjustmentBehavior = .never
        customView.tableView.showsVerticalScrollIndicator = false
        customView.tableView.separatorStyle = .none
        customView.tableView.dataSource = self
        customView.tableView.delegate = self
        customView.tableView.estimatedRowHeight = 72.0
    }
}

extension RemindersListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sectionsCount()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = RemindersListSectionHeaderView()
        header.apply(title: viewModel.headerTitle(for: section), isCurrent: viewModel.isCurrentDay(section: section))
        
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.itemsCount(for: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath, cellType: RemindTableViewCell.self)
        
        let items = viewModel.items(for: indexPath.section)
        let model = items[indexPath.row]
        
        cell.apply(remindPresentable: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.showDetail(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == viewModel.sectionsCount() - 1 && indexPath.row == viewModel.itemsCount(for: indexPath.section) - 1 {
            viewModel.loadNextPage()
        }
    }
    
}

extension RemindersListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 100.0 {
            viewModel.loadPreviousPage()
        }
    }
}
