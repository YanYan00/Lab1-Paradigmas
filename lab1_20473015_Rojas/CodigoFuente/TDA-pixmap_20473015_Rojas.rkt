#lang racket
;--------------Selectores pixrgb-d--------------
(define (get-x x)
  (car x))
(define (get-y x)
  (cadr x))
(define (get-d x)
  (car(reverse x)))
;--------------TdaPixrgb-------------------------
(define (pixrgb-d x y r g b d)
  (if(and (integer? x)(integer? y)(integer? r)(integer? g)(integer? b)(integer? d)
     (and(>= r 0)(<= r 255))(and(>= g 0)(<= g 255))(and(>= b 0)(<= b 255)))
     (list x y r g b d)
   (print "Ingrese correctamente los pixrgb")))

(define (pixmap? imagen)
      (if(and(=(length(caaddr imagen))6))
         #t
         #f))
(provide (all-defined-out))