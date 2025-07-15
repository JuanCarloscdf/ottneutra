import psycopg2
from app.core.database import get_db_connection
from app.models.enterprise import CreateEnterprise, Enterprise

def insert_enterprise(data: CreateEnterprise) -> Enterprise:
    if data is None:
        raise ValueError("no se enviaron los datos de la empresa")

    conn = get_db_connection()
    try:
        cur = conn.cursor()
        query = """
            INSERT INTO enterprice (
                name, email, nit, adress, phone, url_icon, color, rep_name, rep_email, rep_cellphone
            ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            RETURNING *;
        """
        values = (
            data.name,
            data.email,
            data.nit,
            data.adress,
            data.phone,
            data.url_icon,
            data.color,
            data.rep_name,
            data.rep_email,
            data.rep_cellphone,
        )
        cur.execute(query, values)
        row = cur.fetchone()
        if row is None:
            raise Exception("No se pudo obtener la fila de la empresa insertada")

        colnames = [desc[0] for desc in cur.description]
        result_dict = dict(zip(colnames, row))

        print("resultssssssssssssssssss",result_dict)
        conn.commit()

        # Convertir dict a instancia Pydantic Enterprise
        return Enterprise(**result_dict)

    except psycopg2.Error as e:
        conn.rollback()
        raise Exception(f"Error al insertar empresa: {e}")
    finally:
        conn.close()
