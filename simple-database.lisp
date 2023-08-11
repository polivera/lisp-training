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

;; Print database
(defun dump-db ()
  (dolist (cd *db*)
    (format t "~{~a:~10t~a~%~}~%" cd)))

;; Create a Prompt function
(defun prompt-read (prompt)
  ;; Use format to emit the prompt. The *query-io* global variable
  ;; contains the input stream connected to the terminal.
  (format *query-io* "~a: " prompt)
  ;; This is necessary in some implementations to ensure that lisp
  ;; does not wait for a new line
  (force-output *query-io*)
  ;; Read a single line of text
  (read-line *query-io*))

;; Prompt for CD information
(defun prompt-for-cd ()
  (make-cd
   (prompt-read "Title")
   (prompt-read "Artist")
   ;; This line state the following instruction
   ;; - Read the rating from the user input (prompt)
   ;; - Try to parse what you read to an integer value
   ;; - If you can't get an int from the user input, don't throw
   ;;   an error (:junk-allowed). Instead, return nil
   ;; - If the result of parse-int is 'nil', put zero instead (or macro)
   (or (parse-integer (prompt-read "Rating") :junk-allowed t) 0)
   ;; This is like prompt read but repeat until y or n answer
   (y-or-n-p "Ripped?")))

;; Create a loop to input data
(defun add-cds ()
  ;; Create a loop that store information into *db* variable (add-record)
  ;; that is collected from user input (prompt-for-cd) and returned as a list
  ;; (make-cd)
  (loop (add-record (prompt-for-cd))
	(if (not (y-or-n-p "Another?")) (return))))

;; Store *db* data to disk
(defun save-db (filename)
  (with-open-file (out filename
		       :direction :output
		       :if-exist :supersede)
    (with-standard-io-syntax
      (print *db* out))))
