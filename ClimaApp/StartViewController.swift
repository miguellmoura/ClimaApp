//
//  StartViewController.swift
//  ClimaApp
//
//  Created by Aluno on 28/10/22.
//

import UIKit

class StartViewController: UIViewController {

    var unity = ""
    var singleLetter = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
        

    @IBAction func celsius(_ sender: UIButton) {
        unity = "metric"
        singleLetter = "C"
    }
    
    @IBAction func fahrenheit(_ sender: UIButton) {
        unity = "imperial"
        singleLetter = "F"
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! ViewController
        controller.unity = self.unity
        controller.singleLetter = self.singleLetter
    }
    

}
