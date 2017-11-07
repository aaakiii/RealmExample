import UIKit
import RealmSwift

class EditViewController: UIViewController {
    var incomingTodo: Todo?
    let realm = try! Realm()
    @IBOutlet var todoSwitch: UISwitch!
    @IBOutlet var todoTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let todo = incomingTodo {
            todoTextField.text = todo.todoText
            todoSwitch.isOn = todo.isDone
            
        }
    }
    @IBAction func saveTodo(_ sender: Any) {
        if let todo = incomingTodo {
            try! realm.write {
                todo.todoText = todoTextField.text!
                todo.isDone = todoSwitch.isOn
            }
        } else {
            let todo = Todo()
            todo.todoText = todoTextField.text!
            todo.isDone = todoSwitch.isOn
            
            try! realm.write {
                realm.add(todo)
            }
            
        }
        
        navigationController?.popViewController(animated: true)
    }


}
