% Palabras clave comúnmente encontradas en noticias falsas
palabra_clave_falsa("milagro").
palabra_clave_falsa("increíble").
palabra_clave_falsa("revelado").
palabra_clave_falsa("conspiración").
palabra_clave_falsa("sensacional").
palabra_clave_falsa("impactante").
palabra_clave_falsa("urgente").
palabra_clave_falsa("escándalo").
palabra_clave_falsa("misterioso").
palabra_clave_falsa("confidencial").

% Sitios web conocidos por difundir noticias falsas
sitio_falso("www.noticiasfalsas.com").
sitio_falso("www.informacionnoverificada.net").
sitio_falso("www.fakenewsnow.com").
sitio_falso("www.noticiassensacionales.org").

% Sitios web confiables
sitio_confiable("www.bbc.com").
sitio_confiable("www.nytimes.com").
sitio_confiable("www.theguardian.com").
sitio_confiable("www.reuters.com").
sitio_confiable("www.apnews.com").

% Autores conocidos por difundir noticias falsas
autor_falso("John Doe").
autor_falso("Jane Smith").
autor_falso("Anonymous").

% Hechos verificados (Ejemplos)
hecho_verificado("La Tierra es redonda").
hecho_verificado("Las vacunas son seguras y efectivas").
hecho_verificado("El cambio climático es real y está influenciado por la actividad humana").

% Verificar si una noticia contiene palabras clave falsas
contiene_palabra_clave_falsa(Noticia) :-
    split_string(Noticia, " ", "", Palabras),
    member(Palabra, Palabras),
    palabra_clave_falsa(Palabra).

% Verificar si una noticia proviene de un sitio falso
es_de_sitio_falso(URL) :-
    sitio_falso(Sitio),
    sub_string(URL, _, _, _, Sitio).

% Verificar si una noticia proviene de un sitio confiable
es_de_sitio_confiable(URL) :-
    sitio_confiable(Sitio),
    sub_string(URL, _, _, _, Sitio).

% Verificar si una noticia fue escrita por un autor falso
es_de_autor_falso(Autor) :-
    autor_falso(Autor).

% Verificar si una noticia contiene un hecho verificado
contiene_hecho_verificado(Noticia) :-
    hecho_verificado(Hecho),
    sub_string(Noticia, _, _, _, Hecho).

% Verificar la fecha de la noticia (simplificado para el ejemplo)
fecha_valida(Fecha) :-
    sub_string(Fecha, 0, 4, _, AnioStr),
    number_string(Anio, AnioStr),
    Anio >= 2000,
    Anio =< 2024.

% Pregunta inicial del árbol
iniciar :-
    write('¿La noticia proviene de un sitio confiable (sí/no)? '),
    read(Respuesta),
    pregunta_sitio(Respuesta).

% Pregunta sobre el sitio
pregunta_sitio(si) :-
    write('¿La noticia contiene hechos verificados (sí/no)? '),
    read(Respuesta),
    pregunta_hechos(Respuesta).
pregunta_sitio(no) :-
    write('¿La noticia proviene de un sitio conocido por noticias falsas (sí/no)? '),
    read(Respuesta),
    pregunta_sitio_falso(Respuesta).

% Pregunta sobre hechos verificados
pregunta_hechos(si) :-
    write('¿La noticia contiene palabras clave sensacionalistas (sí/no)? '),
    read(Respuesta),
    pregunta_palabras_clave(Respuesta, confiable).
pregunta_hechos(no) :-
    write('La noticia es probablemente falsa debido a la falta de hechos verificados.').

% Pregunta sobre sitios falsos
pregunta_sitio_falso(si) :-
    write('La noticia es probablemente falsa debido a la fuente no confiable.').
pregunta_sitio_falso(no) :-
    write('¿La noticia contiene palabras clave sensacionalistas (sí/no)? '),
    read(Respuesta),
    pregunta_palabras_clave(Respuesta, no_confiable).

% Pregunta sobre palabras clave sensacionalistas
pregunta_palabras_clave(si, _) :-
    write('La noticia es probablemente falsa debido al uso de palabras clave sensacionalistas.').
pregunta_palabras_clave(no, no_confiable) :-
    write('¿La noticia fue escrita por un autor conocido por difundir noticias falsas (sí/no)? '),
    read(Respuesta),
    pregunta_autor(Respuesta).
pregunta_palabras_clave(no, confiable) :-
    write('La noticia parece confiable.').

% Pregunta sobre el autor
pregunta_autor(si) :-
    write('La noticia es probablemente falsa debido al autor poco confiable.').
pregunta_autor(no) :-
    write('¿La fecha de la noticia es válida y reciente (sí/no)? '),
    read(Respuesta),
    pregunta_fecha(Respuesta).

% Pregunta sobre la fecha
pregunta_fecha(si) :-
    write('La noticia parece confiable.').
pregunta_fecha(no) :-
    write('La noticia es probablemente falsa debido a la fecha inválida o antigua.').
