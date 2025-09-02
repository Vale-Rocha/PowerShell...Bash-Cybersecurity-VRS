import sys 
import requests

# Verifica que se haya pasado un argumento 
if len(sys.argv) != 2: 
    print("Uso: python verificar_correo.py correo@example.com") 
    sys.exit(1) 

# Extrae el correo desde los argumentos 
correo = sys.argv[1] 

# Lee la API key desde el archivo 
try: 
    with open("apikey.txt", "r") as archivo: 
        api_key = archivo.read().strip() 

except FileNotFoundError: 

    print("Error: No se encontró el archivo apikey.txt") 
    sys.exit(1) 

# Define la URL de la API 
url = f"https://haveibeenpwned.com/api/v3/breachedaccount/{correo}" 

# Define los headers requeridos por la API 
headers = { 
    "hibp-api-key": api_key, 
    "user-agent": "PythonScript" 
} 

# Realiza la consulta 

response = requests.get(url, headers=headers) 

 

# Verifica el código de estado 

if response.status_code == 200: 

    print(f"La cuenta {correo} ha sido comprometida.") 
    print("Reporte de brechas encontradas:") 

    brechas = response.json() 

    for brecha in brechas: 

        print(f"- Sitio: {brecha['Name']}") 
        print(f"  Fecha: {brecha['BreachDate']}") 
        print(f"  Datos comprometidos: {', '.join(brecha['DataClasses'])}") 
        print(f"  Descripción: {brecha['Description'][:100]}...") 
        print() 

elif response.status_code == 404: 
    print(f"La cuenta {correo} no aparece en ninguna brecha conocida.") 

elif response.status_code == 401: 
    print("Error de autenticación: revisa tu API key.") 

else: 
    print(f"Error inesperado. Código de estado: {response.status_code}")
