# Proyek FastAPI - Autentikasi Pengguna

Proyek ini adalah implementasi sistem autentikasi pengguna menggunakan FastAPI, SQLAlchemy, dan JWT.

## Fitur

- Registrasi pengguna (username, password)
- Autentikasi pengguna dengan JWT
- Endpoint terproteksi yang memerlukan autentikasi

## Persyaratan

- Python 3.9+
- FastAPI
- Uvicorn
- SQLAlchemy
- Passlib
- Python-jose
- Python-multipart
- Bcrypt

## Instalasi

1. Clone repositori ini
2. Instal dependensi:

```bash
pip install -r requirements.txt
```

## Menjalankan Aplikasi

```bash
python run.py
```

Aplikasi akan berjalan di http://127.0.0.1:8000

## Dokumentasi API

Setelah menjalankan aplikasi, Anda dapat mengakses dokumentasi API interaktif di:

- Swagger UI: http://127.0.0.1:8000/docs
- ReDoc: http://127.0.0.1:8000/redoc

## Penggunaan API

### Registrasi Pengguna

```
POST /register
```

Body:
```json
{
  "username": "user1",
  "password": "password123"
}
```

### Login dan Mendapatkan Token

```
POST /token
```

Form data:
- username: user1
- password: password123

### Mendapatkan Informasi Pengguna yang Sedang Login

```
GET /users/me
```

Header:
```
Authorization: Bearer {access_token}
```