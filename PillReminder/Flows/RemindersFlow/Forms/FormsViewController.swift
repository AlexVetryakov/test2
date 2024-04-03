//
//  FormsViewController.swift
//  PillReminder
//
//  Created by Александр Ветряков on 29.12.2023.
//

import UIKit
import Combine

final class FormsViewController: BaseViewController, HasCustomView {

    typealias CustomView = FormsView
    
    private let viewModel: FormsViewModel
        
    // MARK: - Lifecycle
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .default }
    
    init(viewModel: FormsViewModel) {
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        customView.apply(itemsCount: viewModel.forms.count)
    }
    
    private func setupTableView() {
        customView.tableView.registerReusableCell(cellType: FormTableViewCell.self)
        customView.tableView.contentInsetAdjustmentBehavior = .never
        customView.tableView.showsVerticalScrollIndicator = false
        customView.tableView.separatorStyle = .none
        customView.tableView.dataSource = self
        customView.tableView.delegate = self
    }
    
    private func initializeBindings() {
        customView.closeButton.tap()
            .sink { [weak self] in
                guard let self = self else { return }
                
                self.customView.hide {
                    self.viewModel.close()
                }
            }
            .store(in: &cancellables)
    }

}

extension FormsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.forms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath, cellType: FormTableViewCell.self)
        
        let isSeparatorNeeded: Bool = indexPath.row != viewModel.forms.count - 1
        cell.apply(title: viewModel.forms[indexPath.row].title, isSeparatorNeeded: isSeparatorNeeded)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        52.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        customView.hide {
            self.viewModel.select(at: indexPath.row)
        }
    }
}

