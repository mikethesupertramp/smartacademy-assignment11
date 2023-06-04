//
//  ViewController.swift
//  assignment11
//
//  Created by macbook  on 04.06.23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textfieldName: UITextField!
    @IBOutlet weak var textfieldSurname: UITextField!
    @IBOutlet weak var textfieldAge: UITextField!
    @IBOutlet weak var tableview: UITableView!
    
    var people: [PersonModel] = [] {
        didSet {
            tableview.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    
    @IBAction func addPerson(_ sender: Any) {
        let name = textfieldName.text ?? ""
        let surname = textfieldSurname.text ?? ""
        let ageText = textfieldAge.text ?? ""
        
        if !name.isEmpty && !surname.isEmpty && !ageText.isEmpty, let age = Int(ageText) {
            people.append(PersonModel(name: name, surname: surname, age: age))
            
            textfieldName.text = ""
            textfieldSurname.text = ""
            textfieldAge.text = ""
        } else {
            var alert = UIAlertController(
                title: "Error",
                message: "Please fill all fields properly",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .cancel))
            self.show(alert, sender: sender)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let person = people[indexPath.row]
        let cell = tableview.dequeueReusableCell(withIdentifier: "PersonCell") as? PersonCell
        
        cell?.labelName.text = person.name
        cell?.labelSurname.text = person.surname
        cell?.labelAge.text = "\(person.age)"
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
}

