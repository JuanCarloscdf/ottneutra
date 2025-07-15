from fastapi import APIRouter

router = APIRouter(prefix="/user")

@router.post('/')
def create_user():
    return {"message" : "creando user"}

@router.get('/')
def get_users_by_EnterpriseId():
    return {"message" : "obteniendo todos los usuarios de una empresa"}
 
@router.get('/{id}')
def get_user(id:int):
    return {"message": f'obteniendo un user con el id {id}'}

@router.delete('/{id}')
def delete_user(id:int):
    return {"message":f'borrando el user con el id {id}'}

@router.patch('/')
def update_user():
    return{"message" : f'actualizando user'}
