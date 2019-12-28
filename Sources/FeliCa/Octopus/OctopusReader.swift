//
//  OctopusReader.swift
//  TRETJapanNFCReader
//
//  Created by treastrain on 2019/09/20.
//  Copyright © 2019 treastrain / Tanaka Ryoga. All rights reserved.
//

#if os(iOS)
import CoreNFC
#if canImport(TRETJapanNFCReader_FeliCa)
import TRETJapanNFCReader_FeliCa
#endif

@available(iOS 13.0, *)
public typealias OctopusCardTag = NFCFeliCaTag

@available(iOS 13.0, *)
public class OctopusReader: FeliCaReader {
    
    private var octopusCardItemTypes: [OctopusCardItemType] = []
    
    private init() {
        fatalError()
    }
    
    /// Initializes OctopusReader.
    /// - Parameter feliCaReader: FeliCaReader
    public init(feliCaReader: FeliCaReader) {
        super.init(delegate: feliCaReader.delegate!)
    }
    
    /// Initializes OctopusReader.
    /// - Parameter delegate: FeliCaReaderSessionDelegate
    public override init(delegate: FeliCaReaderSessionDelegate) {
        super.init(delegate: delegate)
    }
    
    /// Initializes OctopusReader.
    /// - Parameter viewController: FeliCaReaderSessionDelegate を適用した UIViewController
    public override init(viewController: FeliCaReaderViewController) {
        super.init(viewController: viewController)
    }
    
    /// Get read data from Octopus card
    /// - Parameter itemTypes: Types of data items you want to read from Octopus card
    public func get(itemTypes: [OctopusCardItemType]) {
        self.octopusCardItemTypes = itemTypes
        self.beginScanning()
    }
    
    public func getItems(_ session: NFCTagReaderSession, feliCaTag: NFCFeliCaTag, idm: String, systemCode: FeliCaSystemCode, itemTypes: [OctopusCardItemType], completion: @escaping (FeliCaCard) -> Void) {
        self.octopusCardItemTypes = itemTypes
        self.getItems(session, feliCaTag: feliCaTag, idm: idm, systemCode: systemCode) { (feliCaCard) in
            completion(feliCaCard)
        }
    }
    
    public override func getItems(_ session: NFCTagReaderSession, feliCaTag: NFCFeliCaTag, idm: String, systemCode: FeliCaSystemCode, completion: @escaping (FeliCaCard) -> Void) {
        var octopusCard = OctopusCard(tag: feliCaTag, data: OctopusCardData(idm: idm, systemCode: systemCode))
        DispatchQueue(label: "TRETJPNROctopusReader", qos: .default).async {
            var services: [FeliCaServiceCode : [Data]] = [:]
            for itemType in self.octopusCardItemTypes {
                services[itemType.serviceCode] = self.readWithoutEncryption(session: session, tag: octopusCard.tag, serviceCode: itemType.serviceCode, blocks: itemType.blocks)
            }
            octopusCard.data.contents[systemCode] = FeliCaSystem(systemCode: systemCode, idm: idm, services: services)
            completion(octopusCard)
        }
    }
}

#endif
