//
//  File.swift
//  
//
//  Created by Данила on 21.11.2022.
//

import Foundation
import CoreData

public final class Country: NSManagedObject {
    @NSManaged var name: String
    @NSManaged public var citys: NSSet?
}

extension Country: Identifiable {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country")
    }
    
    @objc(addCitysObject:)
    @NSManaged public func addToCitys(_ value: City)

    @objc(removeCitysObject:)
    @NSManaged public func removeFromCitys(_ value: City)

    @objc(addCitys:)
    @NSManaged public func addToCitys(_ values: NSSet)

    @objc(removeCitys:)
    @NSManaged public func removeFromCitys(_ values: NSSet)
}

public final class City: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var isCapital: Bool
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
    @NSManaged var country: Country
}

extension City: Identifiable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }
}

var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentCloudKitContainer(name: "ExampleModel", managedObjectModel: managedObjectModel())
    
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        if let error = error as NSError? {
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    })
    return container
}()

var context: NSManagedObjectContext = {
    return persistentContainer.viewContext
}()


func managedObjectModel() -> NSManagedObjectModel {
    
    let model = NSManagedObjectModel()
    
    // MARK: - CountryEntity
    
    let countryEnt = NSEntityDescription()
    countryEnt.name = "Country"
    countryEnt.managedObjectClassName = NSStringFromClass(Country.self)
    
    // Attributes
    let countryNameAttr = NSAttributeDescription()
    countryNameAttr.name = "name"
    countryNameAttr.attributeType = .stringAttributeType
    
    
    // MARK: - CityEntity
    
    let cityEnt = NSEntityDescription()
    cityEnt.name = "City"
    cityEnt.managedObjectClassName = NSStringFromClass(City.self)
    
    // Attributes
    let nameAttr = NSAttributeDescription()
    nameAttr.name = "name"
    nameAttr.attributeType = .stringAttributeType
    
    let isCapitalAttr = NSAttributeDescription()
    isCapitalAttr.name = "isCapital"
    isCapitalAttr.attributeType = .booleanAttributeType
    
    let latitudeAttr = NSAttributeDescription()
    latitudeAttr.name = "latitude"
    latitudeAttr.attributeType = .doubleAttributeType
    
    let longitudeAttr = NSAttributeDescription()
    longitudeAttr.name = "longitude"
    longitudeAttr.attributeType = .doubleAttributeType
    
    
    // MARK: - Relationships
    
    let countryToCity = NSRelationshipDescription()
    countryToCity.name = "citys"
    countryToCity.destinationEntity = cityEnt
    countryToCity.deleteRule = .cascadeDeleteRule
    
    let cityToCountry = NSRelationshipDescription()
    cityToCountry.name = "country"
    cityToCountry.destinationEntity = countryEnt
    cityToCountry.maxCount = 1
    cityToCountry.deleteRule = .nullifyDeleteRule
    
    // Inverse relationships
    countryToCity.inverseRelationship = cityToCountry
    cityToCountry.inverseRelationship = countryToCity
    
    
    
    // Set properties
    countryEnt.properties = [countryNameAttr, countryToCity]
    cityEnt.properties = [nameAttr,
                          isCapitalAttr,
                          latitudeAttr,
                          longitudeAttr,
                          cityToCountry]
    
    model.entities = [countryEnt,cityEnt]
    
    return model
}
