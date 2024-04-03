//
//  PillActionCardView.swift
//  PillReminder
//
//  Created by Александр Ветряков on 27.12.2023.
//

import UIKit

final class PillActionCardView: BaseView {
    
    let actionButton = UIButton()
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

    override init() {

        super.init()

        backgroundColor = .clear
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.addCornerRadius(12.0)
    }
    
    func update(value: String) {
        subtitleLabel.text = value
    }
    
    func apply(title: String) {
        titleLabel.text = title
    }
    
    private func setupViews() {
        addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        containerView.backgroundColor = R.color.backgroundSecondary()
        
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(16.0)
        }
        titleLabel.numberOfLines = 1
        titleLabel.font = R.font.openSansSemiBold(size: 16.0)
        titleLabel.textColor = R.color.textPrimary()
        titleLabel.textAlignment = .left
        
        let arrowImageView = UIImageView(image: R.image.arrowRight())
        containerView.addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16.0)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(CGSize(width: 24.0, height: 24.0))
        }
        
        containerView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints {
            $0.trailing.equalTo(arrowImageView.snp.leading).offset(-8.0)
            $0.centerY.equalToSuperview()
            $0.leading.greaterThanOrEqualTo(titleLabel.snp.trailing).offset(8.0)
        }
        subtitleLabel.numberOfLines = 1
        subtitleLabel.font = R.font.openSansRegular(size: 14.0)
        subtitleLabel.textColor = R.color.textPrimary()
        subtitleLabel.textAlignment = .right
        
        containerView.addSubview(actionButton)
        actionButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}
