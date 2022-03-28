//
//  ContentModel.swift
//  LessonsApp
//
//  Created by Kevin Tierney on 3/25/22.
//

import Foundation

class ContentModel: ObservableObject{
    
    // List of modules
    @Published var modules = [Module]()
    
    //Current module
    
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    
    
    var styleData: Data?
    
    init() {
        getLocalData()
    }
    
    // MARK: - Data methods
    
    func getLocalData() {
        
        // Get a URL to the JSon File
        
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        
        // Read the file into a data object
        do{
            let jsonData = try Data(contentsOf: jsonUrl!)
            
            // Try to decode the Json into an array of modules
            
            let jsonDecoder = JSONDecoder()
            let modules = try jsonDecoder.decode([Module].self, from: jsonData)
            
            // Assign parsed modules to modules property
            self.modules = modules
        }
        catch{
            // log error
            print(error)
        }
        
        // get url to the style File
        
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        
      //  read the Style file into style variable
        
        do{
            let styleData = try Data(contentsOf: styleUrl!)
            
            self.styleData = styleData
        }
        catch{
            print("error fetching style data")
        }
        
    }
    
    // MARK: - Module navigation methods
    
    func beginModule(_ moduleId:Int){
        
        // find the index for this module
        
        for index in 0..<modules.count {
            
            if modules[index].id == moduleId{
                
                // found the matching module
                currentModuleIndex = index
                break
            }

        }

        // set the current module
        
        currentModule  = modules[currentModuleIndex]

    }
    
}
