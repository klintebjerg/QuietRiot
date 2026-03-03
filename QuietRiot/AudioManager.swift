import CoreAudio
import AppKit

struct AudioApp {
      let id: AudioObjectID
      let pid: pid_t
      let name: String
  }


class AudioManager {
    func getAudioProcessIDs() -> [AudioObjectID] {
        var address = AudioObjectPropertyAddress(
            mSelector: kAudioHardwarePropertyProcessObjectList,
            mScope:    kAudioObjectPropertyScopeGlobal,
            mElement:  kAudioObjectPropertyElementMain
        )
        
        var dataSize: UInt32 = 0
        AudioObjectGetPropertyDataSize(AudioObjectID(kAudioObjectSystemObject), &address, 0, nil, &dataSize)
        
        var objectIDs = [AudioObjectID](repeating: 0, count: Int(dataSize) / MemoryLayout<AudioObjectID>.size)
        
        AudioObjectGetPropertyData(AudioObjectID(kAudioObjectSystemObject), &address, 0, nil, &dataSize, &objectIDs)
        
        return objectIDs
    }
    
    func getRunningAudioApps() -> [AudioApp] {
        var address = AudioObjectPropertyAddress(
            mSelector: kAudioProcessPropertyPID,
            mScope: kAudioObjectPropertyScopeGlobal,
            mElement: kAudioObjectPropertyElementMain
        )
        
        let ids = getAudioProcessIDs()
        var apps: [AudioApp] = []
        for id in ids {
            var pid: pid_t = 0
            var pidSize = UInt32(MemoryLayout<pid_t>.size)
            AudioObjectGetPropertyData(id, &address, 0, nil, &pidSize, &pid)
            let appName = NSRunningApplication(processIdentifier: pid)?.localizedName ?? "Unknown"
            let app = AudioApp(id: id, pid: pid, name: appName)
            apps.append(app)
        }
        return apps
    }
}
