//
//  NFCReader+NDEFMessage.swift
//  Core
//
//  Created by treastrain on 2022/09/24.
//

import Foundation
#if canImport(CoreNFC)
import CoreNFC
#endif

extension NFCReader where TagType == NDEFMessage {
    #if canImport(CoreNFC)
    public func read(
        invalidateAfterFirstRead: Bool,
        detectingAlertMessage: String,
        didBecomeActive: @Sendable @escaping (_ session: TagType.ReaderSessionAlertMessageable) -> Void = { _ in },
        didInvalidate: @Sendable @escaping (NFCReaderError) -> Void = { _ in },
        didDetectNDEFs: @Sendable @escaping (_ session: TagType.ReaderSessionProtocol, _ messages: TagType.ReaderSessionDetectObject) -> TagType.DetectResult
    ) throws {
        let delegate = NFCNDEFMessageReaderSessionCallbackHandleObject(
            didBecomeActive: didBecomeActive,
            didInvalidate: didInvalidate,
            didDetectNDEFs: didDetectNDEFs
        )
        try read(
            // TODO: support the `queue`
            sessionAndDelegate: { (.init(delegate: delegate, queue: nil, invalidateAfterFirstRead: invalidateAfterFirstRead), delegate) },
            detectingAlertMessage: detectingAlertMessage
        )
    }
    #endif
}
