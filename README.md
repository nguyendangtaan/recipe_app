# Recipe App Mobile 🍳

Ứng dụng di động về công thức nấu ăn được xây dựng bằng Flutter, tích hợp với TheMealDB API để cung cấp trải nghiệm tìm kiếm và khám phá món ăn tuyệt vời.

## ✨ Tính năng chính

### 🏠 Home Screen
- **Danh mục món ăn**: Hiển thị các danh mục với giao diện chip có thể cuộn ngang
- **Món ăn nổi bật**: Carousel các món ăn được chọn lọc
- **Công thức gần đây**: Danh sách các món ăn đã xem gần đây
- **Nguyên liệu**: Hiển thị các nguyên liệu phổ biến
- **Tìm kiếm nhanh**: Search bar để tìm kiếm đơn giản

### 🔍 Hệ thống tìm kiếm
#### Search Screen (từ Home Screen)
- Tìm kiếm đơn giản với gợi ý tự động
- Hiển thị kết quả dạng danh sách
- Giao diện tối giản, dễ sử dụng

#### Search Screen 2 (từ Bottom Navigation)
- **Tìm kiếm nâng cao** với gợi ý tự động
- **Filter Bottom Sheet** với 3 loại lọc:
  - 🏷️ **Danh mục**: Beef, Chicken, Dessert, Lamb, Pasta, Pork, Seafood, etc.
  - 🥩 **Nguyên liệu**: Chicken, Pork, Beef, Fish, Rice, Tomato, Onion, etc.
  - 🌍 **Khu vực**: American, British, Chinese, French, Indian, Italian, etc.
- **Grid Layout**: Hiển thị kết quả dạng lưới 2 cột đẹp mắt

### 📖 Recipe Screen
- **Tab Navigation**: Chuyển đổi mượt mà giữa "Video" và "Công thức"
- **Recipe Cards**: Hiển thị thông tin chi tiết:
  - 🖼️ Hình ảnh thumbnail với nút play overlay
  - ⭐ Đánh giá sao (5 sao)
  - ⏱️ Thời gian nấu
  - 📝 Tiêu đề công thức
  - 👤 Thông tin người tạo với avatar
  - ❤️ Nút bookmark/favorite

### 👤 Profile Screen
- Thông tin cá nhân người dùng
- Danh sách yêu thích dạng grid
- Nút Follow và Message

## 🏗️ Cấu trúc dự án

```
lib/
├── main.dart                    # Entry point của ứng dụng
├── models/                      # Data models
│   ├── category.dart           # Model cho danh mục
│   └── meal.dart               # Model cho món ăn
├── providers/                   # State management với Provider
│   ├── category_provider.dart  # Quản lý danh mục
│   ├── favorite_provider.dart  # Quản lý món ăn yêu thích
│   ├── meal_provider.dart      # Quản lý món ăn và tìm kiếm
│   └── filter_provider.dart    # Quản lý dữ liệu filter
├── screens/                     # UI screens
│   ├── main_screen.dart        # Main navigation screen
│   ├── home_screen.dart        # Home screen
│   ├── search_screen.dart      # Search screen 
│   ├── search_screen2.dart     # Search screen 
│   ├── recipe_screen.dart      # Recipe screen
│   ├── profile_screen.dart     # Profile screen
│   ├── detail_screen.dart      # Detail screen
│   └── splash_screen.dart      # Splash screen
├── services/                    # API services
│   └── api_service.dart        # TheMealDB API integration
└── widgets/                     # Reusable widgets
    ├── category_chip.dart      # Chip cho danh mục
    ├── custom_bottom_nav.dart  # Bottom navigation
    ├── favorite_button.dart    # Nút favorite
    ├── filter_bottom_sheet.dart # Bottom sheet filter
    ├── loading_widget.dart     # Loading indicator
    └── meal_card.dart          # Card hiển thị món ăn
```

