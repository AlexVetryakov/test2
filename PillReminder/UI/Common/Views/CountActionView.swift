//
//  CountActionView.swift
//  PillReminder
//
//  Created by Александр Ветряков on 28.12.2023.
//

import UIKit

final class CountActionView: BaseView {
    
    let plusButton = UIButton()
    let minusButton = UIButton()
    
    private let titleLabel = UILabel()

    override init() {

        super.init()

        backgroundColor = R.color.backgroundPrimary()
        setupViews()
    }
    
    func update(value: String, canDecriment: Bool = true, canIncrement: Bool = true) {
        titleLabel.text = value
        plusButton.isEnabled = canIncrement
        minusButton.isEnabled = canDecriment
    }
    
    private func setupViews() {
        addSubview(minusButton)
        minusButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(4.0)
            $0.leading.equalToSuperview().offset(8.0)
            $0.size.equalTo(CGSize(width: 32.0, height: 32.0))
        }
        minusButton.setImage(R.image.minus(), for: .normal)
        
        addSubview(plusButton)
        plusButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(4.0)
            $0.trailing.equalToSuperview().offset(-8.0)
            $0.size.equalTo(CGSize(width: 32.0, height: 32.0))
        }
        plusButton.setImage(R.image.plus(), for: .normal)
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.trailing.equalTo(plusButton.snp.leading)
            $0.leading.equalTo(minusButton.snp.trailing)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(40.0)
        }
        titleLabel.numberOfLines = 1
        titleLabel.font = R.font.openSansRegular(size: 14.0)
        titleLabel.textColor = R.color.textPrimary()
        titleLabel.textAlignment = .center
    }
}
