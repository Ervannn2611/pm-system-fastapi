from pydantic import BaseModel
from datetime import datetime
from typing import Optional, List
from .models import TaskStatus

class UserBase(BaseModel):
    username: str

class UserCreate(UserBase):
    password: str

class User(UserBase):
    id: int
    is_active: bool

    class Config:
         from_attributes = True

class UserWithProjects(User):
    projects: List["Project"] = []

    class Config:
         from_attributes = True

class Token(BaseModel):
    access_token: str
    token_type: str

class TokenData(BaseModel):
    username: str | None = None

class BlacklistedTokenBase(BaseModel):
    token: str

class BlacklistedToken(BlacklistedTokenBase):
    id: int
    blacklisted_on: datetime

    class Config:
         from_attributes = True

class ProjectBase(BaseModel):
    name: str
    description: Optional[str] = None

class ProjectCreate(ProjectBase):
    pass

class Project(ProjectBase):
    id: int
    created_at: datetime
    updated_at: datetime
    user_id: int
    tasks: List["Task"] = []

    class Config:
         from_attributes = True

class TaskBase(BaseModel):
    name: str
    description: Optional[str] = None
    status: TaskStatus = TaskStatus.TODO
    deadline: Optional[datetime] = None

class TaskCreate(TaskBase):
    pass

class Task(TaskBase):
    id: int
    created_at: datetime
    updated_at: datetime
    project_id: int

    class Config:
         from_attributes = True

class LogoutRequest(BaseModel):
    token: str