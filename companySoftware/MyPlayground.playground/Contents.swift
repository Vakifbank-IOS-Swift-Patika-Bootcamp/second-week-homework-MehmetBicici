import Foundation

// Created some struct data and enum type data

struct Company: CompanyProperty {
    
    var employee: [Employee?]
    var companyName: String?
    var incomeForCompany: Int?
    var yearOfFoundation: Int?
    
}

struct Employee {
    
    var employeeName: String?
    var age: Int?
    var marialStatus: MarialTypesEnum?
    var employeeTypes: EmployeeTypesEnum?
}

// Filtered marial type

enum MarialTypesEnum {
    
    case married
    case single
    
    var status: String {
        switch self {
        case .married:
            return "married"
        case .single:
            return "single"
        }
    }
}

enum EmployeeTypesEnum {
    
    case junior
    case mid
    case senior
    
    var type: String {
        switch self {
        case .junior:
            return "junior"
        case .mid:
            return "mid"
        case .senior:
            return "senior"
        }
    }
}

// Created protocol for getting company property

protocol CompanyProperty {
    var companyName: String? { get }
    var incomeForCompany: Int? { get }
    var yearOfFoundation: Int? { get }
}

// Created add new employee func and calculate employee salary func

class AddEmployeeAndCalculateEmployeeSalary {
    
    func addNewEmployee(companyObject: Company,employeeList: Employee) -> Company {
        var placeHolderObject = companyObject
        let newEmployee = employeeList
        var newEmployeeList = placeHolderObject.employee
        newEmployeeList.append(newEmployee)
        placeHolderObject = Company(employee: newEmployeeList, companyName: placeHolderObject.companyName, incomeForCompany: placeHolderObject.incomeForCompany, yearOfFoundation: placeHolderObject.yearOfFoundation)
        print("Added New Employee: \((newEmployee.employeeName ?? "Empty Frame")) !!")
        print(" ")
        return placeHolderObject
    }
    
    func calculateEmployeeSalary(companyObject: Company) -> [String:Int] {
        var salary = 0
        var salaryAndNameDict = [String:Int]()
        let juniorCoefficient = 2
        let midCoefficient = 3
        let seniorCoefficient = 4
        for employee in companyObject.employee {
            if employee?.employeeTypes == .junior {
                salary = (employee?.age ?? 0) * juniorCoefficient * 1000
            } else if employee?.employeeTypes == .mid {
                salary = (employee?.age ?? 0) * midCoefficient * 1000
            } else if employee?.employeeTypes == .senior {
                salary = (employee?.age ?? 0) * seniorCoefficient * 1000
            } else {
                print("Employee type is not found !")
            }
            if salary != 0 {
                salaryAndNameDict[(employee?.employeeName ?? "")] = salary
            } else {
                salaryAndNameDict[(employee?.employeeName ?? "")] = 0
            }
        }
        return salaryAndNameDict
    }
}

// Created get salary from company and ıncreased ıncome for company func. Added closure for extra act.

class GetSalaryFromCompanyAndDecreasedIncomeForCompany {
    
    func getSalaryFromCompany(companyObject: Company, salaryDict: [String:Int], extraActClosure: () -> Void) -> Company {
        
        var placeHolderObject = companyObject
        var sumOfSalary = 0
        
        for salary in salaryDict.values {
            sumOfSalary += salary
        }
        print("----New Company's Income is Calculating----")
        let newSalary = (placeHolderObject.incomeForCompany ?? 0) - sumOfSalary
        print(" ")
        print("--- New Company's Income is: \(newSalary) $ ---")
        placeHolderObject = Company(employee: placeHolderObject.employee, companyName: placeHolderObject.companyName, incomeForCompany: newSalary, yearOfFoundation: placeHolderObject.yearOfFoundation)
        extraActClosure()
        return placeHolderObject
    }
    
}

// Created base object
var company = Company(employee: [Employee(employeeName: "Jordan Belfort", age: 29, marialStatus: .married, employeeTypes: .senior)], companyName: "Stratton Oakmont", incomeForCompany: 235983, yearOfFoundation: 1989)

// Added new employee
var addEmployee = AddEmployeeAndCalculateEmployeeSalary()
company = addEmployee.addNewEmployee(companyObject: company, employeeList: Employee(employeeName: "Patrick Bateman", age: 28, marialStatus: .single, employeeTypes: .senior))

// Salary calculated for each employee
var salaryDict = addEmployee.calculateEmployeeSalary(companyObject: company)

// Company's income decreased according to employee salaries
var getSalaryFromCompanyAndDecreasedIncomeForCompany = GetSalaryFromCompanyAndDecreasedIncomeForCompany()
getSalaryFromCompanyAndDecreasedIncomeForCompany.getSalaryFromCompany(companyObject: company, salaryDict: salaryDict) {
    print(" ")
    print("If you want me to calculate the annual company budget plan, I can direct you to our artificial intelligence service!")
}
