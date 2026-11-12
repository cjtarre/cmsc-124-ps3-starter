;;;; evaluator.lisp -- Part 2. Write the eight functions below.
;;;;
;;;; The toy language is a Lisp-1. One namespace holds both variables and
;;;; functions, so a variable bound to a closure is callable in operator
;;;; position and (f 1) works with no FUNCALL. The CLISP hosting this file is a
;;;; Lisp-2, which is why the host needs FUNCALL and #' where the toy language
;;;; needs neither. ANALYSIS.md asks you about that difference.
;;;;
;;;; An environment is an association list: ((name . value) (name . value) ...).
;;;; The grader scores E1 to E4 separately, so finish them in order and keep
;;;; every group you get right.
;;;;
;;;; The grammar, in full:
;;;;
;;;;   expr := number
;;;;         | symbol
;;;;         | (+ expr expr) | (- expr expr) | (* expr expr)
;;;;         | (let ((name expr) ...) body)
;;;;         | (lambda (name ...) body)
;;;;         | (operator-expr argument-expr ...)

;;; E1 -- numbers and symbols.

(defun lookup (name env)
  "The value NAME is bound to in ENV.

The first match wins, so an inner binding shadows an outer one that shares its
name. Signal an error when NAME is not bound at all."
  (let ((binding (assoc name env)))
    (if binding
        (cdr binding)
        (error "Unbound variable: ~A" name))))

;;; E2 -- prefix arithmetic.

(defun eval-operands (exprs env)
  "Every expression in EXPRS, evaluated in the same ENV, as a list.

MAPCAR and a LAMBDA do this in one line. Watch the arity: EVAL-EXPR takes two
arguments and MAPCAR hands its function one."
  ; mapcar applies the lambda function one-by-one over all items from exprs 
  ; we use lambda since we need to apply eval-expr onto each item, but mapcar only
  ; hands one argument (expr) to eval-expr when it needs two (both expr and env)
  ; lambda fills the gap by carrying with it the env.
  (mapcar (lambda (expr) (eval-expr expr env)) exprs))

(defun apply-op (op values)
  "Apply the arithmetic operator OP to the two numbers in VALUES.
  OP is the symbol +, -, or *. Signal an error for anything else."
  ; checks if the number of operands are 2
  ; throws an error if more than 2
  ; this is for precaution only
  (unless (= (length values) 2)
    (error "Operand number mismatch: Expected 2, got ~A" (length values)))
  
  ; case checks which operator op is 
  ; then apply calls that operator’s function with the items of values as its arguments
  ; t branch works as a default
  (case op
  (+ (apply #'+ values))
  (- (apply #'- values))
  (* (apply #'* values))
  (t (error "Unknown operator: ~A" op))))

;;; E3 -- let.

(defun extend-env (params args env)
  "ENV with PARAMS bound to ARGS in front of it.

MAPCAR takes two lists and #'CONS pairs them. Build a new list. Do not modify
ENV, because the caller keeps using it after the extension goes out of scope."
  (append (mapcar #'cons params args) env))

(defun eval-let (expr env)
  "Evaluate (let ((name init) ...) body).

Every init is evaluated in ENV before any name is bound, so the bindings happen
in parallel and an init cannot see a name the same LET introduces."
  (let ((bindings (second expr)))
    (let ((params (mapcar #'first bindings))
          (args (eval-operands
                 (mapcar #'second bindings)
                 env)))
      (eval-expr (third expr)
                 (extend-env params args env)))))

;;; E4 -- lambda and application.

(defun make-closure (params body env)
  "A closure over ENV.

Return the list (:closure params body env). ENV is the environment the lambda
was written in, not the one it will later be called from. Saving the wrong one
is what makes the difference between 3 and 101 in the case the manual walks
through."
  ; builds a plain four-element list
  ; it captures the current environment at its creation
  (list :closure params body env))

(defun apply-closure (closure args)
  "Run CLOSURE on ARGS.

The parameters join the environment the closure captured. Signal an error when
CLOSURE is not a closure, and when the argument count does not match."
  ; check if list is really a list (consp) and first item is a :closure
  ; signal error if not
  (unless (and (consp closure) (eq (first closure) :closure))
    (error "Not a closure: ~A" closure))
  ; unpacks params
  (let ((params (second closure))
      ; unpacks body
      (body (third closure))
      ; unpacks captured-env
      (captured-env (fourth closure)))
    ; check if argument count matches
    ; signal error if not
    (unless (= (length params) (length args))
      (error "Argument count mismatch: expected ~A, got ~A" (length params) (length args)))
    ; runs body in the captured environment plus the new parameter bindings
    (eval-expr body (extend-env params args captured-env))))

;;; The dispatcher.

(defun eval-expr (expr env)
  "The value of EXPR in ENV.

Order the branches with care. NIL is a symbol as well as the empty list, and a
number is not a cons, so the atom tests come before the list tests."
  (cond
    ; e1 : number evaluates to itself
    ((numberp expr)
      expr)

    ; e1 : looks up value of a symbol which is a variable name
    ; comes before list check because nil is a symbol
    ((symbolp expr)
      (lookup expr env))

    ; e2 : if first item of a list is an operator, evaluate the rest of the list
    ; and hand results to apply-op
    ((member (car expr) '(+ - *))
      (apply-op (car expr) (eval-operands (cdr expr) env)))

    ;; e3 : if first item of a list is let, send it to eval-let
    ((eq (car expr) 'let)
      (eval-let expr env))

    ; e4 : if first item of a list is a lambda,
    ; pack the parameters, body, and current environment into one list
    ; via make-closure
    ((eq (car expr) 'lambda)
      (make-closure (second expr) (third expr) env))

    ; e4 : any other list is a function call
    ; evaluate first item to get closure (line 157)
    ; evaluate the rest to get arguments
    ; then call apply-closure
    ((consp expr)
      (let ((closure (eval-expr (car expr) env))
          (args (eval-operands (cdr expr) env)))
        (apply-closure closure args)))
    
    ; anything else is an error
    (t
      (error "Unsupported expression: ~A" expr))))
