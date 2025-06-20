from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from .. import models, schemas
from ..database import get_db
from ..security import get_current_active_user, get_current_user_with_blacklist_check

router = APIRouter(
    prefix="/users",
    tags=["users"]
)

# Fungsi untuk mendapatkan current active user dengan pengecekan blacklist
async def get_current_active_user_with_blacklist_check(current_user: models.User = Depends(get_current_user_with_blacklist_check)):
    if not current_user.is_active:
        raise HTTPException(status_code=400, detail="Inactive user")
    return current_user

@router.get("/me", response_model=schemas.User)
async def read_users_me(current_user: models.User = Depends(get_current_active_user_with_blacklist_check)):
    """Endpoint untuk mendapatkan informasi pengguna yang sedang login"""
    return current_user