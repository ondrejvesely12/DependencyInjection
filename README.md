# DependencyInjection


 DependencyInjection is a lightweight dependency injection framework for Swift and SwiftUI that can be used with a property wrapper and allows you to resolve dependencies using parameters.

## Features

- [x] Pure Swift Type Support
- [x] Injection with Arguments
- [x] Object Scopes as None (Transient), Container (Singleton)
- [x] Support of both Reference and Value Types
- [x] Property wrapper that can be used to inject objects

## Basic Usage

First, you need to create the [`Container`](Sources/DependencyInjection/Container/DependencyContainer.swift) .

For example, when using :
```swift
let container = DependencyContainer {
    DependencyRegistration(.oneTime) { (voltage: Voltage) in
        ElectricHeater(voltage: voltage.rawValue) as ElectricHeaterProtocol
    }
    DependencyRegistration(name: "machineHeater230V", lifeCycle: .oneTime) {
        ElectricHeater(voltage: Voltage.v230.rawValue) as ElectricHeaterProtocol
    }
    DependencyRegistration(.shared) {
        TestClass()
    }
}

```


Then you can create an instance or struct as follows
```swift

let heater: ElectricHeaterProtocol = container.resolve(argument: Voltage.v230)

let heater230V: ElectricHeaterProtocol = container.resolve(name: "machineHeater230V")

let testClass: TestClass = container.resolve()

```

Now you can use the `@Inject` property wrapper to inject objects/services in your own classes:

```swift
class CoffeeMachine {
    @LazyInjectedWithArgument<ElectricHeaterProtocol, Voltage>(name: "machineHeater230V", argument: .v230, container: container)
    var heater: ElectricHeaterProtocol
    
    @Injected<TestClass>(container) var testClass
}

```
