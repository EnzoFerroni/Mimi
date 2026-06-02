<div align="center">

<img src="MimiDreams/Assets.xcassets/Mimi.imageset/mimi.parado.svg" width="160" alt="Mimi mascot"/>

# MimiDreams

### Your cozy dream journal, guarded by a sleepy little companion. 🌙

Write down your dreams, watch them bloom on a calendar, and feed **Mimi** —
your pixel companion who happily munches a cookie every time you log a new dream.

<br/>

[![Platform](https://img.shields.io/badge/platform-iOS%2018.5+-000000?style=flat-square&logo=apple)](https://www.apple.com/ios/)
[![Swift](https://img.shields.io/badge/Swift-5.0-FA7343?style=flat-square&logo=swift&logoColor=white)](https://swift.org)
[![SwiftUI](https://img.shields.io/badge/SwiftUI-0080FF?style=flat-square&logo=swift&logoColor=white)](https://developer.apple.com/xcode/swiftui/)
[![Core Data](https://img.shields.io/badge/Core%20Data-1575F9?style=flat-square&logo=apple&logoColor=white)](https://developer.apple.com/documentation/coredata)
[![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)](LICENSE)

<br/>

<a href="https://apps.apple.com/br/app/mimi-dreams/id6747144355">
  <img src="https://developer.apple.com/app-store/marketing/guidelines/images/badge-download-on-the-app-store.svg" height="56" alt="Download on the App Store"/>
</a>

</div>

---

## ✨ About

**MimiDreams** is a SwiftUI iOS app that turns dream journaling into a small daily
ritual. Every dream you record is stored locally with **Core Data**, categorized,
and visualized — so over time you can actually *see* the shape of your sleep.

And because journaling should feel rewarding, every entry feeds **Mimi**: a
frame-by-frame animated mascot that nibbles a cookie as a little thank-you. 🍪

---

## 🚀 Features

| | |
|---|---|
| 🍪 **Animated mascot** | Mimi reacts to your activity with a 42-frame hand-drawn eating animation. |
| 📝 **Dream journaling** | Capture a title, the full dream text, and a mood/type for every entry. |
| 🗂️ **Dream types** | Tag each dream as `Comfort 😃`, `Nightmare 🙁`, `Lucid 😐` or `Symbolic 💭`. |
| 📅 **Calendar view** | Browse your nights on an interactive calendar and revisit past dreams. |
| 📊 **Insights chart** | An interactive pie chart breaks down your dreams by category. |
| 💾 **Offline-first** | 100% local persistence with Core Data — no account, no cloud, fully private. |

---

## 📱 Screenshots

> _Adicione as capturas em `docs/screenshots/` e elas aparecem aqui._

| Mimi | Calendar | Add Dream | Insights |
|:---:|:---:|:---:|:---:|
| <img src="docs/screenshots/mimi.png" width="180"/> | <img src="docs/screenshots/calendar.png" width="180"/> | <img src="docs/screenshots/add.png" width="180"/> | <img src="docs/screenshots/chart.png" width="180"/> |

---

## 🛠️ Tech Stack

- **Language:** Swift 5
- **UI:** SwiftUI + [Swift Charts](https://developer.apple.com/documentation/charts)
- **Persistence:** Core Data
- **Minimum target:** iOS 18.5
- **Architecture:** MVVM-ish — declarative views over a Core Data store, with a
  shared `PersistenceController` singleton.

---

## 📂 Project Structure

```
MimiDreams/
├── MimiDreamsApp.swift        # App entry point, injects the Core Data context
├── ContentView.swift          # Root TabView (Mimi · Dreams)
├── MimiView.swift             # Animated mascot + cookie animation logic
├── CalendarView.swift         # Calendar + horizontal list of dreams
├── AddDreamView.swift         # Create / edit a dream entry
├── DreamCardView.swift        # Reusable dream summary card
├── ChartView.swift            # Interactive pie chart of dream categories
├── Persistence.swift          # Core Data stack (PersistenceController)
├── CoreDataExtentions.swift   # Safe-save helpers for NSManagedObjectContext
├── Assets.xcassets            # Mascot frames, icons, color palette
└── MimiDreams.xcdatamodeld    # Core Data model (Item: title, dreamText, type, timestamp)
```

---

## 🧑‍💻 Getting Started

**Requirements:** macOS with Xcode 16+ and an iOS 18.5 simulator or device.

```bash
git clone https://github.com/EnzoFerroni/MIMI.git
cd MIMI
open MimiDreams.xcodeproj
```

Then hit **⌘R** in Xcode to build and run. No external dependencies — it just works.

---

## 👥 Team

Built with care by:

- **Enzo Ferroni** — [@EnzoFerroni](https://github.com/EnzoFerroni)
- **Lucca Pivoto**
- **Alana Abdias**

---

## 📄 License

Released under the [MIT License](LICENSE). © 2025 Enzo Ferroni, Lucca Pivoto and Alana Abdias.

<div align="center">
<br/>
<sub>Made with 💤 and a lot of cookies.</sub>
</div>
