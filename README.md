# TCL-Mini-Compiler
It's a mini compiler for [TCL programming language](https://www.tcl.tk/about/language.html). In this repository, each section is examined with an example video.

## Lexical Analysis
Separate a stream of characters into different tokens of the language which are described by using regular expressions. I constructed regular expressions to describe token types of [TCL](https://www.tcl.tk/about/language.html) and used it as input for JFlex to generate a Lexer.

For example, we should check the following instructions:
```
for 2
2 : 2
set tempt = 2
if temp > 0
puts tempt
```
These are the steps to take and the result:

![](https://github.com/PouriaRm/TCL-Mini-Compiler/blob/master/Detailed%20Video/Phase1.gif)
