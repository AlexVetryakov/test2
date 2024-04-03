//
//  FormsView.swift
//  PillReminder
//
//  Created by Александр Ветряков on 29.12.2023.
//

import UIKit

final class FormsView: BasePopupView {

    let tableView = UITableView()
    let closeButton = UIButton()
    private let navigationView = UIView()
    private let titleLabel = UILabel()
    private let contentView = UIView()
    
    private let navigationHeight: CGFloat = 56.0
    private let cellHeight: CGFloat = 52.0
    
    // MARK: - Life Cycle

    override init() {

        super.init()

        backgroundColor = .black.withAlphaComponent(0.3)
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addCornerRadius(24.0, corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
    }
    
    func apply(itemsCount: Int) {
        var height = navigationHeight + (Double(itemsCount) * cellHeight) + Constants.UI.botomConstraint
        if height >= Constants.UI.screenHeight {
            height = Constants.UI.screenHeight
        }
        contentView.snp.remakeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.top.lessThanOrEqualToSuperview().offset( Constants.UI.screenHeight - height)
        }
        UIView.animate(withDuration: 0.4) {
            self.layoutIfNeeded()
        }
    }
    
    func hide(completion: @escaping (() -> Void)) {
        contentView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(Constants.UI.screenHeight)
            $0.top.equalToSuperview().offset(Constants.UI.screenHeight)
        }
        UIView.animate(withDuration: 0.4) {
            self.layoutIfNeeded()
        }
        UIView.animate(withDuration: 0.4) {
            self.layoutIfNeeded()
        } completion: { _ in
            completion()
        }
    }
    
    private func setupViews() {
        contentView.backgroundColor = R.color.backgroundPrimary()
        addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(Constants.UI.screenHeight)
            $0.top.equalToSuperview().offset(Constants.UI.screenHeight)
        }
        
        contentView.addSubview(navigationView)
        navigationView.snp.makeConstraints {
            $0.height.equalTo(navigationHeight)
            $0.leading.trailing.top.equalToSuperview()
        }
        
        navigationView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        titleLabel.text = R.string.localizable.pillInfoFormTitle()
        titleLabel.numberOfLines = 1
        titleLabel.font = R.font.openSansSemiBold(size: 16.0)
        titleLabel.textColor = R.color.textPrimary()
        titleLabel.textAlignment = .center
        
        navigationView.addSubview(closeButton)
        closeButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16.0)
            $0.size.equalTo(CGSize(width: 24.0, height: 24.0))
        }
        closeButton.setImage(R.image.close(), for: .normal)
        
        contentView.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

}
