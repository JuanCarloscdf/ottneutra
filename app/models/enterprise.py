from typing import Optional
from pydantic import BaseModel


class CreateEnterprise (BaseModel):
    name:str
    email:str
    nit:str
    adress:str
    phone:str
    url_icon:Optional[str] = None
    color:Optional[str] = None
    rep_name:str
    rep_email:str
    rep_cellphone:str
class Enterprise (CreateEnterprise):
    enter_id:int  