//
//  NavigationView.swift
//  PillReminder
//
//  Created by Александр Ветряков on 29.11.2023.
//

import UIKit

final class NavigationView: BaseView {

    let backButton: UIButton = UIButton()
    private let titleLabel: UILabel = UILabel()
    
    override init() {

        super.init()

        backgroundColor = .clear
        setupViews()
    }
    
    func apply(title: String, needBackButton: Bool) {
        titleLabel.text = title
        backButton.isHidden = !needBackButton
    }
    
    //MARK: - Setup Views
    
    private func setupViews() {
        setupBackButton()
        setupNavigationTitleLabel()
    }
    
    private func setupBackButton() {
        addSubview(backButton)
        backButton.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 44.0, height: 44.0))
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16.0)
        }
        backButton.setImage(R.image.backIcon(), for: .normal)
    }
    
    private func setupNavigationTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        titleLabel.font = R.font.openSansSemiBold(size: 16.0)
        titleLabel.textColor = R.color.textPrimary()
    }
    
}
