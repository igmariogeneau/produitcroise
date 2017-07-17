//===============================================
import UIKit
//===============================================
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate  {
    //------------------------------------------
    @IBOutlet weak var nom_textField: UITextField!
    @IBOutlet weak var note_textField: UITextField!
    @IBOutlet weak var sur_textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var convertir_textField: UITextField!
    @IBOutlet weak var scrollview: UIScrollView!
    //------------------------------------------
    let obj = ProduitCroise()
    //------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //------------------------------------------
    @IBAction func ajouter_button(_ sender: UIButton) {
        obj.ajouterUneNote(nom: nom_textField.text!,
                           note: Double(note_textField.text!)!,
                           sur: Double(sur_textField.text!)!)
        
        obj.parseDict()
        tableView.reloadData()
        resetFields()
        hideKeyboard()
    }
    //------------------------------------------
    func hideKeyboard() {
        nom_textField.resignFirstResponder()
        note_textField.resignFirstResponder()
        sur_textField.resignFirstResponder()
        convertir_textField.resignFirstResponder()
    }
    //------------------------------------------
    func resetFields() {
        nom_textField.text = ""
        note_textField.text = ""
        sur_textField.text = ""
        convertir_textField.text = ""
    }
    //------------------------------------------
    @IBAction func changer_button(_ sender: UIButton) {
        obj.changerNotes(lesNotes: obj.values,
                         noteSur: obj.lesNotes[obj.keys[0]]![1],
                         convertirSur: Double(convertir_textField.text!)!) {$0 * $2 / $1}
        tableView.reloadData()
        resetFields()
        hideKeyboard()
    }
    //------------------------------------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundColor = UIColor.clear
        return obj.lesNotes.count
    }
    //------------------------------------------
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style:UITableViewCellStyle.default, reuseIdentifier:"proto")
        let a = obj.keys[indexPath.row]
        let b = String(format: "%0.1f", obj.values[indexPath.row])
        let c = String(format: "%0.1f", obj.lesNotes[obj.keys[indexPath.row]]![1])
        let s = "\(a) : \(b) / \(c)"
        cell.textLabel!.text = s
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = UIColor.clear
        return cell
    }
    //------------------------------------------
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath as IndexPath)!
        selectedCell.contentView.backgroundColor = UIColor.darkGray
    }
    //------------------------------------------
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            obj.lesNotes[obj.keys[indexPath.row]] = nil
            obj.saveUserDefaults()
            obj.parseDict()
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    //------------------------------------------
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //------------------------------------------
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 10 {
            let theOffset = 900 - UIScreen.main.bounds.size.height
            scrollview.setContentOffset(CGPoint(x: 0, y: theOffset), animated: true)
        } else {
            scrollview.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
    }
    //------------------------------------------
}
//===============================================





















