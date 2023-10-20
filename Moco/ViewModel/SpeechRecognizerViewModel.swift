//
//  SpeechRecognizerViewModel.swift
//  Moco
//
//  Created by Daniel Aprillio on 17/10/23.
//

import AVFoundation
import Foundation
import Speech

class SpeechRecognizerViewModel: ObservableObject {
    static let shared = SpeechRecognizerViewModel()

    @Published var error: RecognizerError?
    @Published var transcript: String = ""
    @Published var possibleTranscripts = [String]()

    private var audioEngine: AVAudioEngine?
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var task: SFSpeechRecognitionTask?
    private let recognizer: SFSpeechRecognizer?
    private let synthesizer = AVSpeechSynthesizer()

    private init() {
        recognizer = SFSpeechRecognizer(locale: Locale(identifier: "id"))

        Task(priority: .background) {
            do {
                guard recognizer != nil else {
                    throw RecognizerError.nilRecognizer
                }
                guard await SFSpeechRecognizer.hasAuthorizationToRecognize() else {
                    throw RecognizerError.notAuthorizedToRecognize
                }
                guard await AVAudioSession.sharedInstance().hasPermissionToRecord() else {
                    throw RecognizerError.notPermittedToRecord
                }
            } catch {
                speakError(error)
            }
        }
    }

    deinit {
        reset()
    }

    private func reset() {
        task?.cancel()
        audioEngine?.stop()
        audioEngine = nil
        request = nil
        task = nil
    }

    // For Text-To-Speech
    func textToSpeech(text: String) {
        #if !targetEnvironment(simulator)
            let utterance = AVSpeechUtterance(string: text)

            do {
                let audioSession = AVAudioSession.sharedInstance()
                try audioSession.setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
            } catch {
                print("Error speakText: \(text)")
            }

            utterance.voice = AVSpeechSynthesisVoice(language: "id-ID")
            utterance.rate = 0.35
            utterance.volume = 1.0
            synthesizer.stopSpeaking(at: .immediate)
            synthesizer.speak(utterance)
        #endif
    }

    func stopSpeaking(_ boundary: AVSpeechBoundary? = .immediate) {
        synthesizer.stopSpeaking(at: boundary ?? .immediate)
    }

    // For Speech-To-Text
    private func inputTranscript(_ message: String) {
        transcript = message
    }

    private func inputPossibleTranscripts(_ messages: [String]) {
        possibleTranscripts = messages
    }

    func resetTranscript() {
        transcript = ""
        possibleTranscripts = []
    }

    func transcribe() {
        print("Start Transcribe")
        resetTranscript()
        DispatchQueue(label: "com.mc2.mini2", qos: .background).async { [weak self] in
            guard let self = self, let recognizer = self.recognizer, recognizer.isAvailable else {
                self?.speakError(RecognizerError.recognizerIsUnavailable)
                return
            }

            do {
                let (audioEngine, request) = try Self.prepareEngine()
                self.audioEngine = audioEngine
                self.request = request

                self.task = recognizer.recognitionTask(with: request) { result, error in
                    let receivedFinalResult = result?.isFinal ?? false
                    let receivedError = error != nil // != nil mean there's error (true)

                    if receivedFinalResult || receivedError {
                        audioEngine.stop()
                        audioEngine.inputNode.removeTap(onBus: 0)
                    }

                    if let result = result {
                        self.inputTranscript(result.bestTranscription.formattedString.trimmingCharacters(in: .whitespacesAndNewlines))
                        self.inputPossibleTranscripts(result.transcriptions.map { $0.formattedString.trimmingCharacters(in: .whitespacesAndNewlines) })
                    }
                }
            } catch {
                self.reset()
                self.speakError(error)
            }
        }
    }

    private static func prepareEngine() throws -> (AVAudioEngine, SFSpeechAudioBufferRecognitionRequest) {
        let audioEngine = AVAudioEngine()

        let request = SFSpeechAudioBufferRecognitionRequest()
        request.shouldReportPartialResults = true

        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        let inputNode = audioEngine.inputNode

        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) {
            (buffer: AVAudioPCMBuffer, _: AVAudioTime) in
            request.append(buffer)
        }
        audioEngine.prepare()
        try audioEngine.start()

        return (audioEngine, request)
    }

    func stopTranscribing() {
        print("Stop Transcribe")
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
        } catch {
            print("Tidak jalan")
        }

        reset()
    }

    private func speakError(_ error: Error) {
        var errorMessage = ""
        if let error = error as? RecognizerError {
            errorMessage += error.errorDescription!
        } else {
            errorMessage += error.localizedDescription
        }
        transcript = "<< \(errorMessage) >>"
    }
}
