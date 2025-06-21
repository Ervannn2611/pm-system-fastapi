
Proyek ini adalah implementasi sistem autentikasi pengguna menggunakan FastAPI, SQLAlchemy, dan JWT. Cocok digunakan sebagai dasar sistem login berbasis token di aplikasi web atau mobile.

---

## ✨ Fitur

- ✅ Registrasi pengguna (username dan password)
- ✅ Autentikasi menggunakan JWT
- ✅ Endpoint terproteksi yang hanya dapat diakses jika sudah login
- ✅ Dokumentasi API otomatis via Swagger & ReDoc
- ✅ Dokumentasi tambahan tersedia di folder `docs/`

---

## 🛠️ Persyaratan

- Python 3.9 atau lebih baru
- FastAPI
- Uvicorn
- SQLAlchemy
- Passlib
- Python-Jose
- Bcrypt
- Python-Multipart

---

## 🚀 Instalasi

1. Clone repositori ini:

```bash
git clone https://github.com/username/manajemen-proyek-fastapi.git
cd manajemen-proyek-fastapi

Buat virtual environment (opsional tapi disarankan):


python -m venv venv
source venv/bin/activate  # Linux/macOS
venv\Scripts\activate     # Windows
Instal semua dependensi:


pip install -r requirements.txt
▶️ Menjalankan Aplikasi
Jalankan aplikasi dengan:

python run.py
Aplikasi akan berjalan di:

http://127.0.0.1:8000
📘 Dokumentasi API
Setelah aplikasi berjalan, kamu bisa mengakses dokumentasi interaktif di:

Swagger UI


🧪 Contoh Penggunaan API
🔸 Registrasi Pengguna
Endpoint:

POST /register
Body (JSON):

json
{
  "username": "testing",
  "password": "test123"
}
🔸 Login dan Dapatkan Token
Endpoint:

POST /login
Form data:

username=testing
password=test123
🔸 Mendapatkan Informasi Pengguna (Terproteksi)
Endpoint:

GET /users/me
Headers:

Authorization: Bearer <access_token>

ReDoc

📁 Dokumentasi tambahan juga tersedia di folder docs/ untuk penjelasan teknis, struktur folder, dan contoh penggunaan lebih lanjut.