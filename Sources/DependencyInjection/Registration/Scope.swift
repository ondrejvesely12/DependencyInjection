//
//  Scope.swift
//
//  Created by Ondřej Veselý on 12.09.2021.
//

/// Scope is a configuration option that determines how the instance provided by the DI container is shared in the system.
/// The scope is represented by the Scope enum.
public enum Scope {
    /// Transient
    ///
    /// If LifeCycle.oneTime is specified, the instance provided by the container is not shared.
    /// In other words, the container always creates a new instance when the type is translated.
    /// No instance is held by the container.
    case oneTime

    /// Container
    /// In LifeCycle.container, the instance provided by the container is shared within the container .
    /// In other words, when the type is first compiled, it is created by the container by invoking the factory closure.
    /// The same instance is returned by the container on each subsequent resolution of the type.
    /// Instance is held by the container.
    /// This scope is also known as a Singleton in other DI frameworks.
    case shared
}
