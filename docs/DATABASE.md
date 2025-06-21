# 📃 Database Documentation

## 🔌 Koneksi Database PostgreSQL

Aplikasi ini terhubung ke database PostgreSQL menggunakan konfigurasi berikut:

```python
SQLALCHEMY_DATABASE_URL = "postgresql://postgres:1234@localhost:5433/proyekdb"
```

**Catatan:**

* Pastikan PostgreSQL berjalan di port `5433`
* Database `proyekdb` sudah dibuat sebelumnya
* Koneksi digunakan oleh SQLAlchemy melalui file `database.py`

---

## 📆 Struktur Tabel

Tabel-tabel berikut dibuat secara otomatis saat server FastAPI dijalankan.

### ✚ users

Menyimpan informasi akun pengguna.

| Kolom            | Tipe Data    | Deskripsi                     |
| ---------------- | ------------ | ----------------------------- |
| id               | Integer (PK) | ID unik pengguna              |
| username         | String       | Nama pengguna (unik)          |
| hashed\_password | String       | Password terenkripsi (bcrypt) |
| is\_active       | Boolean      | Status aktif akun             |

---

### ✚ blacklisted\_tokens

Token JWT yang tidak lagi valid.

| Kolom           | Tipe Data    | Deskripsi               |
| --------------- | ------------ | ----------------------- |
| id              | Integer (PK) | ID unik token           |
| token           | String       | Token JWT yang diblokir |
| blacklisted\_on | DateTime     | Tanggal token diblokir  |

---

### ✚ projects

Informasi proyek pengguna.

| Kolom       | Tipe Data    | Deskripsi                   |
| ----------- | ------------ | --------------------------- |
| id          | Integer (PK) | ID proyek                   |
| name        | String       | Nama proyek                 |
| description | String       | Deskripsi proyek (opsional) |
| created\_at | DateTime     | Tanggal dibuat              |
| updated\_at | DateTime     | Tanggal diperbarui otomatis |
| user\_id    | ForeignKey   | ID pengguna pembuat proyek  |

---

### ✚ tasks

Tugas-tugas yang terkait dengan proyek.

| Kolom       | Tipe Data    | Deskripsi                      |
| ----------- | ------------ | ------------------------------ |
| id          | Integer (PK) | ID tugas                       |
| name        | String       | Nama tugas                     |
| description | String       | Deskripsi (opsional)           |
| status      | Enum         | Status: To Do/In Progress/Done |
| deadline    | DateTime     | Batas waktu (opsional)         |
| created\_at | DateTime     | Tanggal dibuat                 |
| updated\_at | DateTime     | Tanggal diperbarui otomatis    |
| project\_id | ForeignKey   | ID proyek terkait              |

---

## ⚖️ Pembuatan Tabel Otomatis

Tabel-tabel di atas dibuat oleh SQLAlchemy saat aplikasi dijalankan:

```python
@app.on_event("startup")
def startup():
    models.Base.metadata.create_all(bind=engine)
```

Tidak perlu membuat tabel manual selama koneksi berhasil dan struktur model sudah benar.

---

## 🔎 Akses & Verifikasi Data

Gunakan tools seperti **DBeaver** untuk:

1. Terhubung ke database `proyekdb`
2. Buka `Schemas > public > Tables`
3. Klik kanan tabel → **View Data**


