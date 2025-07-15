from fastapi import APIRouter

router = APIRouter(prefix="/sale")

@router.post('/')
def create_sale():
    return {"message" : "creando sale"}
 
@router.get('/{id}')
def get_sale(id:int):
    return {"message": f'obteniendo un sale con el id {id}'}

@router.delete('/{id}')
def delete_emterprise(id:int):
    return {"message":f'borrando el sale con el id {id}'}

@router.patch('/')
def update_sale():
    return{"message" : f'actualizando sale'}
