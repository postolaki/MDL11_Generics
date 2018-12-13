import UIKit

protocol ConfigurableCell {
    static var reuseIdentifier: String { get }
    associatedtype DataType
    func configure(data: DataType, configurator: CellConfigurator)
}

extension ConfigurableCell {
    static var reuseIdentifier: String { return String(describing: Self.self) }
}

protocol CellConfigurator {
    static var reuseId: String { get }
    func configure(cell: UIView, actionProxy: CellActionProxy?)
    var hash: Int { get }
    var actionProxy: CellActionProxy? {get set}
}

class TableCellConfigurator<CellType: ConfigurableCell, DataType: Hashable>: CellConfigurator where CellType.DataType == DataType, CellType: UITableViewCell {
    var actionProxy: CellActionProxy?
    
    static var reuseId: String { return CellType.reuseIdentifier }
    
    let item: DataType
    
    init(item: DataType) {
        self.item = item
    }
    
    func configure(cell: UIView, actionProxy: CellActionProxy? = nil) {
        self.actionProxy = actionProxy
        (cell as! CellType).configure(data: item, configurator: self)
    }

    var hash: Int {
        return String(describing: CellType.self).hashValue ^ item.hashValue
    }
}
