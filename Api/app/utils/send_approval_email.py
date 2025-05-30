def build_email_body(document, date, originator, client, url):
    html_body=f"""
        <h1>Solicitud de aprobación</h1>

        <p style="font-size: 1.2rem;">Se solicito su aprobación para una {document}</p>
        
        <h2>Resumen de la petición</h2>
        <p style="font-size: 1.2rem;">Originador: {originator}</p>
        <p style="font-size: 1.2rem;">Fecha de la solicitud: {date}</p>
        <p style="font-size: 1.2rem;">Cliente: {client}</p>

        <div>
            <a href="{url}?approve=true" style="background-color: green; color:white; padding:5px 10px;text-decoration:none;border-radius:10px;font-size:1.3rem">Aprobar</a>
            <a href="{url}?approve=false" style="background-color: red; color:white; padding:5px 10px;text-decoration:none;border-radius:10px;font-size:1.3rem">Rechazar</a>
        </div>
    """
    
    return html_body