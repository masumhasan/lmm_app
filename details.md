# Project Technical Details

This document lists the SDKs, packages, and 3rd party components used in the **lmm_app** project.

## Core SDKs
- **Flutter SDK**: Used for building the cross-platform application.
- **Dart SDK**: version `^3.10.4`



## Dependencies (Packages)

| Package | Version | Description |
|---------|---------|-------------|
| **flutter_riverpod** | `^2.5.1` | Reactive state management and dependency injection. |
| **go_router** | `^12.0.0` | Declarative routing system for multi-page navigation. |
| **google_fonts** | `^6.1.0` | Provides access to a wide variety of high-quality typography. |
| **animate_do** | `^3.3.4` | Used for implementing UI animations (FadeIn, FadeInUp, etc.). |
| **lucide_icons** | `^0.257.0` | Modern and consistent icon set for the UI. |
| **flutter_svg** | `^2.0.9` | Support for rendering SVG files and assets. |
| **intl** | `^0.18.1` | Used for date/time formatting and internationalization. |
| **cupertino_icons** | `^1.0.8` | Default iOS-style icons. |

## Development Dependencies

| Package | Version | Description |
|---------|---------|-------------|
| **flutter_test** | SDK | Framework for unit and widget testing. |
| **flutter_lints** | `^6.0.0` | Set of recommended lint rules for healthy code. |

## Key Components & Architecture
- **State Management**: Provider/Riverpod pattern.
- **Navigation**: Shell routing with persistence for bottom navigation.
- **UI Design**: "Expensive Minimal" design system with customized typography and animations.
- **Assets**: 
  - Official brand logos stored in `assets/images/logo/`.
  - Custom visualization backgrounds (e.g., `iceburg-ui-x.png`).
