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
    var viewModel = TypesTableVM()
    
    override func viewDidLoad() {
        setupView()
    }
    
    func setupView(){
        self.navigationItem.title = "Filtrar por categoria"
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        let backgroundColor = Utils.hexStringToUIColor(hex: BACKGROUND_COLOR)
        self.navigationController?.navigationBar.barTintColor = backgroundColor
    }
    
    @IBAction func donePressed(_ sender: Any) {
        viewModel.delegate?.typesController(self, didSelectTypes: viewModel.selectedTypes)
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filterOptions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "TypeCell", for: indexPath)
        let type = viewModel.filterOptions[indexPath.row]
      cell.textLabel?.text = type
        cell.accessoryType = viewModel.selectedTypes.contains(type) ? .checkmark : .none
      return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.selectedTypes = viewModel.filterOptions[indexPath.row]
        tableView.reloadData()
    }
}
