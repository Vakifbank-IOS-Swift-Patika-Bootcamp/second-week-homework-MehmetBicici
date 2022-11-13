import Foundation

// Get Data For Zoo

struct Zoo: ZooProperty {
    
    var animal: [Animal]
    var caregiver: [Caregiver]
    var waterLimit: Int?
    var budgetLimit: Int?
}

// Get Data For Animal

struct Animal: AnimalPropert {
    
    var animalName: AnimalTypesEnum?
    var waterConsumption: Int?
    var sound: SoundTypesEnum?
    var caregiver: [Caregiver]
}

// Get Data For Caregiver

struct Caregiver: CaregiverProperty {
    
    var id: Int
    var animalsToLookAt: [AnimalTypesEnum?]
    var salary: Int? {
        // Salary Formula = number of animals cared for by the caregiver * id * 50
        return animalsToLookAt.count * id * 50
    }
}

// Get Protocol for ZooProperty

protocol ZooProperty {
    
    var waterLimit: Int? { get }
    var budgetLimit: Int? { get }
}

// Get Protocol for AnimalPropert

protocol AnimalPropert {
    
    var waterConsumption: Int? { get }
}

// Get Protocol for CaregiverProperty

protocol CaregiverProperty {
    
    var salary: Int? { get }
}

// Enum Type Data for Sound of Animals

enum SoundTypesEnum {

    case me
    case miyav
    case havhav
    case mö
    case empty
    var sound: String {
        switch self {
        case .havhav:
            return "HAVHAVVVV 🐶"
        case .me:
            return "MEEEEEEEE 🐑"
        case .miyav:
            return "MIYAVVVV 🐱"
        case .mö:
            return "MOOOOOOOO 🐮"
        case .empty:
            return "Empty"
        }
        
    }
}

// Enum Type Data for Type of Animals

enum AnimalTypesEnum {
    
    case cat
    case dog
    case cow
    case sheep
    case empty
    var animal: String {
        switch self {
        case .cat:
            return "Cat"
        case .cow:
            return "Cow"
        case .dog:
            return "Dog"
        case .sheep:
            return "Sheep"
        case .empty:
            return "Empty"
        }
    }
}

// Error Type Data for ERROR HANDLING
// I will use it for catching error

enum NumOfCareGiverError: Error {
    
    case overCaregiver
}

// if one animal has two or more caregiver, I will throw the error message which will be number of the caregiver
class CaregiverNum {
    
    func numberOfCaregiver(number: Int) throws {
        guard number < 1 else {
            throw NumOfCareGiverError.overCaregiver
        }
    }
    
    func catchError(numOfOneAnimalCaregiver: Int, caregiverNum: CaregiverNum) throws {
        try caregiverNum.numberOfCaregiver(number: numOfOneAnimalCaregiver)
    }
}


class AddAnimalAndCaregiver {
    
    let caregiverNum = CaregiverNum()
    
    // Add new animal func, if it follows the rule.
    
    func addNewAnimal(zooObject: Zoo, animal: Animal, soundClosure: (SoundTypesEnum) -> Void) -> Zoo {
        var count = 0
        var placeHolderObject = zooObject
        let newAnimal = animal
        var newAnimalList = placeHolderObject.animal
        newAnimalList.append(newAnimal)
        newAnimalList
        for num in newAnimalList{
            if num.caregiver.count > count {
                count = num.caregiver.count
            }
        }

        if count > 1 {
            do {
                try caregiverNum.catchError(numOfOneAnimalCaregiver: count, caregiverNum: caregiverNum)
                print("There is no problem. You can add the caregiver for one animal")
            } catch NumOfCareGiverError.overCaregiver {
                print("More than one caregiver cannot be assigned for one animal.")
                // return empty zoo object
                return Zoo(animal: [], caregiver: [], waterLimit: 0, budgetLimit: 0)
            } catch {
                
            }
            
        }
        placeHolderObject = Zoo(animal: newAnimalList, caregiver: placeHolderObject.caregiver, waterLimit: placeHolderObject.waterLimit, budgetLimit: placeHolderObject.budgetLimit)
        // Hear added animal sound
        soundClosure(newAnimal.sound ?? .empty)
        print("Added New Animal: \((newAnimal.animalName ?? .empty))")
        print(" ")
        return placeHolderObject
    }
    
