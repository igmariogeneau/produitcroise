//===============================================
import UIKit
//===============================================
class ProduitCroise {
    //------------------------------------------
    var lesNotes: [String : [Double]] = [:]
    var keys: [String] = []
    var values: [Double] = []
    //------------------------------------------
    init() {
        parseDict()
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
