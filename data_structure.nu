use util.nu *

## Queue (first in, first out [FIFO])

# TODO also have a [out, new_queue] form with a flag.
export def 'queue shift' [queue] {
    { out: ($queue | first),
      new_queue: ($queue | skip 1) }
}

## Stack (last in, first out [LIFO])

### Pop

# TODO also have a [out, new_stack] form with a flag.
export def 'stack pop' [stack] {
    { out: ($stack | last),
      new_stack: ($stack | drop) }
}

# Inserting a new element
export def 'set insert' [elem
    maybe_set?
    ] {
    let set = if (null? $maybe_set) { $in } else { $maybe_set }

    if $elem not-in $set {
        $set | append $elem
    }
}

# Union
# Maybe use op.nu's `op`
export def 'set union' [set_l set_r] {

    $set_l ++ $set_r | uniq
}

# Intersection
export def 'set intersection' [set_l set_r] {
    $set_l | filter { |elem| $elem in $set_r }
}

# Difference
# $set - $set_b
export def 'set difference' [set_l set_r] {
    $set_l | filter { |elem| $elem not-in $set_r }
}

# Symmetric Difference
export def 'set symmetric difference' [set_l set_r] {
    $set_l ++ $set_r | uniq --unique
}

# Result: [1 4 5]

### Multiset (bag)

# Pretty much the same as a list but you can get the counts of the multiset elements with

# [1 2 2 3] | uniq --count

# Result:
# ╭───┬───────┬───────╮
# │ # │ value │ count │
# ├───┼───────┼───────┤
# │ 0 │     1 │     1 │
# │ 1 │     2 │     2 │
# │ 2 │     3 │     1 │
# ╰───┴───────┴───────╯

# The unique values along with how many times they are in the multiset/bag.
