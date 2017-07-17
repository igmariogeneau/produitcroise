//===============================================
import UIKit
//===============================================
class ProduitCroise {
    //------------------------------------------
    var lesNotes: [String : [Double]] = [:]
    var keys: [String] = []
    var values: [Double] = []
    var userDefaults = UserDefaults.standard
    //------------------------------------------
    init() {
        manageUserDefaults()
        parseDict()
    }
    //------------------------------------------
    func manageUserDefaults() {
        if let savedData = userDefaults.object(forKey: "data") {
            lesNotes = savedData as! [String : [Double]]
        } else {
            userDefaults.set(lesNotes, forKey: "data")
        }
    }
    //------------------------------------------
    func saveUserDefaults() {
        userDefaults.set(lesNotes, forKey: "data")
    }
    //------------------------------------------
    func changerNotes(lesNotes: [Double],
                      noteSur: Double,
                      convertirSur: Double,
                      produitCroise: (_ note: Double, _ sur: Double, _ convertirSur: Double) -> Double) {
        var tableauRetourner: [Double] = []
        for n in lesNotes {
            let d = produitCroise(n, noteSur, convertirSur)
            tableauRetourner.append(d)
        }
        var n: [String : [Double]] = [:]
        var index = 0
        for (a, _) in self.lesNotes {
            n[a] = [tableauRetourner[index], convertirSur]
            index += 1
        }
        self.lesNotes = n
        parseDict()
    }
    //------------------------------------------
    func ajouterUneNote(nom: String, note: Double, sur: Double) {
        lesNotes[nom] = [note, sur]
        saveUserDefaults()
    }
    //------------------------------------------
    func parseDict() {
        keys = []
        values = []
        for (a, b) in lesNotes {
            keys.append(a)
            values.append(b[0])
        }
    }
    //------------------------------------------
}
//===============================================
