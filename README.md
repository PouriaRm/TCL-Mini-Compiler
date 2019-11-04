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

First, Generate a java class with [Jflex](https://jflex.de) from ScannerCup.flex. Then add a new class to the root folder. Now copy the above code and paste it in test.txt. Run the Main.java and see the result.

Here is the answer:

![](https://github.com/PouriaRm/TCL-Mini-Compiler/blob/master/Detailed%20Video/Phase1.gif)

## Syntax Analysis 
I define a class hierarchy to represent nodes in the Abstract Syntax Tree (AST) for TCL programs. This is used to create LL(1) version of context free grammar for TCL. A recursive-descent Parser can parse LL(1) gramar in linear time to create an Abstract Syntax Tree. Java Cup was used as parser for this section.

For example, we should check the following instructions:
```
set a 0
set x 10
set y 5
f { $a} { $a < $x} { Incr $a} {
if { $x > $y} {
puts "Hello World"
}
else {
puts "Bye"
}
}
```
### How to test it?

Like pervious stage.

#### Note: Change the code in above box and trace it again. What will you see?
Here is the answer:

![](https://github.com/PouriaRm/TCL-Mini-Compiler/blob/master/Detailed%20Video/Phase2.gif)

## Semantic Analysis
In this phase, we map (multiple) occurrences of class, method and variable names in a program, to their (unique) definition. Also we should consider Type checking in this phase.

Function comparison in size and type are good examples in this section:
See the code box below:
```
set a 10
set a df
set y 5
proc number { bg h } {
puts "Hello"
}
puts [number bb 2]
```
First, Run it. See the result.

What will happen if we delete this line?
```
set a df
```

what will happen if we change number of parameters?

```
proc number { bg } {
```

or:


```
puts [number bb 2 rb]
```

Here is the answer:


![](https://github.com/PouriaRm/TCL-Mini-Compiler/blob/master/Detailed%20Video/Phase3.gif)

## Question?
Please let me know if you have any questions.

