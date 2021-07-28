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

//getData()
 
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
//getDataPerson()


 
 
// MARK: - Welcome
struct Welcome2: Codable {
    let searchMetadata: SearchMetadata
    let searchParameters: SearchParameters
    let searchInformation: SearchInformation
    let suggestedSearches: [SuggestedSearch]
    let imagesResults: [ImagesResult]

    enum CodingKeys: String, CodingKey {
        case searchMetadata = "search_metadata"
        case searchParameters = "search_parameters"
        case searchInformation = "search_information"
        case suggestedSearches = "suggested_searches"
        case imagesResults = "images_results"
    }
}

// MARK: - ImagesResult
struct ImagesResult: Codable {
    let position: Int
    let thumbnail: String
    let source, title: String
    let link: String
    let original: String
}

// MARK: - SearchInformation
struct SearchInformation: Codable {
    let imageResultsState, queryDisplayed: String

    enum CodingKeys: String, CodingKey {
        case imageResultsState = "image_results_state"
        case queryDisplayed = "query_displayed"
    }
}

// MARK: - SearchMetadata
struct SearchMetadata: Codable {
    let id, status: String
    let jsonEndpoint: String
    let createdAt, processedAt: String
    let googleURL: String
    let rawHTMLFile: String
    let totalTimeTaken: Double

    enum CodingKeys: String, CodingKey {
        case id, status
        case jsonEndpoint = "json_endpoint"
        case createdAt = "created_at"
        case processedAt = "processed_at"
        case googleURL = "google_url"
        case rawHTMLFile = "raw_html_file"
        case totalTimeTaken = "total_time_taken"
    }
}

// MARK: - SearchParameters
struct SearchParameters: Codable {
    let engine, q, googleDomain, ijn: String
    let device, tbm: String

    enum CodingKeys: String, CodingKey {
        case engine, q
        case googleDomain = "google_domain"
        case ijn, device, tbm
    }
}

// MARK: - SuggestedSearch
struct SuggestedSearch: Codable {
    let name: String
    let link: String
    let chips: String
    let serpapiLink: String
    let thumbnail: String

    enum CodingKeys: String, CodingKey {
        case name, link, chips
        case serpapiLink = "serpapi_link"
        case thumbnail
    }
}

var suggestedSearches: [SuggestedSearch] = []
 

 func fetchPhotos(){
    let urlString = "https://serpapi.com/search.json?q=stars&tbm=isch&ijn=0&api_key=fca737073fa8af4e7dc7cb9aa8e9d2997adb47614a6e3b4820918fc20f7195e0"
    guard let url = URL(string: urlString) else {
        return
    }
    let task = URLSession.shared.dataTask(with: url) { data, _, error in
        guard let data = data, error == nil else {
            return
        }
        do{
            let jsonResult = try JSONDecoder().decode(Welcome2.self, from: data)
            DispatchQueue.main.async {
                suggestedSearches = jsonResult.suggestedSearches
                print(jsonResult.suggestedSearches[0].thumbnail)
       
            }
          
        }
        catch {
            print(error)
        }
    }
    task.resume()
}
fetchPhotos()
