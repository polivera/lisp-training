;; Simple CD database

;; Create a global variable
;; (The * is a naming convention)
(defvar *db* nil)

;; Function to add a CD record
(defun make-cd (title artist rating ripped)
  (list :title title :artist artist :rating rating :ripped ripped))

;; Use PUSH macro to store a cd on the db global variable
(defun add-record (cd)
  (push cd *db*))

;; Adding some records
(add-record (make-cd "Roses" "Kathy Mattea" 7 t))
(add-record (make-cd "Fly" "Dixie Chicks" 8 t))
(add-record (make-cd "Home" "Dixie Chicks" 7 t))
(add-record (make-cd "Every Rose Has Its Thorns" "Poison" 8 t))
