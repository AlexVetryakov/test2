//
//  RemindTableViewCell.swift
//  PillReminder
//
//  Created by Александр Ветряков on 01.12.2023.
//

import UIKit
import Combine

final class RemindTableViewCell: UITableViewCell,  Reusable {
    
    private let containerView = UIView()
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let timeLabel = UILabel()
    
    private var cancellables: [AnyCancellable] = []
    
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = R.color.backgroundPrimary()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
    
    func apply(remindPresentable: RemindPresentable) {
        iconImageView.image = remindPresentable.iconImage
        titleLabel.text = remindPresentable.name
        subtitleLabel.text = remindPresentable.dose
        timeLabel.text = remindPresentable.time
        containerView.backgroundColor = remindPresentable.status.backgroundColor
    }
    
    // MARK: - UI
    private func setupViews() {
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(6.0)
            $0.leading.trailing.equalToSuperview().inset(16.0)
        }
        containerView.addCornerRadius(12.0)
        
        containerView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12.0)
            $0.leading.equalToSuperview().inset(16.0)
         //   $0.bottom.lessThanOrEqualToSuperview().inset(12.0)
            $0.size.equalTo(CGSize(width: 48.0, height: 48.0))
        }
        iconImageView.addCornerRadius(24.0)
        iconImageView.contentMode = .center
        iconImageView.backgroundColor = R.color.backgroundPrimary()
        
        containerView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16.0)
            $0.centerY.equalToSuperview()
            $0.width.greaterThanOrEqualTo(40.0)
        }
        timeLabel.textAlignment = .right
        
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(16.0)
            $0.top.equalToSuperview().offset(12.0)
            $0.trailing.equalTo(timeLabel.snp.leading).offset(-12.0)
        }
        titleLabel.numberOfLines = 1
        titleLabel.font = R.font.openSansSemiBold(size: 16.0)
        titleLabel.textColor = R.color.textPrimary()
        titleLabel.textAlignment = .left
        
        containerView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(16.0)
            $0.trailing.equalTo(timeLabel.snp.leading).offset(-12.0)
            $0.top.equalTo(titleLabel.snp.bottom).offset(4.0)
          //  $0.bottom.lessThanOrEqualToSuperview().inset(12.0)
        }
        subtitleLabel.numberOfLines = 1
        subtitleLabel.font = R.font.openSansRegular(size: 14.0)
        subtitleLabel.textColor = R.color.textSecondary()
        subtitleLabel.textAlignment = .left
    }
}
