import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    var todos: Results<Todo>!
    var realm = try! Realm()
    
    @IBOutlet var toDoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todos = realm.objects(Todo.self)
        toDoTableView.dataSource = self
        toDoTableView.delegate = self
        toDoTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        toDoTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditTodo" {
            let destinationVC = segue.destination as! EditViewController
            let todo = todos[(toDoTableView.indexPathForSelectedRow?.row)!]
            destinationVC.incomingTodo = todo
            
        }
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as! TodoCell
        
        cell.todoText.text = todos[indexPath.row].todoText
        cell.isDone.text = todos[indexPath.row].isDone ? "Done" : "Not Yet"
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try! realm.write {
                realm.delete(todos[indexPath.row])
            }
            toDoTableView.reloadData()
        }
        
    }
}

class Todo: Object {
    @objc dynamic var todoText = ""
    @objc dynamic var isDone = false
    
}

class TodoCell: UITableViewCell{
    @IBOutlet var todoText: UILabel!
    @IBOutlet var isDone: UILabel!
}

