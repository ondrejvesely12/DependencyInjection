import XCTest
@testable import DependencyInjection

private class TestClass {
    var counter = 0
    
    func inc() {
        counter += 1
    }
}

enum Voltage: Int, CaseIterable {
    case v110 = 110
    case v230 = 230
    case v380 = 380
}

protocol ElectricHeaterProtocol {
    var voltage: Int { get }
}

struct ElectricHeater: ElectricHeaterProtocol {
    let voltage: Int
    init(voltage: Int) {
        self.voltage = voltage
        print("ElectricHeater", #function)
    }

    func serve() {
        heat()
    }

    func heat() {
        print("heating...")
    }
}

/// Lazy injection property wrapper. Note that embedded container and name properties will be used if set prior to service instantiation.
///
/// Wrapped dependent service is not resolved until service is accessed.
///
@propertyWrapper public struct LazyInjected<Service, Argument> {
    private var initialize: Bool = true
    private var service: Service!
    public var container: DependencyContainerProtocol
    public var name: String?
    public var argument: Argument

    public init(name: String? = nil, argument: Argument, container: DependencyContainerProtocol) {
        self.container = container
        self.argument = argument
        self.name = name
    }
    public var isEmpty: Bool {
        return service == nil
    }
    var registrationIdentifier: RegistrationIdentifier {
        guard let name = name else {
            return .objectIdentifier(ObjectIdentifier(Service.self))
        }
        return .name(name)
    }
    public var wrappedValue: Service {
        mutating get {
            if initialize {
                self.initialize = false
                self.service = container.resolveOptional(registrationIdentifier: registrationIdentifier, argument: argument)
            }
            return service
        }
        mutating set {
            initialize = false
            service = newValue
        }
    }
    public var projectedValue: LazyInjected<Service, Argument> {
        get { return self }
        mutating set { self = newValue }
    }
    public mutating func release() {
        self.service = nil
    }
}

struct Machine {
    let name: String
//    @InjectParam<ElectricHeaterProtocol, Voltage>(Dependencies.main, argument: Voltage.v230) var heater
    @LazyInjected<ElectricHeaterProtocol, Voltage>(name: "machineHeater", argument: .v230, container: Dependencies.main) var heater: ElectricHeaterProtocol
}


struct Dependencies {
    static let main: DependencyContainer =
        DependencyContainer {
            DependencyRegistration(.oneTime) {
                TestClass() as TestClass
            }
            DependencyRegistration(.oneTime) { (voltage: Voltage) in
                ElectricHeater(voltage: voltage.rawValue) as ElectricHeaterProtocol
            }
            DependencyRegistration(name: "machineHeater", lifeCycle: .oneTime) { (voltage: Voltage) in
                ElectricHeater(voltage: voltage.rawValue) as ElectricHeaterProtocol
            }
        }
}

private class TestClassWithWrappers {
    @Inject(Dependencies.main) var testClass: TestClass
    var counter = 0
    
    func inc() {
        counter += 1
    }
}

final class DependencyInjectionTests: XCTestCase {
    func testString() {
        let container: DependencyContainerProtocol = DependencyContainer()
        container.register(DependencyRegistration(.shared, {
            "eeee" as String
        }))
        
        let string: String = container.resolve(argument: Void())
        XCTAssertEqual(string, "eeee")
    }
    
    func testDSL() {
        let container = DependencyContainer {
            DependencyRegistration(.oneTime) {
                String() as String
            }
            DependencyRegistration(.oneTime) {
                2 as Int
            }
            DependencyRegistration(.shared) {
                TestClass()
            }
        }
        let string: String = container.resolve(argument: Void())
        XCTAssertEqual(string, "")
        let int: Int = container.resolve(argument: Void())
        XCTAssertEqual(int, 2)
    }

    func testDSLShared() {
        let container = DependencyContainer {
            DependencyRegistration(.shared) {
                TestClass()
            }
        }
        let testClass: TestClass = container.resolve()
        XCTAssertEqual(testClass.counter, 0)
        testClass.inc()
        XCTAssertEqual(testClass.counter, 1)

        let testClass2: TestClass = container.resolve(argument: Void())
        XCTAssertEqual(testClass2.counter, 1)
        testClass.inc()
        testClass.inc()
        testClass.inc()
        XCTAssertEqual(testClass2.counter, 4)
        let testClass3: TestClass = container.resolve(argument: Void())
        XCTAssertEqual(testClass3.counter, 4)
    }
    
    func testDSLOneTime() {
        let container = DependencyContainer {
            DependencyRegistration(.oneTime) {
                TestClass()
            }
        }
        let testClass: TestClass = container.resolve()
        XCTAssertEqual(testClass.counter, 0)
        testClass.inc()
        XCTAssertEqual(testClass.counter, 1)

        let testClass2: TestClass = container.resolve()
        XCTAssertEqual(testClass2.counter, 0)
        testClass.inc()
        testClass.inc()
        testClass.inc()
        XCTAssertEqual(testClass2.counter, 0)
        let testClass3: TestClass = container.resolve()
        XCTAssertEqual(testClass3.counter, 0)
    }

    func testDSLOneTimeOptional() {
        let container = DependencyContainer {
            DependencyRegistration(.oneTime) {
                TestClass() as TestClass?
            }
        }
        let testClass: TestClass? = container.resolve()
        XCTAssertEqual(testClass?.counter, 0)
    }
    
    func testPropertyWrapper() {
        let testClassWithWrappers = TestClassWithWrappers()
        print(testClassWithWrappers.testClass)
        XCTAssertEqual(testClassWithWrappers.testClass.counter, 0)
        let testClassWithWrappers2 = TestClassWithWrappers()
        print(testClassWithWrappers2.testClass)
        XCTAssertEqual(testClassWithWrappers2.testClass.counter, 0)

    }

    
    func testWithArguments() {
        let container: DependencyContainerProtocol = DependencyContainer()
        container.register(lifeCycle: .oneTime) { (voltage: Voltage) in
            ElectricHeater(voltage: voltage.rawValue) as ElectricHeaterProtocol
        }
        let heater: ElectricHeaterProtocol = container.resolve(argument: Voltage.v230)
        XCTAssertEqual(heater.voltage, Voltage.v230.rawValue)
    }

    func testMachine() {
        var machine = Machine(name: "bugatti")
        print(Dependencies.main)
        print(machine.heater.voltage)
    }
}
