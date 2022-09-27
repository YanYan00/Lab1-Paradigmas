#lang racket
(require "TDA-bitmap_20473015_Rojas.rkt")
(require "TDA-hexmap_20473015_Rojas.rkt")
(require "TDA-pixmap_20473015_Rojas.rkt")
(provide (all-defined-out))
;--------------Selectores image-----------------
;Dominio: imagen
;Recorrido: ancho
;Descripcion: devuelve el ancho de la imagen
;Tipo de recursion: no hay
(define (get-ancho imagen)
  (car imagen))

;Dominio: imagen
;Recorrido: alto
;Descripcion: devuelve el alto de la imagen
;Tipo de recursion: no hay
(define (get-alto imagen)
  (car(cdr imagen)))

;Dominio: imagen
;Recorrido: pixeles
;Descripcion: devuelve la lista de pixeles
;Tipo de recursion: no hay
(define (get-pixeles imagen)
  (car(cddr imagen)))
;--------------Funciones TDA-image--------------
;Dominio: ancho(int) X alto(int) X v(int) X z(int) X '()
;Recorrido: Lista
;Descripcion: forma una lista con coordenadas dependiendo del ancho que depende del alto
;Tipo de recursion: Lineal
(define(lista-coordenadas ancho alto v z lista)
  (if(= alto v)
     (reverse lista)
  (if(= ancho z)
     (lista-coordenadas ancho alto (+ v 1) 0 lista)
   (lista-coordenadas ancho alto v (+ z 1) (cons (list v z) lista)))))

;Dominio: coordenadas(list) X pixeles(list)
;Recorrido: Lista que contiene los datos ordenados por coordenadas
;Descripcion: compara si la lista de pixeles está ordenada en el caso de no estarlo la ordena comparando el pixel con la lista de coordenadas ingresada
;Tipo de recursion: Lineal
(define (ord-pix-envoltorio lista1 lista2)
  (define(ordenar-pixeles coordenadas pixeles pixeles-aux pixel lista-salida)
  (if (null? coordenadas)
      (reverse lista-salida)
    (if (equal? (car coordenadas) (list (car(car pixeles-aux)) (car(cdr(car pixeles-aux)))))
        (ordenar-pixeles (cdr coordenadas) pixeles  pixeles (car pixeles) (cons pixel lista-salida))
      (ordenar-pixeles coordenadas pixeles (cdr pixeles-aux)(car(cdr pixeles-aux)) lista-salida))))
  (ordenar-pixeles lista1 lista2 lista2 (car lista2) null))
;--------------TDA-image--------------
;Dominio: ancho(int) X alto(int) X datos(list)
;Recorrido: image
;Descripcion: construye una imagen
;Tipo de recursion: no usa
(define (image ancho alto . datos)
  (if(and(integer? alto)(integer? ancho)(>= alto 0)(>= ancho 0))
     (if(=(* alto ancho)(length datos))
          (list ancho alto (ord-pix-envoltorio (lista-coordenadas ancho alto 0 0 null) datos))
      (list ancho alto datos))
   (print "ingresa los datos correctamente")))   

