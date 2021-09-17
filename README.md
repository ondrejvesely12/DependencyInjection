# DependencyInjection


 DependencyInjection is a lightweight dependency injection framework for Swift and SwiftUI that can be used with a property wrapper and allows you to resolve dependencies using parameters.

## Features

- [x] Pure Swift Type Support
- [x] Injection with Arguments
- [x] Object Scopes as None (Transient), Container (Singleton)
- [x] Support of both Reference and Value Types
- [x] Property wrapper that can be used to inject objects
- [x] Property wrapper that can be used to inject objects
- [x] Creating a container using a domain-specific language (DSL)

## Basic Usage

First, you need to create the [`Container`](Sources/DependencyInjection/Container/DependencyContainer.swift) .

For example, when using :
```swift

let container = Container {
    Shared {
        TestClass() as TestClass
    }
    OneTime { (voltage: Voltage) in
        ElectricHeater(voltage: voltage.rawValue) as ElectricHeaterProtocol
    }
    OneTime(name: "machineHeater") { (voltage: Voltage) in
        ElectricHeater(voltage: voltage.rawValue) as ElectricHeaterProtocol
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

enum Dependencies {
    static let main =
        Container {
            OneTime {
                TestClass()
            }
            OneTime { (voltage: Voltage) in
                ElectricHeater(voltage: voltage.rawValue) as ElectricHeaterProtocol
            }
            OneTime(name: "machineHeater") { (voltage: Voltage) in
                ElectricHeater(voltage: voltage.rawValue) as ElectricHeaterProtocol
            }
        }
}

class CoffeeMachine {
    // Heater
    @LazyInjectedWithArgument<ElectricHeaterProtocol, Voltage>(name: "machineHeater", argument: .v230, container: Dependencies.main)
    var heater: ElectricHeaterProtocol
    
    // Test Class
    @Injected<TestClass>(container: Dependencies.main) var testClass

    // Test Class 2
    @Injected(container: Dependencies.main) var testClass2: TestClass
}


```
