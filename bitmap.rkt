#lang racket
(provide (all-defined-out))
(define (bitmap x)
  x)

(define (pixbit-d x y bit depth)
  (if(and(integer? x) (integer? y) (integer? bit)(integer? depth)(or(= 0 bit)(= 1 bit)))
     (list x y bit depth)
   (print "ingresa correctamente los datos")))
      

