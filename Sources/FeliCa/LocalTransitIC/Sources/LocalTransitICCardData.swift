//
//  LocalTransitICCardData.swift
//  DriversLicenseReader
//
//  Created by treastrain on 2019/11/21.
//  Copyright © 2019 treastrain / Tanaka Ryoga. All rights reserved.
//

import Foundation
#if canImport(TRETJapanNFCReader_FeliCa)
import TRETJapanNFCReader_FeliCa
#endif

/// 地方の交通系ICカードのデータ
public struct LocalTransitICCardData: FeliCaCardData {
    public var version: String = "3"
    public var type: FeliCaCardType = .localTransitIC
    public let primaryIDm: String
    public let primarySystemCode: FeliCaSystemCode
    public var contents: [FeliCaSystemCode : FeliCaSystem] = [:] {
        didSet {
            self.convert()
        }
    }
    
    public var balance: Int?
    public var transactions: [LocalTransitICCardTransaction]? {
        didSet {
            self.balance = transactions?.first?.balance
        }
    }
    
    public init(idm: String, systemCode: FeliCaSystemCode) {
        self.primaryIDm = idm
        self.primarySystemCode = systemCode
    }
    
    public init(idm: String, systemCode: FeliCaSystemCode, data: FeliCaData) {
        self.primaryIDm = idm
        self.primarySystemCode = systemCode
        self.contents = data
        self.convert()
    }
    
    public mutating func convert() {
        for (systemCode, system) in self.contents {
            switch systemCode {
            case self.primarySystemCode:
                let services = system.services
                for (serviceCode, blockData) in services {
                    let blockData = blockData.blockData
                    switch LocalTransitICCardItemType(serviceCode) {
                    case .transactions:
                        self.transactions = convertToTransactions(blockData)
                    case .none:
                        break
                    }
                }
            default:
                break
            }
        }
    }
    
    private mutating func convertToTransactions(_ blockData: [Data]) -> [LocalTransitICCardTransaction] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/M/d H:m"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        var transactions: [LocalTransitICCardTransaction] = []
        
        for data in blockData {
            let (boardingDateString, alightingDateString) = self.dateString(from: data[0], data[1], data[2], data[3], data[4])
            guard let departDate = formatter.date(from: boardingDateString), let arriveDate = formatter.date(from: alightingDateString) else {
                continue
            }
            
            let departStation = Data([data[5], data[6]])
            let arriveStation = Data([data[7], data[8]])
            let transactionType = self.transactionType(from: data[9])
            let difference = (Int(data[10]) << 8) + Int(data[11])
            let balance = (Int(data[14]) << 8) + Int(data[15])
            
            let transaction = LocalTransitICCardTransaction(date: arriveDate, type: transactionType, difference: difference, balance: balance, departDate: departDate, arriveDate: arriveDate, departStation: departStation, arriveStation: arriveStation)
            transactions.append(transaction)
        }
        
        return transactions
    }
    
    
    private func dateString(from data0: UInt8, _ data1: UInt8, _ data2: UInt8, _ data3: UInt8, _ data4: UInt8) -> (String, String) {
        let year = Int(data0 >> 1) + 2000
        let month = ((data0 & 0x1) << 3) + (data1 >> 5)
        let day = data1 & 0x1F
        let boardingHour = (data2 >> 2) & 0x1F
        let boardingMinute = ((data2 & 0x3) << 4) + (data3 >> 4)
        let alightingHour = ((data3 & 0x7) << 2) + (data4 >> 6)
        let alightingMinute = data4 & 0x3F
        
        
        let boardingDateString = "\(year)/\(month)/\(day) \(boardingHour):\(boardingMinute)"
        let alightingDateString = "\(year)/\(month)/\(day) \(alightingHour):\(alightingMinute)"
        
        return (boardingDateString, alightingDateString)
    }
    
    private func transactionType(from data9: UInt8) -> FeliCaCardTransactionType {
        switch data9 {
        case 0x52:
            return .transit
        case 0x55:
            return .credit
        default:
            return .unknown
        }
    }
}

/// 地方の交通系ICカードの利用履歴
public struct LocalTransitICCardTransaction: FeliCaCardTransaction {
    public let date: Date
    public let type: FeliCaCardTransactionType
    public let difference: Int
    public let balance: Int
    
    public let departDate: Date
    public let arriveDate: Date
    public let departStation: Data
    public let arriveStation: Data
}

@available(*, unavailable, renamed: "LocalTransitICCardData")
public typealias RyutoCardData = LocalTransitICCardData
@available(*, unavailable, renamed: "LocalTransitICCardTransaction")
public typealias RyutoCardTransaction = LocalTransitICCardTransaction
