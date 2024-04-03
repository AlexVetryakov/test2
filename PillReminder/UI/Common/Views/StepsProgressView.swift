//
//  StepsProgressView.swift
//  PillReminder
//
//  Created by Александр Ветряков on 02.01.2024.
//

import UIKit

final class StepsProgressView: BaseView {
    
    private var currentStep: Double = 1.0
    
    private let trackView = UIView()
    private let progressView = UIView()
    
    private let stepsCount: Int

    init(stepsCount: Int) {
        self.stepsCount = stepsCount

        super.init()

        backgroundColor = R.color.backgroundPrimary()
        setupViews()
    }
    
    func nextStep() {
        currentStep += 1
        progressView.snp.remakeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.width.equalTo(Constants.UI.screenWidth * ( currentStep / Double(stepsCount) ))
        }
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    func previousStep() {
        currentStep -= 1
        progressView.snp.remakeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.width.equalTo(Constants.UI.screenWidth * ( currentStep / Double(stepsCount) ))
        }
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    private func setupViews() {
        addSubview(trackView)
        trackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        trackView.backgroundColor = R.color.divider()
        
        addSubview(progressView)
        progressView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.width.equalTo(Constants.UI.screenWidth / Double(stepsCount))
        }
        progressView.backgroundColor = R.color.base()
    }
}
