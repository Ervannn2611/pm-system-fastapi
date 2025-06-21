from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from . import models
from .database import engine
from .routers import auth, users, projects, tasks

# Inisialisasi aplikasi FastAPI
app = FastAPI(
    title="User Authentication API",
    description="API untuk autentikasi pengguna dengan FastAPI",
    version="0.1.0"
)

# Konfigurasi CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Tambahkan router
app.include_router(auth.router)
app.include_router(users.router)
app.include_router(projects.router)
app.include_router(tasks.router)

# Buat tabel database setelah semua import dan inisialisasi
@app.on_event("startup")
def startup():
    from . import models  # pastikan ini ada, walaupun sudah ada di atas
    print(">> Membuat tabel...")
    print(">> Model yang dikenali:", models.Base.metadata.tables.keys())
    models.Base.metadata.create_all(bind=engine)
    print(">> Tabel selesai dibuat.")


@app.get("/")
def read_root():
    return {"message": "Welcome to User Authentication API"}
