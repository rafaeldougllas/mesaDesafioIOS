//
//  TypesTableVC.swift
//  mesaDesafio
//
//  Created by Rafael Douglas on 02/03/20.
//  Copyright © 2020 com.rafael.douglas. All rights reserved.
//

import UIKit

protocol TypesTableVCDelegate: class {
  func typesController(_ controller: TypesTableVC, didSelectTypes types: String)
}

class TypesTableVC: UITableViewController {
    let filterOptions = ["Todos", "Aeroportos", "Restaurantes", "Baladas", "Supermercados", "Shopping centers"]
    weak var delegate: TypesTableVCDelegate?
    var selectedTypes: String = "Todos"
    
    @IBAction func donePressed(_ sender: Any) {
        delegate?.typesController(self, didSelectTypes: selectedTypes)
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return filterOptions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "TypeCell", for: indexPath)
      let type = filterOptions[indexPath.row]
      cell.textLabel?.text = type
      cell.accessoryType = selectedTypes.contains(type) ? .checkmark : .none
      return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
      selectedTypes = filterOptions[indexPath.row]
      tableView.reloadData()
    }
}
