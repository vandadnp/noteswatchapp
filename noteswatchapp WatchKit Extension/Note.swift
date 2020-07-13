import UIKit
import AVFoundation

class Note {
    
    let noteType: NoteType
    
    static func setupAudioSession() {
        let session = AVAudioSession.sharedInstance()
        try? session.setCategory(
            .playback,
            mode: .default,
            policy: .default,
            options: []
        )
    }
    
    private var player: AVAudioPlayer?
    private let data: Data
    
    init?(resName: String, noteType: NoteType) {
        if let data = NSDataAsset(name: resName)?.data {
            self.data = data
            self.noteType = noteType
        } else {
            return nil
        }
    }
    
    func play() {
        stop()
        player = try? AVAudioPlayer(data: data)
        player?.play()
    }
    
    func stop() {
        player?.stop()
    }
    
    static func randomNote() -> Note {
        return allNotes.shuffled().first!
    }
        
}

private let allNotes: [Note] = [
    Note(resName: "clean-A-1", noteType: .a),
    Note(resName: "clean-A-2", noteType: .a),
    Note(resName: "clean-A-3", noteType: .a),
    Note(resName: "clean-A-4", noteType: .a),
    Note(resName: "clean-A-5", noteType: .a),
    Note(resName: "clean-A-6", noteType: .a),
    Note(resName: "clean-A-7", noteType: .a),
    
    Note(resName: "clean-Asharp-1", noteType: .aSharp),
    Note(resName: "clean-Asharp-2", noteType: .aSharp),
    Note(resName: "clean-Asharp-3", noteType: .aSharp),
    Note(resName: "clean-Asharp-4", noteType: .aSharp),
    Note(resName: "clean-Asharp-5", noteType: .aSharp),
    Note(resName: "clean-Asharp-6", noteType: .aSharp),
    Note(resName: "clean-Asharp-7", noteType: .aSharp),
    
    Note(resName: "clean-B-1", noteType: .b),
    Note(resName: "clean-B-2", noteType: .b),
    Note(resName: "clean-B-3", noteType: .b),
    Note(resName: "clean-B-4", noteType: .b),
    Note(resName: "clean-B-5", noteType: .b),
    Note(resName: "clean-B-6", noteType: .b),
    Note(resName: "clean-B-7", noteType: .b),
    
    Note(resName: "clean-C-1", noteType: .c),
    Note(resName: "clean-C-2", noteType: .c),
    Note(resName: "clean-C-3", noteType: .c),
    Note(resName: "clean-C-4", noteType: .c),
    Note(resName: "clean-C-5", noteType: .c),
    Note(resName: "clean-C-6", noteType: .c),
    Note(resName: "clean-C-7", noteType: .c),
    
    Note(resName: "clean-Csharp-1", noteType: .cSharp),
    Note(resName: "clean-Csharp-2", noteType: .cSharp),
    Note(resName: "clean-Csharp-3", noteType: .cSharp),
    Note(resName: "clean-Csharp-4", noteType: .cSharp),
    Note(resName: "clean-Csharp-5", noteType: .cSharp),
    Note(resName: "clean-Csharp-6", noteType: .cSharp),
    Note(resName: "clean-Csharp-7", noteType: .cSharp),
   
    Note(resName: "clean-D-1", noteType: .d),
    Note(resName: "clean-D-2", noteType: .d),
    Note(resName: "clean-D-3", noteType: .d),
    Note(resName: "clean-D-4", noteType: .d),
    Note(resName: "clean-D-5", noteType: .d),
    Note(resName: "clean-D-6", noteType: .d),
    Note(resName: "clean-D-7", noteType: .d),
    
    Note(resName: "clean-Dsharp-1", noteType: .dSharp),
    Note(resName: "clean-Dsharp-2", noteType: .dSharp),
    Note(resName: "clean-Dsharp-3", noteType: .dSharp),
    Note(resName: "clean-Dsharp-4", noteType: .dSharp),
    Note(resName: "clean-Dsharp-5", noteType: .dSharp),
    Note(resName: "clean-Dsharp-6", noteType: .dSharp),
    Note(resName: "clean-Dsharp-7", noteType: .dSharp),
    
    Note(resName: "clean-E-1", noteType: .e),
    Note(resName: "clean-E-2", noteType: .e),
    Note(resName: "clean-E-3", noteType: .e),
    Note(resName: "clean-E-4", noteType: .e),
    Note(resName: "clean-E-5", noteType: .e),
    Note(resName: "clean-E-6", noteType: .e),
    Note(resName: "clean-E-7", noteType: .e),
    
    Note(resName: "clean-F-1", noteType: .f),
    Note(resName: "clean-F-2", noteType: .f),
    Note(resName: "clean-F-3", noteType: .f),
    Note(resName: "clean-F-4", noteType: .f),
    Note(resName: "clean-F-5", noteType: .f),
    Note(resName: "clean-F-6", noteType: .f),
    Note(resName: "clean-F-7", noteType: .f),
    
    Note(resName: "clean-Fsharp-1", noteType: .fSharp),
    Note(resName: "clean-Fsharp-2", noteType: .fSharp),
    Note(resName: "clean-Fsharp-3", noteType: .fSharp),
    Note(resName: "clean-Fsharp-4", noteType: .fSharp),
    Note(resName: "clean-Fsharp-5", noteType: .fSharp),
    Note(resName: "clean-Fsharp-6", noteType: .fSharp),
    Note(resName: "clean-Fsharp-7", noteType: .fSharp),
    
    Note(resName: "clean-G-1", noteType: .g),
    Note(resName: "clean-G-2", noteType: .g),
    Note(resName: "clean-G-3", noteType: .g),
    Note(resName: "clean-G-4", noteType: .g),
    Note(resName: "clean-G-5", noteType: .g),
    Note(resName: "clean-G-6", noteType: .g),
    Note(resName: "clean-G-7", noteType: .g),
    
    Note(resName: "clean-Gsharp-1", noteType: .gSharp),
    Note(resName: "clean-Gsharp-2", noteType: .gSharp),
    Note(resName: "clean-Gsharp-3", noteType: .gSharp),
    Note(resName: "clean-Gsharp-4", noteType: .gSharp),
    Note(resName: "clean-Gsharp-5", noteType: .gSharp),
    Note(resName: "clean-Gsharp-6", noteType: .gSharp),
    Note(resName: "clean-Gsharp-7", noteType: .gSharp),
    ].compactMap { $0 }


extension Note {
    enum NoteType: CaseIterable {
        case a, aSharp
        case b
        case c, cSharp
        case d, dSharp
        case e
        case f, fSharp
        case g, gSharp
        
        var name: String {
            switch self {
            case .a: return "A"
            case .aSharp: return "A#"
            case .b: return "B"
            case .c: return "C"
            case .cSharp: return "C#"
            case .d: return "D"
            case .dSharp: return "D#"
            case .e: return "E"
            case .f: return "F"
            case .fSharp: return "F#"
            case .g: return "G"
            case .gSharp: return "G#"
            }
        }
        
        func noteTypesExcludingThis(count: Int) -> [NoteType] {
            .init(
                NoteType.allCases
                    .filter { $0 != self }
                    .shuffled()
                    .prefix(upTo: count)
            )
        }
        
    }
}
