//
//  ViewController.swift
//  HW8
//
//  Created by Margarita Can on 9.04.2024.
//

import UIKit

struct Person {
    var name: String
    var lastName: String
}

final class ViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var persons: [Person] = []
    private var contactsAll: [String: [Person]] = [:]
    private var editingMode = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupEditButtonItem()
        setupTableView()
        
    }
    private func setupEditButtonItem() {
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PersonTableViewCell", bundle: nil), forCellReuseIdentifier: "PersonTableViewCell")
    }
    @IBAction func addButtonDidTap(_ sender: Any) {
         if let secondVC = UIStoryboard(name: "Second", bundle: nil).instantiateViewController(withIdentifier: "SecondVC") as? SecondVC {
            secondVC.delegate = self
            present (secondVC, animated: true)
        
        }
    }
    override func setEditing (_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated )
        editingMode = editing
        tableView.setEditing(editing, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections( in tableView: UITableView) -> Int {
        return contactsAll.keys.sorted().count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionTitle = contactsAll.keys.sorted ()
        let letter = sectionTitle[section]
        return contactsAll[letter]?.count ?? 0
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return contactsAll.keys.sorted()[section]
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle:
                   UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath ) {
        if editingStyle == .delete {
            let sectionTitles = contactsAll.keys.sorted()
            let letter = sectionTitles[indexPath.section]
            
            if var personsInSection = contactsAll[letter] {
                personsInSection.remove(at: indexPath.row)
                contactsAll[letter] = personsInSection
                persons = contactsAll.values.flatMap { $0 }
            }
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
    UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonTableViewCell", for: indexPath) as? PersonTableViewCell
        
        let sectionTitles = contactsAll.keys.sorted()
        let letter = sectionTitles[indexPath.section]
        
        if let personsInSection = contactsAll[letter], indexPath.row <
            personsInSection.count {
        let person = personsInSection[indexPath.row]
        cell?.configure(with: person)
    }
    return cell!
}
}
extension ViewController: AddPersonDelegate {
    func configure(person: Person) {
    persons.append(person)
    persons.sort { $0.name < $1.name }
    
    contactsAll = Dictionary(grouping: persons, by: {
        String($0.name.prefix(1)).uppercased()
    })
    tableView.reloadData()
    
}
}
