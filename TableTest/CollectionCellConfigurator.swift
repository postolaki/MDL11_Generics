import UIKit

class CollectionCellConfigurator<CellType: ConfigurableCell, DataType: Hashable>: CellConfigurator where CellType.DataType == DataType, CellType: UICollectionViewCell {
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
