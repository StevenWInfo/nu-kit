# A bunch of important utility functions.

# Unfortunately can't use optional param here since empty param is null which is what we are checking for.
export def null? [val] {
    $val == null
}

# Second command to accomodate for null checking `$in`.
# TODO should this be a flag instead?
export def 'null? in' [] {
    $in == null
}

export def exists? [val] {
    $val != null
}

# Same issue as `null? in`
export def 'exists? in' [] {
    $in != null
}

export def trace [] {
    do { print $in; $in }
}

export def compose [f g] {
    {|...x| do $f (do $g ...$x) }
}

export def 'fn partial' [fn ...params] {
    {|...closure_params| do $fn ...$params ...$closure_params }
}

export def 'fn curry' [
    fn
    arity # Can't infer number of parameters so have to specify.
    ] {
    # TODO 
}

export def 'fn to pipe' [
    fn
    ] {
    {|...it| do $fn $in ...$it }
}

# TODO Problem when `$fn` is called with no extra parameters. Basically no arguments for `$it`. Nushell doesn't handle when spread operator doesn't have arguments. I think that would probably be considered a bug. Want to check beforehand and then submit a bug. Or at least means spread operator needs more work.
# Made a comment about this on an existing bug I'm pretty sure is also about the same root problem: https://github.com/nushell/nushell/issues/11287
export def 'fn from pipe' [
    fn
    ] {
    {|fst, ...it| $fst | do $fn ...$it }
    
}

# y combinator or some better way to do recusion.
export def recurse [] {
}

# TODO add tests
