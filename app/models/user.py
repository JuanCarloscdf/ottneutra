from typing import Optional
from pydantic import BaseModel

class CreateUser(BaseModel):
    name: str
    email: str
    username: str
    password: str
    ci: Optional[str] = None

class User(CreateUser):
    id: int
