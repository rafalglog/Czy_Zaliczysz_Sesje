//
//  ViewController.swift
//  Czy_Zaliczysz_Sesje
//  Projekt na zalicznie przedmiotu Programowanie urządzeń mobilnych
//  Created by Rafal Glogowski on 31/10/2023.
// Index# 163707
//

import UIKit

class ViewController: UIViewController {
    //powiazanie elemtów z ekranu z kodem
    @IBOutlet weak var KostkaImage1: UIImageView!
    @IBOutlet weak var KostkaImage2: UIImageView!
    @IBOutlet weak var KostkaImage3: UIImageView!
    @IBOutlet weak var KostkaImage4: UIImageView!
    @IBOutlet weak var wynikKostek: UILabel!
    @IBOutlet weak var ileWypadlo: UILabel!
    
    @IBOutlet weak var jezykAngielski: UIImageView!
    @IBOutlet weak var jezyk_Polski: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Tekst komunikatu po otwarciu aplikacji
        let infoMessage = "Pamiętaj, żeby zaliczyć musisz się postarać!"
        displayInformationMessage(message: infoMessage)
                
        //ustawienie kostek w pozycji początkowej 6
        //przezroczystość 50%
        KostkaImage1.image = UIImage(imageLiteralResourceName: "DiceSix")
        KostkaImage2.image = UIImage(imageLiteralResourceName: "DiceSix")
        KostkaImage3.image = UIImage(imageLiteralResourceName: "DiceSix")
        KostkaImage4.image = UIImage(imageLiteralResourceName: "DiceSix")
        KostkaImage1.alpha = 0.5
        KostkaImage2.alpha = 0.5
        KostkaImage3.alpha = 0.5
        KostkaImage4.alpha = 0.5
        
        //Dodanie funkcji shake
        _ = becomeFirstResponder()
        
    }
    override func becomeFirstResponder() -> Bool {
        return true
    }
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            SprawdzNacisniete(UIButton())
        }
    }
    //kod który się wykona po naciśnięciu przycisku
    @IBAction func SprawdzNacisniete(_ sender: UIButton) {
        
        // Utwórz tablicę obrazów i pszypisz numer obrazowi
        let diceImages = ["DiceOne", "DiceTwo", "DiceThree", "DiceFour", "DiceFive", "DiceSix"]
        let diceNumbers = [1, 2, 3, 4, 5, 6]
        //Zlicz sumę max na wszystkich kostkach
        let dicesSum = 4 * diceImages.count
        // Utwórz pustą tablicę do przechowywania unikalnych losowych numerów
        var uniqueIndexes = [Int]()
        // Generuj unikalne losowe numery dla każdego obrazu KostkaImage
        while uniqueIndexes.count < 4 {
            let randomIndex = Int.random(in: 0..<diceImages.count)
            if !uniqueIndexes.contains(randomIndex) {
                uniqueIndexes.append(randomIndex)
            }
        }
        
        // Wyświetl wybrane obrazy w widokach KostkaImage za pomocą unikalnych numerów
        KostkaImage1.image = UIImage(imageLiteralResourceName: diceImages[uniqueIndexes[0]])
        KostkaImage2.image = UIImage(imageLiteralResourceName: diceImages[uniqueIndexes[1]])
        KostkaImage3.image = UIImage(imageLiteralResourceName: diceImages[uniqueIndexes[2]])
        KostkaImage4.image = UIImage(imageLiteralResourceName: diceImages[uniqueIndexes[3]])
        
        // Wyświetlanie Informacji o zaliczeniu
        //Oblicz sumę powiązanych liczb
        let sum = diceNumbers[uniqueIndexes[0]] + diceNumbers[uniqueIndexes[1]] + diceNumbers[uniqueIndexes[2]] + diceNumbers[uniqueIndexes[3]]
        //oblicz procent z sumy oczek na kostce
        let procent = round(Double(sum) / Double(dicesSum) * 100)
        //formatuj wyglad wyswietlaneg procenty bez przecinka
        let formattedProcent = Int(procent)
        //zmienna ktora wyswietla jaki wynik został wylosowany
        let ileKostki = "Kostki mówią, że masz \(String(formattedProcent)) % szansy zdać."
        //wyswietlanie sformatowanej zmiennej ileKostki w elemencie UI ileWypadlo
        ileWypadlo.text = ileKostki
        //zmienna która sprawdza % i wybiera tekst do wyświetlenia
        let textdowyswietlenia = procent >= 60  ? "Chyba Ci się uda" : "Musisz się jeszcze pouczyć"
        //wyswietlanie sformatowanej zmiennej textdowyswietlenia w elemencie UI wynikKostek
        wynikKostek.text = textdowyswietlenia
        
    //Wyswietlenie informacji po wylosowaniu sześciu oczek na wystkich kostkach
        func geniusz(message: String) {
            DispatchQueue.main.async {
                let alertController = UIAlertController(title: "Uwaga Geniusz!", message: message, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Tak wiem, jestem geniuszem", style: .default, handler: nil))
                // Tutaj dodaj wywołanie, aby wyświetlić UIAlertController na ekranie
                self.present(alertController, animated: true, completion: nil)
            }
        }

        if Int(sum) == Int(dicesSum) {
            let geniusztext = "Jesteś Geniuszem! Idź na piwo!"
            geniusz(message: geniusztext)
        }
        
    }
    
    // funkcja do Wyświetlenia komunikatu na 4s w formie pop up,
    func displayInformationMessage(message: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Dobra Rada", message: message, preferredStyle: .alert)
            //po usunieciu // z lini poniżej uruchomi się przycisk OK
            //alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            alertController.view.alpha = 0.5
            
            if let window = UIApplication.shared.windows.first {
                window.rootViewController?.present(alertController, animated: true, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    alertController.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
  
    
}
