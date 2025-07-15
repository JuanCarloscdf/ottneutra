from fastapi import APIRouter

router = APIRouter(prefix="/product")

@router.post('/')
def create_product():
    return {"message" : "creando product"}

@router.get('/')
def get_products_by_EnterpriseId():
    return {"message" : "obteniendo todos los productos de una empresa"}
 
@router.get('/{id}')
def get_product(id:int):
    return {"message": f'obteniendo un product con el id {id}'}

@router.delete('/{id}')
def delete_product(id:int):
    return {"message":f'borrando el product con el id {id}'}

@router.patch('/')
def update_product():
    return{"message" : f'actualizando product'}
