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
    func configure(cell: UIView)
    func configure(cell: UIView, actionProxy: CellActionProxy)
    var hash: Int { get }
    var actionProxy: CellActionProxy? {get set}
}
