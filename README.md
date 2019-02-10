# Haskell Workshop - Lambda Days 2019

### Content
- Lenses

## Instructions

### Command line

To compile and execute run:
```
$ stack build
$ stack exec haskell-workshop-ld2019-exe
```

or in one-liner:
```
$ stack build && stack exec haskell-workshop-ld2019-exe
```

### REPL

To use in GHC REPL run:
```
$ stack ghci --only-main
λ main
```
The option `--only-main` imports only main module.
You can skip it, but in that case when you try executing `run` function it will be ambiguous.

You can also run separate examples in `ghci` by:
```
λ Workshop.LensExamples.run
... etc.
```

If you want to work in a scope of a specific module you can use for example:
```
λ :m +Workshop.LensExamples
λ run
```
or simply:
```
λ import Workshop.LensExamples
λ run
```

You can also "unimport" a specific module by:
```
λ :m -Workshop.LensExamples
```

You can inspect your code in for example in following ways:
```
λ :t Point
Point :: a -> a -> Point a
λ :i Point
data Point a = Point {_x :: a, _y :: a}
instance Show a => Show (Point a)
λ :k Point
Point :: * -> *
λ :t x
x :: Functor f => (a -> f a) -> Point a -> f (Point a)
λ :i x
x :: Control.Lens.Type.Lens' (Point a) a
```
Where `:t` stands for type, `:i` for information and `:k` for kind.

You can reload the code after changes with `:r` and quit with `:q`.