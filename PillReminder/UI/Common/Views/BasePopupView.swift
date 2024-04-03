//
//  BasePopupView.swift
//  PillReminder
//
//  Created by Александр Ветряков on 29.12.2023.
//
import UIKit

class BasePopupView: BaseView {

    var closeClosure: (() -> Void)?
    var handleCloseClosure: (() -> Void)?
    
    var isClosable = true
    
    private var keyboardFrameY: CGFloat = UIScreen.main.bounds.size.height
    
    private let containerView = UIView()
    private var containerHeight: CGFloat = 0.0
    private let backView = UIView()
    private var initialFrame: CGRect = .zero
    
    override init() {

        super.init()

        backgroundColor = .clear
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.addCornerRadius(24.0, corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
    }
    
    func showPopup(completionHandler: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.3) {
            self.backView.alpha = 0.4
            self.containerView.frame = CGRect(x: 0.0, y: Constants.UI.screenHeight - self.containerHeight, width: Constants.UI.screenWidth, height: self.containerHeight)
        } completion: { _ in
            completionHandler?()
        }
    }
    
    func close() {
        if !isClosable { return }
        
        UIView.animate(withDuration: 0.3) {
            self.backView.alpha = 0.0
            self.containerView.frame = CGRect(x: 0.0, y: Constants.UI.screenHeight, width: Constants.UI.screenWidth, height: self.containerHeight)
        } completion: { _ in
            self.handleCloseClosure?()
        }
    }
    
    func setupConainerView(contentView: UIView, maxHeight: CGFloat, gestureEnabled: Bool = true) {
        containerHeight = maxHeight
        addSubview(containerView)
        containerView.frame = CGRect(x: 0.0, y: Constants.UI.screenHeight, width: Constants.UI.screenWidth, height: maxHeight)
        containerView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        if gestureEnabled {
           setupGestureRecognizers()
        }
        
        NotificationCenter.default.addObserver(self,
           selector: #selector(self.keyboardNotification(notification:)),
           name: UIResponder.keyboardWillChangeFrameNotification,
           object: nil)
    }
    
    private func setupViews() {
        addSubview(backView)
        backView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        backView.backgroundColor = .black
        backView.alpha = 0.0
    }
    
    private func setupGestureRecognizers() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handlePopupTap(_:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePopupPan(_:)))

        backView.addGestureRecognizer(tapGestureRecognizer)
        backView.addGestureRecognizer(panGestureRecognizer)

        let panGestureRecognizerView = UIPanGestureRecognizer(target: self, action: #selector(handlePopupPan(_:)))
        containerView.addGestureRecognizer(panGestureRecognizerView)
    }
    
    private func closeContainerView() {
        if !isClosable { return }
        
        endEditing(true)
        UIView.animate(withDuration: 0.3) {
            self.backView.alpha = 0.0
            self.containerView.frame = CGRect(
                x: 0.0,
                y: Constants.UI.screenHeight,
                width: Constants.UI.screenWidth,
                height: self.containerHeight
            )
        } completion: { _ in
            self.closeClosure?()
        }
    }
    
    @objc
    private func handlePopupTap(_ gestureRecognizer: UITapGestureRecognizer) {
        closeContainerView()
    }
    
    @objc
    func handlePopupPan(_ gestureRecognizer: UIPanGestureRecognizer) {
        if !isClosable { return }
        
        let translation = gestureRecognizer.translation(in: self)
        
        switch gestureRecognizer.state {
        case .began:
            initialFrame = containerView.frame
            endEditing(true)
        case .changed:
            var newOriginY = initialFrame.origin.y + translation.y
            if newOriginY <= initialFrame.origin.y {
                newOriginY = initialFrame.origin.y
            }
            
            let newFrame = CGRect(
                x: initialFrame.origin.x,
                y: newOriginY,
                width: initialFrame.size.width,
                height: initialFrame.size.height
            )
            containerView.frame = newFrame
            
        case .ended, .cancelled:
            if translation.y > 50 {
                closeContainerView()
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.containerView.frame.origin.y = Constants.UI.screenHeight - self.containerHeight
                }
            }
    
        default:
            break
        }
        
    }
    
    @objc func keyboardNotification(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }

        let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        let endFrameY = endFrame?.origin.y ?? 0

        if endFrameY >= UIScreen.main.bounds.size.height {
            initialFrame.origin.y = containerView.frame.origin.y + (endFrame?.size.height  ?? 0.0)
            containerView.frame.origin.y = containerView.frame.origin.y + (endFrame?.size.height  ?? 0.0)
        } else {
            if keyboardFrameY != endFrameY {
                containerView.frame.origin.y = UIScreen.main.bounds.size.height - containerHeight - (endFrame?.size.height  ?? 0.0)
                return
            }
            initialFrame.origin.y = containerView.frame.origin.y + (endFrame?.size.height  ?? 0.0)
            containerView.frame.origin.y = containerView.frame.origin.y - (endFrame?.size.height  ?? 0.0)
            keyboardFrameY = endFrameY
        }
    }

}

