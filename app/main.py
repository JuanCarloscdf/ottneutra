from fastapi import FastAPI
from app.routes import enterprice, user,product,sale

app = FastAPI()


@app.get('/')
def healthy():
    return {"message":"Wellcome to the OTT jungle"}

app.include_router(enterprice.router)
app.include_router(user.router)
app.include_router(product.router)
app.include_router(sale.router)