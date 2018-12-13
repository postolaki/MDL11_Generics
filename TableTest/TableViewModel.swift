import UIKit

typealias UserCellConfig = TableCellConfigurator<UserCell, User>
typealias MessageCellConfig = TableCellConfigurator<MessageCell, String>
typealias ImageCellConfig = TableCellConfigurator<ImageCell, URL>

class TableViewModel {
    private (set) var items: [CellConfigurator] = [
        UserCellConfig.init(item: User(name: "John Smith", imageName: "user3")),
        
        MessageCellConfig(item: "Hi, this is a message text. Tra la la. Tra la la."),
        ImageCellConfig(item: Bundle.main.url(forResource: "beach@2x", withExtension: "jpg")!),
        UserCellConfig(item:User(name: "Jessica Wood", imageName: "user2")),
        MessageCellConfig(item: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
        TableCellConfigurator<WarningCell, String>(item: "Hey!! It's a warning!!!!"),
    ]

    func update() {
        items.shuffle()
    }
}
