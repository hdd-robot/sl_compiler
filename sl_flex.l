%{

#include "global.h"
#include "sl_bison.tab.h"

#include <stdlib.h>

%}

blancs    [ \t]+

chiffre   [0-9]
entier    {chiffre}+
exposant  [eE][+-]?{entier}

reel    {entier}("."{entier})?{exposant}?

%%

String                 = Word
                       | ByteLengthEncodedString
                       | StringLiteral


ByteLengthEncodedString = "#" DecimalLiteral+ "\"" <byte sequence>

Word                   [~ "\0x00" - "\0x20", "(", ")", "#", "0" - "9", ":", "-", "?"][~ "\0x00" - "\0x20", "(", ")"]*


ParameterName          ":" String


VariableIdentifier     "?" String


Sign                   [ "+" , "-" ]


Integer                Sign? DecimalLiteral+ | Sign? "0" ["x", "X"] HexLiteral+


Dot                    "."

Float                  = Sign? FloatMantissa FloatExponent? | Sign? DecimalLiteral+ FloatExponent
 

FloatMantissa          = DecimalLiteral+ Dot DecimalLiteral* | DecimalLiteral* Dot DecimalLiteral+


FloatExponent          = Exponent Sign? DecimalLiteral+

Exponent               = ["e","E"].

DecimalLiteral         = ["0" - "9"].

HexLiteral             = ["0" - "9", "A" - "F", "a" - "f"]

StringLiteral          = "\""( [~ "\""] | "\\\"" )*"\""

DateTime               = Sign? Year Month Day "T" Hour Minute Second MilliSecond TypeDesignator?
                         
Year                   = DecimalLiteral DecimalLiteral DecimalLiteral DecimalLiteral
Month                  = DecimalLiteral DecimalLiteral
Day                    = DecimalLiteral DecimalLiteral
Hour                   = DecimalLiteral DecimalLiteral 
Minute                 = DecimalLiteral DecimalLiteral
Second                 = DecimalLiteral DecimalLiteral
MilliSecond            = DecimalLiteral DecimalLiteral DecimalLiteral
TypeDesignator         = ["a" - "z" , "A" – "Z"]

 
