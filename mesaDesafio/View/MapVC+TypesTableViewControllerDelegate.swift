//
//  MapVC+TypesTableViewControllerDelegate.swift
//  mesaDesafio
//
//  Created by Rafael Douglas on 02/03/20.
//  Copyright © 2020 com.rafael.douglas. All rights reserved.
//

import Foundation

// MARK: - TypesTableViewControllerDelegate
extension MapVC: TypesTableVCDelegate {
  func typesController(_ controller: TypesTableVC, didSelectTypes types: String) {
    selectedFilter = controller.selectedTypes
    dismiss(animated: true)
    getPlaces()
  }
}
