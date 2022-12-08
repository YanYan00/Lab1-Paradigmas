#lang racket

(require "TDA-bitmap_20473015_Rojas.rkt")
(require "TDA-hexmap_20473015_Rojas.rkt")
(require "TDA-pixmap_20473015_Rojas.rkt")
(require "TDA-image_20473015_Rojas.rkt")
;---------------------------------------Ejemplo general----------------------------------------
(display "Ejemplo lab")(display"\n")
(define img1 (image 2 2
                  (pixrgb-d 0 0 255 0 0 10)
                  (pixrgb-d 0 1 0 255 0 20)
                  (pixrgb-d 1 0 0 0 255 10)
                  (pixrgb-d 1 1 255 255 255  1))
 )
(define img2 (image 2 2
                  (pixbit-d 0 0 0 10)
                  (pixbit-d 0 1 1 20)
                  (pixbit-d 1 0 1 10)
                  (pixbit-d 1 1 0 255))
 )
(define img3 (imgRGB->imgHex img1))
(bitmap? img1) ; la respuesta debería ser #f
(bitmap? img2)  ; la respuesta debería ser #t
(bitmap? img3)  ; la respuesta debería ser #f

(pixmap? img1) ; la respuesta debería ser #t
(pixmap? img2)  ; la respuesta debería ser #f
(pixmap? img3)  ; la respuesta debería ser #f

(hexmap? img1) ; la respuesta debería ser #f
(hexmap? img2)  ; la respuesta debería ser #f
(hexmap? img3)  ; la respuesta debería ser #t

(compressed? img1) ; la respuesta debería ser #f
(compressed? img2) ; la respuesta debería ser #f
(compressed? img3) ; la respuesta debería ser #f

(flipH img1)
(flipH img2)
(flipH img3)

(flipV img1)
(flipV img2)
(flipV img3)

(histogram img2)

(define img4 (rotate90 img1))
(define img5 (rotate90 img2))
(define img6 (rotate90 img3))

img4
img5
img6
;---------------------------------------Primer ejemplo-----------------------------------------
(display "Primer Ejemplo")(display"\n")
;Creación de una imagen de 3 x 3 del tipo pixmap
(define img7 (image 3 3
                  (pixrgb-d 0 0 255 0 0 10)
                  (pixrgb-d 0 1 0 255 0 20)
                  (pixrgb-d 0 2 0 0 255 10)
                  (pixrgb-d 1 0 255 5 255  1)
                  (pixrgb-d 1 1 255 2 255  1)
                  (pixrgb-d 1 2 255 56 255  1)
                  (pixrgb-d 2 0 255 25 255  1)
                  (pixrgb-d 2 1 255 55 255  1)
                  (pixrgb-d 2 2 255 255 255  1)))

;Creación de una imagen de 3 x 3 del tipo bitmap
(define img8 (image 3 3
                  (pixbit-d 0 0 0 10)
                  (pixbit-d 0 1 1 20)
                  (pixbit-d 0 2 1 10)
                  (pixbit-d 1 0 1 10)
                  (pixbit-d 1 1 0 20)
                  (pixbit-d 1 2 1 10)
                  (pixbit-d 2 0 1 10)
                  (pixbit-d 2 1 1 10)
                  (pixbit-d 2 2 1 10)))

(bitmap? img7) ; la respuesta debería ser #f
(bitmap? img8)  ; la respuesta debería ser #t

(pixmap? img7) ; la respuesta debería ser #t
(pixmap? img8)  ; la respuesta debería ser #f

(hexmap? img7) ; la respuesta debería ser #f
(hexmap? img8)  ; la respuesta debería ser #f

(compressed? img7) ; la respuesta debería ser #f
(compressed? img8) ; la respuesta debería ser #f

img7
img8

(flipH img7)
(flipH img8)

(flipV img7)
(flipV img8)


(define img9 (crop img7 0 0 1 1)) ; debería retornar una imágen con 4 pixel
(define img10 (crop img8 0 0 2 1)) ; debería retornar una imágen con 6 pixeles
(define img11 (imgRGB->imgHex img7)); debería retornar una imágen hex
img9
img10
img11
(histogram img8)

(define img12 (rotate90 img7));crea una imagen rotada en 90* de la img7
(define img13 (rotate90 img8));crea una imagen rotada en 90* de la img8

img12
img13

;-------------------------------------------Segundo Ejemplo---------------------------------------------
(display "Segundo Ejemplo")(display"\n")
;Creación de una imagen de 2 x 3 del tipo pixmap
(define img14 (image 2 3
                  (pixrgb-d 0 0 255 0 0 10)
                  (pixrgb-d 0 1 0 255 0 20)
                  (pixrgb-d 1 0 0 0 255 10)
                  (pixrgb-d 1 1 255 5 255  1)
                  (pixrgb-d 2 0 255 2 255  1)
                  (pixrgb-d 2 1 255 56 255  1)))
(define img15 (imgRGB->imgHex img14))
;Creación de una imagen de 2 x 3 del tipo bitmap
(define img16 (image 2 3
                  (pixbit-d 0 0 0 10)
                  (pixbit-d 0 1 1 20)
                  (pixbit-d 1 0 1 10)
                  (pixbit-d 1 1 1 10)
                  (pixbit-d 2 0 0 20)
                  (pixbit-d 2 1 1 10)))

img14
img15
img16
(bitmap? img14) ; la respuesta debería ser #f
(bitmap? img15)  ; la respuesta debería ser #f
(bitmap? img16)  ; la respuesta debería ser #t

(pixmap? img14) ; la respuesta debería ser #t
(pixmap? img15)  ; la respuesta debería ser #f
(pixmap? img16)  ; la respuesta debería ser #f

(hexmap? img14) ; la respuesta debería ser #f
(hexmap? img15)  ; la respuesta debería ser #t
(hexmap? img16)  ; la respuesta debería ser #f

(compressed? img14) ; la respuesta debería ser #f
(compressed? img15) ; la respuesta debería ser #f
(compressed? img16) ; la respuesta debería ser #f


(flipH img14)
(flipH img15)
(flipH img16)

(flipV img14)
(flipV img15)
(flipV img16)


(define img17 (crop img14 1 0 2 1)) ; debería retornar una imágen con 4 pixel
(define img18 (crop img15 0 0 0 0)) ; debería retornar una imágen con 1 pixeles
img17
img18
(histogram img16)

(define img19 (rotate90 img14));crea una imagen rotada en 90* de la img14
(define img20 (rotate90 img15));crea una imagen rotada en 90* de la img15
(define img21 (rotate90 img16));crea una imagen rotada en 90* de la img16
img19
img20
img21


(provide (all-defined-out))