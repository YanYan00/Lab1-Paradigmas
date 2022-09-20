#lang racket
(provide (all-defined-out))

(define (TDAimage alto ancho . datos)
  (if (and (integer? alto)(integer? ancho)(>= alto 0)(>= ancho 0))
  (list alto ancho datos)
  (print "ingresa los datos correctamente")))

(define (pixbit-d x y bit depth)
  (if(and(integer? x) (integer? y) (integer? bit)(integer? depth)(or(= 0 bit)(= 1 bit)))
     (list x y bit depth)
   (print "ingresa correctamente los datos")))

(define hola(TDAimage 2 2 (pixbit-d 0 1 0 20) (pixbit-d 1 0 0 30) (pixbit-d 1 1 1 4)))

(define (bitmap? imagen)
  (if(= (*(car imagen)(car(cdr imagen))) (length(car(cddr imagen))))
     (if(and(= 4 (length(car(car(cddr hola))))) (integer? (car(cdr(reverse(car(car(cddr imagen))))))))
        #t
      (#f))
   (#f)))
#;
(define (pixhex-d x y hex d)
  (if(and(integer? x)(integer? y)(string? hex)(integer? d))
     (list x y hex d)
   (print "ingresa correctamente los datos")))
;(define holaa(TDAimage 2 2 (pixhex-d 0 1 "a" 20) (pixhex-d 1 0 "a" 30) (pixhex-d 1 1 "a" 4)))

(define (bitmap?? imagen)
      (if(and(=(length(caaddr imagen))4)(integer? (car(cdr(reverse(car(car(cddr imagen))))))))
         #t
         #f))