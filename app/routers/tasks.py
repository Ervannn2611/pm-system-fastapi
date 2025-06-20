from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List

from .. import models, schemas
from ..database import get_db
from ..security import get_current_active_user_with_blacklist_check

router = APIRouter(
    prefix="/projects/{project_id}/tasks",
    tags=["tasks"]
)

# Fungsi helper untuk mendapatkan proyek (tanpa verifikasi kepemilikan)
def get_project(project_id: int, db: Session):
    project = db.query(models.Project).filter(models.Project.id == project_id).first()
    if project is None:
        raise HTTPException(status_code=404, detail="Project not found")
    return project

@router.post("/", response_model=schemas.Task)
async def create_task(
    project_id: int,
    task: schemas.TaskCreate,
    db: Session = Depends(get_db),
    current_user: models.User = Depends(get_current_active_user_with_blacklist_check)
):
    """Endpoint untuk membuat tugas baru dalam proyek"""
    project = get_project(project_id, db)
    db_task = models.Task(
        **task.dict(),
        project_id=project.id
    )
    db.add(db_task)
    db.commit()
    db.refresh(db_task)
    return db_task

@router.get("/", response_model=List[schemas.Task])
async def read_tasks(
    project_id: int,
    skip: int = 0,
    limit: int = 100,
    db: Session = Depends(get_db),
    current_user: models.User = Depends(get_current_active_user_with_blacklist_check)
):
    """Endpoint untuk mendapatkan daftar tugas dalam proyek"""
    project = get_project(project_id, db)
    tasks = db.query(models.Task).filter(models.Task.project_id == project.id).offset(skip).limit(limit).all()
    return tasks

@router.get("/{task_id}", response_model=schemas.Task)
async def read_task(
    project_id: int,
    task_id: int,
    db: Session = Depends(get_db),
    current_user: models.User = Depends(get_current_active_user_with_blacklist_check)
):
    """Endpoint untuk mendapatkan detail tugas berdasarkan ID"""
    project = get_project(project_id, db)
    task = db.query(models.Task).filter(
        models.Task.id == task_id,
        models.Task.project_id == project.id
    ).first()
    if task is None:
        raise HTTPException(status_code=404, detail="Task not found")
    return task

@router.put("/{task_id}", response_model=schemas.Task)
async def update_task(
    project_id: int,
    task_id: int,
    task: schemas.TaskCreate,
    db: Session = Depends(get_db),
    current_user: models.User = Depends(get_current_active_user_with_blacklist_check)
):
    """Endpoint untuk mengupdate tugas"""
    project = get_project(project_id, db)
    db_task = db.query(models.Task).filter(
        models.Task.id == task_id,
        models.Task.project_id == project.id
    ).first()
    if db_task is None:
        raise HTTPException(status_code=404, detail="Task not found")

    for key, value in task.dict().items():
        setattr(db_task, key, value)

    db.commit()
    db.refresh(db_task)
    return db_task

@router.delete("/{task_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_task(
    project_id: int,
    task_id: int,
    db: Session = Depends(get_db),
    current_user: models.User = Depends(get_current_active_user_with_blacklist_check)
):
    """Endpoint untuk menghapus tugas"""
    project = get_project(project_id, db)
    db_task = db.query(models.Task).filter(
        models.Task.id == task_id,
        models.Task.project_id == project.id
    ).first()
    if db_task is None:
        raise HTTPException(status_code=404, detail="Task not found")

    db.delete(db_task)
    db.commit()
    return None
