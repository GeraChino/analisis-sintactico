
   
import java_cup.runtime.*;
      
%%
%class Lexer

%line
%column
%cup
   

%{   
    
    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }
    
    private Symbol symbol(int type, Object value) {

        if(type == sym.ID)
            Variables.initializeVariable((String)value);

        return new Symbol(type, yyline, yycolumn, value);
    }
    
%}
   
LineTerminator = \r|\n|\r\n
WhiteSpace     = {LineTerminator} | [ \t\f]

dec_int_lit = 0 | [1-9][0-9]*("."[1-9][0-9]*)?
dec_int_id = [A-Za-z_][A-Za-z_0-9]*
 
%%  
   /* YYINITIAL is the state */
   
<YYINITIAL> {
   
    ";"                { return symbol(sym.SEMI); }
    "+"                { System.out.print(" + "); return symbol(sym.PLUS); }
    "-"                { System.out.print(" - "); return symbol(sym.MINUS); }
    "*"                { System.out.print(" * "); return symbol(sym.TIMES); }
    "/"                { System.out.print(" / "); return symbol(sym.DIVIDE); }
    "("                { System.out.print(" ( "); return symbol(sym.LPAREN); }
    ")"                { System.out.print(" ) "); return symbol(sym.RPAREN); }
    "="                { System.out.print(" = "); return symbol(sym.EQ);}
   
    {dec_int_lit}      { System.out.print(yytext());
                         return symbol(sym.NUMBER, new Integer(yytext())); }
   
    {dec_int_id}       { System.out.print(yytext());
                         return symbol(sym.ID, yytext());}
   
    {WhiteSpace}       { /* do nothing */ }   
}

[^]                    { throw new Error("Illegal character <"+yytext()+">"); }
