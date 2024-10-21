# SwiftUI Sheet Coordinator

This POC takes the concept of a Sheet Coordinator from [SwiftLee](https://www.avanderlee.com/swiftui/presenting-sheets/) and extends it to consider different sheet styles (sheets and fullCovers) and priorities.

Sheets can be added to the queue with a priority. The coordinator will present the sheet with the highest priority. 
If a sheet is added to the queue, it will re-sort itself to ensure the highest-priority sheet is presented next.

To simplify the logic of how/when to call the view modifiers, a transparent FullScreenCover is presented without animation if a Sheet is presented and no FullScreenCover is available.

```
View
|
|-- FullScreenCover
|   |
|   |-- Sheet
```

## Demo
![Simulator Screen Recording - iPhone 15 Pro - 2024-07-02 at 10 26 39](https://github.com/gmoraleda/SwiftUI-Sheet-Coordinator/assets/25835012/4c80d7bc-1ff5-4742-8244-7c495b175da8)
