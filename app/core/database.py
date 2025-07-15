import os
import psycopg2
from config import settings

def get_db_connection():
    """
    Conecta a la base de datos de PostgreSQL, devuelve la conexión abierta.

    Si la variable de entorno DATABASE_URL no está configurada, se utilizarán
    las variables de entorno definidas en settings.py.

    :rtype: psycopg2.extensions.connection
    :raises: Exception
    """
    try:
        db_url = os.getenv('DATABASE_URL', f"postgresql://{settings.DB_USER}:{settings.DB_PASSWORD}@{settings.DB_HOST}:5433/ottneutra")
        print(db_url)
        connection = psycopg2.connect(db_url)
        print("Conexión a la base de datos PostgreSQL exitosa.")
        return connection
    except psycopg2.Error as e:
        raise Exception(f"Error al conectar con PostgreSQL: {e}")