    // Add new caregiver
    
    func addNewCaregiver(zooObject: Zoo, caregiver: Caregiver) -> Zoo {
        var placeHolderObject = zooObject
        let newCaregiver = caregiver
        var newCaregiverList = placeHolderObject.caregiver
        newCaregiverList.append(newCaregiver)
        placeHolderObject = Zoo(animal: placeHolderObject.animal, caregiver: newCaregiverList, waterLimit: placeHolderObject.waterLimit, budgetLimit: placeHolderObject.budgetLimit)
        print("Added New Caregiver with id: \(newCaregiver.id) ")
        print(" ")
        return placeHolderObject
    }
    
}

class BudgetAndWaterLimit {
    
    // Decreased Zoo budget
    
    func decreasedBudget(zooObject: Zoo) -> Zoo {
        var sumOfSalaries = 0
        var placeHolderObject = zooObject
        for salaryOfCaregiver in zooObject.caregiver {
            sumOfSalaries += (salaryOfCaregiver.salary ?? 0)
        }
        print("Sum of Caregiver Salary: \(sumOfSalaries) $")
        print(" ")
        print("----New Zoo's Budget is Calculating----")
        let newBudget = (placeHolderObject.budgetLimit ?? 0) - sumOfSalaries
        print(" ")
        print("--- New Zoo's Budget is: \(newBudget) $ ---")
        placeHolderObject = Zoo(animal: placeHolderObject.animal, caregiver: placeHolderObject.caregiver, waterLimit: placeHolderObject.waterLimit, budgetLimit: newBudget)
        return placeHolderObject
    }
    
    // decreased water limit
    func decreasedWaterLimit(zooObject: Zoo) -> Zoo {
        var sumOfAnimalsWaterConsumption = 0
        var placeHolderObject = zooObject
        for waterConsumption in placeHolderObject.animal {
            sumOfAnimalsWaterConsumption += (waterConsumption.waterConsumption ?? 0)
        }
        print(" ")
        print("Sum of Water Consumption for Animals: \(sumOfAnimalsWaterConsumption)")
        print(" ")
        print("----New Zoo's Water Limit is Calculating----")
        let newWaterLimit = (placeHolderObject.waterLimit ?? 0) - sumOfAnimalsWaterConsumption
        print(" ")
        print("--- New Zoo's Water Limit is: \(newWaterLimit) Liter ---")
        placeHolderObject = Zoo(animal: placeHolderObject.animal, caregiver: placeHolderObject.caregiver, waterLimit: newWaterLimit, budgetLimit: placeHolderObject.budgetLimit)
        return placeHolderObject
    }

}

let addAnimalAndCaregiver = AddAnimalAndCaregiver()
let budgetAndWaterLimit = BudgetAndWaterLimit()

// Create Zoo Object
var zoo = Zoo(animal: [Animal(animalName: .cow, waterConsumption: 2, sound: .mö, caregiver: [Caregiver(id: 1, animalsToLookAt: [.cow])])], caregiver: [Caregiver(id: 1, animalsToLookAt: [.cat,.sheep,.cow])], waterLimit: 600, budgetLimit: 125000)

// Add New Animal and Hear its sound. If you create an animal and give more than one caregiver for one animal you will see the error.

zoo = addAnimalAndCaregiver.addNewAnimal(zooObject: zoo, animal: Animal(animalName: .cat, waterConsumption: 15, sound: .miyav, caregiver: [Caregiver(id: 1, animalsToLookAt: [.sheep])])) {sound in
    print(sound.sound)
}

// Add new caregiver

zoo = addAnimalAndCaregiver.addNewCaregiver(zooObject: zoo, caregiver: Caregiver(id: 2, animalsToLookAt: [.sheep,.cow]))

// Calculate new budget

zoo = budgetAndWaterLimit.decreasedBudget(zooObject: zoo)

// Calculate new water limit
zoo = budgetAndWaterLimit.decreasedWaterLimit(zooObject: zoo)
