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
    viewModel.selectedFilter = controller.viewModel.selectedTypes
    dismiss(animated: true)
    viewModel.getPlaces(mapView: mapView)
  }
}
