from datetime import datetime
from app.config import FRONTEND_URL

def build_send_approbation_request(document: str, originator: str, url: str, message: str | None = None):
    html_message = ""
    if message:
        html_message = f"""<p style="font-size: 1.2rem;">Mensaje: {message}</p>"""
        
    html_body=f"""
        <h1>Solicitud de aprobación</h1>

        <p style="font-size: 1.2rem;">Se solicito su aprobación para una {document}</p>

        <h2>Resumen de la petición</h2>
        <p style="font-size: 1.2rem;">Originador: {originator}</p>
        <p style="font-size: 1.2rem;">Fecha de la solicitud: {datetime.now}</p>
        
        {html_message}

        <div>
            <a href="{url}?approve=true" style="background-color: green; color:white; padding:5px 10px;text-decoration:none;border-radius:10px;font-size:1.3rem">Aprobar</a>
            <a href="{url}?approve=false" style="background-color: red; color:white; padding:5px 10px;text-decoration:none;border-radius:10px;font-size:1.3rem">Rechazar</a>
        </div>
    """
    return html_body

def build_reject_approvation(document: str, rejector_name: str, reason: str | None, item_id: str, url: str, message: str | None = None):
    html_message = ""
    if message:
        html_message = f"""<p style="font-size: 1.2rem;">Mensaje: {message}</p>"""
    
    html_body=f"""
        <h1>Se rechazo la solicitud</h1>
        <p style="font-size: 1.2rem;">Se rechazo una solicitud de aprobación para el documento: {document} con el id: {item_id}</p>
        <p style="font-size: 1.2rem;">La persona que rechazo la solicitud fue: {rejector_name}</p>
        <p style="font-size: 1.2rem;">Razón: {reason}</p>
        {html_message}
        
        <a href="{FRONTEND_URL}{url}" style="background-color: green; color:white; padding:5px 10px;text-decoration:none;border-radius:10px;font-size:1.3rem">Ver más información</a>
    """
    return html_body

def build_finish_approvation(document: str, item_id: str, url: str, message: int | None = None):
    html_message = ""
    if message:
        html_message = f"""<p style="font-size: 1.2rem;">Mensaje: {message}</p>"""
        
    html_body=f"""
        <h1>Solicitud Aprobada</h1>
        <p style="font-size: 1.2rem;">Se aprobo una solicitud para el documento: {document} con el id: {item_id}</p>
        {html_message}
        
        <a href="{FRONTEND_URL}{url}" style="background-color: green; color:white; padding:5px 10px;text-decoration:none;border-radius:10px;font-size:1.3rem">Ver más información</a>
    """
    return html_body

def build_notify_sended(document: str, item_id: str, url: str, message: str | None = None):
    html_message = ""
    if message:
        html_message = f"""<p style="font-size: 1.2rem;">Mensaje: {message}</p>"""
        
    html_body=f"""
        <h1>Documento {document} terminado</h1>
        <p style="font-size: 1.2rem;">Se finalizo el documento: {document} con el id: {item_id}</p>
        {html_message}
        
        <a href="{FRONTEND_URL}{url}" style="background-color: green; color:white; padding:5px 10px;text-decoration:none;border-radius:10px;font-size:1.3rem">Ver más información</a>
    """
    return html_body

def build_notify_task_message(task_id: int, message: str, originator: str):
    html_body = f"""
        <h1>{originator} envio un mensaje</h1>
        <p style="font-size: 1.2rem;">{originator} envio un mensaje en la tarea con el id: {task_id}</p>
        
        <p>Mensaje: {message}</p>
    """
    return html_body