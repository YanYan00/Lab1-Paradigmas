#lang racket
(require "bitmap.rkt")
(define (TDAimage alto ancho . datos)
  (if (and (integer? alto)(integer? ancho)(>= alto 0)(>= ancho 0))
  (list alto ancho  (car datos))
  (print "ingresa los datos correctamente")))

(define hola(TDAimage 1 2 '(1 2 3)))
