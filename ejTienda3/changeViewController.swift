//
//  changeViewController.swift
//  ejTienda3
//
//  Created by Javier Rodríguez Valentín on 01/10/2021.
//

import UIKit

class changeViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var labelProducto: UILabel!
    @IBOutlet weak var labelPrecio: UILabel!
    @IBOutlet weak var changeBtn: UIButton!
    @IBOutlet weak var inputProducto: UITextField!
    @IBOutlet weak var inputPrecio: UITextField!
    
    var transfer2:Producto?
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        changeBtn.layer.cornerRadius = 15
        changeBtn.titleLabel?.font = .systemFont(ofSize: 25)
        changeBtn.setTitle("Cambiar", for: .normal)
        changeBtn.backgroundColor = UIColor(red: 0/255, green: 128/255, blue: 254/255, alpha: 1.0)
        changeBtn.tintColor = .white
        
        label.text = "Introduzca el producto"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22)
        
        
        
    }

}
