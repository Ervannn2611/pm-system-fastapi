from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

# Gunakan SQLALCHEMY_DATABASE_URL sebagai database
SQLALCHEMY_DATABASE_URL = "postgresql://postgres:1234@localhost:5433/proyekdb"


# Buat engine database
engine = create_engine(SQLALCHEMY_DATABASE_URL)

# Buat SessionLocal class untuk instance session database
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Buat Base class untuk model deklaratif
Base = declarative_base()

# Dependency untuk mendapatkan database session
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()