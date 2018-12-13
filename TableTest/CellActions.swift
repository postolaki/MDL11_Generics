import UIKit

enum ActionIdentifier: String {
    case followUser, simpleButton
}

enum CellAction: Hashable {
    case didSelect
    case custom(ActionIdentifier)
    
    public var hashValue: Int {
        switch self {
        case .didSelect:
            return 1
        case .custom(let identifier):
            return identifier.rawValue.hashValue
        }
    }
}
