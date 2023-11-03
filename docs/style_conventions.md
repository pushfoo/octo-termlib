# Project Conventions

[pyglet]: https://github.com/pyglet/pyglet

**TL;DR:** an evolving hybrid of the following:

* Markdown
* Styles I saw in other Octo projects
* [pyglet][pyglet]'s doc style,
  which is a variant of Google's Python docstring style.

I'm open to feedback. At some point, I might write scripts or
adapters to render this to some endpoint as friendly HTML / text.

## Table of contents:

1. [Register usage](#register-usage)
2. [The `#:` Prefix](#the--prefix)
3. [Names](#names)
4. [Data types](#data-types)
5. [Function Doc Style](#function-doc-style)

## Comment types

## Register usage:

**TL;DR**:

1. Major functions persist state to memory between calls
2. "returns" is interpreted as any register which holds a 
   useful value at the end of a function call.

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

There's no IDE support (yet?), but I'm using the following so
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
