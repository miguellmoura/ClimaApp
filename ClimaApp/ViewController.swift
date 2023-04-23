//
//  ViewController.swift
//  ClimaApp
//
//  Created by Aluno on 24/10/22.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var tempMax: UILabel!
    @IBOutlet weak var tempMin: UILabel!
    @IBOutlet weak var namecity: UILabel!
    
    var lon = 0.0
    var lat = 0.0
    let key = "b5639b8bbbc7dcea3a1fefbfdabac225"
    let reqWeather = "https://api.openweathermap.org/data/2.5/weather"
    var unity: String?
    var singleLetter: String?
    
    let lm = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
            
        // qual objetivo vai receber as atualizações de localização
        lm.delegate = self
        
        // solicitar autorização do usuário
        lm.requestWhenInUseAuthorization()
        
        // precisão que o gps deve utilizar (gasta muita bateria)
        lm.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        // requisitar a localização
        lm.requestLocation()
        
        // iniciar a atualização
        lm.startUpdatingLocation()
    
    }

    // uma nova localização foi encontrada
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lat = (locations.last?.coordinate.latitude)!
        lon = (locations.last?.coordinate.longitude)!
        updateTemp()
        lm.stopUpdatingLocation()
        
    }
    
    func updateTemp () {
        let reqString = "\(reqWeather)?lat=\(lat)&lon=\(lon)&appid=\(key)&units=\(unity!)"
        print(reqString)
        
        if let url = URL(string: reqString) {
            // Criar uma sessão
            let sessao = URLSession(configuration: .default)
            
            // Criar uma tarefa pausada
            
            let tarefa = sessao.dataTask(with: url) { data, response, error in
                print("a resposta chegou")
                
                let decodificador = JSONDecoder()
                
                do {
                    
                    let dados = try decodificador.decode(Main.self, from: data!)
                    
                    DispatchQueue.main.async {
                        self.temp.text = "Temperatura Atual: \(String(dados.main["temp"]!))°\(self.singleLetter!)"
                        self.tempMax.text = "Temperatura Máxima: \(String(dados.main["temp_max"]!)) ° \(self.singleLetter!)"
                        self.tempMin.text = "Temperatura Mínima: \(String(dados.main["temp_min"]!)) ° \(self.singleLetter!)"
                        self.namecity.text = "Cidade: " + dados.name
                    }
                    
                } catch {
                    print("deu erro: \(error)")
                }
                
            }
            
            // ativa a tarefa e envia a requisição para a URL (resume que faz a conexão)
            tarefa.resume()
        }
    }
    
    // não foi possível atualizar a localização
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }

}

