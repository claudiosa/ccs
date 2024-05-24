lista = [
    {"service_id": "B5001", "locomotiveId": "250-1"},
    {"service_id": null, "locomotiveId": "250-1"},
    {"service_id": "B0001", "locomotiveId": "250-1"},
    {"service_id": null, "locomotiveId": "250-1"},
    {"service_id": "B5002", "locomotiveId": "250-1"},
    {"service_id": null, "locomotiveId": "250-1"}
]

# Filtrar os dicionários com "service_id" diferente de None ou "null"
dicionarios_filtrados = [d for d in lista if d.get("service_id") is not None and d.get("service_id") != null]

print(dicionarios_filtrados)
