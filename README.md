# Form Validate App

แอปพลิเคชัน Flutter สำหรับการจัดการระบบ Authentication ที่มีฟีเจอร์การเข้าสู่ระบบ, สมัครสมาชิก, และรีเซ็ตรหัสผ่าน พร้อมการเชื่อมต่อ API และการจัดเก็บข้อมูลใน Local Storage

## API ที่เรียกใช้

- https://github.com/Apisit250aps/transactions

## 📱 ฟีเจอร์หลัก

- **Authentication System**
  - เข้าสู่ระบบด้วยอีเมลและรหัสผ่าน
  - สมัครสมาชิกใหม่
  - รีเซ็ตรหัสผ่าน
  - ออกจากระบบ
- **Splash Screen** - หน้าจอเริ่มต้นที่ตรวจสอบสถานะการล็อกอิน
- **Navigation Management** - การจัดการหน้าจอด้วย GetX
- **Local Storage** - จัดเก็บ Token และข้อมูลผู้ใช้ด้วย Hive
- **API Integration** - เชื่อมต่อกับ Backend API
- **State Management** - จัดการ State ด้วย GetX Controller

## 🏗️ โครงสร้างโปรเจ็กต์

```
lib/
├── components/          # UI Components ที่ใช้ซ้ำ
│   └── drawer.dart     # Drawer Component
├── controllers/         # State Management Controllers
│   └── auth_controller.dart  # จัดการ Authentication
├── routes/             # การจัดการ Routes
│   ├── app_pages.dart  # กำหนด Pages และ Bindings
│   └── app_routes.dart # กำหนดชื่อ Routes
├── screens/            # หน้าจอต่างๆ
│   ├── splash_screen.dart
│   ├── login.dart
│   ├── regis.dart
│   ├── forget_pass.dart
│   └── home.dart
├── services/           # Services สำหรับการจัดการข้อมูล
│   └── storage_service.dart  # Local Storage Service
├── utils/              # Utilities และ Helpers
│   ├── api.dart        # API Configuration
│   └── navigation_helper.dart  # Navigation Helpers
└── main.dart           # Entry Point
```

## 🛠️ เทคโนโลยีที่ใช้

### Dependencies หลัก

- **Flutter SDK** `^3.8.1` - Framework หลัก
- **GetX** `^4.7.2` - State Management, Routing, และ Dependency Injection
- **Hive** `^2.2.3` - NoSQL Database สำหรับ Local Storage
- **HTTP** `^1.5.0` - HTTP Client สำหรับเรียก API
- **Path Provider** `^2.1.4` - จัดการ File Path

### Dev Dependencies

- **Flutter Test** - Testing Framework
- **Flutter Lints** `^5.0.0` - Code Analysis และ Linting

## 🎨 UI/UX Features

- **Material Design** - ใช้ Material Design Components
- **Custom Theme** - ธีมสีน้ำเงินและการออกแบบที่สอดคล้อง
- **Responsive Design** - ปรับขนาดได้กับหน้าจอต่างๆ
- **Form Validation** - ตรวจสอบข้อมูลฟอร์มอย่างครบถ้วน
- **Loading States** - แสดงสถานะการโหลด
- **Error Handling** - จัดการข้อผิดพลาดอย่างเหมาะสม

## 🚀 การติดตั้งและรัน

### ความต้องการของระบบ

- Flutter SDK ^3.8.1
- Dart SDK
- Android Studio หรือ VS Code
- Android/iOS Emulator หรืออุปกรณ์จริง

### ขั้นตอนการติดตั้ง

1. **Clone Repository**

   ```bash
   git clone <repository-url>
   cd api_consume
   ```

2. **ติดตั้ง Dependencies**

   ```bash
   flutter pub get
   ```

3. **รันแอป**
   ```bash
   flutter run
   ```

## 🔧 การตั้งค่า

### API Configuration

แก้ไขไฟล์ `lib/utils/api.dart` เพื่อตั้งค่า API Endpoint:

```dart
const String BASE_URL = 'https://your-api-domain.com';
const String LOGIN_ENDPOINT = '/auth/login';
const String REGISTER_ENDPOINT = '/auth/register';
```

### Assets

- โลโก้และรูปภาพอยู่ในโฟลเดอร์ `assets/images/`
- รองรับไฟล์: `logo.png`, `reset.png`

## 📋 ฟีเจอร์โดยละเอียด

### 1. Authentication Controller (`auth_controller.dart`)

- จัดการสถานะการล็อกอิน
- เชื่อมต่อ API สำหรับ Login, Register, Reset Password
- จัดเก็บ Token ใน Local Storage
- Auto-login detection

### 2. Storage Service (`storage_service.dart`)

- ใช้ Hive Database
- จัดเก็บ Token และข้อมูลผู้ใช้
- Secure Storage Implementation

### 3. Navigation System

- ใช้ GetX Routing
- Named Routes
- Route Guards
- Deep Linking Support

### 4. Screens Overview

#### Splash Screen

- ตรวจสอบสถานะการล็อกอิน
- นำทางไปหน้าที่เหมาะสม

#### Login Screen

- ฟอร์มเข้าสู่ระบบ
- Form Validation
- Loading State
- Error Handling

#### Register Screen

- ฟอร์มสมัครสมาชิก
- ตรวจสอบข้อมูล
- API Integration

#### Forget Password Screen

- ฟอร์มรีเซ็ตรหัสผ่าน
- ส่งอีเมลรีเซ็ต

#### Home Screen

- หน้าหลักหลังเข้าสู่ระบบ
- Drawer Navigation
- User Information Display

## 🧪 การทดสอบ

```bash
# รันการทดสอบ
flutter test

# ตรวจสอบ Code Quality
flutter analyze
```

## 📱 Platform Support

- ✅ Android
- ✅ iOS
- ⚠️ Web (Limited)
- ⚠️ Desktop (Limited)

## 🔒 Security Features

- Token-based Authentication
- Secure Local Storage
- Input Validation
- Error Handling
- Auto-logout on Token Expiry

## 🤝 การพัฒนาต่อ

### Code Style

- ใช้ Flutter/Dart conventions
- ใส่ comments เป็นภาษาไทย
- ตัวแปรและฟังก์ชันเป็นภาษาอังกฤษ

### Git Workflow

```bash
# ตัวอย่าง commit messages
git commit -m "feat: add login functionality"
git commit -m "fix: handle login error properly"
git commit -m "refactor: improve auth controller"
```

## 📄 License

สามารถใช้เพื่อการศึกษาและพัฒนาได้อย่างอิสระ

## 👨‍💻 ผู้พัฒนา

โดย ผู้ช่วยศาสาตราจารย์พิศาล สุขขี  
สาขาวิทยาการคอมพิวเตอร์  
มหาวิทยาลัยราชภัฏศรีสะเกษ

---

## 📞 การติดต่อและสนับสนุน

หากมีคำถามหรือปัญหาในการใช้งาน สามารถสร้าง Issue ในโปรเจ็กต์นี้ได้

**Happy Coding! 🚀**
