//
//  PillDoseCardView.swift
//  PillReminder
//
//  Created by Александр Ветряков on 28.12.2023.
//

import UIKit

final class PillDoseCardView: BaseView {

    let countActionView = CountActionView()
    private let containerView = UIView()

    override init() {

        super.init()

        backgroundColor = .clear
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.addCornerRadius(12.0)
        countActionView.addCornerRadius(8.0)
    }
    
    private func setupViews() {
        addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        containerView.backgroundColor = R.color.backgroundSecondary()
        
        let titleLabel = UILabel()
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.0)
            $0.centerY.equalToSuperview()
        }
        titleLabel.text = R.string.localizable.pillInfoSingleDoseTitle()
        titleLabel.numberOfLines = 1
        titleLabel.font = R.font.openSansSemiBold(size: 16.0)
        titleLabel.textColor = R.color.textPrimary()
        titleLabel.textAlignment = .left
        
        containerView.addSubview(countActionView)
        countActionView.snp.makeConstraints {
            $0.trailing.top.bottom.equalToSuperview().inset(16.0)
        }
    }

}
