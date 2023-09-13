//
//  ViewController.swift
//  ejTienda3
//
//  Created by Javier Rodríguez Valentín on 30/09/2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var inputProducto: UITextField!
    @IBOutlet weak var inputPrecio: UITextField!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var table: UITableView!
    
    var transfer:Producto?
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var array:[Producto] = []
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.dataSource = self
        table.delegate = self
        
        table.tableFooterView = UIView() //no muestra nada por debajo de la última fila
        
        table.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        addBtn.layer.cornerRadius = 15
        addBtn.titleLabel?.font = .systemFont(ofSize: 25)
        addBtn.setTitle("Añadir", for: .normal)
        addBtn.backgroundColor = UIColor(red: 0/255, green: 128/255, blue: 254/255, alpha: 1.0)
        addBtn.tintColor = .white
        
        label.text = "Introduzca el producto"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22)
        
        inputProducto.attributedPlaceholder = NSAttributedString(string: "Producto",attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        inputPrecio.attributedPlaceholder = NSAttributedString(string: "Precio",attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        getData()
    }
    
    //MARK: addBtnAct
    @IBAction func addBtnAct(_ sender: Any) {
        if inputProducto.text != "" && inputPrecio.text != "" {
            
            let productoAdd = Producto(context: self.context)
            productoAdd.producto = inputProducto.text
            productoAdd.precio = inputPrecio.text
            
            do {
                try self.context.save()
                self.getData()
            } catch {
                //print("ERROR: al guardar datos")
                alert(msg: "ERROR: al guardar datos", a: 0)
            }
            
        }
    }
    
    //MARK: getData
    func getData() {
        
        do {
            self.array = try context.fetch(Producto.fetchRequest())
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        } catch {
            //print("ERROR: al obtener datos")
            alert(msg: "ERROR: al obtener datos", a: 0)
        }
    }
    
    //MARK: Alert
    func alert(msg:String, a:Int){
        
        if a == 0{
            //print("errores")
            let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            present(alert, animated: true, completion: {/*Para poner el temporizador, se puede poner nil*/ Timer.scheduledTimer(withTimeInterval: 5, repeats: false, block: {_ in
                self.dismiss(animated: true, completion: nil)
            })})
        }else if a == 1{
            //print("modificar")
            //al final esta parte no se utiliza porque se hace la parte de modificar en la extansión del delegate
        }else{
            //print("ERROR GRAVE, GRAVISIMO")
            let alert = UIAlertController(title: "Alert", message: "ERROR GRAVE, GRAVISIMO", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            present(alert, animated: true, completion: {/*Para poner el temporizador, se puede poner nil*/ Timer.scheduledTimer(withTimeInterval: 5, repeats: false, block: {_ in
                self.dismiss(animated: true, completion: nil)
            })})
        }
        
        
    }
    
}


//MARK: extensión dataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Las secciones nos hacen la tabla completa (si == 0 una vez, pero si es mayor que 0 más veces) y el resto de secciones que pongamos (en la funcion de secciones) nos lo hace poniendo solo los elementos que digamos en este caso 2
        /*if section == 0 {
         return array.count
         }else{
         return 2
         
         }*/
        
        return array.count
    }
    
    //MARK: Constructor Celda
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell
        
        cell?.labelProducto.text = array[indexPath.row].producto
        cell?.labelPrecio.text = array[indexPath.row].precio
        
        return cell!
        
    }
}

//MARK: extensión delegate
extension ViewController: UITableViewDelegate {
    
    //esta función nos dice el elemento seleccionado
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Has seleccionado: \(array[indexPath.row])")
    }
    
    //nº de veces que nos repite la tabla
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //MARK: eliminar o modificar
    //Eliminamos arrastrando el elemento hacia la izquierda con leadingSwipeActionsConfigurationForRowAt
    
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        //parte de borrar
        let action = UIContextualAction(style: .destructive, title: "BORRAR") { [self](action,view,completionHandler) in
            let eraseProducto = self.array[indexPath.row]
            self.context.delete(eraseProducto)
            do {
                try self.context.save()
            } catch {
                //print("ERROR: al borrar datos")
                alert(msg: "ERROR: al borrar datos", a: 0)
            }
            self.getData()
        }
        
        //parte de modificar
        let action2 = UIContextualAction(style: .normal, title: "Modificar") { /*[self] -> si pongo este self entre corchetes no necesitaría poner en el código de esta función la palabra self antes de cada variable*/ _,_,_ in
            //selecciono un elemento del array
            
            //transfer = self.array[indexPath.row]
            let modifyProducto = self.array[indexPath.row]
            //creo una alerta
            let alert2 = UIAlertController(title: "Modificar", message: "Elemento a editar", preferredStyle: .alert)
            //añado un campo de texto
            alert2.addTextField()
            alert2.addTextField()
            //creo el campo de texto que le digo ue va a ser el primero [0]
            let textField = alert2.textFields![0]
            let textField2 = alert2.textFields![1]
            //Escribe en el textField de la alerta el contenido de la celda seleccionada
            textField.text = modifyProducto.producto
            
            textField2.text = modifyProducto.precio
            //creo una acción dentro de la alerta en forma de botón
            let action2Alerta = UIAlertAction(title: "OK", style: .default) { (_) in
                //creo un textField y le pongo el contenido de la alerta
                let textField3 = alert2.textFields![0]
                modifyProducto.producto = textField3.text
                let textField4 = alert2.textFields![1]
                modifyProducto.precio = textField4.text!
                
                do {
                    try self.context.save()
                    self.getData()
                } catch {
                    //print("Error al eliminar un objeto")
                    self.alert(msg: "Error al modificar un objeto", a: 0)
                }
            }
            
            //añado la accion a la alerta
            alert2.addAction(action2Alerta)
            
            //añado un nuevo botón de cancelar
            let cancelButton = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
            alert2.addAction(cancelButton)
            
            //presento la alerta
            self.present(alert2, animated: true, completion: nil)
            
        }
        action2.backgroundColor = .darkGray
        
        return UISwipeActionsConfiguration(actions: [action2,action])
    }
}

