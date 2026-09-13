# Hui Management (Quản lí hụi)

A cross-platform Flutter app for organisers of Vietnamese *hụi* savings groups. It manages members, funds, payout sessions, daily bills and printable reports.

![Flutter](https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?logo=dart&logoColor=white)
![Firebase Hosting](https://img.shields.io/badge/Firebase_Hosting-FFCA28?logo=firebase&logoColor=black)

## Overview

**Hụi** (also called *họ* or *phường*) is a Vietnamese rotating savings and credit association (ROSCA). A group of members pays into a shared pot every period. In each round, one member "takes" the pot, usually by bidding how much they will give up. Members who have already taken the pot keep paying the full share until the cycle ends. The organiser (*chủ hụi*) collects the money, pays it out and keeps the books, and doing this in notebooks gets error-prone quickly.

This app is the organiser's dashboard. It talks to a REST API ([hui_management_backend](https://github.com/khangzxrr/hui_management_backend)) and replaces the paper ledger. It records who belongs to which fund and who has taken each session. It also works out what every member owes or is owed each day, and exports the paperwork as PDFs. The UI is in Vietnamese.

## Features

- **Authentication**: phone number + password login. The returned JWT is attached to every API request by an authorised HTTP client, and routes are protected by an `AuthGuard`.
- **Member management**: create, edit and delete members with a photo, identity details, bank account, address and nickname. Photos are uploaded to the backend's media endpoint.
- **Fund (dây hụi) management**
  - Create day- or month-based funds with the share price, service fee, open date and session schedule.
  - Add or remove members, archive funds and view the generated session dates.
- **Sessions (kỳ hụi)**
  - Open a normal session by choosing the member who takes the pot and entering their bid.
  - Create **emergency sessions** for several members at once.
  - Record a **final settlement** for a member who has already taken the pot.
  - Browse session details and delete sessions.
- **Payments & bills**
  - Per-member daily payments with fund bills and custom bills (e.g. outside debts).
  - Record cash or bank-transfer transactions.
  - Amounts are also shown in Vietnamese words.
- **Reports**
  - A member report grid with totals paid, debt, alive/dead fund amounts, total taken and net balance, with filters and infinite scroll.
  - A fund report ("giấy hụi") in an editable grid.
- **PDF export**: generate and preview the fund report and the session hand-over slip ("giấy giao hụi"), then print them or save them as images.
- **Responsive layout** with a small-screen breakpoint. It runs on Android, iOS, web and desktop.

## Tech stack

| Area | Libraries |
| --- | --- |
| Framework | Flutter, Dart (SDK `>=2.19.6`) |
| State & DI | `provider`, `get_it` |
| Routing | `auto_route` (code-generated, with guards) |
| Networking & models | `http`, `json_serializable` / `json_annotation`, `fpdart` (`TaskEither` error handling) |
| Forms | `flutter_form_builder`, `form_builder_validators`, `form_builder_image_picker`, `currency_text_input_formatter` |
| Data grids | `pluto_grid`, `syncfusion_flutter_datagrid`, `infinite_scroll_pagination` |
| Documents | `pdf`, `printing`, `image_gallery_saver`, `image_downloader_web` |
| Tooling | `build_runner`, `flutter_launcher_icons`, Firebase Hosting (web), fastlane (iOS TestFlight lane) |

## Project structure

```
lib/
├── main.dart                 # MultiProvider setup + MaterialApp.router
├── routes/                   # auto_route config and AuthGuard
├── service/                  # API clients: login, user, fund, payment, image, download, notification
├── provider/                 # ChangeNotifier state (auth, members, funds, payments, reports)
├── model/                    # JSON-serializable DTOs (*.g.dart generated)
├── view/
│   ├── fund/                 # fund list/detail/edit, members, reports, PDF export
│   ├── fund_session/         # create normal/emergency sessions, session detail, PDF slip
│   ├── member/               # member list, edit, report grid
│   └── payments/             # payment list, paycheck, custom bills
├── view_models/, filters/, grid_datasource/, pluto_grid_extentions/  # grid & filter helpers
└── helper/                   # constants, authorized HTTP client, dialogs, formatting
import_user_from_excel.py     # one-off script to bulk-import members from a spreadsheet via the API
```

## Getting started

### Prerequisites

- Flutter SDK (Dart `>=2.19.6`)
- A running instance of [hui_management_backend](https://github.com/khangzxrr/hui_management_backend)

### Setup

```bash
git clone https://github.com/khangzxrr/hui_management_flutter.git
cd hui_management_flutter
flutter pub get

# generate JSON serializers and routes
flutter pub run build_runner build --delete-conflicting-outputs
```

Point the app at your API by editing `apiHostName` in `lib/helper/constants.dart`. Commented-out alternatives for `localhost` and the Android emulator (`10.0.2.2`) are already in that file.

### Run

```bash
flutter run            # pick a device
flutter run -d chrome  # web
```

When you change models or routes during development, keep the code generator running:

```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

### Deploy (web)

The web build is set up for Firebase Hosting (`firebase.json`):

```bash
firebase experiments:enable webframeworks
firebase deploy --only hosting
```

## Related projects

- [hui_management_backend](https://github.com/khangzxrr/hui_management_backend): the ASP.NET Core API this app consumes.

## Contributors

- [@khangzxrr](https://github.com/khangzxrr) (Vo Ngoc Khang)
- [@Datnqse62453](https://github.com/Datnqse62453)
