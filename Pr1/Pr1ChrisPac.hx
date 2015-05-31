// Christopher Pac
//
// Compiler Construction Spring 2015 Project Milestone 1
//

module nyu.cc.cpp270.project.Pr1ChrisPac {

/* LEXICAL ANALYSIS */
// 2.1 Definition

space [ \t\n\r] | "//".* | "/*" ( [^*] | [\n\r] | ("*"+ ( [^*/] | [\n\r] )))* "*"+ "/" ;


// Integer
token INT | ⟨Digit⟩+ ;

// Identifier
token ID | ( ⟨Letter⟩ | ⟨LetterDollarOrUnderscore⟩ )+ ( ⟨Letter⟩ | ⟨LetterDollarOrUnderscore⟩ | ⟨Digit⟩ )* ;

// String
token STR | \' ( [^\'\\\n] | \\ ⟨Escape⟩ )* \' | \" ( [^\"\\\n] | \\ ⟨Escape⟩ )* \" ;

token fragment LetterDollarOrUnderscore | [$_] ; // extra characters allowed in Identifier
token fragment Letter | [a-zA-Z] ;
token fragment Digit  | [0-9] ;
token fragment HexDigit | [0-9a-fA-F] ;
token fragment HexEscape | 'x' ⟨HexDigit⟩ ⟨HexDigit⟩ ;
token fragment Escape | ⟨HexEscape⟩ | [nt] | "\n" | \' | \" | \\ ; // bug in HACS \'" should always be escaped 

/* SYNTAX ANALYSIS. */

// 2.2 Definition -- Expression

sort Expression 
| ⟦ ⟨Expression@1⟩ , ⟨Expression⟩ ⟧
| ⟦ ⟨SubExpression⟩ ⟧@1
;

sort SubExpression | ⟦ ⟨SExp⟩ ⟧ | ⟦ ⟨AExp⟩ ⟧ ;

// AExp
// Advanced Expression
// Uses Object Literal
// DOES NOT define assignment production
//
sort AExp 
//| ⟦ ⟨AExp@1⟩ , ⟨Expression⟩ ⟧

| ⟦ ⟨AExp@2⟩ || ⟨AExp@3⟩ ⟧@2
| ⟦ ⟨AExp@3⟩ && ⟨AExp@4⟩ ⟧@3

| ⟦ ⟨AExp@5⟩ != ⟨AExp@5⟩ ⟧@5
| ⟦ ⟨AExp@5⟩ == ⟨AExp@5⟩ ⟧@5

| ⟦ ⟨AExp@6⟩ < ⟨AExp@6⟩ ⟧@6
| ⟦ ⟨AExp@6⟩ > ⟨AExp@6⟩ ⟧@6
| ⟦ ⟨AExp@6⟩ <= ⟨AExp@6⟩ ⟧@6
| ⟦ ⟨AExp@6⟩ >= ⟨AExp@6⟩ ⟧@6

| ⟦ ⟨AExp@7⟩ - ⟨AExp@8⟩ ⟧@7
| ⟦ ⟨AExp@7⟩ + ⟨AExp@8⟩ ⟧@7

| ⟦ ⟨AExp@8⟩ * ⟨AExp@9⟩ ⟧@8
| ⟦ ⟨AExp@8⟩ / ⟨AExp@9⟩ ⟧@8
| ⟦ ⟨AExp@8⟩ % ⟨AExp@9⟩ ⟧@8

| ⟦ +⟨AExp@9⟩ ⟧@9
| ⟦ -⟨AExp@9⟩ ⟧@9
| ⟦ !⟨AExp@9⟩ ⟧@9

| ⟦ ⟨AExp@10⟩( ⟨Expression⟩ ) ⟧@10
| ⟦ ⟨AExp@10⟩() ⟧@10
| ⟦ ⟨AExp@10⟩( ) ⟧@10
| ⟦ ⟨AExp@10⟩.⟨ID⟩ ⟧@10

| ⟦ ⟨ObjectLiteral⟩ ⟧@11
| ⟦ this ⟧@11
| ⟦ ⟨ID⟩ ⟧@11
| sugar ⟦ (⟨AExp#⟩) ⟧@11 → AExp#
;

// SExp
// Simple Expression
// Uses Plain Literal
// defines assignment production
//
sort SExp 
//| ⟦ ⟨SExp@1⟩ , ⟨Expression⟩ ⟧

| ⟦ ⟨SExp@2⟩ +=  ⟨Expression⟩ ⟧@1
| ⟦ ⟨SExp@2⟩ =  ⟨Expression⟩ ⟧@1

| ⟦ ⟨SExp@2⟩ || ⟨SExp@3⟩ ⟧@2
| ⟦ ⟨SExp@3⟩ && ⟨SExp@4⟩ ⟧@3

| ⟦ ⟨SExp@5⟩ != ⟨SExp@5⟩ ⟧@5
| ⟦ ⟨SExp@5⟩ == ⟨SExp@5⟩ ⟧@5

| ⟦ ⟨SExp@6⟩ < ⟨SExp@6⟩ ⟧@6
| ⟦ ⟨SExp@6⟩ > ⟨SExp@6⟩ ⟧@6
| ⟦ ⟨SExp@6⟩ <= ⟨SExp@6⟩ ⟧@6
| ⟦ ⟨SExp@6⟩ >= ⟨SExp@6⟩ ⟧@6

| ⟦ ⟨SExp@7⟩ - ⟨SExp@8⟩ ⟧@7
| ⟦ ⟨SExp@7⟩ + ⟨SExp@8⟩ ⟧@7

| ⟦ ⟨SExp@8⟩ * ⟨SExp@9⟩ ⟧@8
| ⟦ ⟨SExp@8⟩ / ⟨SExp@9⟩ ⟧@8
| ⟦ ⟨SExp@8⟩ % ⟨SExp@9⟩ ⟧@8

| ⟦ +⟨SExp@9⟩ ⟧@9
| ⟦ -⟨SExp@9⟩ ⟧@9
| ⟦ !⟨SExp@9⟩ ⟧@9

| ⟦ ⟨SExp@10⟩( ⟨Expression⟩ ) ⟧@10
| ⟦ ⟨SExp@10⟩() ⟧@10
| ⟦ ⟨SExp@10⟩( ) ⟧@10
| ⟦ ⟨SExp@10⟩.⟨ID⟩ ⟧@10

| ⟦ ⟨PlainLiteral⟩ ⟧@11
| ⟦ this ⟧@11
| ⟦ ⟨ID⟩ ⟧@11
| sugar ⟦ (⟨SExp#⟩) ⟧@11 → SExp#
;


sort Literal |  ⟦ ⟨PlainLiteral⟩ ⟧ | ⟦ ⟨ObjectLiteral⟩ ⟧ ;
sort PlainLiteral | ⟦ ⟨INT⟩ ⟧ | ⟦ ⟨STR⟩ ⟧ ;
sort ObjectLiteral | ⟦ {} ⟧ |  ⟦ { } ⟧ | ⟦ {⟨FieldList⟩} ⟧ ;
sort FieldList | ⟦ ⟨FieldList⟩ , ⟨LiteralField⟩ ⟧ | ⟦ ⟨LiteralField⟩ ⟧@1 ;
sort LiteralField | ⟦ ⟨ID⟩ : ⟨SubExpression⟩ ⟧ ;

// 2.3 Definition

sort Type
| ⟦ boolean ⟧
| ⟦ int ⟧
| ⟦ string ⟧
| ⟦ void ⟧
| ⟦ ⟨ID⟩ ⟧
;

// 2.4 Definition -- Statements
sort Statement | ⟦ ⟨Substatement⟩ ⟧ | ⟦ { ⟨Substatements⟩ } ⟧ | ⟦ { } ⟧ | ⟦ {} ⟧ ;

sort Substatements | ⟦ ⟨Substatement⟩ ⟧ | ⟦ ⟨Substatement⟩ ⟨Substatements⟩ ⟧ ;

sort Substatement
| ⟦ if ( ⟨Expression⟩ ) ⟨Statement⟩ ⟨ElseStatement⟩ ⟧
| ⟦ while (⟨Expression⟩) ⟨Statement⟩ ⟧
| ⟦ ⟨Expression⟩ ; ⟧
| ⟦ return ⟨Expression⟩ ; ⟧
| ⟦ var ⟨Type⟩ ⟨ID⟩ ; ⟧
| ⟦ return ; ⟧
| ⟦ ; ⟧
;

sort AllStatements | ⟦ ⟨Statement⟩ ⟧ | ⟦ ⟨Statement⟩ ⟨AllStatements⟩ ⟧ ;

sort ElseStatement | ⟦ else ⟨Statement⟩ ⟧ | ⟦  ⟧ ;

// 2.5 Definition -- Declaration

sort Declaration | ⟦ ⟨ClassDeclaration⟩ ⟧ | ⟦ ⟨FunctionDeclaration⟩ ⟧ ;

// Class Declaration
sort ClassDeclaration | ⟦ class ⟨ID⟩ { ⟨Members⟩ }  ⟧ ;
sort Members |  ⟦ ⟨Member⟩ ⟧ | ⟦ ⟨Member⟩ ⟨Members⟩ ⟧ ;
sort Member | ⟦ ⟨Type⟩ ⟨ID⟩ ; ⟧ | ⟦ ⟨Type⟩ ⟨ID⟩ ⟨ArgumentSignature⟩ { ⟨AllStatements⟩ } ⟧ ;

sort FunctionDeclaration | ⟦ function ⟨Type⟩ ⟨ID⟩ ⟨ArgumentSignature⟩ { ⟨AllStatements⟩ } ⟧ ;
sort ArgumentSignature | ⟦ ( ⟨Parameters⟩ ) ⟧ | ⟦ (  ) ⟧ | ⟦ () ⟧ ; // () is treated as one token

sort Parameters | ⟦ ⟨Parameter⟩ ⟧ | ⟦ ⟨Parameter⟩ , ⟨Parameters⟩ ⟧ ;
sort Parameter | ⟦ ⟨Type⟩ ⟨ID⟩ ⟧ ;

// 2.6 Definition -- Program

sort Program | ⟦ ⟨Declaration⟩ ⟧ | ⟦ ⟨Declaration⟩ ⟨Program⟩ ⟧ ;

}
