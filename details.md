# Project Technical Details

**Last Updated**: 2026-05-21

This document lists the SDKs, packages, and 3rd party components used in the **lmm_app** project.

## Core SDKs
- **Flutter SDK**: Used for building the cross-platform application.
- **Dart SDK**: version `^3.10.4`
- **App Version**: `1.0.0+1`

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
| **just_audio** | `^0.9.43` | Audio playback for ambient sounds and voiceovers. |
| **lottie** | `^3.3.1` | Renders Lottie animations from JSON files. |
| **dotlottie_loader** | `^0.0.4` | Loads and renders DotLottie (.lottie) animation files. |

## Development Dependencies

| Package | Version | Description |
|---------|---------|-------------|
| **flutter_test** | SDK | Framework for unit and widget testing. |
| **flutter_lints** | `^6.0.0` | Set of recommended lint rules for healthy code. |

## Key Components & Architecture
- **State Management**: Provider/Riverpod pattern.
- **Navigation**: Shell routing with persistence for bottom navigation (via `go_router`).
- **UI Design**: "Expensive Minimal" design system with customized typography and animations.
- **Onboarding/Auth**: Currently features a simplified flow with a mocked "AUTH SCREEN" for rapid iteration.

## Features (In Progress/Implemented)
- **Auth & Onboarding**: Multi-step educational onboarding flow.
- **Dashboard**: Central hub for user activity and progress.
- **Muscle Dashboard**: Visualization of cognitive training progress.
- **Workouts**: Structured cognitive training sessions.
- **Library**: Repository of training materials and drills.
- **Drift**: Pattern exposure through media integrations.
- **Return to Now**: Quick mental reset tools.
- **AI Coach**: Integrated assistive training guidance.
- **Tools Hub**: Centralized access to various training utilities.
- **Profile**: User settings and personal data management.

## Assets

### Images
- `assets/images/` — General image assets.
- `assets/images/logo/` — Official brand logos.

### Audio
- `assets/audios/ambient/` — Ambient background sounds.
- `assets/audios/voiceovers/` — General voiceover files.
- `assets/audios/voiceovers/workout1/` — Voiceovers specific to Workout 1.

### Animations
- `assets/lotties/` — Lottie and DotLottie animation files.

## Custom Fonts

| Family | Weights / Styles |
|--------|-----------------|
| **CormorantGaramond** | Regular, Italic |
| **Inter** | Regular, Medium (500), SemiBold (600) |
| **JetBrainsMono** | Regular, Medium (500), Bold (700) |
