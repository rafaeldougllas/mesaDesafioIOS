//
//  TypesTableVM.swift
//  mesaDesafio
//
//  Created by Rafael Douglas on 05/03/20.
//  Copyright © 2020 com.rafael.douglas. All rights reserved.
//

import Foundation
class TypesTableVM{
    let filterOptions = ["Todos", "Aeroportos", "Restaurantes", "Baladas", "Supermercados", "Shopping centers"]
    weak var delegate: TypesTableVCDelegate?
    var selectedTypes: String = "Todos"
}