## 🚀 Cách sử dụng

### 1. Cài đặt và chạy ứng dụng
```bash
# Clone repository
git clone <repository-url>
cd recipe_appmobile

# Cài đặt dependencies
flutter pub get

# Chạy ứng dụng
flutter run
```

### 2. Navigation và điều hướng

#### Bottom Navigation
- 🏠 **Home**: Màn hình chính với danh mục và món ăn nổi bật
- 🔍 **Search**: Tìm kiếm nâng cao với filter
- ➕ **Add**: Floating Action Button (có thể thêm món ăn mới)
- 📖 **Bookmark**: Trang công thức với tab Video/Công thức
- 👤 **Profile**: Trang cá nhân người dùng

#### Tìm kiếm
- **Từ Home Screen**: Nhấn vào search bar → Search Screen 
- **Từ Bottom Nav**: Nhấn icon search → Search Screen 2 

#### Filter (chỉ có trong Search Screen 2)
1. Nhấn vào icon filter (🔍)
2. Chọn một trong ba loại:
   - **Danh mục**: Lọc theo loại món ăn
   - **Nguyên liệu**: Lọc theo nguyên liệu chính
   - **Khu vực**: Lọc theo xuất xứ món ăn
3. Nhấn "Xác nhận" để áp dụng filter

### 3. Tính năng chi tiết

#### Home Screen
- Cuộn ngang để xem các danh mục
- Nhấn vào món ăn để xem chi tiết
- Search bar để tìm kiếm nhanh

#### Search Screen 
- Gõ để tìm kiếm
- Gợi ý tự động khi gõ
- Kết quả dạng danh sách
- Nút back để quay lại

#### Search Screen 2 
- Tìm kiếm với gợi ý
- Filter bottom sheet
- Kết quả dạng grid 2 cột
- Random meals khi chưa tìm kiếm

#### Recipe Screen
- Tab "Video": Công thức dạng video
- Tab "Công thức": Công thức dạng text
- Mỗi card có đầy đủ thông tin
- Nút favorite để lưu

## 🛠️ Công nghệ sử dụng

### Frontend
- **Flutter**: Framework chính


### State Management
- **Provider**: Quản lý state toàn ứng dụng

### Backend & API
- **TheMealDB API**: API miễn phí cho dữ liệu món ăn
- **HTTP**: Giao tiếp với API

### Dependencies chính
```yaml
dependencies:
  flutter: ^3.0.0
  provider: ^6.0.0
  http: ^0.13.0
```

## 📱 Giao diện



### UI Components
- **Bottom Navigation**: 5 tab với FAB ở giữa
- **Cards**: Rounded corners với shadow
- **Chips**: Cho danh mục và filter
- **Bottom Sheet**: Modal filter
- **Grid Layout**: 2 cột cho kết quả tìm kiếm

## 🔧 API Integration

### TheMealDB API Endpoints
- `search.php?s=query`: Tìm kiếm theo tên
- `search.php?f=letter`: Tìm kiếm theo chữ cái đầu
- `filter.php?c=category`: Lọc theo danh mục
- `filter.php?i=ingredient`: Lọc theo nguyên liệu
- `filter.php?a=area`: Lọc theo khu vực
- `random.php`: Lấy món ăn ngẫu nhiên
- `lookup.php?i=id`: Chi tiết món ăn



## 🚀 Tính năng nổi bật

### ✅ Đã hoàn thành
- [x] Home Screen với danh mục và món ăn nổi bật
- [x] Hệ thống tìm kiếm đơn giản và nâng cao
- [x] Filter theo danh mục, nguyên liệu, khu vực
- [x] Recipe Screen với tab navigation
- [x] Profile Screen với thông tin cá nhân
- [x] Bottom Navigation với 5 tab
- [x] API Integration với TheMealDB
- [x] State Management với Provider
- [x] Responsive Design
- [x] Loading States và Error Handling




