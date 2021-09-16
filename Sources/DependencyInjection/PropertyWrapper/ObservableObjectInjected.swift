//
//  ObservableObjectInjected.swift
//
//  Created by Ondřej Veselý on 16.09.2021.
//

import Combine
import SwiftUI

/// Immediate injection property wrapper for SwiftUI ObservableObjects.
/// This wrapper is meant for use in SwiftUI Views and exposes
/// bindable objects similar to that of SwiftUI @observedObject and @environmentObject.
///
/// Dependent service must be of type ObservableObject. Updating object state will trigger view update.
///
/// Wrapped dependent service is resolved immediately using DependencyContainer upon struct initialization.
///
@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@propertyWrapper struct ObservableObjectInjected<Service>: DynamicProperty where Service: ObservableObject {
    // MARK: - Properties

    // MARK: Private

    @ObservedObject private var service: Service

    // MARK: Public

    var wrappedValue: Service {
        get { return service }
        mutating set { service = newValue }
    }

    var projectedValue: ObservedObject<Service>.Wrapper {
        return $service
    }

    // MARK: - Initialization

    init(container: DependencyContainerProtocol) {
        service = container.resolve()
    }

    init(name: String, container: DependencyContainerProtocol) {
        service = container.resolve(name: name)
    }
}
