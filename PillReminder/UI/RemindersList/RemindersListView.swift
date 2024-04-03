//
//  RemindersListView.swift
//  PillReminder
//
//  Created by Александр Ветряков on 28.11.2023.
//

import UIKit

final class RemindersListView: BaseView {
    
    let menuButton = UIButton()
    let addButton = UIButton()
    let dateButton = UIButton()
    let tableView = UITableView()
    let placeholderView = RemindersListPlaceholderView()
    
    private let titleLabel = UILabel()
    private let navigationView = UIView()
    
    override init() {

        super.init()

        backgroundColor = R.color.backgroundPrimary()
        setupViews()
    }
    
    func setPlaceholderHidden(_ isHidden: Bool) {
        tableView.backgroundView = isHidden ? nil : placeholderView
    }
    
    func apply(title: String) {
        titleLabel.text = title
    }
    
    private func setupViews() {
        setupNavigation()
        setupTableView()
    }
    
    private func setupNavigation() {
        addSubview(navigationView)
        navigationView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(48.0)
            $0.leading.trailing.equalToSuperview()
        }
        navigationView.backgroundColor = R.color.backgroundPrimary()
        
        navigationView.addSubview(menuButton)
        menuButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16.0)
            $0.size.equalTo(CGSize(width: 24.0, height: 24.0))
            $0.centerY.equalToSuperview()
        }
        menuButton.setImage(R.image.burgerMenuIcon(), for: .normal)
        
        navigationView.addSubview(addButton)
        addButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16.0)
            $0.size.equalTo(CGSize(width: 24.0, height: 24.0))
            $0.centerY.equalToSuperview()
        }
        addButton.setImage(R.image.addReminderIcon(), for: .normal)
        
        let containerView = UIView()
        navigationView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }

        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.bottom.top.equalToSuperview()
        }
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 1
        titleLabel.font = R.font.openSansSemiBold(size: 16.0)
        titleLabel.textColor = R.color.textPrimary()
        
        let arrowImageView = UIImageView(image: R.image.arrowDropDownBigIcon())
        containerView.addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints {
            $0.trailing.bottom.top.equalToSuperview()
            $0.leading.equalTo(titleLabel.snp.trailing).offset(8.0)
        }
        arrowImageView.contentMode = .center
        
        containerView.addSubview(dateButton)
        dateButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        let separatorView = UIView()
        navigationView.addSubview(separatorView)
        separatorView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1.0)
        }
        separatorView.backgroundColor = R.color.divider()
    }
    
    private func setupTableView() {
        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(navigationView.snp.bottom)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }

}


