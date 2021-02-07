#!/usr/bin/env swift

// Compile with:
// swiftc notify.swift -o notify
// Most credit goes to https://github.com/mnewt/dotemacs/blob/master/bin/dark-mode-notifier.swift
// Source: https://gist.github.com/bouk/5046a9e9cf2424091070b14b8f3333ea

// Usage: ./notify.swift fish -c change_background
// TODO: add launchd script
import Cocoa

@discardableResult
func shell(_ args: [String]) -> Int32 {
    let task = Process()
    let isDark = UserDefaults.standard.string(forKey: "AppleInterfaceStyle") == "Dark"
    var env = ProcessInfo.processInfo.environment
    env["DARKMODE"] = isDark ? "1" : "0"
    task.environment = env
    task.launchPath = "/usr/bin/env"
    task.arguments = args
    task.standardError = FileHandle.standardError
    task.standardOutput = FileHandle.standardOutput
    task.launch()
    task.waitUntilExit()
    return task.terminationStatus
}

let args = Array(CommandLine.arguments.suffix(from: 1))
shell(args)

DistributedNotificationCenter.default.addObserver(
    forName: Notification.Name("AppleInterfaceThemeChangedNotification"),
    object: nil,
    queue: nil) { (notification) in
        shell(args)
}

NSApplication.shared.run()
