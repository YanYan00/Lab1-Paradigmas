#lang racket
(provide (all-defined-out))

(define (pixbit-d x y bit depth)
  (if(and(integer? x) (integer? y) (integer? bit)(integer? depth)(or(= 0 bit)(= 1 bit)))
     (list x y bit depth)
   (print "ingresa correctamente los pixbit")))

(define (bitmap? imagen)
      (if(and(=(length(caaddr imagen))4)(integer? (car(cdr(reverse(car(car(cddr imagen))))))))
         #t
         #f))