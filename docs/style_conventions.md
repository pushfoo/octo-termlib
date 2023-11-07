# Project Conventions

**This is a WIP technical details page. For quickstart
instructions, see the top of [README.md](../README.md)**

[pyglet]: https://github.com/pyglet/pyglet
[chiplet]: https://github.com/gulrak/chiplet

**TL;DR:** I'm open to feedback on the project's blend of:

* Markdown
* Styles I saw in other Octo projects, such as the [chiplet][chiplet]
  preprocessor.
* [pyglet][pyglet]'s doc style, a variant of Google's Python docstring style.

There's no rendering of the doc data to HTML or Markdown *yet*, but
that may change.

## Table of contents

1. [Includes & Overrides](#includes--overrides)
2. [Register usage](#register-usage)
3. [The `#:` Prefix](#the--prefix)
4. [Names](#names)
5. [Data types](#data-types)
6. [Function Doc Style](#function-doc-style)

## Includes & Overrides

Much like C/C++, this project uses defines to prevent repeating
includes and definitions. These constants use `TERMLIB_` as a
prefix:

| Type         | Example                 | Corresponding guard constant      |
|--------------|-------------------------|-----------------------------------|
| File include | `drawing.8o`            | `:const TERMLIB_DRAWING 1`        |
| Function     | `: handle-newline`      | `:const TERMLIB_HANDLE_NEWLINE 1` |
| Macro        | `:macro use-color {...` | `:const TERMLIB_USE_COLOR 1`      |

You can override certain functions by defining the following
before importing the file which would otherwise define it:

1. A replacement function or macro with the same behavior
2. The corresponding constant, which prevents it from being
   declared by project files

## Register usage:

**TL;DR**:

1. Major functions persist state to memory between calls
2. "returns" means a register which holds a new
    useful value at the end of a function call.
3. "Updates" means the value has the same general kind of
   meaning as before, but the value has been updated to
   reflect current state

| Register range(s)  | Purpose(s)                    | Comments                                      |
|--------------------|-------------------------------|-----------------------------------------------|
| `v0` - `v4`        | Working memory, function args | Can be clobbered between major function calls |
| `vF`               | Return code, temp storage.    | Like +/- ops, returns query results           |

The major functions are expected to persist state to memory locations
between calls. The "_internal" functions may or may not do so, but they
are not intended t be called directly by user code.

### The `#:` Prefix
`#:` is intended to mark comments as about items either:

* immediately before the current line, such as an alias:
  ```
  :const EXAMPLE_1 1 #: This text describes the constant
  ```

* above the current indent
  ```
  :const EXAMPLE_2 2

    #: This text describes the constant above it.
  ``` 

## Names

| Object type        | Naming scheme               |
|--------------------|-----------------------------|
| Function-like      | callables-use-kebab-case    |
| Internal func-like | _internal-subroutine        |
| Data               | data_labels_use_underscores |
| Internal data      | _subcomponent_label         |

### Data types

There's no IDE support (yet?), but I'm using the following
notation so far:

| type name       | meaning                    |
|-----------------|----------------------------|
| `u8`            | unsigned byte              |
| `vN`            | a V register               |
| `const $SYMBOL` | a prefix for another type  |
| `label`         | a label-like object        |
| `u16`           | an unsigned 16 bit integer |
| `void`          | no return                  |

## Function Doc Style

**TL:DR** sort of like [pyglet]'s docstring style, a variant of Google's.

The main differences:
1. `Updates:` indicates registers which are updated for the outside
   world to use, but not the main return value.
2. `Clobbers:` indicates registers may be changed but aren't guaranteed
   to hold values meaningful outside their original context.

An absent `Returns:` field is also assumed to mean `void`.

Example:

```
: example-function-name 

  #: One-line summary of what this function does.
  #:
  #: Optional additional detail paragraphs.
  #:
  #: Args:
  #:   reg_something : data type comment
  #:     Detail lines. There may be one or more of these
  #:     included like in Google's Python Docstring Style.
  #:  arg_name_2 : data type comment
  #:     More example detail lines. 
  #: Updates:
  #:   times_called
  #: Clobbers:
  #:   v0, v1
  #: Returns:
  #:   vF : u8
  #:     Some single integer value. 
  
  # Code here
 
  return  # Indented rather than at the end of a function
```
