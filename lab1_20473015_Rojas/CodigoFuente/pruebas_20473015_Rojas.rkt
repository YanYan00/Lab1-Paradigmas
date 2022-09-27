#lang racket

(require "TDA-bitmap_20473015_Rojas.rkt")
(require "TDA-hexmap_20473015_Rojas.rkt")
(require "TDA-pixmap_20473015_Rojas.rkt")
(require "TDA-image_20473015_Rojas.rkt")

;---------------------------------------Primer ejemplo-----------------------------------------
(display "Primer Ejemplo")(display"\n")
;Creación de una imagen de 2 x 2 del tipo pixmap
(define img1 (image 2 2
                  (pixrgb-d 0 0 255 0 0 10)
                  (pixrgb-d 0 1 0 255 0 20)
                  (pixrgb-d 1 0 0 0 255 10)
                  (pixrgb-d 1 1 255 255 255  1)
 ))

;Creación de una imagen de 2 x 2 del tipo bitmap
(define img2 (image 2 2
                  (pixbit-d 0 0 0 10)
                  (pixbit-d 0 1 1 20)
                  (pixbit-d 1 0 1 10)
                  (pixbit-d 1 1 0 255))
 )

(bitmap? img1) ; la respuesta debería ser #f
(bitmap? img2)  ; la respuesta debería ser #t

(pixmap? img1) ; la respuesta debería ser #t
(pixmap? img2)  ; la respuesta debería ser #f

(hexmap? img1) ; la respuesta debería ser #f
(hexmap? img2)  ; la respuesta debería ser #f

(compressed? img1) ; la respuesta debería ser #f
(compressed? img2) ; la respuesta debería ser #f

img1
img2

(flipH img1)
(flipH img2)

(flipV img1)
(flipV img2)


(define img4 (crop img1 0 0 0 0)) ; debería retornar una imágen con un pixel
(define img5 (crop img2 0 0 0 1)) ; debería retornar una imágen con dos pixeles



img4
img5


;-------------------------------------------Segundo Ejemplo---------------------------------------------
(display "Segundo Ejemplo")(display"\n")
;Creación de una imagen de 2 x 2 del tipo pixmap
(define immg1 (image 2 2
                  (pixrgb-d 0 0 235 152 48 10)
                  (pixrgb-d 0 1 153 255 22 20)
                  (pixrgb-d 1 0 0 0 212 10)
                  (pixrgb-d 1 1 43 15 10  1)
 ))

;Creación de una imagen de 2 x 2 del tipo hexmap
(define immg2 (image 2 2
                  (pixhex-d 0 0 "#F1D5D5" 10)
                  (pixhex-d 0 1 "#F3D0D0" 20)
                  (pixhex-d 1 0 "#CFA6A6" 10)
                  (pixhex-d 1 1 "#B29595" 255))
 )

(bitmap? immg1) ; la respuesta debería ser #f
(bitmap? immg2)  ; la respuesta debería ser #f

(pixmap? immg1) ; la respuesta debería ser #t
(pixmap? immg2)  ; la respuesta debería ser #f

(hexmap? immg1) ; la respuesta debería ser #f
(hexmap? immg2)  ; la respuesta debería ser #t

(compressed? immg1) ; la respuesta debería ser #f
(compressed? immg2) ; la respuesta debería ser #f

immg1
immg2

(flipH immg1)
(flipH immg2)

(flipV immg1)
(flipV immg2)


(define immg4 (crop immg1 0 0 0 1)) ; debería retornar una imágen con dos pixel
(define immg5 (crop immg2 0 0 0 0)) ; debería retornar una imágen con un pixeles
(define immg6 (crop immg1 0 1 1 1)) ; debería retornar una imágen con dos pixeles
(define immg7 (crop immg2 1 0 1 1)) ; debería retornar una imágen con dos pixeles

immg4
immg5
immg6
immg7

(provide (all-defined-out))