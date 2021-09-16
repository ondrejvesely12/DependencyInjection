@testable import DependencyInjection
import XCTest

class TestClass {
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

struct Machine {
    let name: String
    @LazyInjectedWithArgument<ElectricHeaterProtocol, Voltage>(name: "machineHeater", argument: .v230, container: Dependencies.main) var heater: ElectricHeaterProtocol
}

class CoffeeMachine {
    @LazyInjectedWithArgument<ElectricHeaterProtocol, Voltage>(name: "machineHeater230V", argument: .v230, container: Dependencies.main) var heater: ElectricHeaterProtocol
    @Injected<TestClass>(Dependencies.main) var testClass
}

enum Dependencies {
    static let main =
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
    @Injected(Dependencies.main) var testClass: TestClass
    var counter = 0

    func inc() {
        counter += 1
    }
}

final class DependencyInjectionTests: XCTestCase {
    func testString() {
        let container: DependencyContainerProtocol = DependencyContainer()
        container.register(DependencyRegistration(.shared) {
            "eeee" as String
        })

        let string: String = container.resolve(argument: ())
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
        let string: String = container.resolve(argument: ())
        XCTAssertEqual(string, "")
        let int: Int = container.resolve(argument: ())
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

        let testClass2: TestClass = container.resolve(argument: ())
        XCTAssertEqual(testClass2.counter, 1)
        testClass.inc()
        testClass.inc()
        testClass.inc()
        XCTAssertEqual(testClass2.counter, 4)
        let testClass3: TestClass = container.resolve(argument: ())
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
        XCTAssertEqual(testClassWithWrappers.testClass.counter, 0)
        let testClassWithWrappers2 = TestClassWithWrappers()
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
}
