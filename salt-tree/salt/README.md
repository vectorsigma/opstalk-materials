# Salt Tree Organization

This salt tree is based around the loose metaphor of combining small things into
larger things.  The basic UNIX philosophy of "do one thing, do it well" and 
"do complex things by composing simpler things".

## Philosophy

Generally, you'll find that if you make your Salt states small and general, your 
states will become composable.  The reason this is important in larger shops, is
that it makes writing more complex states easier, because you end up mostly just
including other states (composing) and using Salt's [Extend](http://docs.saltstack.com/en/latest/topics/tutorials/states_pt3.html#extend-declaration) 
syntax.

## How it's structured

1. `elements/` :: Base level states.  Usually just installs a package, creates a user, or some small, minor, re-usable task.
2. `compounds/` :: Next level states, usually composed of element states, in a slightly more complex (and thus application specific) configuration.
  1. `compounds/common/` :: These are 
3. `materials/` :: Top-level states, composed of compound states and element states in highly specific and most likely complicated configurations, usually applied to a given machine.

