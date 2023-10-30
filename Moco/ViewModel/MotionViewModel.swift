//
//  MotionViewModel.swift
//  Moco
//
//  Created by Daniel Aprillio on 29/10/23.
//

import CoreMotion
import Foundation

class MotionViewModel: ObservableObject {
    @Published var accelerationValue: String = ""
    @Published var gravityValue: String = ""
    @Published var rotationValue: String = ""
    
    @Published var roll = false
    @Published var pitch = false
    @Published var rollNum = 0.0
    @Published var pitchNum = 0.0

    // The instance of CMMotionManager responsible for handling sensor updates
    private let motionManager = CMMotionManager()
    private var timer: Timer!

    // Properties to hold the sensor values
    private var userAcceleration: CMAcceleration = .init()
    private var gravity: CMAcceleration = .init()
    private var rotationRate: CMRotationRate = .init()
    private var attitude: CMAttitude?

    init() {
        // Set the update interval to any time that you want
        motionManager.deviceMotionUpdateInterval = 1.0 / 60.0 // 60 Hz
        motionManager.accelerometerUpdateInterval = 1.0 / 60.0
        motionManager.gyroUpdateInterval = 1.0 / 20.0
        
//        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(MotionViewModel.printUpdate), userInfo: nil, repeats: true)
    }
    
    func startUpdates() {
        accelerationValue = ""
        gravityValue = ""
        rotationValue = ""
        startFetchingSensorData()
    }

    private func startFetchingSensorData() {
        // Check if the motion manager is available and the sensors are available
        if motionManager.isDeviceMotionAvailable && motionManager.isAccelerometerAvailable && motionManager.isGyroAvailable {
            // Start updating the sensor data
            motionManager.startDeviceMotionUpdates(to: .main) { [weak self] motion, error in
                guard let self = self else { return } // Avoid memory leaks
                // Check if there's any error in the sensor update
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
                getMotionAndGravity(motion: motion)
            }
            motionManager.startGyroUpdates(to: .main) { [weak self] gyroData, _ in
                guard let self = self else { return }
                getRotation(gyroData: gyroData)
            }
        }
    }

    private func getMotionAndGravity(motion: CMDeviceMotion?) {
        if let motion = motion {
            // Get user acceleration and gravity data
            userAcceleration = motion.userAcceleration
            gravity = motion.gravity
            attitude = motion.attitude
            // Update publishers with the new sensor data
            accelerationValue = "X: \(userAcceleration.x), \n Y: \(userAcceleration.y), \n Z: \(userAcceleration.z)"
            gravityValue = "X: \(gravity.x), \n Y: \(gravity.y), \n Z: \(gravity.z)"
        }
    }

    private func getRotation(gyroData: CMGyroData?) {
        if let gyroData = gyroData {
            // Get rotation rate data
            rotationRate = gyroData.rotationRate
            // Update publisher with the new sensor data
            rotationValue = "X: \(rotationRate.x), \n Y: \(rotationRate.y), \n Z: \(rotationRate.z)"
        }
    }

    func getRotationRate() -> CMRotationRate {
        rotationRate
    }

    func getAcceleration() -> CMAcceleration {
        userAcceleration
    }

    func getAttitude() -> CMAttitude? {
        attitude
    }

    func updateMotion() {
        rollNum = getAttitude()?.roll ?? 0
        pitchNum = getAttitude()?.pitch ?? 0
        roll = rollNum > 0
        pitch = pitchNum > 0
    }
    
    // Function responsible for stopping the sensor updates
    func stopUpdates() {
        motionManager.stopDeviceMotionUpdates()
        motionManager.stopAccelerometerUpdates()
        motionManager.stopGyroUpdates()
    }
    
    @objc func printUpdate() {
        if let accelerometerData = motionManager.accelerometerData {
            print(accelerometerData)
        }
        if let gyroData = motionManager.gyroData {
            print(gyroData)
        }
        if let magnetometerData = motionManager.magnetometerData {
            print(magnetometerData)
        }
        if let deviceMotion = motionManager.deviceMotion {
            print(deviceMotion)
        }
    }
    
}

