//
//  UIDevice+Extension.swift
//
//
//  Created by Kyle on 2024/4/20.
//

import Darwin
import Foundation
import KYFoundation
import class UIKit.UIDevice

extension UIDevice: KYProtocol {}

extension KYWrapper where Base == UIDevice {
    public var isPad: Bool {
        base.userInterfaceIdiom == .pad
    }
    
    public static var isPad: Bool {
        Base.current.ky.isPad
    }
}

extension KYWrapper where Base == UIDevice {
    /// 获取设备型号名称 eg. iPhone15,1
    public var modelName: String {
        Base.ky.modelName
    }
    
    private static let modelName: String = {
        #if targetEnvironment(simulator)
        ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? ""
        #else
        var sysinfo = utsname()
        uname(&sysinfo)
        guard let model = String(
            bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)),
            encoding: .ascii
        ) else { return "" }
        return model.trimmingCharacters(in: .controlCharacters)
        #endif
    }()
    
    /// 设备类型
    public enum DeviceType {
        /// 非全面屏设备
        case nonFullscreen
        
        /// 刘海屏设备
        case notch
        
        /// 灵动岛设备
        case dynamicIsland
    }
    
    /// 获取当前设备类型
    public var type: DeviceType {
        if isNotchDevice {
            return .notch
        } else if isDynamicIslandDevice {
            return .dynamicIsland
        } else {
            return .nonFullscreen
        }
    }
    
    /// 判断是否是刘海屏设备
    public var isNotchDevice: Bool {
        Base.ky.isNotchDevice
    }
    
    private static var isNotchDevice: Bool { notchDeviceModels.contains(modelName) }
    
    private static let notchDeviceModels: Set<String> = [
        "iPhone10,3", "iPhone10,6", // iPhone X
        "iPhone11,2", "iPhone11,4", "iPhone11,6", "iPhone11,8", // iPhone XS, XS Max, XR
        "iPhone12,1", "iPhone12,3", "iPhone12,5", // iPhone 11, 11 Pro, 11 Pro Max
        "iPhone13,1", "iPhone13,2", "iPhone13,3", "iPhone13,4", // iPhone 12 mini, 12, 12 Pro, 12 Pro Max
        "iPhone14,4", "iPhone14,5", "iPhone14,2", "iPhone14,3", // iPhone 13 mini, 13, 13 Pro, 13 Pro Max
        "iPhone14,6", // iPhone SE (3rd generation)
        "iPhone14,7", "iPhone14,8", // iPhone 14, 14 Plus
    ]

    /// 判断是否是灵动岛设备
    public var isDynamicIslandDevice: Bool {
        Base.ky.isDynamicIslandDevice
    }
    
    private static var isDynamicIslandDevice: Bool { dynamicIslandDeviceModels.contains(modelName) }
    
    private static let dynamicIslandDeviceModels: Set<String> = [
        "iPhone15,2", "iPhone15,3", // iPhone 14 Pro, 14 Pro Max
        "iPhone15,4", "iPhone15,5", // iPhone 15, iPhone 15 Plus
        "iPhone16,1", "iPhone16,2", // iPhone 15 Pro, iPhone 15 Pro Max
    ]
}

#if DEBUG
import SwiftUI

@available(iOS 17, *)
#Preview {
    VStack {
        Text(verbatim: "Device: \(UIDevice.current.ky.modelName)")
        Text(verbatim: "isNotchDevice: \(UIDevice.current.ky.isNotchDevice)")
        Text(verbatim: "isDynamicIslandDevice: \(UIDevice.current.ky.isDynamicIslandDevice)")
    }
}
#endif
