from fastapi import APIRouter
from psycopg2 import DatabaseError

from app.core.database import get_db_connection
from app.models.enterprise import CreateEnterprise, Enterprise
from app.models.response import EnterpriseResponse
from app.services.enterprise import insert_enterprise

router = APIRouter(prefix="/enterprise")

@router.post('/')
def create_enterprise(enterprise:CreateEnterprise):
    print(enterprise)
    created = insert_enterprise(enterprise)
    if created is None:
        raise DatabaseError('error al crear una empresa')
    return EnterpriseResponse(
        data=created,
        message="empresa registarda correctamente",
        status=200,
        success=True
    )
 
@router.get('/{id}')
def get_enterprise(id:int):
    return {"message": f'obteniendo un enterprise con el id {id}'}

@router.delete('/{id}')
def delete_emterprise(id:int):
    return {"message":f'borrando el enterprise con el id {id}'}

@router.patch('/')
def update_enterprise():
    return{"message" : f'actualizando enterprise'}
