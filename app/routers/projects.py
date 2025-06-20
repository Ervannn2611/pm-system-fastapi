from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List

from .. import models, schemas
from ..database import get_db
from ..security import get_current_active_user_with_blacklist_check

router = APIRouter(
    prefix="/projects",
    tags=["projects"]
)

@router.post("/", response_model=schemas.Project)
async def create_project(
    project: schemas.ProjectCreate, 
    db: Session = Depends(get_db),
    current_user: models.User = Depends(get_current_active_user_with_blacklist_check)
):
    """Buat proyek baru (dengan menyimpan user yang membuatnya, opsional)"""
    db_project = models.Project(
        **project.dict(),
        user_id=current_user.id  # Opsional: kamu bisa hapus ini jika tidak perlu
    )
    db.add(db_project)
    db.commit()
    db.refresh(db_project)
    return db_project

@router.get("/", response_model=List[schemas.Project])
async def read_projects(
    skip: int = 0, 
    limit: int = 100, 
    db: Session = Depends(get_db),
    current_user: models.User = Depends(get_current_active_user_with_blacklist_check)
):
    """Ambil semua proyek (bisa dilihat semua user)"""
    return db.query(models.Project).offset(skip).limit(limit).all()

@router.get("/{project_id}", response_model=schemas.Project)
async def read_project(
    project_id: int, 
    db: Session = Depends(get_db),
    current_user: models.User = Depends(get_current_active_user_with_blacklist_check)
):
    """Ambil detail proyek berdasarkan ID (global)"""
    project = db.query(models.Project).filter(models.Project.id == project_id).first()
    if project is None:
        raise HTTPException(status_code=404, detail="Project not found")
    return project

@router.put("/{project_id}", response_model=schemas.Project)
async def update_project(
    project_id: int, 
    project: schemas.ProjectCreate, 
    db: Session = Depends(get_db),
    current_user: models.User = Depends(get_current_active_user_with_blacklist_check)
):
    """Update proyek (bisa diubah siapa saja)"""
    db_project = db.query(models.Project).filter(models.Project.id == project_id).first()
    if db_project is None:
        raise HTTPException(status_code=404, detail="Project not found")
    
    for key, value in project.dict().items():
        setattr(db_project, key, value)
    
    db.commit()
    db.refresh(db_project)
    return db_project

@router.delete("/{project_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_project(
    project_id: int, 
    db: Session = Depends(get_db),
    current_user: models.User = Depends(get_current_active_user_with_blacklist_check)
):
    """Hapus proyek (siapa pun bisa menghapus)"""
    db_project = db.query(models.Project).filter(models.Project.id == project_id).first()
    if db_project is None:
        raise HTTPException(status_code=404, detail="Project not found")
    
    db.delete(db_project)
    db.commit()
    return None