;--------------Funcion compressed?---------------
;Dominio: imagen
;Recorrido: booleano
;Descripcion: comprueba si una imagen esta comprimida
;Tipo de recursion: no usa
(define (compressed? imagen)
  (if(=(*(get-ancho imagen)(get-alto imagen)) (length (get-pixeles imagen)))
     #t
    #f))
;--------------Funciones para flips--------------
;Dominio: lista
;Recorrido: lista-filtrada
;Descripcion: crea una lista con los datos de los pixeles sin x e y
;Tipo de recursion: Lineal
(define (transformar lista salida)
  (if(null? lista)
      (reverse salida)
     (transformar (cdr lista) (cons (cddr(car lista)) salida))))

;Dominio: lista1
;Recorrido: lista-salida
;Descripcion: crea una lista lineal a partir de una lista de sub-listas
;Tipo de recursion: Lineal
(define (volverEnvoltorio lista1)
  (define (volver lista lista-aux lista-salida)
    (if(null? (cdr lista))
       (if(null? lista-aux)        
          (reverse lista-salida)
          (volver lista (cdr lista-aux) (cons (car lista-aux) lista-salida)))  
       (if(null? lista-aux)
          (volver (cdr lista) (car(cdr lista)) lista-salida)
          (volver lista (cdr lista-aux) (cons (car lista-aux) lista-salida))) 
       ))
  (volver lista1 (car lista1) null))

;Dominio: lista1 lista2
;Recorrido: lista1 con los datos de lista2 agregados
;Descripcion:Mete los datos de las sublistas de lista2 en las sublistas de lista1 esta funcion se ocupa mayormente para ordenar cambios en los datos
;Tipo de recursion: Lineal
(define (juntarEnvoltorio lista1 lista2)
         (define (juntar lista1 lista2 lista-agregar lista-pasar lista-salida)
           (if (null? (cdr lista1))
               (if(null? lista-pasar)
                  (reverse (cons (reverse lista-agregar) lista-salida))
                  (juntar lista1 lista2 (cons (car lista-pasar) lista-agregar) (cdr lista-pasar) lista-salida))
               (if(null? lista-pasar)
                  (juntar (cdr lista1)(cdr lista2)(reverse(car(cdr lista1)))(car(cdr lista2))(cons (reverse lista-agregar)lista-salida))
                  (juntar lista1 lista2 (cons (car lista-pasar) lista-agregar) (cdr lista-pasar) lista-salida)))
           )
         (juntar lista1 lista2 (car lista1) (car lista2) null))
;--------------Funcion flipH--------------
;Dominio: punto(ancho) i(iterador) lista(pixeles) '() '()
;Recorrido: lista agrupada en tramos
;Descripcion: agrupa los datos dependiendo del ancho, si es una imagen 3x3 junta los datos de pixeles de 3 en 3 y los devuelve invertidos
;Tipo de recursion: lineal
(define (invertirH punto i lista a b)
  (if(null? lista)
     (reverse (cons a b))
     (if(= punto i)
        (invertirH punto 1 (cdr lista) (reverse(cons(car lista)null)) (cons a b))
      (invertirH punto (+ 1 i) (cdr lista) (cons (car lista) a ) b)  
)))
;Dominio: imagen
;Recorrido: imagen
;Descripcion: devuelve la imagen girada horizontalmente
;Tipo de recursion: no hay
(define (flipH imagen)
  (list (get-ancho imagen) (get-alto imagen) (juntarEnvoltorio (lista-coordenadas (get-ancho imagen) (get-alto imagen) 0 0 null)
          (volverEnvoltorio (invertirH (get-ancho imagen) 0 (transformar (get-pixeles imagen) null) null null)
        ))))
;--------------Funcion flipV--------------
;Dominio: punto(alto) i(iterador) lista(pixeles) '() '()
;Recorrido: pixeles agrupados en tramos
;Descripcion: agrupa la imagen en tramos dependiendo del alto
;Tipo de recursion: lineal
(define (agrupar punto i lista a b)
  (if(null? lista)
     (cons (reverse a) b)
     (if(= punto i)
        (agrupar punto 1 (cdr lista) (cons(reverse(car lista))null) (cons (reverse a) b))
      (agrupar punto (+ 1 i) (cdr lista) (cons (car lista) a ) b)  
)))
;Dominio:imagen
;Recorrido: imagen
;Descripcion: gira verticalmente la imagen
;Tipo de recursion: no usa
(define (flipV imagen)
  (list (get-ancho imagen) (get-alto imagen) (juntarEnvoltorio (lista-coordenadas (get-ancho imagen) (get-alto imagen) 0 0 null)
          (volverEnvoltorio (agrupar (get-ancho imagen)0(transformar (get-pixeles imagen) null) null null)
        ))))
;--------------Funcion crop--------------
;Dominio: lista(pixeles) x1 x2 lista-salida
;Recorrido: lista-salida
;Descripcion:  filtra la imagen cuando cuanto el alto no está entre x1 y x2
;Tipo de recursion: lineal
(define (filtrar-alto pixeles x1 x2 lista-salida)
  (if(null? pixeles)
     (reverse lista-salida)
   (if(and (>= (car(car pixeles)) x1)(<= (car(car pixeles)) x2))
      (filtrar-alto (cdr pixeles) x1 x2 (cons (car pixeles) lista-salida))
     (filtrar-alto (cdr pixeles) x1 x2 lista-salida)
 )))
;Dominio: lista(pixeles) x1 x2 lista-salida
;Recorrido: lista-salida
;Descripcion:  filtra la imagen cuando cuanto el ancho no está entre y1 e y2
;Tipo de recursion: lineal
(define (filtrar-ancho pixeles y1 y2 lista-salida)
  (if(null? pixeles)
     (reverse lista-salida)
   (if(and (>= (car(cdr(car pixeles))) y1)(<= (car(cdr(car pixeles))) y2))
      (filtrar-ancho (cdr pixeles) y1 y2 (cons (car pixeles) lista-salida))
     (filtrar-ancho (cdr pixeles) y1 y2 lista-salida)
 )))
;---------------------------------------------------------------------------
;Dominio: lista
;Recorrido: cont
;Descripcion:  cuenta el ancho cuando el largo de la nueva imagen recortada es impar
;Tipo de recursion: lineal
(define(anchoImpares lista)
        (define(calcular-ancho-impares lista cont iniciador x)
          (if(null? lista)
             cont
             (if(not(= x iniciador))
                (calcular-ancho-impares (cdr lista) 1 x (car(car lista)))
                (calcular-ancho-impares (cdr lista) (+ cont 1) iniciador (car(car lista))))))
  (calcular-ancho-impares lista 0 (caar lista) (caar lista))
)
;Dominio: lista
;Recorrido: cont
;Descripcion:  cuenta el ancho cuando el largo de la nueva imagen recortada es par
;Tipo de recursion: lineal
(define(anchoPares lista)
  (define(calcular-ancho-pares lista cont iniciador x)
    (if(null? lista)
       (+ cont 1)
       (if(not(= x iniciador))
          (calcular-ancho-pares (cdr lista) 1 x (car(car lista)))
          (calcular-ancho-pares (cdr lista) (+ cont 1) iniciador (car(car lista)))
          )))
  (calcular-ancho-pares lista 1 (caar lista) (caar lista)))
;-----------------------------------------------------
;Dominio: lista
;Recorrido: cont
;Descripcion:  cuenta el alto cuando el largo de la nueva imagen recortada es impar
;Tipo de recursion: lineal
(define(altoImpares lista)
  (define(calcular-alto-impares lista cont iniciador x)
    (if(null? lista)
       (+ cont 1)
       (if(not(= x iniciador))
          (calcular-alto-impares (cdr lista) (+ cont 1) x (car(car lista)))
          (calcular-alto-impares (cdr lista) cont iniciador (car(car lista)))
          )))
  (calcular-alto-impares lista 1 (caar lista) (caar lista)))
;Dominio: lista
;Recorrido: cont
;Descripcion: cuenta el alto cuando el largo de la nueva imagen recortada es par
;Tipo de recursion: lineal
(define(altoPares lista)
  (define(calcular-alto-pares lista cont iniciador x)
    (if(null? (cdr lista))
       (+ cont 1)
       (if(not(= x iniciador))
          (calcular-alto-pares (cdr lista) (+ cont 1) x (car(car lista)))
          (calcular-alto-pares (cdr lista) cont iniciador (car(car lista)))
          )))
  (calcular-alto-pares lista 1 (caar lista) (caar lista)))

;Dominio: imagen x1 y1 x2 y2
;Recorrido: imagen recortada
;Descripcion: agrupa los valores que estan entre las coordenadas que se pide recortar
;Tipo de recursion: no hay
(define(filtrar-puntos imagen x1 y1 x2 y2)
  (filtrar-ancho (filtrar-alto (get-pixeles imagen) x1 x2 null)  y1 y2 null))

;Dominio: imagen x1  y1 x2 y2
;Recorrido: imagen
;Descripcion: Recorta una imagen y le reasigna las posiciones al recorte
;Tipo de recursion: no usa
(define(crop imagen x1 y1 x2 y2)
          (if(odd? (length(filtrar-puntos imagen x1 y1 x2 y2)))
             (if(= 3 (length(filtrar-puntos imagen x1 y1 x2 y2)))
                (list (anchoImpares (filtrar-puntos imagen x1 y1 x2 y2))(altoImpares (filtrar-puntos imagen x1 y1 x2 y2))
                      (juntarEnvoltorio (lista-coordenadas (anchoImpares (filtrar-puntos imagen x1 y1 x2 y2))
                        (altoImpares (filtrar-puntos imagen x1 y1 x2 y2))0 0 null)(transformar (filtrar-puntos imagen x1 y1 x2 y2) null)
                                      ))
              (if(= 1 (length(filtrar-puntos imagen x1 y1 x2 y2)))
                 (list 1 1 (juntarEnvoltorio (lista-coordenadas 1 1 0 0 null)
                (transformar (filtrar-puntos imagen x1 y1 x2 y2) null)
                                      ))
               (list (anchoPares (filtrar-puntos imagen x1 y1 x2 y2))(anchoPares (filtrar-puntos imagen x1 y1 x2 y2))
                     (juntarEnvoltorio (lista-coordenadas (anchoPares (filtrar-puntos imagen x1 y1 x2 y2))
                (anchoPares (filtrar-puntos imagen x1 y1 x2 y2))0 0 null)
                (transformar (filtrar-puntos imagen x1 y1 x2 y2) null))
                                      )))      
             (list (anchoPares (filtrar-puntos imagen x1 y1 x2 y2))(altoPares (filtrar-puntos imagen x1 y1 x2 y2))
                (juntarEnvoltorio (lista-coordenadas (anchoPares (filtrar-puntos imagen x1 y1 x2 y2))
                (anchoPares (filtrar-puntos imagen x1 y1 x2 y2))0 0 null)
                (transformar (filtrar-puntos imagen x1 y1 x2 y2) null)
                                      ))))                
;--------------Funcion imgRGB->imgHex-------
(define hexadecimales (list "0" "1" "2" "3" "4" "5" "6" "7" "8" "9" "A" "B" "C" "D" "E" "E"))
;Dominio: pixeles transformados(hex)
;Recorrido: pixeles tipo hex
;Descripcion: cambia los datos de un rgb y lo transforma a hex y lo mete a una listaq
;Tipo de recursion: lineal
(define (crearHex pixeles transformados)
  (define (cambiar-pixel lista-pixeles lista-hexadecimales lista-salida)
    (if(null? (cdr lista-pixeles))
       (reverse(cons (list (get-x (car lista-pixeles))(get-y (car lista-pixeles))(car lista-hexadecimales)(get-d (car lista-pixeles))) lista-salida))
     (cambiar-pixel (cdr lista-pixeles) (cdr lista-hexadecimales) (cons (list (get-x (car lista-pixeles))(get-y (car lista-pixeles))(car lista-hexadecimales)(get-d (car lista-pixeles)))lista-salida))
       ))
  (cambiar-pixel pixeles transformados null))
;Dominio: lista
;Recorrido: lista-palabras
;Descripcion: convierte los datos de rgb a hex y los guarda en una lista de hex
;Tipo de recursion: lineal
(define(transformarHex lista)
  (define(transformarValores lista lista-actual palabra lista-palabras hexadecimales)
    (if(null? (cdr lista))
       (if(null? lista-actual)
          (reverse(cons palabra lista-palabras))
        (transformarValores lista (cdr lista-actual) (string-append palabra (string-append (list-ref hexadecimales (quotient (car lista-actual) 16))(list-ref hexadecimales (remainder (car lista-actual)16)))) lista-palabras hexadecimales))
    (if(null? lista-actual)
        (transformarValores (cdr lista) (car(cdr lista)) "#" (cons palabra lista-palabras) hexadecimales)
        (transformarValores lista (cdr lista-actual) (string-append palabra (string-append (list-ref hexadecimales (quotient (car lista-actual) 16))(list-ref hexadecimales (remainder (car lista-actual)16)))) lista-palabras hexadecimales)
       )))
  (transformarValores lista (car lista) "#" null hexadecimales))
;Dominio: lista(pixeles)
;Recorrido: lista
;Descripcion: Elimina de todos los pixeles el valor depth
;Tipo de recursion: lineal
(define (filtro-depth lista)
  (define (quitar-depth lista lista-salida)
    (if(null? lista)
       (reverse lista-salida)
       (quitar-depth (cdr lista) (cons (reverse(cdr(reverse(car lista)))) lista-salida))))
  (quitar-depth lista null))
;Dominio: imagen
;Recorrido: imagen
;Descripcion: Transforma una imagen rgb a hex
;Tipo de recursion: no hay
(define(imgRGB->imgHex imagen)
  (list (get-ancho imagen)(get-alto imagen)(crearHex (get-pixeles imagen)(transformarHex(filtro-depth (transformar(get-pixeles imagen)null))))))
;--------------Histogram------

     
(define (histogram imagen)
  (filtro-depth(transformar(get-pixeles imagen)null)))

;--------------Funcion rotate90-------------
(define(agruparEnvoltorio lista ancho alto)
        (define(agrupar-tramos-cuadrados lista lista-aux elemento ancho alto x y lista-salida)
          (if(= (-(* alto alto)alto) x)
             (reverse lista-salida)
             (if(= ancho y)
                (agrupar-tramos-cuadrados  lista lista-aux (cadr lista) ancho alto (+ x 1) 0 (cons elemento lista-salida))
                (if(null? (cdr lista-aux))
                   (agrupar-tramos-cuadrados (cdr lista) (cdr lista) (car(cdr lista)) ancho alto x 0 (cons (car(cdr lista)) lista-salida))
                   (agrupar-tramos-cuadrados lista (cdr lista-aux) (cadr lista-aux) ancho alto x (+ y 1) lista-salida))     
                )))
   (agrupar-tramos-cuadrados lista lista (cons (car lista) null) ancho alto 0 0 null))
;
(define(agruparEnvoltorioNoCuadrados lista ancho alto)
        (define(agrupar-tramos-no lista lista-aux elemento ancho alto x y lista-salida)
          (if(= (-(* alto ancho)ancho) x)
             (reverse lista-salida)
             (if(= ancho y)
                (agrupar-tramos-no  lista lista-aux (cadr lista) ancho alto (+ x 1) 0 (cons elemento lista-salida))
                (if(null? (cdr lista-aux))
                   (agrupar-tramos-no (cdr lista) (cdr lista) (car(cdr lista)) ancho alto x 0 (cons (car(cdr lista)) lista-salida))
                   (agrupar-tramos-no lista (cdr lista-aux) (cadr lista-aux) ancho alto x (+ y 1) lista-salida))     
            
                )))
  (agrupar-tramos-no lista lista (cons (car lista)null) ancho alto 0 0 null))
;
  
(define(separar cantidad i lista lista-agregar lista-salida)
  (if(null? lista)
     (reverse (cons lista-agregar lista-salida))
   (if(= cantidad i)
      (separar cantidad 1 (cdr lista) (cons(car lista) null) (cons lista-agregar lista-salida))
     (separar cantidad (+ i 1) (cdr lista) (cons (car lista) lista-agregar) lista-salida))))

(define(rotate90 imagen)
  (if(=(get-ancho imagen)(get-alto imagen))
     (list (get-ancho imagen) (get-alto imagen) (juntarEnvoltorio (lista-coordenadas (get-ancho imagen) (get-alto imagen) 0 0 null)
                    (volverEnvoltorio(separar (get-ancho imagen) 1 (agruparEnvoltorio (transformar (get-pixeles imagen)null)
                    (get-ancho imagen)(get-alto imagen)) (cons(car(transformar (get-pixeles imagen)null))null) null))))

     (list (get-alto imagen) (get-ancho imagen) (juntarEnvoltorio (lista-coordenadas (get-alto imagen) (get-ancho imagen) 0 0 null)
                    (volverEnvoltorio(separar (get-alto imagen) 1 (agruparEnvoltorioNoCuadrados (transformar (get-pixeles imagen)null)
                    (get-ancho imagen) (get-alto imagen)) (cons(car(transformar (get-pixeles imagen)null))null) null))))))
