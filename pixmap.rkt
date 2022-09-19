#lang racket
(define (pixmap x)
  x)
(define (pixrgb-d x y r g b d)
  (if(and (integer? x)(integer? y)(integer? r)(integer? g)(integer? b)(integer? d))
     (list x y r g b d)
   (print "Ingrese correctamente los datos")))