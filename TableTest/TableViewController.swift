import UIKit

class TableViewController: UITableViewController {

    internal let viewModel = TableViewModel()
    let actionsProxy = CellActionProxy()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 50
        self.tableView.tableFooterView = UIView()

        self.addHandlers()
    }

    private func addHandlers() {
        actionsProxy.on(.didSelect) { (c: UserCellConfig, cell) in
            print("did select user cell", c.item, cell)
        }.on(.custom(ActionIdentifier.followUser.rawValue)) { (c: UserCellConfig, cell) in
            print("follow user", c.item)
        }.on(.didSelect) { (c: ImageCellConfig, cell) in
            print("did select image cell", c.item, cell)
        }.on(.didSelect) { (c: MessageCellConfig, cell) in
            print("did select message cell", c.item, cell)
        }.on(.custom(ActionIdentifier.simpleButton.rawValue)) { (c: ImageCellConfig, cell) in
            print("simple button action")
        }
    }

    @IBAction func onUpdate(_ sender: Any) {
        viewModel.update()
        let indexSet = IndexSet(integersIn: 0 ..< tableView.numberOfSections)
        tableView.reloadSections(indexSet, with: .fade)
        
        let sections = tableView.numberOfSections - 1
        let rows = tableView.numberOfRows(inSection: sections) - 1
        let indexPath = IndexPath(row: rows, section: sections)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
}

extension TableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.items.count > 0 ? 1 : 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellConfigurator = viewModel.items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: cellConfigurator).reuseId, for: indexPath)
        cellConfigurator.configure(cell: cell, actionProxy: actionsProxy)
//        cellConfigurator.configure(cell: cell)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellConfigurator = viewModel.items[indexPath.row]
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        actionsProxy.invoke(action: .didSelect, cell: cell, configurator: cellConfigurator)
    }
}
