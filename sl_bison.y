%{

#include "global.h"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

%}

%token  String ByteLengthEncodedString Word ParameterName VariableIdentifier
%token  Sign Integer Dot Float FloatMantissa FloatExponent Exponent DecimalLiteral
%token  HexLiteral StringLiteral DateTime Year Month Day Hour Minute Second  
%token  MilliSecond TypeDesignator


%start Content
%%

Content:
    /*vide*/
    | "(" Content ContentExpression ")"
    ;
    
ContentExpression:
    IdentifyingExpression
    | ActionExpression
    | Proposition
    ;

Proposition:
    Wff
    ;
 

Wff:
    AtomicFormula
    | "(" UnaryLogicalOp  Wff ")"
    | "(" BinaryLogicalOp Wff Wff ")"
    | "(" Quantifier      Variable Wff ")"
    | "(" ModalOp         Agent Wff ")"
    | "(" ActionOp        ActionExpression ")"
    | "(" ActionOp        ActionExpression Wff ")"
    ;
 

UnaryLogicalOp:
    "not"
    ;
 

BinaryLogicalOp:
    "and"
    | "or"
    | "implies"
    | "equiv"
    ;
 

AtomicFormula:
    PropositionSymbol
    | "(" BinaryTermOp    TermOrIE TermOrIE ")"
    | "(" PredicateSymbol TermOrIE AtomicFormula ")"
    | "true"
    | "false"
    ;
 

BinaryTermOp:
    "="
    | "result"
    ;

Quantifier:
    "forall"
    | "exists"
    ;
 

ModalOp:
    "B"
    | "U"
    | "PG"
    | "I"
    ;
 

ActionOp:
    "feasible"
    | "done"
    ;

 

TermOrIE:
    Term
    | IdentifyingExpression
    ;
 

Term:
    Variable
    | FunctionalTerm
    | ActionExpression
    | Constant
    | Sequence
    | Set
    ;

 

IdentifyingExpression  :
    "(" ReferentialOperator TermOrIE Wff ")"
    ;

 

ReferentialOperator:
    "iota"
    | "any"
    | "all"
    ;
     

FunctionalTerm:
    "(" FunctionSymbol TermOrIE FunctionalTerm ")"
    | "(" FunctionSymbol Parameter FunctionalTerm ")"
    ;

 

Constant:
    NumericalConstant
    | String
    | DateTime
    ;

 

NumericalConstant:
    Integer
    | Float;
    

 

Variable:
    VariableIdentifier
    ;

 

ActionExpression:
    "(" "action" Agent TermOrIE ")"
    | "(" "|" ActionExpression ActionExpression ")"
    | "(" ";" ActionExpression ActionExpression ")"
    ;


PropositionSymbol:
    String;


PredicateSymbol:
    String;


FunctionSymbol:
    String;
 
Agent:
    TermOrIE;
 
Sequence:
    "(" "sequence" TermOrIE Sequence ")";

Set:
    "(" "set" TermOrIE Set ")";

 
Parameter:
    ParameterName ParameterValue;


ParameterValue:
    TermOrIE;

 

%%

int yyerror(char *s) {
  printf("%s\n",s);
}

int main(void) {
  yyparse();
}
