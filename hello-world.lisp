;; Hello World in list

(defun hello-world ()
  (format t "hello from a function"))

(getf (list :foo 1 :bar 2 :baz 3) :foo)
