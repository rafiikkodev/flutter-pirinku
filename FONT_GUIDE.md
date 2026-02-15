# Panduan Penggunaan Font Visby

## Font Families
Project ini menggunakan 2 font family:
1. **Visby CF** - Font standar dengan sudut tajam
2. **Visby Round CF** - Font dengan sudut membulat (digunakan sebagai font utama)

## Font Weights yang Tersedia

### Visby CF
- Thin (100) - `FontWeight.w100` atau `thin`
- Light (300) - `FontWeight.w300` atau `light`
- Regular (400) - `FontWeight.w400` atau `regular`
- Medium (500) - `FontWeight.w500` atau `medium`
- DemiBold (600) - `FontWeight.w600` atau `semiBold`
- Bold (700) - `FontWeight.w700` atau `bold`
- ExtraBold (800) - `FontWeight.w800` atau `extraBold`
- Heavy (900) - `FontWeight.w900` atau `black`

### Visby Round CF
- ExtraLight (200) - `FontWeight.w200` atau `extraLight`
- Light (300) - `FontWeight.w300` atau `light`
- Regular (400) - `FontWeight.w400` atau `regular`
- Medium (500) - `FontWeight.w500` atau `medium`
- DemiBold (600) - `FontWeight.w600` atau `semiBold`
- Bold (700) - `FontWeight.w700` atau `bold`
- ExtraBold (800) - `FontWeight.w800` atau `extraBold`
- Heavy (900) - `FontWeight.w900` atau `black`

## Cara Penggunaan

### 1. Menggunakan Font Family Constant
```dart
import 'package:flutter_pirinku/app/core/theme/app_theme.dart';

Text(
  'Hello World',
  style: TextStyle(
    fontFamily: visbyRoundCF,  // atau visbyCF
    fontSize: 16,
    fontWeight: medium,
  ),
)
```

### 2. Menggunakan Predefined TextStyle
```dart
import 'package:flutter_pirinku/app/core/theme/app_theme.dart';

// Text dengan warna primary (default hitam)
Text(
  'Hello World',
  style: primaryTextStyle.copyWith(
    fontSize: 16,
    fontWeight: semiBold,
  ),
)

// Text dengan warna secondary (abu-abu)
Text(
  'Hello World',
  style: secondaryTextStyle.copyWith(
    fontSize: 14,
    fontWeight: medium,
  ),
)

// Text dengan warna putih
Text(
  'Hello World',
  style: whiteTextStyle.copyWith(
    fontSize: 16,
    fontWeight: bold,
  ),
)
```

### 3. Menggunakan Font Langsung
```dart
Text(
  'Hello World',
  style: TextStyle(
    fontFamily: 'Visby Round CF',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: txtPrimary,
  ),
)
```

## Font Weight Variables yang Tersedia di app_theme.dart
- `thin` - FontWeight.w100
- `extraLight` - FontWeight.w200
- `light` - FontWeight.w300
- `regular` - FontWeight.w400
- `medium` - FontWeight.w500
- `semiBold` - FontWeight.w600
- `bold` - FontWeight.w700
- `extraBold` - FontWeight.w800
- `black` - FontWeight.w900

## Contoh Kombinasi

### Heading
```dart
Text(
  'Heading Utama',
  style: TextStyle(
    fontFamily: visbyRoundCF,
    fontSize: 24,
    fontWeight: bold,
    color: txtPrimary,
  ),
)
```

### Body Text
```dart
Text(
  'Ini adalah body text',
  style: TextStyle(
    fontFamily: visbyRoundCF,
    fontSize: 14,
    fontWeight: regular,
    color: txtPrimary,
  ),
)
```

### Caption
```dart
Text(
  'Caption atau keterangan',
  style: TextStyle(
    fontFamily: visbyRoundCF,
    fontSize: 12,
    fontWeight: light,
    color: txtSecondary,
  ),
)
```

## Notes
- Font default yang digunakan di app adalah **Visby Round CF**
- Semua font sudah dikonfigurasi di `pubspec.yaml` dengan weight yang lengkap
- Import `app_theme.dart` untuk menggunakan font constants dan predefined styles
