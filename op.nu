use util.nu *
use std assert

# Providing the operators as commands (and closures hopefully)
# Useful for using as part of pipelines and other uses.

# I'm putting the same interface on everything, even commutative operators, so it's both easier to remember and maybe if there's some way to use commands or flags generically.

# TODO maybe provide streaming versions too? Or have flags to stream them. Or maybe just recommend people use `fn to pipe`.

# TODO decide if having first be right and `$in` be right but first as left and second as right otherwise is too "cute"/clever.

def op [fn
    captured_in: any
    first?: any
    second?: any
    --left (-l): any
    --right (-r): any
    ] {

    let l_and_r = match [$captured_in, $first, $second, $left, $right] {
        [$l $r null null null] => [$l $r],
        [_ $l $r null null] => [$l $r],
        [_ $r _ $l null] => [$l $r],
        [$r null _ $l null] => [$l $r],
        [_ $l _ null $r] => [$l $r],
        [$l null _ null $r] => [$l $r],
        [_ _ _ $l $r] => [$l $r],
    }

    print [$captured_in $first $second $left $right]
    print $l_and_r

    match $l_and_r {
        [null, null] => $fn,
        [$l, null] => ({|inner_r| do $fn $l $inner_r }),
        [null, $r] => ({|inner_l| do $fn $inner_l $r }),
        [$l, $r] => (do $fn $l $r),
    }
}

export def op_add [fst?: int
    snd?: int
    --left (-l): int
    --right (-r): int
    ] {

    op {|l, r|
        $l + $r
    } $in $fst $snd --left=$left --right=$right
}

#[test]
def smoke_test_add [] {
    assert ((op_add 1 2) == 3)
}

#[test]
def flag_test_add [] {
    assert ((op_add --left=1 --right=2) == 3)
}

#[test]
def pipe_test_add [] {
    assert ((1 | op_add 2) == 3)
}

#[test]
def closure_test_add [] {
    assert ((do (op_add) 1 2) == 3)
}

#[test]
def curried_test_add [] {
    assert ((do (op_add 1) 2) == 3)
}

#[test]
def pipe_curried_test_add [] {
    assert ((do (1 | op_add) 2) == 3)
}

#[test]
def pipe_curried_right_test_add [] {
    assert ((do (op_add --right=1) 2) == 3)
}

export def op_in [fst?: any
    snd?: any
    --left (-l): any
    --right (-r): any
    ] {

    let fn = {|l, r|
        $l in $r
    }

    op $fn $in $fst $snd --left=$left --right=$right
}

# ???
export def op_if [] {
}

export def op_for [] {
}
