# Risk Clarity ⚖️

## The Pain Point
In an era of information overload, health-conscious individuals are constantly bombarded with conflicting data about toxins, pollution, microplastics, and lifestyle habits. Most existing apps provide vague advice ("This is bad for you") without context.

Users don't just want to know if something is bad; they want **comparative clarity**. They want to know: *"How bad is sitting all day compared to living in a city with air pollution?"*

## Design Philosophy: Minimalism & Focus
Risk Clarity is designed with a "Single Feature" focus. 
- **No distractions**: No login, no social feed, no ads.
- **Side-by-side comparison**: The UI is split into two halves, allowing users to select a "Base" risk and a "Comparison" risk.
- **Immediate Value**: The "Verdict" panel at the bottom provides a clear, quantitative comparison (e.g., "X has a 20% higher impact than Y").
- **Material 3**: Utilizes a sophisticated "Indigo/Midnight" color palette to evoke a sense of research-backed calm and clarity.

## Implementation Details
- **Clean Code**: Zero warnings in `flutter analyze`.
- **Modern APIs**: Uses `.withValues(alpha: ...)` instead of deprecated `.withOpacity()`.
- **Responsive**: Adapts gracefully to various screen sizes using Flutter's `Expanded` and `Row` widgets.

## Technical Requirements
- Flutter SDK
- Path: `/{flutter-sdk-path}/flutter/bin/flutter`
- Analyze: `flutter analyze`
