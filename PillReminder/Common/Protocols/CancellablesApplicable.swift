//
//  CancellablesApplicable.swift
//  PillReminder
//
//  Created by Александр Ветряков on 01.12.2023.
//
import Combine

protocol CancellablesApplicable {
    var cancellables: [AnyCancellable] { get set }
}
