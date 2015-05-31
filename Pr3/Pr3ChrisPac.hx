// [NYU Courant Institute] Compiler Construction/Spring 2015/Project Milestone 3 -*-hacs-*-

/*
*** Chris Pac
**  cpp270
**  4/30/2015
*/

// 1. Lexical analysis
// 2. JST Grammar
// 3. MinARM32 assembler grammar
// 4. Compiler
//
// See http://cs.nyu.edu/courses/spring15/CSCI-GA.2130-001/pr3/pr3.pdf
//
// References:
//
// * JST: JST Syntax specification
//   in http://cs.nyu.edu/courses/spring15/CSCI-GA.2130-001/pr1/pr1.pdf.

module edu.nyu.cs.cc.Pr3ChrisPac {

  
////////////////////////////////////////////////////////////////////////
// 1. LEXICAL ANALYSIS
////////////////////////////////////////////////////////////////////////


// TOKENS (JST 2.1).

space [ \t\n\r] | '//' [^\n]* | '/*' ( [^*] | '*' [^/] )* '*/'  ; // Inner /* ignored

token ID  | ⟨LetterEtc⟩ (⟨LetterEtc⟩ | ⟨Digit⟩)* ;

token INT     | ⟨Digit⟩+ ;

token fragment Letter     | [A-Za-z] ;
token fragment LetterEtc  | ⟨Letter⟩ | [$_] ;
token fragment Digit      | [0-9] ;

 
////////////////////////////////////////////////////////////////////////
// 2. JST GRAMMAR
////////////////////////////////////////////////////////////////////////

 
// PROGRAM (JST 2.6)

main sort Program  |  ⟦ ⟨Declarations⟩ ⟧ ;

// DECLARATIONS (JST 2.5)

sort Declarations | ⟦ ⟨Declaration⟩ ⟨Declarations⟩ ⟧ | ⟦⟧ ;

sort Declaration
|  ⟦ class ⟨ID⟩ { ⟨Members⟩ } ⟧
|  ⟦ function ⟨Type⟩ ⟨Identifier⟩ ⟨ArgumentSignature⟩ { ⟨Statements⟩ } ⟧
;

sort Members | ⟦ ⟨Member⟩ ⟨Members⟩ ⟧ | ⟦⟧ ;

sort Member
|  ⟦ ⟨Type⟩ ⟨ID⟩ ; ⟧
;

sort ArgumentSignature
|  ⟦ ( ) ⟧
|  ⟦ ( ⟨Type⟩ ⟨Identifier⟩ ⟨TypeIdentifierTail⟩ ) ⟧
;
sort TypeIdentifierTail |  ⟦ , ⟨Type⟩ ⟨Identifier⟩ ⟨TypeIdentifierTail⟩ ⟧  |  ⟦ ⟧ ;

// STATEMENTS (JST 2.4)

sort Statements | ⟦ ⟨Statement⟩ ⟨Statements⟩ ⟧ | ⟦⟧ ;

sort Statement
|  ⟦ { ⟨Statements⟩ } ⟧
|  ⟦ var ⟨Type⟩ ⟨Identifier⟩ ; ⟧
|  ⟦ ; ⟧
|  ⟦ ⟨Expression⟩ ; ⟧
|  ⟦ if ( ⟨Expression⟩ ) ⟨IfTail⟩ ⟧
|  ⟦ while ( ⟨Expression⟩ ) ⟨Statement⟩ ⟧
|  ⟦ return ⟨Expression⟩ ; ⟧
|  ⟦ return ; ⟧
;

sort IfTail | ⟦ ⟨Statement⟩ else ⟨Statement⟩ ⟧ | ⟦ ⟨Statement⟩ ⟧ ;

// TYPES (JST 2.3)

sort Type
|  ⟦ int ⟧
|  ⟦ void ⟧
|  ⟦ ⟨ID⟩ ⟧
;

// EXPRESSIONS (JST 2.2)

sort Expression

|  sugar ⟦ ( ⟨Expression#e⟩ ) ⟧@10 → #e

|  ⟦ ⟨Integer⟩ ⟧@10
|  ⟦ ⟨Identifier⟩ ⟧@10

|  ⟦ ⟨Expression@9⟩ ( ) ⟧@9
|  ⟦ ⟨Expression@9⟩ ( ⟨Expression⟩ ) ⟧@9
|  ⟦ ⟨Expression@9⟩ . ⟨ID⟩ ⟧@9

|  ⟦ ! ⟨Expression@8⟩ ⟧@8
|  ⟦ - ⟨Expression@8⟩ ⟧@8
|  ⟦ + ⟨Expression@8⟩ ⟧@8

|  ⟦ ⟨Expression@7⟩ * ⟨Expression@8⟩ ⟧@7

|  ⟦ ⟨Expression@6⟩ + ⟨Expression@7⟩ ⟧@6
|  ⟦ ⟨Expression@6⟩ - ⟨Expression@7⟩ ⟧@6

|  ⟦ ⟨Expression@6⟩ < ⟨Expression@6⟩ ⟧@5
|  ⟦ ⟨Expression@6⟩ > ⟨Expression@6⟩ ⟧@5
|  ⟦ ⟨Expression@6⟩ <= ⟨Expression@6⟩ ⟧@5
|  ⟦ ⟨Expression@6⟩ >= ⟨Expression@6⟩ ⟧@5

|  ⟦ ⟨Expression@5⟩ == ⟨Expression@5⟩ ⟧@4
|  ⟦ ⟨Expression@5⟩ != ⟨Expression@5⟩ ⟧@4

|  ⟦ ⟨Expression@3⟩ && ⟨Expression@4⟩ ⟧@3

|  ⟦ ⟨Expression@2⟩ || ⟨Expression@3⟩ ⟧@2

|  ⟦ ⟨Expression@2⟩ = ⟨Expression@1⟩ ⟧@1
|  ⟦ ⟨Expression@2⟩ = ⟨ObjectLiteral⟩ ⟧@1

|  ⟦ ⟨Expression@1⟩ , ⟨Expression⟩ ⟧
;

sort ObjectLiteral  |  ⟦ { } ⟧  |  ⟦ { ⟨KeyValue⟩ ⟨KeyValueTail⟩ } ⟧ ;
sort KeyValueTail   |  ⟦ , ⟨KeyValue⟩ ⟨KeyValueTail⟩ ⟧  |  ⟦ ⟧ ;
sort KeyValue       |  ⟦ ⟨ID⟩ : ⟨Expression@1⟩ ⟧ ;

sort Integer  |   ⟦ ⟨INT⟩ ⟧ ;
sort Identifier  |  symbol ⟦⟨ID⟩⟧ ;

 
////////////////////////////////////////////////////////////////////////
// 3. MinARM32 ASSEMBLER GRAMMAR
////////////////////////////////////////////////////////////////////////

 
// Instructions.
sort Instructions | ⟦ ⟨Instruction⟩ ⟨Instructions⟩ ⟧ | ⟦⟧ ;

sort Instruction
| ⟦ DEF ⟨ID⟩ = ⟨Integer⟩ ¶⟧		// define identifier
| ⟦ ⟨Label⟩ ⟧ 		 		// define address label
| ⟦ DCI ⟨Integers⟩ ¶⟧			// allocate integers
| ⟦ ⟨Op⟩ ¶⟧	  			// machine instruction
;

sort Integers | ⟦ ⟨Integer⟩, ⟨Integers⟩ ⟧ | ⟦ ⟨Integer⟩ ⟧ ;

sort Label | symbol ⟦⟨ID⟩⟧ ;
 
// Syntax of individual machine instructions.
sort Op

| ⟦ MOV ⟨Reg⟩, ⟨Arg⟩ ⟧			// move
| ⟦ MVN ⟨Reg⟩, ⟨Arg⟩ ⟧			// move not
| ⟦ ADD ⟨Reg⟩, ⟨Reg⟩, ⟨Arg⟩ ⟧		// add
| ⟦ SUB ⟨Reg⟩, ⟨Reg⟩, ⟨Arg⟩ ⟧		// subtract
| ⟦ RSB ⟨Reg⟩, ⟨Reg⟩, ⟨Arg⟩ ⟧		// reverse subtract
| ⟦ AND ⟨Reg⟩, ⟨Reg⟩, ⟨Arg⟩ ⟧		// bitwise and
| ⟦ ORR ⟨Reg⟩, ⟨Reg⟩, ⟨Arg⟩ ⟧		// bitwise or
| ⟦ EOR ⟨Reg⟩, ⟨Reg⟩, ⟨Arg⟩ ⟧		// bitwise exclusive or
| ⟦ CMP ⟨Reg⟩, ⟨Arg⟩ ⟧	    		// compare
| ⟦ MUL ⟨Reg⟩, ⟨Reg⟩, ⟨Reg⟩ ⟧		// multiply

| ⟦ B ⟨Identifier⟩ ⟧			// branch always
| ⟦ BEQ ⟨Identifier⟩ ⟧			// branch if equal
| ⟦ BNE ⟨Identifier⟩ ⟧			// branch if not equal
| ⟦ BGT ⟨Identifier⟩ ⟧			// branch if greater than
| ⟦ BLT ⟨Identifier⟩ ⟧			// branch if less than
| ⟦ BGE ⟨Identifier⟩ ⟧			// branch if greater than or equal
| ⟦ BLE ⟨Identifier⟩ ⟧			// branch if less than or equal
| ⟦ BL ⟨Identifier⟩ ⟧			// branch and link

| ⟦ LDR ⟨Reg⟩, ⟨Mem⟩ ⟧			// load register from memory
| ⟦ STR ⟨Reg⟩, ⟨Mem⟩ ⟧			// store register to memory

| ⟦ LDMFD ⟨Reg⟩! , {⟨Regs⟩} ⟧ 		// load multiple fully descending (pop)
| ⟦ STMFD ⟨Reg⟩! , {⟨Regs⟩} ⟧		// store multiple fully descending (push)
;

// Arguments.

sort Reg	| ⟦R0⟧ | ⟦R1⟧ | ⟦R2⟧ | ⟦R3⟧ | ⟦R4⟧ | ⟦R5⟧ | ⟦R6⟧ | ⟦R7⟧
     		| ⟦R8⟧ | ⟦R9⟧ | ⟦R10⟧ | ⟦R11⟧ | ⟦R12⟧ | ⟦SP⟧ | ⟦LR⟧ | ⟦PC⟧ ;

sort Arg | ⟦⟨Constant⟩⟧ | ⟦⟨Reg⟩⟧ | ⟦⟨Reg⟩, LSL ⟨Constant⟩⟧ | ⟦⟨Reg⟩, LSR ⟨Constant⟩⟧ ;

sort Mem | ⟦ [ ⟨Reg⟩, ⟨Sign⟩ ⟨Arg⟩ ] ⟧ ;
sort Sign | ⟦+⟧ | ⟦-⟧ | ⟦⟧ ;

sort Regs | ⟦⟨Reg⟩⟧ | ⟦⟨Reg⟩, ⟨Regs⟩⟧ | ⟦⟨Reg⟩-⟨Reg⟩, ⟨Regs⟩⟧ ;

sort Constant | ⟦#⟨Integer⟩⟧ | ⟦&⟨ID⟩⟧ ;

// Assembler helper: concatenation/flattening of code:
sort Instructions | scheme ⟦ { ⟨Instructions⟩ } ⟨Instructions⟩ ⟧ ;
⟦ {} ⟨Instructions#⟩ ⟧ → # ;
⟦ {⟨Instruction#1⟩ ⟨Instructions#2⟩} ⟨Instructions#3⟩ ⟧
  → ⟦ ⟨Instruction#1⟩ {⟨Instructions#2⟩} ⟨Instructions#3⟩ ⟧ ;


////////////////////////////////////////////////////////////////////////
// 4. COMPILER
////////////////////////////////////////////////////////////////////////


// Main scheme.
sort Instructions  |  scheme Compile(Program) ;
Compile(#1) → P2(P1(#1), #1) ;
 
// PASS 1:

// Result sort for first pass, with join operation.
sort After1 | Data1(Instructions, MT, FT) | scheme Join1(After1, After1) ;
Join1(Data1(#1, #mt1, #ft1), Data1(#2, #mt2, #ft2))
  → Data1(⟦ { ⟨Instructions#1⟩ } ⟨Instructions#2⟩ ⟧, AppendMT(#mt1, #mt2), AppendFT(#ft1, #ft2)) ;

// Member to type environment (list of pairs with append).
sort MT | NoMT | MoreMT(ID, Type, MT) | scheme AppendMT(MT, MT) ;
AppendMT(NoMT, #mt2) → #mt2 ;
AppendMT(MoreMT(#id1, #T1, #mt1), #mt2) → MoreMT(#id1, #T1, AppendMT(#mt1, #mt2)) ;
 
// Function to return type environment (list of pairs with append).
sort FT | NoFT | MoreFT(Identifier, Type, FT) | scheme AppendFT(FT, FT) ;
AppendFT(NoFT, #ft2) → #ft2 ;
AppendFT(MoreFT(#id1, #T1, #ft1), #ft2) → MoreFT(#id1, #T1, AppendFT(#ft1, #ft2)) ;

// Pass 1 recursion.
sort After1 | scheme P1(Program) ;
P1(⟦⟨Declarations#Ds⟩⟧) → P1Ds(#Ds) ;

sort After1 | scheme P1Ds(Declarations);
P1Ds(⟦⟨Declaration#D⟩ ⟨Declarations#Ds⟩⟧) → Join1(P1D(#D), P1Ds(#Ds)) ;
P1Ds(⟦⟧) → Data1(⟦⟧, NoMT, NoFT) ;

sort After1 | scheme P1D(Declaration) ;
P1D(⟦ class ⟨ID#C⟩ { ⟨Members#Ms⟩ } ⟧) → P1Ms(#C, #Ms, ⟦0⟧) ;
P1D(⟦ function ⟨Type#T⟩ ⟨Identifier#f⟩ ⟨ArgumentSignature#As⟩ { ⟨Statements#S⟩ } ⟧)
  → Data1(⟦⟧, NoMT, MoreFT(#f, #T, NoFT)) ;

sort After1 | scheme P1Ms(ID, Members, Computed) ;
P1Ms(#C, ⟦ ⟨Type#T⟩ ⟨ID#m⟩ ; ⟨Members#Ms⟩ ⟧, #x)
  → Join1(P1MemberOffset(MemberOffset(#C, #m), #x, #T), P1Ms(#C, #Ms, ⟦#x+4⟧)) ;
P1Ms(#C, ⟦⟧, #x) → P1ClassSize(#C, #x) ;

// Helper to generate offset directive and mapping.
sort After1 | scheme P1MemberOffset(Computed, Computed, Type) ;
P1MemberOffset(#id, #x, #T)
  → Data1(⟦ DEF ⟨ID#id⟩ = ⟨INT#x⟩ ⟧, MoreMT(#id, #T, NoMT), NoFT) ;

// Helper to generate offset directive and mapping.
sort After1 | scheme P1ClassSize(Computed, Computed) ;
P1ClassSize(#C, #x) → Data1(⟦ DEF ⟨ID ClassSize(#C)⟩ = ⟨INT#x⟩ ⟧, NoMT, NoFT) ;

// Helper to generate name for class member offset.
sort Computed | scheme MemberOffset(ID, ID) ;
MemberOffset(#C, #m) → ⟦ #C @ "_" @ #m ⟧ ; 

// Helper to compute name for class size.
sort Computed | scheme ClassSize(ID) ;
ClassSize(#C) → ⟦ #C @ "__size" ⟧ ;

// PASS 2:
/*
*** Helper function to get the next register for general computations
*/
sort Reg | scheme NextReg(Reg);
NextReg(⟦R0⟧)  → ⟦R1⟧;
NextReg(⟦R1⟧)  → ⟦R2⟧;
NextReg(⟦R2⟧)  → ⟦R3⟧;
NextReg(⟦R3⟧)  → ⟦R4⟧;
NextReg(⟦R4⟧)  → ⟦R5⟧;
NextReg(⟦R5⟧)  → ⟦R6⟧;
NextReg(⟦R6⟧)  → ⟦R7⟧;
NextReg(⟦R7⟧)  → ⟦R8⟧;
NextReg(⟦R8⟧)  → ⟦R9⟧;
NextReg(⟦R9⟧)  → ⟦R10⟧;
NextReg(⟦R10⟧)  → ⟦R11⟧;
NextReg(⟦R11⟧)  → error⟦out of registers⟧;

/*
*** Type and location structure. Each local function variable has a type and location where its 
**  stored on the stack. The Integer is the offset into the stack. The offset is from the Frame Pointer.
*/
sort TL | TypeLoc(Type, Integer);

// map of local variables to type and location.
sort VD | NoVD | MoreVD(Identifier, TL, VD) | scheme AppendVD(VD, VD);
AppendVD(NoVD, #vd2) → #vd2 ;
AppendVD(MoreVD(#id1, #tl1, #vd1), #vd2) → MoreVD(#id1, #tl1, AppendVD(#vd1, #vd2)) ;

// lookup function that returns the offset into the stack where a variable is located 
sort Integer | scheme VDLookupX(VD, Identifier);
VDLookupX(MoreVD(#id, TypeLoc(#t, #x), #m) , #id) → #x;
VDLookupX(NoVD, #id) → ⟦404⟧;											// NOTE: Should really do the error
default VDLookupX(MoreVD(#id1, #tl, #m), #id2) → VDLookupX(#m, #id2);

// lookup function that returns the type of a local variable 
sort Type | scheme VDLookupT(VD, Identifier);
VDLookupT(MoreVD(#id, TypeLoc(#t, #x), #m) , #id) → #t;
VDLookupT(NoVD, #id) → ⟦ void ⟧;											// NOTE: Should really do the error
default VDLookupT(MoreVD(#id1, #tl, #m), #id2) → VDLookupT(#m, #id2);

/*
*** A function that returns the type of a function OR the type of a local variable.
*   The function first looks in the function/type map and if it doesn't find it there then it looks
*   in the local variable/type map.
*/
sort Type | scheme LookupT(Env, Identifier);
LookupT(EnvConst(#vd, #mt, MoreFT(#id, #t, #mf)), #id) → #t;
LookupT(EnvConst(#vd, #mt, NoFT), #id) → VDLookupT(#vd, #id);	
default LookupT(EnvConst(#vd, #mt, MoreFT(#id, #t, #mf)), #id2) → LookupT(EnvConst(#vd, #mt, #mf), #id2);

/*
*** Environment sort that has a structure which bundles all three maps.
**  VD - the local Variable to type and location map
**  MT - class Member to type map
**  FT - Function name to type map
*/
sort Env | EnvConst(VD, MT, FT); 

// *** STARTS HERE ***
sort Instructions | scheme P2(After1, Program) ;
P2(Data1(#1, #mt1, #ft1), #P) → ⟦ { ⟨Instructions#1⟩ } ⟨Instructions Pe(#P, EnvConst(NoVD, #mt1, #ft1))⟩  ⟧ ;

sort Instructions | scheme Pe(Program, Env);
Pe(⟦⟨Declarations#Ds⟩⟧, #e1) → Dse(#Ds, #e1) ;

sort Instructions | scheme Dse(Declarations, Env);
Dse(⟦⟨Declaration#D⟩ ⟨Declarations#Ds⟩⟧, #e1) → ⟦ { ⟨Instructions De(#D, #e1)⟩ } ⟨Instructions Dse(#Ds, #e1)⟩ ⟧;
Dse(⟦⟧, #e1) → ⟦⟧ ;

sort Instructions | scheme De(Declaration, Env);
De(⟦ class ⟨ID#1⟩ { ⟨Members#Ms⟩ } ⟧, #e1) → ⟦⟧ ;

// fend is a label to jump to the end of the function
De(⟦ function ⟨Type#T⟩ f ⟨ArgumentSignature#As⟩ { ⟨Statements#S⟩ } ⟧, EnvConst(#vd1, #mt1, #ft1))
  → ⟦ {f} 
  LDMFD SP!, {R4, R5, R6, R7, R8, R9, R10, R11, LR} 
  MOV R12, SP 
  {⟨Instructions As(#As, ⟦R0⟧)⟩} 
  {⟨Instructions Sse(#S, EnvConst(AsE(#As, #vd1, ⟦0-4⟧), #mt1, #ft1), AsC(#As, ⟦0⟧), ⟦fend⟧)⟩} 
  {fend} 
  MOV SP, R12 
  LDMFD SP!, {R4, R5, R6, R7, R8, R9, R10, R11, PC} ⟧ ;

//  Computed parameter is the CURRENT offset from FP; Label is the label at the end of a function
sort Instructions | scheme Sse(Statements, Env, Computed, Label);

/*
*** SeC function calculates the new offset. The offset will ONLY change if it's the 'var' Statement
**  otherwise the same offset is returned. Therefore, unlike the reference solution we dont pass -4 but
**  the function returns offset-4 iff it's a 'var' statement.
*** SeE function extends the environment map (the VD map) iff it's a 'var' statement otherwise unchanged
**  env is returned.
*/
Sse(⟦ ⟨Statement#S⟩ ⟨Statements#Ss⟩ ⟧, #e1, #x, ⟦ l ⟧) → ⟦ {⟨Instructions Se(#S, #e1, SeC(#S, #x), ⟦ l ⟧)⟩} {⟨Instructions Sse(#Ss, SeE(#S, #e1, SeC(#S, #x)), SeC(#S, #x), ⟦ l ⟧)⟩} ⟧ ;
Sse(⟦⟧, #e1, #x, #l) → ⟦⟧ ;

sort Instructions | scheme Se(Statement, Env, Computed, Label); // the label is just so we can do the [return ]

Se(⟦ var ⟨Type#1⟩ ⟨Identifier#2⟩ ; ⟧, #e1, #x, ⟦ l ⟧) → ⟦ADD SP,R12,#⟨INT#x⟩⟧ ;

Se(⟦ ⟨Expression#E⟩ ; ⟧, #e1, #x, ⟦ l ⟧) → ⟦ {⟨Instructions EeR(#E, ⟦R4⟧, #e1)⟩} ⟧;

Se( ⟦ ; ⟧, #e1, #x, ⟦ l ⟧) → ⟦⟧;

Se(⟦ while ( ⟨Expression#E⟩ ) ⟨Statement#S⟩ ⟧, #e1, #x, ⟦ l ⟧) 
	→ ⟦ b
	{⟨Instructions Be(#E, ⟦ lt ⟧, ⟦ lf ⟧, #e1)⟩}
	lt	
	{⟨Instructions Se(#S, #e1, #x, ⟦ l ⟧)⟩}	
	B b
	lf⟧;
	
Se(⟦ return ⟨Expression#E⟩ ; ⟧, #e1, #x, ⟦ l ⟧) → ⟦{⟨Instructions EeR(#E, ⟦R4⟧, #e1)⟩} MOV R0, R4 B l⟧;

Se( ⟦ return ; ⟧, #e1, #x, ⟦ l ⟧) → ⟦B l⟧;

/*
*** Since the offset is the CURRENT offset, and not offset-4, we need to restore SP to this current
**  offset from the FP before any changes were done to SP inside the Statements.
*/
Se(⟦ { ⟨Statements#Ss⟩ } ⟧, #e1, #x, ⟦ l ⟧) → ⟦ {⟨Instructions Sse(#Ss, #e1, #x, ⟦ l ⟧)⟩} ADD SP,R12,#⟨INT#x⟩⟧;

Se( ⟦ if ( ⟨Expression#E⟩ ) ⟨IfTail#It⟩ ⟧, #e1, #x, ⟦ l ⟧) 
  → ⟦ {⟨Instructions Be(#E, ⟦ lt ⟧, ⟦ lf ⟧, #e1)⟩}
  lt  
  {⟨Instructions It(#It, #e1, #x, ⟦ l ⟧, ⟦ lf ⟧)⟩}
  ⟧;


/*
*** First label is the one for [return]
*** Second label is the false case
*/
sort Instructions | scheme It(IfTail, Env, Computed, Label, Label);
It(⟦ ⟨Statement#1⟩ else ⟨Statement#2⟩ ⟧, #e1, #x, ⟦ l ⟧, ⟦ lf ⟧) 
  → ⟦ {⟨Instructions Se(#1, #e1, #x, ⟦ l ⟧)⟩}
  B ln
  lf {⟨Instructions Se(#2, #e1, #x, ⟦ l ⟧)⟩}
  ln ⟧;
  
It(⟦ ⟨Statement#1⟩ ⟧, #e1, #x, ⟦ l ⟧, ⟦ lf ⟧) 
  → ⟦ {⟨Instructions Se(#1, #e1, #x, ⟦ l ⟧)⟩}
  lf ⟧;

/*
*** The EeR function takes the Expression, register and environment.
**  Reg - is the target register where the results should be stored.
*/
sort Instructions | scheme EeR(Expression, Reg, Env);
EeR( ⟦ ⟨Integer#1⟩ ⟧, ⟦ ⟨Reg#r⟩ ⟧, #e1) 
  → Immediable(CmpImmediable(#1,⟦MOV ⟨Reg#r⟩,#⟨Integer#1⟩⟧,⟦LDR ⟨Reg#r⟩, [PC, #0] MOV PC, PC DCI ⟨Integer#1⟩⟧ ));

// Helper functions to decide if a constant integer value is immediable or not.
sort Computed | scheme CmpImmediable(Integer, Instructions, Instructions);
CmpImmediable(⟦ ⟨INT#n⟩ ⟧, #ii, #id) → ⟦ #n < 256 ? #ii : #id ⟧;

sort Instructions | scheme Immediable(Computed);
Immediable(#n) → #n;

// load the local variable from the stack based on its offset from the FP
EeR( ⟦ ⟨Identifier#1⟩ ⟧ , ⟦ ⟨Reg#r⟩ ⟧, EnvConst(#vd1, #mt1, #ft1)) → ⟦LDR ⟨Reg#r⟩,[R12,#⟨INT VDLookupX(#vd1, #1)⟩ ]⟧;

// load the value based on its class member offset from its base address
EeR(⟦ ⟨Expression#1⟩ . ⟨ID#2⟩ ⟧ , ⟦ ⟨Reg#r⟩ ⟧, #e1) 
  → ⟦ {⟨Instructions EeR(#1, #r, #e1)⟩} 
  LDR ⟨Reg#r⟩,[⟨Reg#r⟩,&⟨ID ClassMember( EeT(#1,#e1), #2)⟩]⟧;


// The first expression better be a function name (i.e. Identifier). 
// We have a helper synthesized attribute to get the function name identifier
EeR(⟦ ⟨Expression#1 ↑id(⟦ fn ⟧)⟩ ( ⟨Expression#2⟩ ) ⟧, ⟦ ⟨Reg#r⟩ ⟧, #e1) 
  → ⟦ STMFD SP!,{R0, R1, R2, R3, R12}
  {⟨Instructions EeR(#2, #r, #e1)⟩}
  {⟨Instructions FnArgHelper(#2, ⟦R0⟧ ,#r)⟩}
  BL fn  
  MOV ⟨Reg#r⟩, R0 
  LDMFD SP!,{R0, R1, R2, R3, R12}⟧;

EeR(⟦ ⟨Expression#1 ↑id(⟦ fn ⟧)⟩ ( ) ⟧, ⟦ ⟨Reg#r⟩ ⟧, #e1) 
  → ⟦ STMFD SP!,{R0, R1, R2, R3, R12}
  BL fn  
  MOV ⟨Reg#r⟩, R0 
  LDMFD SP!,{R0, R1, R2, R3, R12}⟧;

EeR(⟦ - ⟨Expression#1⟩ ⟧, ⟦ ⟨Reg#r⟩ ⟧, #e1) → ⟦ {⟨Instructions EeR(#1, #r, #e1)⟩} RSB ⟨Reg#r⟩,⟨Reg#r⟩,#0 ⟧;

EeR(⟦ + ⟨Expression#1⟩ ⟧, ⟦ ⟨Reg#r⟩ ⟧, #e1) → ⟦ {⟨Instructions EeR(#1, #r, #e1)⟩} ⟧;

EeR(⟦ ⟨Expression#1⟩ * ⟨Expression#2⟩ ⟧, ⟦ ⟨Reg#r⟩ ⟧, #e1)
  → ⟦ {⟨Instructions EeR(#1, #r, #e1)⟩} 
  {⟨Instructions EeR(#2, NextReg(#r), #e1)⟩} 
  MUL ⟨Reg#r⟩, ⟨Reg#r⟩, ⟨Reg NextReg(#r)⟩ ⟧;

EeR(⟦ ⟨Expression#1⟩ + ⟨Expression#2⟩ ⟧, ⟦ ⟨Reg#r⟩ ⟧, #e1) 
  → ⟦ {⟨Instructions EeR(#1, #r, #e1)⟩} 
  {⟨Instructions EeR(#2, NextReg(#r), #e1)⟩} 
  ADD ⟨Reg#r⟩, ⟨Reg#r⟩, ⟨Reg NextReg(#r)⟩ ⟧;

EeR(⟦ ⟨Expression#1⟩ - ⟨Expression#2⟩ ⟧, ⟦ ⟨Reg#r⟩ ⟧, #e1) 
  → ⟦ {⟨Instructions EeR(#1, #r, #e1)⟩} 
  {⟨Instructions EeR(#2, NextReg(#r), #e1)⟩} 
  SUB ⟨Reg#r⟩, ⟨Reg#r⟩, ⟨Reg NextReg(#r)⟩ ⟧;

// TODO: check if STR #0 or #-4 or #4, its one of them
EeR(⟦ ⟨Expression#1⟩ = ⟨Expression#2⟩ ⟧, ⟦ ⟨Reg#r⟩ ⟧, #e1) 
  → ⟦ {⟨Instructions EeR(#2, #r, #e1)⟩}
  {⟨Instructions AssignmentOP(#1, #r, #e1)⟩}⟧;

// AssignmentOP - assignment operator is a helper function that decides if the base address is
// a frame pointer or heap address
sort Instructions | scheme AssignmentOP(Expression, Reg, Env);

AssignmentOP(⟦ ⟨Identifier#1⟩ ⟧, ⟦ ⟨Reg#r⟩ ⟧, EnvConst(#vd1, #mt1, #ft1)) 
  → ⟦ STR ⟨Reg#r⟩,[R12,#⟨INT VDLookupX(#vd1, #1)⟩]⟧;
  
AssignmentOP(⟦ ⟨Expression#1⟩ . ⟨ID#2⟩ ⟧, ⟦ ⟨Reg#r⟩ ⟧, #e1) 
  → ⟦ {⟨Instructions EeR(#1, NextReg(#r), #e1)⟩} 
  STR ⟨Reg#r⟩, [⟨Reg NextReg(#r)⟩, &⟨ID ClassMember( EeT(#1,#e1), #2)⟩]⟧;

EeR(⟦ ⟨Expression#1⟩ = ⟨ObjectLiteral#2⟩ ⟧, ⟦ ⟨Reg#r⟩ ⟧, #e1)
  → ⟦ {⟨Instructions OlR(#2, #r, #e1, EeT(#1,#e1))⟩}  
  {⟨Instructions AssignmentOP(#1, #r, #e1)⟩}⟧;

EeR(⟦ ⟨Expression#1⟩ , ⟨Expression#2⟩ ⟧, ⟦ ⟨Reg#r⟩ ⟧, #e1)
  → ⟦ {⟨Instructions EeR(#1, #r, #e1)⟩}
  {⟨Instructions EeR(#2, NextReg(#r), #e1)⟩} ⟧;

sort Instructions | FnArgHelper(Expression, Reg, Reg);
FnArgHelper(⟦ ⟨Expression#1⟩ , ⟨Expression#2⟩ ⟧, ⟦ ⟨Reg#dest⟩ ⟧, ⟦ ⟨Reg#src⟩ ⟧)  
  → ⟦ MOV ⟨Reg#dest⟩, ⟨Reg#src⟩ {⟨Instructions FnArgHelper(#2, NextReg(#dest), NextReg(#src))⟩}⟧;
  
default FnArgHelper(#E, ⟦ ⟨Reg#dest⟩ ⟧, ⟦ ⟨Reg#src⟩ ⟧) 
  → ⟦ MOV ⟨Reg#dest⟩, ⟨Reg#src⟩ ⟧;
  
/*
*** Be function takes a boolean expression, label true, label false, and environment
*/
sort Instructions | scheme Be(Expression, Label, Label, Env);

Be(⟦ ! ⟨Expression#1⟩ ⟧, ⟦ lt ⟧, ⟦ lf ⟧, #e1) → ⟦{⟨Instructions Be(#1, ⟦ lf ⟧, ⟦ lt ⟧, #e1)⟩}⟧;

Be(⟦ ⟨Expression#1⟩ < ⟨Expression#2⟩ ⟧, ⟦ lt ⟧, ⟦ lf ⟧, #e1) 
	→ ⟦ {⟨Instructions EeR(#1, ⟦R4⟧, #e1)⟩} 
	{⟨Instructions EeR(#2, ⟦R5⟧, #e1)⟩}
	CMP R4, R5
	BLT lt
	B lf ⟧;

Be(⟦ ⟨Expression#1⟩ > ⟨Expression#2⟩ ⟧, ⟦ lt ⟧, ⟦ lf ⟧, #e1) 
	→ ⟦ {⟨Instructions EeR(#1, ⟦R4⟧, #e1)⟩} 
	{⟨Instructions EeR(#2, ⟦R5⟧, #e1)⟩}
	CMP R4, R5
	BGT lt
	B lf ⟧;

Be(⟦ ⟨Expression#1⟩ <= ⟨Expression#2⟩ ⟧, ⟦ lt ⟧, ⟦ lf ⟧, #e1) 
	→ ⟦ {⟨Instructions EeR(#1, ⟦R4⟧, #e1)⟩} 
	{⟨Instructions EeR(#2, ⟦R5⟧, #e1)⟩}
	CMP R4, R5
	BLE lt
	B lf ⟧;

Be(⟦ ⟨Expression#1⟩ >= ⟨Expression#2⟩ ⟧, ⟦ lt ⟧, ⟦ lf ⟧, #e1) 
	→ ⟦ {⟨Instructions EeR(#1, ⟦R4⟧, #e1)⟩} 
	{⟨Instructions EeR(#2, ⟦R5⟧, #e1)⟩}
	CMP R4, R5
	BGE lt
	B lf ⟧;

Be(⟦ ⟨Expression#1⟩ == ⟨Expression#2⟩ ⟧, ⟦ lt ⟧, ⟦ lf ⟧, #e1) 
	→ ⟦ {⟨Instructions EeR(#1, ⟦R4⟧, #e1)⟩} 
	{⟨Instructions EeR(#2, ⟦R5⟧, #e1)⟩}
	CMP R4, R5
	BEQ lt
	B lf ⟧;

Be(⟦ ⟨Expression#1⟩ != ⟨Expression#2⟩ ⟧, ⟦ lt ⟧, ⟦ lf ⟧, #e1) 
	→ ⟦ {⟨Instructions EeR(#1, ⟦R4⟧, #e1)⟩} 
	{⟨Instructions EeR(#2, ⟦R5⟧, #e1)⟩}
	CMP R4, R5
	BNE lt
	B lf ⟧;

Be(⟦ ⟨Expression#1⟩ && ⟨Expression#2⟩ ⟧, ⟦ lt ⟧, ⟦ lf ⟧, #e1)
  → ⟦ {⟨Instructions Be(#1, ⟦ lnt ⟧, ⟦ lf ⟧, #e1)⟩} 
  {lnt}
  {⟨Instructions Be(#2, ⟦ lt ⟧, ⟦ lf ⟧, #e1)⟩} ⟧;


Be(⟦ ⟨Expression#1⟩ || ⟨Expression#2⟩ ⟧, ⟦ lt ⟧, ⟦ lf ⟧, #e1)
  → ⟦ {⟨Instructions Be(#1, ⟦ lt ⟧, ⟦ lnf ⟧, #e1)⟩} 
  {lnf}
  {⟨Instructions Be(#2, ⟦ lt ⟧, ⟦ lf ⟧, #e1)⟩} ⟧;

/*
*** As and Tit generate the instruction that store function arguments to the stack.
**  Reg - the register that corresponds to the function argument.
*/
sort Instructions | scheme As(ArgumentSignature, Reg);
As(⟦ ( ) ⟧, #r) → ⟦⟧ ;
As(⟦ ( ⟨Type#1⟩ ⟨Identifier#2⟩ ⟨TypeIdentifierTail#3⟩ ) ⟧, #r) → ⟦ STMFD SP!, {⟨Reg#r⟩} {⟨Instructions Tit(#3, NextReg(#r))⟩}⟧ ;

sort Instructions | scheme Tit(TypeIdentifierTail, Reg);
Tit(⟦ ⟧, #r) → ⟦⟧ ;
Tit(⟦ , ⟨Type#1⟩ ⟨Identifier#2⟩ ⟨TypeIdentifierTail#3⟩ ⟧, #r) → ⟦ STMFD SP!, {⟨Reg#r⟩} {⟨Instructions Tit(#3, NextReg(#r))⟩}⟧ ;

/*
*** OlR is responsible for allocating space on the heap for an object of the specified Type
*** The function stores the heap address of the object in the specified Reg
*/
sort Instructions | scheme OlR(ObjectLiteral, Reg, Env, Type);

/*
*** There are two choices that can be made for empty object literal list.
**  1. Dont allocate space since the user did not specify any values and just set the address to null.
**  2. Allocate the required space for this type since each class member item maybe set individually.
*      That is set using the Exp.id.
**  I have adopted the first option since I am working under the assumption that object literals must
**  have all the class members present in order to be valid. Therefore an empty OL does not have any members.
**  Option 2 would be trivial to implement since its a degenerate case of OL with values.
*/ 
OlR(⟦ { } ⟧, ⟦ ⟨Reg#r⟩ ⟧, #e1, ⟦ ⟨Type#t⟩ ⟧) → ⟦MOV ⟨Reg#r⟩, #0⟧;

// We take the opportunity here to convert Type to ID. Type should be a class name.
OlR(⟦ { ⟨KeyValue#1⟩ ⟨KeyValueTail#2⟩ } ⟧, ⟦ ⟨Reg#r⟩ ⟧, #e1, ⟦ ⟨ID#t⟩ ⟧) 
  → ⟦ STMFD SP!,{R0-R3,R12}
  MOV R0,&⟨ID ClassSize(#t)⟩ 
  BL allocate 
  MOV ⟨Reg#r⟩, R0
  LDMFD SP!,{R0-R3,R12}
  {⟨Instructions KV(#1, #r, #e1, #t)⟩}  
  {⟨Instructions KVT(#2, #r, #e1, #t)⟩} ⟧;


sort Instructions | scheme KVT(KeyValueTail, Reg, Env, ID) | scheme KV(KeyValue, Reg, Env, ID);
KVT(⟦ , ⟨KeyValue#1⟩ ⟨KeyValueTail#2⟩ ⟧, ⟦ ⟨Reg#r⟩ ⟧, #e1, #t) 
  → ⟦ {⟨Instructions KV(#1, #r, #e1, #t)⟩} 
  {⟨Instructions KVT(#2, #r, #e1, #t)⟩} ⟧;
  
KVT(⟦ ⟧, #r, #e1, #t) → ⟦ ⟧;

KV(⟦ ⟨ID#1⟩ : ⟨Expression#2⟩ ⟧, ⟦ ⟨Reg#r⟩ ⟧, #e1, ⟦ ⟨ID#t⟩ ⟧)
  → ⟦ {⟨Instructions EeR(#2, NextReg(#r), #e1)⟩}
  STR ⟨Reg NextReg(#r)⟩,[⟨Reg#r⟩,&⟨ID MemberOffset(#t,#1)⟩] ⟧;

/*
*** Extend environment with arguments and local variables and save their stack location (i.e var -> Type && Location)
*/
sort VD | scheme AsE(ArgumentSignature, VD, Computed);
AsE(⟦ ( ) ⟧, #vd1, #x) → #vd1 ;
AsE(⟦ ( ⟨Type#1⟩ ⟨Identifier#2⟩ ⟨TypeIdentifierTail#3⟩ ) ⟧, #vd1, #x) → AppendVD(MoreVD(#2, TypeLoc(#1, #x), NoVD), TitE(#3, #vd1, ⟦#x-4⟧)) ; // !!!! NOTE: confirm the append doesnt need to be reversed

sort VD | scheme TitE(TypeIdentifierTail, VD, Computed);
TitE(⟦ ⟧, #vd1, #x) → #vd1 ;
TitE(⟦ , ⟨Type#1⟩ ⟨Identifier#2⟩ ⟨TypeIdentifierTail#3⟩ ⟧, #vd1, #x) → AppendVD(MoreVD(#2, TypeLoc(#1, #x), NoVD), TitE(#3, #vd1, ⟦#x-4⟧)) ;

// extend env for 'var'
sort Env | scheme SeE(Statement, Env, Computed);
SeE(⟦ var ⟨Type#1⟩ ⟨Identifier#2⟩ ; ⟧, EnvConst(#vd1, #mt1, #ft1), #x) → EnvConst(AppendVD(MoreVD(#2, TypeLoc(#1, #x), NoVD), #vd1), #mt1, #ft1) ;

/*
** default SeE(#S, #e1, #x) → #e1 ;
*** Tried the above but did not work had to put all the productions :(
*/
SeE(⟦ { ⟨Statements#1⟩ } ⟧, #e1, #x) → #e1 ;
SeE(⟦ ; ⟧, #e1, #x) → #e1 ;
SeE(⟦ ⟨Expression#1⟩ ; ⟧, #e1, #x) → #e1 ;
SeE(⟦ if ( ⟨Expression#1⟩ ) ⟨IfTail#2⟩  ⟧, #e1, #x) → #e1 ;
SeE(⟦ while ( ⟨Expression#1⟩ ) ⟨Statement#2⟩ ⟧, #e1, #x) → #e1 ;
SeE(⟦ return ⟨Expression#1⟩ ; ⟧, #e1, #x) → #e1 ;
SeE(⟦ return ; ⟧, #e1, #x) → #e1 ;

/*
*** Calculate the offsets for function arguments and statements
*/
sort Computed | scheme AsC(ArgumentSignature, Computed);
AsC(⟦ ( ) ⟧, #x) → #x ;
AsC(⟦ ( ⟨Type#1⟩ ⟨Identifier#2⟩ ⟨TypeIdentifierTail#3⟩ ) ⟧, #x) → TitC(#3, ⟦#x-4⟧) ; 

sort Computed | scheme TitC(TypeIdentifierTail, Computed);
TitC(⟦ ⟧, #x) → #x ;
TitC(⟦ , ⟨Type#1⟩ ⟨Identifier#2⟩ ⟨TypeIdentifierTail#3⟩ ⟧, #x) → TitC(#3, ⟦#x-4⟧) ;

sort Computed | scheme SeC(Statement, Computed);
SeC(⟦ var ⟨Type#1⟩ ⟨Identifier#2⟩ ; ⟧, #x)  → ⟦#x-4⟧; 
default SeC(#S, #x) → #x ; 


/*
*** It takes many dummies to make this work.
**  The function that does the reall work is MTLookupT which returns a Type for class members (classname_id)
**  Unfortunately the classname_id has to be Computed hence the dummies.
*   MT - class member to type map
*   Computed - the computed concatenation of class name and id (classname_id)
*   ID - the concatenated class name and id (classname_id)
*/
sort Type | scheme MTLookupTDummy1(MT, Computed) | scheme MTLookupTDummy2(MT, ID)| scheme MTLookupT(MT, ID); // the type is the id/class name
MTLookupTDummy1(#m1, #id)  → MTLookupTDummy2(#m1, #id);
[data #id] MTLookupTDummy2(#m1, #id) → MTLookupT(#m1, #id);
MTLookupT(MoreMT(#id, #t, #m), #id) → #t;
MTLookupT(NoMT, #t) → ⟦ error ⟧;									// NOTE: Should really do the error
default MTLookupT(MoreMT(#id, #t, #m), #tc) → MTLookupT(#m, #tc);

// Helper to generate name for class member offset.
sort Computed | scheme ClassMember(Type, ID) ;
ClassMember(⟦ ⟨ID#id⟩ ⟧, #m) → ⟦ #id @ "_" @ #m ⟧ ; 

/*
*** Types Handling
*/
sort Type | scheme EeT(Expression, Env);
EeT( ⟦ ⟨Integer#1⟩ ⟧, #e1) → ⟦ int ⟧;

EeT( ⟦ ⟨Identifier#1⟩ ⟧, #e1) → LookupT(#e1, #1);

EeT(⟦ ⟨Expression#1⟩ . ⟨ID#2⟩ ⟧, EnvConst(#vd1, #mt1, #ft1)) 
 → MTLookupTDummy1(#mt1, ClassMember( EeT(#1, EnvConst(#vd1, #mt1, #ft1)),#2) );

EeT(⟦ ⟨Expression#1⟩ ( ) ⟧, #e1) → EeT(#1, #e1);

EeT(⟦ ⟨Expression#1⟩ ( ⟨Expression#2⟩ ) ⟧, #e1) → EeT(#1, #e1);

EeT(⟦ - ⟨Expression#1⟩ ⟧, #e1) → EeT(#1, #e1);
EeT(⟦ + ⟨Expression#1⟩ ⟧, #e1) → EeT(#1, #e1);

EeT(⟦ ⟨Expression#1⟩ * ⟨Expression#2⟩ ⟧, #e1) → ⟦ int ⟧;
EeT(⟦ ⟨Expression#1⟩ + ⟨Expression#2⟩ ⟧, #e1) → ⟦ int ⟧;
EeT(⟦ ⟨Expression#1⟩ - ⟨Expression#2⟩ ⟧, #e1) → ⟦ int ⟧;

EeT(⟦ ⟨Expression#1⟩ = ⟨Expression#2⟩ ⟧, #e1) → EeT(#1, #e1);
EeT(⟦ ⟨Expression#1⟩ = ⟨ObjectLiteral#2⟩ ⟧, #e1) → EeT(#1, #e1);

/*
*** Needed Synthesized attributes
*/
attribute ↑id(Identifier) ;
sort Expression | ↑id ;
⟦ ⟨Identifier#1⟩ ⟧ ↑id(#1);

}
