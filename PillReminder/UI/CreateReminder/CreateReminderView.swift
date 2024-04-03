//
//  CreateReminderView.swift
//  PillReminder
//
//  Created by Александр Ветряков on 03.12.2023.
//

import UIKit

final class CreateReminderView: BaseView {
    
    let backButton: UIButton = UIButton()
    let navigationView: UIView = UIView()
    let stepsProgressView = StepsProgressView(stepsCount: 2)
    private let titleLabel: UILabel = UILabel()

    override init() {

        super.init()

        backgroundColor = R.color.backgroundPrimary()
        setupViews()
    }
    
    private func setupViews() {
        
        addSubview(navigationView)
        navigationView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(48.0)
            $0.leading.trailing.equalToSuperview()
        }
        navigationView.backgroundColor = R.color.backgroundPrimary()
        
        navigationView.addSubview(backButton)
        backButton.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 44.0, height: 44.0))
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16.0)
        }
        backButton.setImage(R.image.backIcon(), for: .normal)
        
        navigationView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        titleLabel.font = R.font.openSansSemiBold(size: 16.0)
        titleLabel.textColor = R.color.textPrimary()
        titleLabel.text = R.string.localizable.createReminderNavigationTitle()
        
        navigationView.addSubview(stepsProgressView)
        stepsProgressView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(2.0)
        }
        stepsProgressView.backgroundColor = R.color.base()
    }

}
