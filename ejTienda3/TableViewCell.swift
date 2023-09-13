//
//  TableViewCell.swift
//  ejTienda3
//
//  Created by Javier Rodríguez Valentín on 30/09/2021.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelProducto: UILabel!
    @IBOutlet weak var labelPrecio: UILabel!
    @IBOutlet weak var cell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cell.backgroundColor = .cyan
        labelProducto.textColor = .black
        labelPrecio.backgroundColor = .red
        labelPrecio.textColor = .white
        labelPrecio.textAlignment = .center
        labelPrecio.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
