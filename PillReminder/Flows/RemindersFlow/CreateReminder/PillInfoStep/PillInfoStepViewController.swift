//
//  PillInfoStepViewController.swift
//  PillReminder
//
//  Created by Александр Ветряков on 03.12.2023.
//

import UIKit
import Photos

final class PillInfoStepViewController: BaseViewController, HasCustomView, AlertControllerPresentable {

    typealias CustomView = PillInfoStepView
    
    private let viewModel: PillInfoStepViewModel
    
    private let imagePickerService = ImagePickerService()
    
    // MARK: - Lifecycle
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .default }
    
    init(viewModel: PillInfoStepViewModel) {
        self.viewModel = viewModel
        
        super.init()
    }
    
    override func loadView() {
        view = CustomView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initializeBindings()
    }
    
    // MARK: - Initialize bindings
    
    private func initializeBindings() {
        customView.nameCardView.nameInputField.onTextChanged = { [weak self] text in
            self?.viewModel.update(name: text)
        }
        
        imagePickerService.imageCallback = { [weak self] image in
            self?.customView.photoImageView.image = image
            self?.customView.photoImageView.isHidden = false
            self?.viewModel.update(photo: image)
        }
        
        viewModel.$name
            .receive(on: DispatchQueue.main)
            .sink { [weak self] name in
                guard let self = self else { return }
                
                self.customView.proceedButton.isEnabled = !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            }.store(in: &cancellables)
        
        customView.makePhotoCardView.actionButton.tap()
            .sink { [weak self] in
                let libraryAction = { [weak self] in
                    self?.showImagePicker()
                }
                
                let makePhotoAction = { [weak self] in
                   // self?.showDocumentPicker()
                }
                
                self?.presentActionSheetAlertController(
                    title: nil,
                    cancelTitle: R.string.localizable.commonCancelTitle(),
                    actionTitles: [R.string.localizable.pillInfoMakePhotoButtonTitle(), R.string.localizable.pillInfoLoadPhotoButtonTitle()],
                    actionHandlers: [makePhotoAction, libraryAction])
            }
            .store(in: &cancellables)
        
        customView.formCardView.actionButton.tap()
            .sink { [weak self] in
                self?.viewModel.showForms()
            }
            .store(in: &cancellables)
        
        customView.doseCardView.countActionView.plusButton.tap()
            .sink { [weak self] in
                self?.viewModel.incrementDose()
            }
            .store(in: &cancellables)
        
        customView.doseCardView.countActionView.minusButton.tap()
            .sink { [weak self] in
                self?.viewModel.decrimentDose()
            }
            .store(in: &cancellables)
        
        customView.proceedButton.tap()
            .sink { [weak self] in
                self?.viewModel.showNext()
            }
            .store(in: &cancellables)
        
        viewModel.$currentDose
            .receive(on: DispatchQueue.main)
            .sink { [weak self] dose in
                guard let self = self else { return }
                
                self.customView.doseCardView.countActionView.update(value: dose)
            }.store(in: &cancellables)
        
        viewModel.$currentForm
            .receive(on: DispatchQueue.main)
            .sink { [weak self] form in
                guard let self = self else { return }
                
                self.customView.formCardView.update(value: form.title)
            }.store(in: &cancellables)
    }
    
    private func showImagePicker() {
        switch PHPhotoLibrary.authorizationStatus() {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ [weak self] status in
                if status == .authorized {
                    DispatchQueue.main.async {
                        self?.imagePickerService.presentPhotosPicker()
                    }
                }
            })
            
        case .authorized:
            imagePickerService.presentVideoAndPhotoPicker()
            
        default:
            showPhotoSettingAlert()
        }
    }
    
    private func showPhotoSettingAlert() {
        presentAlertController(
            title: R.string.localizable.pillInfoChangePhotoTitle(),
            message: R.string.localizable.pillInfoChangePhotoSubtitle(),
            cancelTitle: nil,
            actionTitle: R.string.localizable.commonSettingsTitle()) { [weak self] in
               // self?.viewModel.openSettings()
            }
    }

}
