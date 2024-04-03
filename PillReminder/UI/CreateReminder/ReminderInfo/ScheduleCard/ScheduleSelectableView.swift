//
//  ScheduleSelectableView.swift
//  PillReminder
//
//  Created by Александр Ветряков on 08.01.2024.
//

import UIKit

final class ScheduleSelectableView: BaseView {
    
    let actionButton = UIButton()
    
    private let titleLabel = UILabel()
    private let checkImageView = UIImageView()

    override init() {

        super.init()

        backgroundColor = .clear
        setupViews()
    }
    
    func update(isSelected: Bool) {
        checkImageView.image = isSelected ? R.image.check() : UIImage()
    }
    
    func apply(title: String) {
        titleLabel.text = title
    }
    
    private func setupViews() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.centerY.equalToSuperview()
        }
        titleLabel.numberOfLines = 1
        titleLabel.font = R.font.openSansRegular(size: 14.0)
        titleLabel.textColor = R.color.textPrimary()
        titleLabel.textAlignment = .left
        
        addSubview(checkImageView)
        checkImageView.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 24.0, height: 24.0))
            $0.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(16.0)
        }
        
        addSubview(actionButton)
        actionButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
