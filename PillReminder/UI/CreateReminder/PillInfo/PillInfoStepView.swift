//
//  PillInfoStepView.swift
//  PillReminder
//
//  Created by Александр Ветряков on 03.12.2023.
//

import UIKit

final class PillInfoStepView: BaseView {
    
    let nameCardView = PillNameCardView()
    let formCardView = PillActionCardView()
    let doseCardView = PillDoseCardView()
    let makePhotoCardView = PillActionCardView()
    let photoImageView = UIImageView()
    let proceedButton = PrimaryButton()
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    override init() {

        super.init()

        backgroundColor = R.color.backgroundPrimary()
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        photoImageView.addCornerRadius(12.0)
    }
    
    private func setupViews() {
        addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-(80.0 + Constants.UI.botomConstraint))
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
        }

        contentView.backgroundColor = R.color.backgroundPrimary()
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        contentView.addSubview(nameCardView)
        nameCardView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16.0)
            $0.top.equalToSuperview().offset(16.0)
        }
        
        contentView.addSubview(formCardView)
        formCardView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16.0)
            $0.top.equalTo(nameCardView.snp.bottom).offset(16.0)
        }
        formCardView.apply(title: R.string.localizable.pillInfoFormTitle())
        
        contentView.addSubview(doseCardView)
        doseCardView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16.0)
            $0.top.equalTo(formCardView.snp.bottom).offset(16.0)
        }
        
        contentView.addSubview(makePhotoCardView)
        makePhotoCardView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16.0)
            $0.top.equalTo(doseCardView.snp.bottom).offset(16.0)
        }
        makePhotoCardView.apply(title: R.string.localizable.pillInfoMakePhotoTitle())
        
        contentView.addSubview(photoImageView)
        photoImageView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(16.0)
            $0.top.equalTo(makePhotoCardView.snp.bottom).offset(16.0)
            $0.size.equalTo(CGSize(width: (Constants.UI.screenWidth - 32.0), height: (Constants.UI.screenWidth - 32.0)))
        }
        photoImageView.isHidden = true
        
        let buttonView = UIView()
        buttonView.backgroundColor = R.color.backgroundPrimary()
        addSubview(buttonView)
        buttonView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
        buttonView.addSubview(proceedButton)
        proceedButton.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview().inset(16.0)
            $0.height.equalTo(48.0)
        }
        proceedButton.isEnabled = false
        proceedButton.setTitle(R.string.localizable.commonNextTitle(), for: .normal)
    }
}
