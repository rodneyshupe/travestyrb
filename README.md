# Travesty in Ruby

This analyzes input text and then randomly generates text output based on pattern probability using a character-level Markov chain model.

My first exposure to this algorithm was via a Pascal version published in
[BYTE November 1984](https://www.scribd.com/doc/99613420/Travesty-in-Byte)
([alt reference](https://archive.org/stream/byte-magazine-1984-11/1984_11_BYTE_09-12_New_Chips#page/n129/mode/2up)).
Since then I have implemented this algorithm as a learning tool for new
languages. Besides this implementation, I have done implementations in
*HP Basic*,
*Diabol*,
*Cobol*,
*PL1*,
*Plus*,
*C*,
*Visual Basic*,
*Java*,
*Perl*,
*Node.js*,
[*Bash*](https://github.com/rodneyshupe/travestysh),
[*Rust*](https://github.com/rodneyshupe/travestyrs),
*Python*,
and probably a few I have forgotten.

## Algorithm

This is a free interpretation of the Travesty algorithm by Hugh Kenner and
Joseph O'Rourke discussed in BYTE, and conceptually related to ideas in
"[Richard A. O’Keefe - An introduction to Hidden Markov Models](https://www.cs.otago.ac.nz/cosc348/hmm/hmm.pdf)".

> A kth-order travesty generator keeps a “left context” of k symbols. Here
> k = 3, one context is “fro”. At each step, we find all the places in the
> text that have the same left context, pick one of them at random, emit the
> character we find there, and shift the context one place to the left.
> ...
> A Travesty generator can never generate any (local) combination it has not
> seen; it cannot generalise.

## Getting Started

Clone this repo and run the `travesty.rb` script from the command line:

```sh
ruby travesty.rb --file sample.txt --pattern 9 --length 2000
```

To wrap lines at 50 characters:

```sh
ruby travesty.rb -f sample.txt -p 9 -l 2000 -w 50
```

To write the output to a file:

```sh
ruby travesty.rb -f sample.txt -p 9 -l 2000 -w 50 -o output.txt
```

## Command-line Options

```text
Usage: ruby travesty.rb [options]

    -f, --file FILE                Input text file (required)
    -p, --pattern N                Pattern length (n-gram), default: 9
    -l, --length N                 Number of characters to output, default: 2000
    -w, --wrap N                   Wrap output at N characters per line (optional)
    -o, --output FILE              Write output to specified file (optional)
```

## Attributions

* `sample.txt` - Extract of sonets from
  [bbejeck](https://github.com/bbejeck/hadoop-algorithms/blob/master/src/shakespeare.txt)'s
  *Complete Works of Shakespeare* text file.
* `adventure.txt` - Extract from Crowther, Will, and D. Woods.
  [Adventure](http://mirror.ifarchive.org/if-archive/games/source/adv350-pdp10.tar.gz)
  (aka "ADVENT" and "Colossal Cave") FORTRAN source code. 1977.
  