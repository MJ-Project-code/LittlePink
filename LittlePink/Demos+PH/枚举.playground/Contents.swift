import UIKit

enum CompassPoint {
    case north
    case south
    case east
    case west
}

enum Beverage: CaseIterable {
    case coffee, tea, juice
}
let numberOfChoices = Beverage.allCases
for numberOfChoice in numberOfChoices{
    print(numberOfChoice)
}
//print("\(numberOfChoices) beverages available")
// Prints "3 beverages available"

UILabel().textAlignment
