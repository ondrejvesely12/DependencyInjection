//
//  InjectedObservableObject.swift
//
//  Created by Ondřej Veselý on 16.09.2021.
//

import Combine
import SwiftUI

/// Immediate injection property wrapper for SwiftUI ObservableObjects.
/// This wrapper is meant for use in SwiftUI Views and exposes
/// bindable objects similar to that of SwiftUI @ObservedObject and @EnvironmentObject.
///
/// Dependent service must be of type ObservableObject. Updating object state will trigger view update.
///
/// Wrapped dependent service is resolved immediately using DependencyContainer upon struct initialization.
///
@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@propertyWrapper public struct InjectedObservableObject<Service>: DynamicProperty where Service: ObservableObject {
    // MARK: - Properties

    // MARK: Private

    @ObservedObject private var service: Service

    // MARK: Public

    public var wrappedValue: Service {
        get { return service }
        mutating set { service = newValue }
    }

    public var projectedValue: ObservedObject<Service>.Wrapper {
        return $service
    }

    // MARK: - Initialization

    public init(container: ContainerProtocol) {
        service = container.resolve()
    }

    public init(name: String, container: ContainerProtocol) {
        service = container.resolve(name: name)
    }
}
