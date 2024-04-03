//
//  FormTableViewCell.swift
//  PillReminder
//
//  Created by Александр Ветряков on 29.12.2023.
//

import UIKit
import Combine

final class FormTableViewCell: UITableViewCell, Reusable {
    
    private let titleLabel = UILabel()
    private let separatorView = UIView()
    
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
    
    func apply(title: String, isSeparatorNeeded: Bool) {
        titleLabel.text = title
        separatorView.isHidden = !isSeparatorNeeded
    }
    
    // MARK: - UI
    private func setupViews() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16.0)
            $0.centerY.equalToSuperview()
        }
        titleLabel.numberOfLines = 1
        titleLabel.font = R.font.openSansSemiBold(size: 16.0)
        titleLabel.textColor = R.color.textPrimary()
        titleLabel.textAlignment = .left
        
        contentView.addSubview(separatorView)
        separatorView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16.0)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1.0)
        }
        separatorView.backgroundColor = R.color.divider()
    }
}
