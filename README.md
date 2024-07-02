# SwiftUI Sheet Coordinator

This POC takes the concept of a SheetCoordinator from [SwiftLee](https://www.avanderlee.com/swiftui/presenting-sheets/) and extends it to consider different sheet styles (sheets and fullCovers) as well as priorities.

Sheets can be added to the queue with a priority. The coordinator will present the sheet with the highest priority. If a sheet is added to the queue, the queue will re-sort itself to ensure the highest priority sheet is presented next.

## Demo
![Simulator Screen Recording - iPhone 15 Pro - 2024-07-02 at 10 26 39](https://github.com/gmoraleda/SwiftUI-Sheet-Coordinator/assets/25835012/4c80d7bc-1ff5-4742-8244-7c495b175da8)
