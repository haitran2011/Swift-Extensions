//
//  UIDevice+Ex.swift
//
//  Created by Augus on 3/23/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import UIKit


extension UIDevice {

    func rotateToPortraitIfNeeded() {

        guard UIApplication.shared.statusBarOrientation.isLandscape else { return }

        setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
    }

    func rotateToLandscapeIfNeeded(_ direction: UIInterfaceOrientation = .landscapeRight) {

        guard UIApplication.shared.statusBarOrientation.isPortrait else { return }

        setValue(direction.rawValue, forKey: "orientation")
    }
}

extension UIDevice {

    var isPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }

    var isSimulator: Bool {
        let code = hardwareVersion
        return code == "i386" || code == "x86_64"
    }

    var hardwareVersion: String {
        var systemInfo = utsname()
        uname(&systemInfo)

        let versionCode = String(utf8String: NSString(bytes: &systemInfo.machine, length: Int(_SYS_NAMELEN), encoding: String.Encoding.ascii.rawValue)!.utf8String!)!

        return versionCode
    }
}

// MARK: - Check if device supports blur
// REFERENCE: - http://stackoverflow.com/a/29997626/4656574

extension UIDevice {
    
    var isBlurSupported: Bool {
        var supported = Set<String>()
        supported.insert("iPad")
        supported.insert("iPad1,1")
        supported.insert("iPhone1,1")
        supported.insert("iPhone1,2")
        supported.insert("iPhone2,1")
        supported.insert("iPhone3,1")
        supported.insert("iPhone3,2")
        supported.insert("iPhone3,3")
        supported.insert("iPod1,1")
        supported.insert("iPod2,1")
        supported.insert("iPod2,2")
        supported.insert("iPod3,1")
        supported.insert("iPod4,1")
        supported.insert("iPad2,1")
        supported.insert("iPad2,2")
        supported.insert("iPad2,3")
        supported.insert("iPad2,4")
        supported.insert("iPad3,1")
        supported.insert("iPad3,2")
        supported.insert("iPad3,3")
        
        return !supported.contains(hardwareString)
    }
    
    fileprivate var hardwareString: String {
        var name: [Int32] = [CTL_HW, HW_MACHINE]
        var size: Int = 2
        sysctl(&name, 2, nil, &size, &name, 0)
        var hw_machine = [CChar](repeating: 0, count: Int(size))
        sysctl(&name, 2, &hw_machine, &size, &name, 0)
        
        let hardware: String = String(cString: hw_machine)
        return hardware
    }
}
