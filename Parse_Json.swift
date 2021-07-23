import UIKit


//Para cuando es un array
struct Welcome: Codable {
    let postCode, country, countryAbbreviation: String
    let places: [Place]

    enum CodingKeys: String, CodingKey {
        case postCode = "post code"
        case country
        case countryAbbreviation = "country abbreviation"
        case places
    }
}

// MARK: - Place
struct Place: Codable {
    let placeName, longitude, state, stateAbbreviation: String
    let latitude: String

    enum CodingKeys: String, CodingKey {
        case placeName = "place name"
        case longitude, state
        case stateAbbreviation = "state abbreviation"
        case latitude
    }
}



var result:Welcome?
func getData(){
    let urlString = "https://api.zippopotam.us/us/90210"
    guard let url = URL(string: urlString) else {
        return
    }
    
    let task =  URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
        guard let data = data, error == nil else {
            return
        }
         
        do{
            result = try JSONDecoder().decode(Welcome.self, from: data)
            
        }
        catch {
            print("error to parse json")
        }
        guard let finalData = result else {
            return
        }
        print(finalData.places)
        print("starting \(data)")
    })
    task.resume()
}

getData()
 
struct Person: Codable {
    let name: String
    let age, count: Int
}

var dataPerson:Person?
// SIN ARRAY
func getDataPerson(){
    let urlString = "https://api.agify.io/?name=bella"
    guard let url = URL(string: urlString) else {
        return
    }
    
    let task =  URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
        guard let data = data, error == nil else {
            return
        }
         
        do{
            dataPerson = try JSONDecoder().decode(Person.self, from: data)
            
        }
        catch {
            print("error to parse json")
        }
        guard let finalData = dataPerson else {
            return
        }
        print("\(finalData.name) \(finalData.age)")
        print("starting \(data)")
    })
    task.resume()
}
getDataPerson()
