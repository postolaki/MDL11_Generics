import UIKit

enum CellAction: Hashable {
    case didSelect
    case custom(String)
    
    public var hashValue: Int {
        switch self {
        case .didSelect:
            return 1
        case .custom(let identifier):
            return identifier.hashValue
        }
    }
}
