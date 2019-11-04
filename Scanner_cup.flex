import java_cup.runtime.Symbol;
import java_cup.runtime.ComplexSymbolFactory;
import java_cup.runtime.ComplexSymbolFactory.Location;
import java.io.*;

%%
%public
%class ScannerCUP
%cup
%type Symbol
%function next_token
%type java_cup.runtime.Symbol
%eofval{
  return new java_cup.runtime.Symbol(sym.EOF);
%eofval}
%eofclose
%line
%column

%{
      StringBuffer string = new StringBuffer();
  /* To create a new java_cup.runtime.Symbol with information about
       the current token, the token will have no value in this
       case. */
    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }
    
    /* Also creates a new java_cup.runtime.Symbol with information
       about the current token, but this object has a value. */
    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }
  
	  private Symbol symbol(String name, int sym, Object val,int buflength) {
      return new Symbol(sym, yyline, yycolumn, val);
  }
%}

Ident = [a-zA-Z$_] [a-zA-Z0-9$_]*
IntLiteral = 0 | [1-9][0-9]*
BoolLiteral = true | false
new_line = \r|\n|\r\n;
white_space = {new_line} | [ \t\f]

%state STRING

%%

<YYINITIAL>{
/* keywords */
"set"             { return symbol(sym.TYPE); }
"if"              { return symbol(sym.IF); }
"else"            { return symbol(sym.ELSE); }
"for"           { return symbol(sym.FOR); }
"read"            { return symbol(sym.READ); }
"puts"           { return symbol(sym.PUTS); }
"proc"           { return symbol(sym.PROC); }

/* names */
{Ident}           { return symbol(sym.IDENT, yytext()); }

/* bool literal */
{BoolLiteral} { return symbol(sym.BOOLCONST, new Boolean(Boolean.parseBool(yytext()))); }

/* literals */
{IntLiteral} { return symbol(sym.INTCONST, new Integer(Integer.parseInt(yytext()))); }

/* separators */
  \"              { string.setLength(0); yybegin(STRING); }
";"               { return symbol(sym.SEMICOLON); }
","               { return symbol(sym.COMMA); }
"("               { return symbol(sym.LPAR); }
")"               { return symbol(sym.RPAR); }
"{"               { return symbol(sym.BEGIN); }
"}"               { return symbol(sym.END); }
"="               { return symbol(sym.ASSIGN); }
"+"               { return symbol(sym.BINOP ); }
"-"               { return symbol(sym.BINOP ); }
"*"               { return symbol(sym.BINOP); }
"/"               { return symbol(sym.BINOP ); }
"%"               { return symbol(sym.BINOP ); }
"<="              { return symbol(sym.COMP ); }
">="              { return symbol(sym.COMP ); }
"=="              { return symbol(sym.COMP); }
"!="              { return symbol(sym.COMP ); }
"<"               { return symbol(sym.COMP); }
">"               { return symbol(sym.COMP); }
"&&"              { return symbol(sym.BBINOP); }
"||"              { return symbol(sym.BBINOP); }
"!"               { return symbol(sym.BUNOP); }
"["              { return symbol(sym.LB); }
"]"               { return symbol(sym.RB); }


{white_space}     { /* ignore */ }

}

<STRING> {
  \"                             { yybegin(YYINITIAL); 
      return symbol(sym.STRINGCONST,string.toString()); }
  [^\n\r\"\\]+                   { string.append( yytext() ); }
  \\t                            { string.append('\t'); }
  \\n                            { string.append('\n'); }

  \\r                            { string.append('\r'); }
  \\\"                           { string.append('\"'); }
  \\                             { string.append('\\'); }
}

<<EOF>>				{return symbol(sym.EOF);}
/* error fallback */
.|\n              {  /* throw new Error("Illegal character <"+ yytext()+">");*/
		    System.err.println("Illegal character <"+ yytext()+">");
                  }