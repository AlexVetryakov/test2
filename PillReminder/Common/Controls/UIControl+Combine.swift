//
//  UIControl+Combine.swift
//  PillReminder
//
//  Created by Александр Ветряков on 01.12.2023.
//

import Foundation
import UIKit
import Combine

/// A custom subscription to capture UIControl target events.
final class UIControlSubscription<SubscriberType: Subscriber, Control: UIControl>: Subscription where SubscriberType.Input == Control {
  
    private var subscriber: SubscriberType?
    private let control: Control
    
    init(subscriber: SubscriberType, control: Control, event: UIControl.Event) {
        self.subscriber = subscriber
        self.control = control
        control.addTarget(self, action: #selector(eventHandler), for: event)
    }
  
    func request(_ demand: Subscribers.Demand) {
        // We do nothing here as we only want to send events when they occur.
        // See, for more info: https://developer.apple.com/documentation/combine/subscribers/demand
    }
  
    func cancel() {
        subscriber = nil
    }
  
    @objc private func eventHandler() {
        _ = subscriber?.receive(control)
    }
}

final class UIControlSubscriptionOnValue<SubscriberType: Subscriber, Control: UIControl, ResultType>: Subscription where SubscriberType.Input == ResultType {
  
    private var subscriber: SubscriberType?
    private let control: Control
    private let keyPath: KeyPath<Control, ResultType>
  
    init(subscriber: SubscriberType, control: Control, event: Control.Event, keyPath: KeyPath<Control, ResultType>) {
        self.subscriber = subscriber
        self.control = control
        self.keyPath = keyPath
    
        control.addTarget(self, action: #selector(eventHandler), for: event)
    }
  
    func request(_ demand: Subscribers.Demand) {
        // We do nothing here as we only want to send events when they occur.
        // See, for more info: https://developer.apple.com/documentation/combine/subscribers/demand
    }
  
    func cancel() {
        subscriber = nil
    }
  
    @objc private func eventHandler() {
        _ = subscriber?.receive(control[keyPath: keyPath])
    }
}

/// A custom `Publisher` to work with our custom `UIControlSubscription`.
struct UIControlPublisher<Control: UIControl>: Publisher {
  
    typealias Output = Control
    typealias Failure = Never
  
    let control: Control
    let controlEvents: Control.Event
  
    init(control: Control, events: Control.Event) {
        self.control = control
        self.controlEvents = events
    }
  
    func receive<S>(subscriber: S) where S : Subscriber, S.Failure == UIControlPublisher.Failure, S.Input == UIControlPublisher.Output {
        let subscription = UIControlSubscription(subscriber: subscriber, control: control, event: controlEvents)
        subscriber.receive(subscription: subscription)
    }
}

/// A custom `Publisher` to work with our custom `UIControlSubscription`.
struct UIControlWithDataPublisher<Control: UIControl,ResultType>: Publisher {
  
    typealias Output = ResultType
    typealias Failure = Never
  
    let control: Control
    let controlEvents: Control.Event
    let keyPath: KeyPath<Control, ResultType>
  
    init(control: Control, events: Control.Event, keyPath: KeyPath<Control, ResultType>) {
        self.control = control
        self.controlEvents = events
        self.keyPath = keyPath
    }
  
    func receive<S>(subscriber: S) where S : Subscriber, S.Failure == UIControlWithDataPublisher.Failure, S.Input == UIControlWithDataPublisher.Output {
        let subscription = UIControlSubscriptionOnValue(subscriber: subscriber, control: control, event: controlEvents, keyPath: keyPath)
        subscriber.receive(subscription: subscription)
    }
}

/// Extending the `UIControl` types to be able to produce a `UIControl.Event` publisher.
protocol CombineCompatible { }

extension UIControl: CombineCompatible { }

extension CombineCompatible where Self: UIControl {
  
    func publisher(for events: UIControl.Event) -> UIControlPublisher<UIControl> {
        UIControlPublisher(control: self, events: events)
    }
  
    func publisher<ResultType>(for events: UIControl.Event, keyPath: KeyPath<Self, ResultType>) -> UIControlWithDataPublisher<Self,ResultType> {
        UIControlWithDataPublisher(control: self, events: events, keyPath: keyPath)
    }
}
