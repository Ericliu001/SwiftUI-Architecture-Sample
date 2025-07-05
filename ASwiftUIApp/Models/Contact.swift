/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Maps the ID, given name, family name, full name, initials, and phone number information of a contact object.
*/

import SwiftUI
import UniformTypeIdentifiers
import Contacts
#if canImport(UIKit)
import UIKit
typealias PlatformImage = UIImage
#elseif canImport(AppKit)
import AppKit
typealias PlatformImage = NSImage
#endif

struct Contact: Identifiable, Codable, Hashable {
    var id: String
    var givenName: String
    var familyName: String
    var thumbNail: Data?
    var phoneNumber: String
    var email: String?
    var videoURL: URL?
    var fullName: String {
        givenName + " " + familyName
    }
}

extension UTType {
    static var exampleContact = UTType(exportedAs: "com.example.contact")
}

extension Contact: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        // Allows Contact to be transferred with a custom content type.
        CodableRepresentation(contentType: .exampleContact)
        // Allows importing and exporting Contact data as a vCard.
        DataRepresentation(contentType: .vCard) { contact in
            try contact.toVCardData()
        } importing: { data in
            try await parseVCardData(data)
        }
        // Enables exporting the `phoneNumber` string as a proxy for the entire `Contact`.
        ProxyRepresentation { contact in
            contact.phoneNumber
        } importing: { value  in
            Contact(id: UUID().uuidString, givenName: value, familyName: "", phoneNumber: "")
        }
        .suggestedFileName { $0.fullName }
    }
    
    static func parseVCardData(_ data: Data) async throws -> Contact {
        let contacts = try await CNContactVCardSerialization.contacts(
            with: data
        )
        
        guard let contact = contacts.first else {
            throw NSError(domain: "ContactImportError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid vCard data."])
        }
        
        let phoneNumber = contact.phoneNumbers.first?.value.stringValue ?? ""
        let email = contact.emailAddresses.first?.value as String?
        let thumbNail: Data? = contact.imageData
        return Contact(
            id: contact.id.uuidString,
            givenName: contact.givenName,
            familyName: contact.familyName,
            thumbNail: thumbNail,
            phoneNumber: phoneNumber,
            email: email,
            videoURL: nil
        )
    }
}

extension Contact {
    static var mock: [Contact] = [
         Contact(
             id: "123E4567-E89B-12D3-A456-426614174000",
             givenName: "Juan",
             familyName: "Chavez",
             thumbNail: nil,
             phoneNumber: "(510) 555-0101",
             email: "chavez4@icloud.com",
             videoURL: nil
         ),
         Contact(
             id: "123E4567-E89B-12D3-A456-426614174001",
             givenName: "Mei",
             familyName: "Chen",
             thumbNail: nil,
             phoneNumber: "(510) 555-0102",
             email: "meichen3@icloud.com",
             videoURL: nil
         ),
         Contact(
             id: "123E4567-E89B-12D3-A456-426614174002",
             givenName: "Tom",
             familyName: "Clark",
             thumbNail: convertImageToData(PlatformImage(named: "AdamGooseff")!),
             phoneNumber: "(510) 555-0103",
             email: "tclark3@icloud.com",
             videoURL: Contact.urlForResource(named: "video1", withExtension: "m4v")
         ),
         Contact(
             id: "123E4567-E89B-12D3-A456-426614174003",
             givenName: "Bill",
             familyName: "James",
             thumbNail: convertImageToData(PlatformImage(named: "AgaOrlova")!),
             phoneNumber: "(510) 555-0104",
             email: "billjames2@icloud.com",
             videoURL: Contact.urlForResource(named: "video1", withExtension: "m4v")
         ),
         Contact(
             id: "123E4567-E89B-12D3-A456-426614174004",
             givenName: "Anne",
             familyName: "Johnson",
             thumbNail: convertImageToData(PlatformImage(named: "AllisonCain")!),
             phoneNumber: "(510) 555-0105",
             email: "annejohnson1@icloud.com",
             videoURL: Contact.urlForResource(named: "video2", withExtension: "m4v")
         ),
         Contact(
             id: "123E4567-E89B-12D3-A456-426614174005",
             givenName: "Maria",
             familyName: "Ruiz",
             thumbNail: convertImageToData(PlatformImage(named: "AmberSpiers")!),
             phoneNumber: "(510) 555-0106",
             email: "mruiz2@icloud.com",
             videoURL: Contact.urlForResource(named: "video2", withExtension: "m4v")
         ),
         Contact(
             id: "123E4567-E89B-12D3-A456-426614174007",
             givenName: "Ravi",
             familyName: "Patel",
             thumbNail: nil,
             phoneNumber: "(510) 555-0107",
             email: "ravipatel@icloud.com",
             videoURL: nil
         )
     ]
    
    static func convertImageToData(_ image: PlatformImage) -> Data? {
         #if canImport(AppKit)
         guard let tiffData = image.tiffRepresentation else { return nil }
         guard let bitmapImage = NSBitmapImageRep(data: tiffData) else { return nil }
         return bitmapImage.representation(using: .png, properties: [:])
         #elseif canImport(UIKit)
         return image.pngData()
         #endif
     }
}

extension Contact {
    func toVCardData() throws -> Data {
        let contact = CNMutableContact()
        contact.givenName = givenName
        contact.familyName = familyName
        contact.phoneNumbers = [CNLabeledValue(label: CNLabelPhoneNumberMobile, value: CNPhoneNumber(stringValue: phoneNumber))]
        contact.imageData = thumbNail
        if let email = email {
            contact.emailAddresses = [CNLabeledValue(label: CNLabelEmailiCloud, value: NSString(string: email))]
        }
        let data = try CNContactVCardSerialization.data(with: [contact])
        return data
    }
    
    static func urlForResource(named name: String, withExtension ext: String) -> URL? {
        Bundle.main.url(forResource: name, withExtension: ext)
    }
}
