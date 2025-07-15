from email import message
from xmlrpc.client import Boolean
from pydantic import BaseModel

from app.models.enterprise import Enterprise
from app.models.user import User


class BaseResponse(BaseModel):
    success:Boolean
    status: int
    message:str
class UserResponse(BaseResponse):
    data: User    
 
class EnterpriseResponse(BaseResponse):
    data:Enterprise    