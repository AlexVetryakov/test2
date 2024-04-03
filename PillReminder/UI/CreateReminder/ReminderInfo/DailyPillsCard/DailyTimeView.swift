//
//  DailyTimeView.swift
//  PillReminder
//
//  Created by Александр Ветряков on 09.01.2024.
//

import UIKit

final class DailyTimeView: BaseView {
    
    var deleteAction: ((Int) -> Void)?
    var changeTimeAction: ((Int) -> Void)?
    
    private let countLabel = UILabel()
    private let timeLabel = UILabel()
    private let actionButton = UIButton()
    private let deleteButton = UIButton()

    override init() {

        super.init()

        backgroundColor = .clear
        setupViews()
    }
    
    func apply(time: String, count: String) {
        countLabel.text = count
        timeLabel.text = time
    }
    
    private func setupViews() {
        addSubview(countLabel)
        countLabel.snp.makeConstraints {
            $0.leading.centerY.equalToSuperview()
        }
        countLabel.numberOfLines = 1
        countLabel.font = R.font.openSansRegular(size: 14.0)
        countLabel.textColor = R.color.textPrimary()
        countLabel.textAlignment = .left
        
        addSubview(deleteButton)
        deleteButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12.0)
            $0.trailing.equalToSuperview()
            $0.size.equalTo(CGSize(width: 32.0, height: 32.0))
        }
        deleteButton.setImage(R.image.trash(), for: .normal)
        deleteButton.imageView?.contentMode = .center
        deleteButton.addTarget(self, action: #selector(deleteButtonTouchUpInside), for: .touchUpInside)
        
        let timeContainerView = UIView()
        addSubview(timeContainerView)
        timeContainerView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.height.equalTo(32.0)
        }
        
        timeContainerView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        timeLabel.numberOfLines = 1
        timeLabel.font = R.font.openSansRegular(size: 14.0)
        timeLabel.textColor = R.color.textPrimary()
        timeLabel.textAlignment = .left
        
        let arrowImageView = UIImageView(image: R.image.arrowRight())
        timeContainerView.addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.leading.equalTo(timeLabel.snp.trailing).offset(8.0)
            $0.size.equalTo(CGSize(width: 24.0, height: 24.0))
            $0.centerY.equalToSuperview()
        }
        
        timeContainerView.addSubview(actionButton)
        actionButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        actionButton.addTarget(self, action: #selector(actionButtonTouchUpInside), for: .touchUpInside)
        
        let separatorView = UIView()
        addSubview(separatorView)
        separatorView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1.0)
        }
        separatorView.backgroundColor = R.color.divider()
    }
    
    @objc
    private func deleteButtonTouchUpInside() {
        deleteAction?(tag)
    }
    
    @objc
    private func actionButtonTouchUpInside() {
        changeTimeAction?(tag)
    }

}
