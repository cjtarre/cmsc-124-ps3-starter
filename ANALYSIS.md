# Environments and the Toy Evaluator

Form traced:
```lisp
(eval-expr '(let ((x 2))
              (let ((f (lambda (y) (+ x y))))
                (let ((x 100))
                  (f 1))))
           '())
```

The expression begins with an empty environment. When `eval-expr` encounters the outermost `let`, it calls `eval-let`, which evaluates the initial value and uses `extend-env` to bind `x` to `2` before evaluating the body. The next `let` evaluates a lambda expression, which has access to the outer binding of `x`, so it captures that as part of its environment. The resulting closure then binds to `f`. Next, the innermost `let` introduces another binding for `x`, this time with the value `100`. This new binding shadows the earlier one within its body. Evaluation eventually reaches `(f 1)`, where the function stored in `f` is called with the argument `1`.

The defining environment is captured when `eval-expr` encounters the lambda expression and passes the current environment to `make-closure`. The closure stores the parameters, body, and environment in a list with the structure `(:closure params body env)`. At the time of creation, the environment contains `x = 2`, which was introduced by the outer `let`, so this is what gets stored in the closure. The later binding `x = 100` does not exist yet. When the function is called, `apply-closure` uses the saved environment and extends it with the parameter binding `y = 1` before evaluating the function body. 

Under lexical scope, the function uses the environment where it was defined. Therefore, the body `(+ x y)` uses `x = 2` and `y = 1`, producing `3`. However, the caller’s environment contains a newer binding for `x` with the value `100`. If apply-closure used the caller’s environment instead, the expression would evaluate to `101`. This would introduce dynamic scope, where the values of free variables depend on the environment active during a function call rather than the environment where the function was defined.

The toy evaluator also differs from CLISP in how functions are called. Common Lisp is a Lisp-2 because it uses separate namespaces for variables and functions. When a function is stored in a variable, `funcall` is needed to invoke that function value. In contrast, the toy language is a Lisp-1, where variables and functions share one namespace. Its application branch evaluates the operator expression to obtain a closure, evaluates the arguments, and applies the closure directly. This allows `(f 1)` to work without requiring `funcall`.