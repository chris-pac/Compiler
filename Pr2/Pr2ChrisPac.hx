// [NYU Courant Institute] Compiler Construction/Spring 2015/Project Milestone 2
// JST PARSER AND TYPE CHECK SKELETON
// based on http://cs.nyu.edu/courses/spring15/CSCI-GA.2130-001/pr2/Pr2Base.hx

// Chris Pac 
// SDD Type checking
// 1/4/2015

module edu.nyu.cs.cc.pr2.Pr2ChrisPac {

// PROGRAM

main sort Program  |  ⟦ ⟨Declarations⟩ ⟧ ;

// DECLARATIONS

sort Declarations | ⟦ ⟨Declaration⟩ ⟨Declarations⟩ ⟧ | ⟦⟧ ;

sort Declaration
|  ⟦ class ⟨ID⟩ { ⟨Members⟩ } ⟧
|  ⟦ function ⟨Type⟩ ⟨ID⟩ ⟨ArgumentSignature⟩ { ⟨Statements⟩ } ⟧
;

sort Members | ⟦ ⟨Member⟩ ⟨Members⟩ ⟧ | ⟦⟧ ;

sort Member
|  ⟦ ⟨Type⟩ ⟨ID⟩ ; ⟧
|  ⟦ ⟨Type⟩ ⟨ID⟩ ⟨ArgumentSignature⟩ { ⟨Statements⟩ } ⟧
;

sort ArgumentSignature
|  ⟦ ( ) ⟧
|  ⟦ ( ⟨Type⟩ ⟨ID⟩ ⟨TypeIdentifierTail⟩ ) ⟧
;
sort TypeIdentifierTail |  ⟦ , ⟨Type⟩ ⟨ID⟩ ⟨TypeIdentifierTail⟩ ⟧  |  ⟦ ⟧ ;

// STATEMENTS

sort Statements | ⟦ ⟨Statement⟩ ⟨Statements⟩ ⟧ | ⟦⟧ ;

sort Statement
|  ⟦ { ⟨Statements⟩ } ⟧
|  ⟦ var ⟨Type⟩ ⟨ID⟩ ; ⟧
|  ⟦ ⟨Expression⟩ ; ⟧
|  ⟦ if ( ⟨Expression⟩ ) ⟨IfTail⟩ ⟧
|  ⟦ while ( ⟨Expression⟩ ) ⟨Statement⟩ ⟧
|  ⟦ return ⟨Expression⟩ ; ⟧
|  ⟦ return ; ⟧
|  ⟦ ; ⟧
;
sort IfTail | ⟦ ⟨Statement⟩ else ⟨Statement⟩ ⟧ | ⟦ ⟨Statement⟩ ⟧ ;

// TYPES

sort Type  |  ⟦ boolean ⟧  |  ⟦ int ⟧  |  ⟦ string ⟧  |  ⟦ void ⟧  |  ⟦ ⟨ID⟩ ⟧  ;

// EXPRESSIONS

sort Expression

|  sugar ⟦ ( ⟨Expression#e⟩ ) ⟧@10 → #e

|  ⟦ ⟨SimpleLiteral⟩ ⟧@10
|  ⟦ ⟨ID⟩ ⟧@10
|  ⟦ this ⟧@10

|  ⟦ ⟨Expression@9⟩ ( ⟨Expression⟩ ) ⟧@9
|  ⟦ ⟨Expression@9⟩ ( ) ⟧@9
|  ⟦ ⟨Expression@9⟩ . ⟨ID⟩ ⟧@9

|  ⟦ ! ⟨Expression@8⟩ ⟧@8
|  ⟦ - ⟨Expression@8⟩ ⟧@8
|  ⟦ + ⟨Expression@8⟩ ⟧@8

|  ⟦ ⟨Expression@7⟩ * ⟨Expression@8⟩ ⟧@7
|  ⟦ ⟨Expression@7⟩ / ⟨Expression@8⟩ ⟧@7
|  ⟦ ⟨Expression@7⟩ % ⟨Expression@8⟩ ⟧@7

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
|  ⟦ ⟨Expression@2⟩ += ⟨Expression@1⟩ ⟧@1

|  ⟦ ⟨Expression@1⟩ , ⟨Expression⟩ ⟧
;

sort SimpleLiteral  |  ⟦ ⟨STR⟩ ⟧  |  ⟦ ⟨INT⟩ ⟧ ;
sort ObjectLiteral  |  ⟦ { } ⟧  |  ⟦ { ⟨KeyValue⟩ ⟨KeyValueTail⟩ } ⟧ ;
sort KeyValueTail   |  ⟦ , ⟨KeyValue⟩ ⟨KeyValueTail⟩ ⟧  |  ⟦ ⟧ ;
sort KeyValue       |  ⟦ ⟨ID⟩ : ⟨Expression@1⟩ ⟧ ;


// LEXICAL CONVENTIONS

space [ \t\n\r] | '//' [^\n]* | '/*' ( [^*] | '*' [^/] )* '*/'  ;

token ID	| ⟨LetterEtc⟩ (⟨LetterEtc⟩ | ⟨Digit⟩)* ;

token INT	| ⟨Digit⟩+ ;


token STR	| "\'" ( [^\'\\\n] | \\ ⟨Escape⟩ )* "\'"
		| "\"" ( [^\"\\\n] | \\ ⟨Escape⟩ )* "\""
		;

token fragment Letter	| [A-Za-z] ;
token fragment LetterEtc	| ⟨Letter⟩ | [$_] ;
token fragment Digit	| [0-9] ;

token fragment Escape	| [^x] | "x" ⟨Hex⟩ ⟨Hex⟩ ;
token fragment Hex	| [0-9A-Fa-f] ;

/*
* This is a list used for storing type descriptors.
* The main functions are: 
*	TDListAppend
*		Concatenates two list together and returns the result
*		
*	TDListIfEmpty
*		takes in three lists and if 1st L is empty return 2nd L else return 3rd L
*	
*	The rest of functions were used to test the problem described in 2.3.3 of the documentation.
*	For some strange reason the TDListInt and TDListJustRet would return different structures even tho same thing was passed in.
*/
sort TDList | TDListConst(TD, TDList) | TDListEmpty ;

| scheme TDListAppend(TDList, TDList)
| scheme TDListIfEmpty(TDList, TDList, TDList)
;
TDListAppend(TDListEmpty, #)  → # ;
TDListAppend(TDListConst(#v , #l1), #l2) → TDListConst(#v, TDListAppend(#l1, #l2)) ;

TDListIfEmpty(#1, #2, #3) → #3 ;
TDListIfEmpty(TDListEmpty, #2, #3) → #2 ; 

sort MapKey | Key(ID) | This | Return;

/*
* TDMap stores name to type descriptor mapping
* main functions
*	TDMapAppend
*	Concatenates two maps
*	
*rest of the functions used for testing
*
*/

sort TDMap | TDMapConst(MapKey, TD, TDMap) | TDMapEmpty

| scheme TDMapAppend(TDMap, TDMap)
;
TDMapAppend(TDMapEmpty, #)  → # ;
TDMapAppend(TDMapConst(#k, #v, #m1), #m2)  → TDMapConst(#k, #v, TDMapAppend(#m1, #m2));


/*
* Type descriptor and the associated functions
*
* Functions described in the reference SDD
*
* TypeIf is a helper function that returns 1st or 2nd type based on true or false value
*
*/
sort TD | TDType(Type) | Call(TD, TDList) | Class(TDMap) | Error  | None 

| scheme TypeIf(Boolean, TD, TD)
| scheme TypeAdds(TD, TD)
| scheme TDMapLookup(TDMap, MapKey)  // returns value given key(ID)
| scheme TDMapLookupTD(TDMap, TD)	// helper function when TDType[ ID=Key ] is passed in
| scheme DoCall(TD, TDList)
| scheme DoMemberEnv(TDMap, TD, ID) // first map is the environment map, TD has the class name TDType[classname], ID is class member
| scheme DoMemberHelper(TD, ID) // TD is the Class(TDMap) type and id is the class member
;

TypeIf(True, #1, #2) → #1;
TypeIf(False, #1, #2) → #2;

/*
*** THESE EXTRA HELPERS ARE NEEDED TO TEST EQUALITY.
*/
sort Boolean | scheme IsSameType(TD, TD) | scheme IsSameID(ID, ID) | scheme IsSameTypeForObjectLiterals(TD, TD)
| IsSubMap(TDMap, TDMap, Boolean)	// checks if second map is a subset of the first map
| IsKeyValInMap(TDMap, MapKey, TD)	// checks if the key, value pair is in the map
;
IsSameType(TDType(#), TDType(#)) → True ;
IsSameType(#, #) → True ;
IsSameType(TDType(⟦ ⟨ID#1⟩ ⟧), TDType(#2)) → IsSameID(#1, #2);    // The problem is that sometimes we put ID into TDType(ID) and sometimes Type into TDType(Type)...
IsSameType(TDType(#2), TDType(⟦ ⟨ID#1⟩ ⟧)) → IsSameID(#2, #1);    // ... HACS treats these two as different even if the string inside is the same. Thats the reason for these two statements...
default IsSameType(#1, #2) → False ;                            // ... as an example we create TDType(ClassID) and TDType([ <ID> ])
IsSameID(#, #) → True ;
default IsSameID(#1, #2) → False ;

/*
*** Checks if one map is a submap of another. Used when OL is assigned to class type
*/
IsSubMap(#m, TDMapEmpty, #b) → #b;
IsSubMap(#m1, #m2, False)  → False;
default IsSubMap(#m1, TDMapConst(#k, #v, #m2), #b) → IsSubMap(#m1, #m2, IsKeyValInMap(#m1, #k, #v));

IsKeyValInMap(TDMapEmpty, #k, #v)  → False;
IsKeyValInMap(TDMapConst(#k, #v, #m), #k, #v)  → True;
default IsKeyValInMap(TDMapConst(#k1, #v1, #m), #k2, #v2)  → IsKeyValInMap(#m, #k2, #v2);

/*
*** Does logically the same thing as IsSameType. However it handles functions being passed in as parameters
*	I did not want to modify IsSameType due to fear of breaking things that already work 
*/
IsSameTypeForObjectLiterals(TDType(#), TDType(#)) → True ;
IsSameTypeForObjectLiterals(Class(#m), Class(#m)) → True ;
IsSameTypeForObjectLiterals(Call(#1, #2), Call(#1, #2)) → True ;
IsSameTypeForObjectLiterals(Error, Error) → True ;
IsSameTypeForObjectLiterals(None, None) → True ;

IsSameTypeForObjectLiterals(Class(#m1), Class(#m2)) → IsSubMap(#m1, #m2, True) ;

IsSameTypeForObjectLiterals(TDType(#), #1) → False ;
IsSameTypeForObjectLiterals(Class(#m), #1) → False ;
IsSameTypeForObjectLiterals(Call(#1, #2), #3) → False ;
IsSameTypeForObjectLiterals(Error, #) → False ;
IsSameTypeForObjectLiterals(None, #) → False ;
default IsSameTypeForObjectLiterals(#1, #2) → IsSameTypeForObjectLiterals(#1, #2) ; // force it to recalculate

sort TD;

TypeAdds(#1, #2)  →
  TypeIf( And(IsSameType(#1, TDType(⟦ int ⟧)) , IsSameType(#2, TDType(⟦ int ⟧))) ,  TDType(⟦ int ⟧) ,
  TypeIf( And(IsSameType(#1, TDType(⟦ int ⟧)) , IsSameType(#2, TDType(⟦ string ⟧))) , TDType(⟦ string ⟧) ,
  TypeIf( And(IsSameType(#1, TDType(⟦ string ⟧)) , IsSameType(#2, TDType(⟦ int ⟧))) , TDType(⟦ string ⟧) ,
  TypeIf( And(IsSameType(#1, TDType(⟦ string ⟧)) , IsSameType(#2, TDType(⟦ string ⟧))) , TDType(⟦ string ⟧) ,
  Error)))) ;

TDMapLookup(TDMapConst(#n, #t, #m), #n) → #t;
TDMapLookup(TDMapEmpty, #n)  → Error ;
default TDMapLookup(TDMapConst(#n, #t, #m), #n2) → TDMapLookup(#m, #n2);

/*
*** Helper method when key is stuck in TDType[ ID=key]
*/
TDMapLookupTD(#m, TDType(⟦ ⟨ID#k⟩ ⟧))  → TDMapLookup(#m, Key(#k)) ;
TDMapLookupTD(#m, TDType(#k))  → TDMapLookup(#m, Key(#k)) ; // no idea why sometimes the above one matches and sometimes this one
default TDMapLookupTD(#1, #2) → Error ;

/*
*** The DoMember* functions are used to get a type out of a class map
**	DoMemberEnv -> DoMemberHelper
*
**	The DoMemberEnv computes the type on the Exp.id production
*	It takes an environment map, type which contains the name of the class TDType[ classname ], and id which is a class member or method
*	First we need to find the actual Class(Map) type using the classname as key in the environment. Thats done by TDMapLookupTD.
*	The results of TDMapLookupTD are passed into DoMemberHelper including the member/method identifier
*
**	DoMemberHelper takes the actual Class(Map=Key->Type,...) type and the member/method identifier ID=Key
*	Using the ID as key it calls TDMapLookup to search through the map and return the type of the member/method as defined in the class
*	The function expends all the parameters of TD to force the passed in function(TDMapLookupTD) to calculate a value
*/

DoMemberHelper(Class(#m), ⟦ ⟨ID#id⟩ ⟧) → TDMapLookup(#m, Key(#id));
DoMemberHelper(Error, ⟦ ⟨ID#id⟩ ⟧) → Error;
DoMemberHelper(Call(#1, #2), ⟦ ⟨ID#id⟩ ⟧) → Error;
DoMemberHelper(TDType(#1), ⟦ ⟨ID#id⟩ ⟧) → Error;
DoMemberHelper(None, ⟦ ⟨ID#id⟩ ⟧) → Error;
default DoMemberHelper(#1, #2)  → DoMemberHelper(#1, #2); // this recursive call forces that the passed in function is calculated

DoMemberEnv(#1, Class(#m), #k)  → TDMapLookup(#m, Key(#k)); // Its already a class (static call)
DoMemberEnv(#e, #1, #2)  →
  TypeIf( And(IsSameType(#1, TDType(⟦ string ⟧)), IsSameID(#2, ⟦ length ⟧)) , TDType(⟦ int ⟧) ,  
  TypeIf( And(IsSameType(#1, TDType(⟦ string ⟧)), IsSameID(#2, ⟦ charCodeAt ⟧)) , Call(TDType(⟦ string ⟧), TDListConst(TDType(⟦ int ⟧), TDListEmpty)) ,  
  TypeIf( And(IsSameType(#1, TDType(⟦ string ⟧)), IsSameID(#2, ⟦ substr ⟧)) , Call(TDType(⟦ string ⟧), TDListConst(TDType(⟦ int ⟧), TDListConst(TDType(⟦ int ⟧), TDListEmpty))) ,  
  DoMemberHelper(TDMapLookupTD(#e, #1), #2)  ))) ;

// The second parameter in Call type descriptor is a list of types that represent function parameters if they are equal than the function can be called
DoCall(Call(#t, #tl), #tl) → #t;
default DoCall(#1, #2) → Error;

// CHECK STRUCTURE
/*
* TypeComp
*	returns true if two types are the same or false otherwise
*	
* IsMapEmpty and MapEquals used purely for debugging
*
* GoodTypes or DoTypes in SDD ref
*/
sort Boolean  | True  | False ;

| scheme And(Boolean,Boolean) 
| scheme Or(Boolean,Boolean)
| scheme Not(Boolean)
| scheme TypeComp(TD, TD)
| scheme LVal(Expression)
| scheme TDMapDefinedTD(TDMap, TD)
| scheme TDMapDefined(TDMap, MapKey)
| scheme GoodTypes(TDMap, TDList, Boolean)
| scheme IsMapEmpty(TDMap)
;

IsMapEmpty(TDMapEmpty) → True;
default IsMapEmpty(#1) → False;

And(True, #2) → #2 ;
And(False, #2) → False ;

Or(False, #2) → #2 ;
Or(True, #2)  → True ;

Not(True) → False ;
Not(False) → True;

TypeComp(#, #) → True ;
TypeComp(#1, #2) → False ;

LVal(⟦ ⟨Expression#1⟩ . ⟨ID#2⟩ ⟧)  → True ;
LVal(⟦ ⟨ID#⟩ ⟧)  → True ;
LVal(⟦ this ⟧)  → True ;
default LVal(#)  → False ;

TDMapDefinedTD(#, TDType(⟦ boolean ⟧)) → True ;
TDMapDefinedTD(#, TDType(⟦ int ⟧)) → True ;
TDMapDefinedTD(#, TDType(⟦ string ⟧)) → True ;
TDMapDefinedTD(#, TDType(⟦ void ⟧)) → True ;
/*
*** This next line just refuses to work no matter what I try. It is the reason why classes do not work.
*/
TDMapDefinedTD(#m, TDType(⟦ ⟨ID#k⟩ ⟧))  → TDMapDefined(#m, Key(#k)) ;
TDMapDefinedTD(#m, TDType(#k))  → TDMapDefined(#m, Key(#k)) ;
default TDMapDefinedTD(#1, #2) → False ;

TDMapDefined(TDMapConst(#n, #t, #m), #n) → True;
TDMapDefined(TDMapEmpty, #n)  → False ;  // or ⟦ Did not work ⟧
default TDMapDefined(TDMapConst(#n, #t, #m), #n2) → TDMapDefined(#m, #n2);

/*
*** Checks if all the types in the list are defined in the environment map
*	Follows Rose's SDD definition 
*/
GoodTypes(#m, TDListEmpty, #b)  → #b;
GoodTypes(#m, #l, False)  → False;
GoodTypes(#m, TDListConst(#t, #l), #b)  → GoodTypes(#m, #l, TDMapDefinedTD(#m, #t));

// ALL Of the  Attributes
attribute ↑ok(Boolean) ;
attribute ↑t(TD) ; // type
attribute ↑nds(TDMap) ;

attribute ↑mm(TDMap) ; // used instead of the ns attribute
attribute ↑ps(TDList) ; // Type Descriptor vector/list

attribute ↓e(TDMap);
attribute ↓r(TD); // used as an inherited attribute for testing "return"

sort Answer  | ⟦OK⟧  | ⟦ERROR⟧ ;
| scheme Check(Program)
| scheme Check2(Program)
;

/*
*** Wire up Code
*/
Check(#P)  → Check2(Run(#P)) ;

Check2(#P ↑ok(True)) → ⟦OK⟧ ;
Check2(#P ↑ok(False)) → ⟦ERROR⟧ ;

sort Program | scheme Run(Program);
Run(#P ↑nds(#nds))  → Pe(#P) ↓e(#nds) ;

/* *************** START Comparison TEST ****************** */
/*
*** I have set up this test to check if literal comparisons work and they do NOT.
**  The method for comparing follows directly as Prof. Rose has instructed.
**  This is the reason why the length/charCodeAt/substr do not work.
** 
*/

/*
*** INPUT and OUTPUT to/from TestIDCompare -> IsSameID
*cpp270@energon1[Tests2]$ ./Pr2ChrisPac.run --scheme=TestIDCompare --sort=Expression --term='"ok".length'
* '$Print2-Pr2ChrisPac$Boolean'[Pr2ChrisPac$Boolean_False, 0]
*/

//sort Boolean
//| scheme TestIDCompare(Expression);
//TestIDCompare(⟦ ⟨Expression#1⟩ . ⟨ID#2⟩ ⟧) → IsSameID(#2, ⟦ length ⟧);  // THIS IS THE TEST we CARE about and it returns False
//TestIDCompare(⟦ ⟨Expression#1 ↑t(#t1)⟩ . ⟨ID#2⟩ ⟧) → IsSameType(#t1, TDType(⟦ string ⟧)); // control test to see if this works returns True
/* *************** END Comparison TEST ****************** */

// SYNTHESIZE ATTRIBUTES

// ------------------------------------------------------------------------------
sort Program | ↑ok ;
⟦ ⟨Declarations#Ds ↑ok(#ok1)⟩ ⟧ ↑ok(#ok1) ;

sort Program | ↑nds;
⟦ ⟨Declarations#Ds ↑nds(#nds1)⟩ ⟧ ↑nds(#nds1) ;

// ------------------------------------------------------------------------------
sort Declarations | ↑ok ;

⟦ ⟨Declaration#D ↑ok(#ok1)⟩ ⟨Declarations#Ds ↑ok(#ok2)⟩ ⟧ ↑ok(And(#ok1,#ok2));
⟦⟧ ↑ok(True);

sort Declarations | ↑nds;
⟦ ⟨Declaration#D ↑nds(#m1)⟩ ⟨Declarations#Ds ↑nds(#m2)⟩ ⟧ ↑nds(TDMapAppend(#m1, #m2)) ;
⟦⟧ ↑nds(TDMapEmpty);

// ------------------------------------------------------------------------------
sort Declaration | ↑ok ;

⟦ class ⟨ID#1⟩ { ⟨Members#2 ↑ok(#ok1)⟩ } ⟧ ↑ok(#ok1) ;

/*
*** This is done in the inherited section since we needs an environment.
*/
//**⟦ function ⟨Type#1⟩ ⟨ID#2⟩ ⟨ArgumentSignature#3⟩ { ⟨Statements#4⟩ } ⟧ ↑ok(True) ; 

sort Declaration | ↑nds;
⟦ class ⟨ID#1⟩ { ⟨Members#2 ↑mm(#mm)⟩ } ⟧ ↑nds(TDMapConst(Key(#1), Class(#mm), TDMapEmpty));
⟦ function ⟨Type#1⟩ ⟨ID#2⟩ ⟨ArgumentSignature#3 ↑ps(#ps1)⟩ { ⟨Statements#4⟩ } ⟧ ↑nds(TDMapConst(Key(#2), Call(TDType(#1), #ps1), TDMapEmpty));

// ------------------------------------------------------------------------------
sort Members | ↑ok ;

⟦ ⟨Member#M ↑ok(#ok1)⟩ ⟨Members#Ms ↑ok(#ok2)⟩ ⟧ ↑ok(And(#ok1,#ok2));
⟦⟧ ↑ok(True);

sort Members | ↑mm ;
⟦ ⟨Member#M ↑mm(#mm1)⟩ ⟨Members#Ms ↑mm(#mm2)⟩ ⟧ ↑mm(TDMapAppend(#mm1, #mm2));
⟦⟧ ↑mm(TDMapEmpty);

sort Members | ↑ps;
⟦ ⟨Member#M ↑ps(#ps1)⟩ ⟨Members#Ms ↑ps(#ps2)⟩ ⟧ ↑ps(TDListAppend(#ps1, #ps2));
⟦⟧ ↑ps(TDListEmpty);

// ------------------------------------------------------------------------------
sort Member | ↑ok ;

⟦ ⟨Type#1⟩ ⟨ID#2⟩ ; ⟧  ↑ok(True) ;
⟦ ⟨Type#1⟩ ⟨ID#2⟩ ⟨ArgumentSignature#3⟩ { ⟨Statements#4⟩ } ⟧  ↑ok(True) ;

sort Member | ↑mm ;
⟦ ⟨Type#1⟩ ⟨ID#2⟩ ; ⟧  ↑mm(TDMapConst(Key(#2), TDType(#1), TDMapEmpty)) ;
⟦ ⟨Type#1⟩ ⟨ID#2⟩ ⟨ArgumentSignature#3 ↑ps(#ps1)⟩ { ⟨Statements#4⟩ } ⟧  ↑mm(TDMapConst(Key(#2), Call(TDType(#1), #ps1), TDMapEmpty)) ;

sort Member | ↑ps;
⟦ ⟨Type#1⟩ ⟨ID#2⟩ ; ⟧  ↑ps(TDListConst(TDType(#1),TDListEmpty)) ;
⟦ ⟨Type#1⟩ ⟨ID#2⟩ ⟨ArgumentSignature#3 ↑ps(#ps1)⟩ { ⟨Statements#4⟩ } ⟧  ↑ps(TDListConst(Call(TDType(#1), #ps1),TDListEmpty)) ;

// ------------------------------------------------------------------------------
sort ArgumentSignature | ↑ps;

// TODO: ArgS needs e but later
⟦ ( ) ⟧ ↑ps(TDListEmpty) ;
⟦ ( ⟨Type#1⟩ ⟨ID#2⟩ ⟨TypeIdentifierTail#3 ↑ps(#ps1)⟩ ) ⟧ ↑ps(TDListAppend(TDListConst(TDType(#1), TDListEmpty), #ps1)) ;

sort ArgumentSignature | ↑mm;
⟦ ( ) ⟧ ↑mm(TDMapEmpty) ;
⟦ ( ⟨Type#1⟩ ⟨ID#2⟩ ⟨TypeIdentifierTail#3 ↑mm(#mm1)⟩ ) ⟧ ↑mm(TDMapAppend(TDMapConst(Key(#2), TDType(#1), TDMapEmpty), #mm1)) ;

// ------------------------------------------------------------------------------
sort TypeIdentifierTail | ↑ps;

// TODO: ArgS needs e but later
⟦ , ⟨Type#1⟩ ⟨ID#2⟩ ⟨TypeIdentifierTail#3 ↑ps(#ps1)⟩ ⟧  ↑ps(TDListAppend(TDListConst(TDType(#1), TDListEmpty), #ps1)) ;
⟦ ⟧ ↑ps(TDListEmpty) ;

sort TypeIdentifierTail | ↑mm;
⟦ , ⟨Type#1⟩ ⟨ID#2⟩ ⟨TypeIdentifierTail#3 ↑mm(#mm1)⟩ ⟧  ↑mm(TDMapAppend(TDMapConst(Key(#2), TDType(#1), TDMapEmpty) ,#mm1)) ;
⟦ ⟧ ↑mm(TDMapEmpty) ;

// ------------------------------------------------------------------------------
sort Statements | ↑ok ;

/*
*** This is now done in the inherited section since we needs an environment.
*/
//**⟦ ⟨Statement#S ↑ok(#ok1)⟩ ⟨Statements#Ss ↑ok(#ok2)⟩ ⟧ ↑ok(And(#ok1,#ok2));
⟦⟧ ↑ok(True);


// ------------------------------------------------------------------------------
sort Statement | ↑ok ;

⟦ { ⟨Statements#Ss ↑ok(#ok1)⟩ } ⟧ ↑ok(#ok1);
⟦ var ⟨Type#1⟩ ⟨ID#2⟩ ; ⟧ ↑ok(True);
⟦ ⟨Expression#1 ↑t(#t1)⟩ ; ⟧ ↑ok(Not(TypeComp(#t1, Error)));
⟦ if ( ⟨Expression#1 ↑t(#t1)⟩ ) ⟨IfTail#2 ↑ok(#ok1)⟩ ⟧ ↑ok(And(TypeComp(#t1, TDType(⟦ boolean ⟧)), #ok1));
⟦ while ( ⟨Expression#1 ↑t(#t1)⟩ ) ⟨Statement#2 ↑ok(#ok1)⟩ ⟧ ↑ok(And(TypeComp(#t1, TDType(⟦ boolean ⟧)), #ok1));
⟦ ; ⟧ ↑ok(True);

sort Statement | ↑mm ;

⟦ { ⟨Statements#Ss⟩ } ⟧ ↑mm(TDMapEmpty);
⟦ var ⟨Type#1⟩ ⟨ID#2⟩ ; ⟧ ↑mm(TDMapConst(Key(#2), TDType(#1), TDMapEmpty));
⟦ ⟨Expression#1⟩ ; ⟧  ↑mm(TDMapEmpty);
⟦ if ( ⟨Expression#1⟩ ) ⟨IfTail#2⟩ ⟧ ↑mm(TDMapEmpty);
⟦ while ( ⟨Expression#1⟩ ) ⟨Statement#2⟩ ⟧ ↑mm(TDMapEmpty);
⟦ return ⟨Expression#1⟩ ; ⟧ ↑mm(TDMapEmpty);
⟦ return ; ⟧ ↑mm(TDMapEmpty);
⟦ ; ⟧ ↑mm(TDMapEmpty);

sort Statement | ↑ps;

⟦ { ⟨Statements#Ss⟩ } ⟧ ↑ps(TDListEmpty);
⟦ var ⟨Type#1⟩ ⟨ID#2⟩ ; ⟧ ↑ps(TDListConst(TDType(#1), TDListEmpty));
⟦ ⟨Expression#1⟩ ; ⟧  ↑ps(TDListEmpty);
⟦ if ( ⟨Expression#1⟩ ) ⟨IfTail#2⟩ ⟧ ↑ps(TDListEmpty);
⟦ while ( ⟨Expression#1⟩ ) ⟨Statement#2⟩ ⟧ ↑ps(TDListEmpty);
⟦ return ⟨Expression#1⟩ ; ⟧ ↑ps(TDListEmpty);
⟦ return ; ⟧ ↑ps(TDListEmpty);
⟦ ; ⟧ ↑ps(TDListEmpty);

// ------------------------------------------------------------------------------
sort IfTail | ↑ok ;

⟦ ⟨Statement#1 ↑ok(#ok1)⟩ else ⟨Statement#2 ↑ok(#ok2)⟩ ⟧ ↑ok(And(#ok1, #ok2)) ;

⟦ ⟨Statement#1 ↑ok(#ok1)⟩ ⟧ ↑ok(#ok1) ;

// ------------------------------------------------------------------------------
sort Expression | ↑t ;

⟦ ⟨SimpleLiteral#1 ↑t(#t1)⟩ ⟧ ↑t(#t1);

/*
*** This is now done in the inherited section since we needs an environment.
*/
// ⟦ ⟨ID⟩ ⟧ 	
// ⟦ this ⟧ 	

/* This first production test for correct function arguments
* The commented out production should be used however as described in 2.3.3 the TDListIfEmpty refuses to work correctly
* This works:  DoCall(#t1 , TDListConst(#t2, TDListEmpty)) but 
	this does not for some starnge reason DoCall(#t1 , TDListIfEmpty(TDListEmpty, TDListConst(#t2, TDListEmpty) , TDListConst(#t2, TDListEmpty)))
* even tho TDListIfEmpty should just give me back the value that works by itself
*
* You can not pass computed values to functions and expect correct results if there are no helper functions down stream
*
*** The uncommented statement works for multiargument functions. I have left the commented out as an example of my firts attempt at making this work with function passing
*
*/
//⟦ ⟨Expression#1 ↑t(#t1)⟩ ( ⟨Expression#2 ↑t(#t2) ↑ps(#ps1)⟩ ) ⟧ ↑t( DoCall(#t1 , TDListIfEmpty(#ps1, TDListConst(#t2, TDListEmpty) , #ps1)) ) ;
//⟦ ⟨Expression#1 ↑t(#t1)⟩ ( ⟨Expression#2 ↑t(#t2) ↑ps(#ps1)⟩ ) ⟧ ↑t( DoCall(#t1 , TDListConst(#t2, TDListEmpty)) ) ;
⟦ ⟨Expression#1 ↑t(#t1)⟩ ( ⟨Expression#2 ↑ps(#ps1)⟩ ) ⟧ ↑t( DoCall(#t1 , #ps1) ) ;

⟦ ⟨Expression#1 ↑t(#t1)⟩ ( ) ⟧ ↑t( DoCall(#t1 , TDListEmpty) ) ;

/*
*** This is now done in the inherited section since DoMember needs an environment. DoMember has been converted to DoMemberEnv
*/
//⟦ ⟨Expression#1 ↑t(#t1)⟩ . ⟨ID#2⟩ ⟧ ↑t( DoMember(#t1 , #2) ) ;

⟦ ! ⟨Expression#1 ↑t(#t1)⟩ ⟧ ↑t(TypeIf( TypeComp(#t1, TDType(⟦ boolean ⟧)) , #t1, Error)) ;
⟦ - ⟨Expression#1 ↑t(#t1)⟩ ⟧ ↑t(TypeIf( TypeComp(#t1, TDType(⟦ int ⟧)) , #t1, Error)) ;
⟦ + ⟨Expression#1 ↑t(#t1)⟩ ⟧ ↑t(TypeIf( TypeComp(#t1, TDType(⟦ int ⟧)) , #t1, Error)) ;

⟦ ⟨Expression#1 ↑t(#t1)⟩ * ⟨Expression#2 ↑t(#t2)⟩ ⟧ ↑t(TypeIf(And( TypeComp(#t1, TDType(⟦ int ⟧)), TypeComp(#t1, #t2)) , #t1, Error));
⟦ ⟨Expression#1 ↑t(#t1)⟩ / ⟨Expression#2 ↑t(#t2)⟩ ⟧ ↑t(TypeIf(And( TypeComp(#t1, TDType(⟦ int ⟧)), TypeComp(#t1, #t2)) , #t1, Error));
⟦ ⟨Expression#1 ↑t(#t1)⟩ % ⟨Expression#2 ↑t(#t2)⟩ ⟧ ↑t(TypeIf(And( TypeComp(#t1, TDType(⟦ int ⟧)), TypeComp(#t1, #t2)) , #t1, Error));

⟦ ⟨Expression#1 ↑t(#t1)⟩ + ⟨Expression#2 ↑t(#t2)⟩ ⟧ ↑t(TypeAdds(#t1, #t2)) ;
⟦ ⟨Expression#1 ↑t(#t1)⟩ - ⟨Expression#2 ↑t(#t2)⟩ ⟧ ↑t(TypeIf(And( TypeComp(#t1, TDType(⟦ int ⟧)), TypeComp(#t1, #t2)) , #t1, Error));

// TypeIf returns bool or Error based on the firts argument which is just nested And and Ors
⟦ ⟨Expression#1 ↑t(#t1)⟩ < ⟨Expression#2 ↑t(#t2)⟩ ⟧ ↑t(TypeIf( Or(And( TypeComp(#t1, TDType(⟦ int ⟧)), TypeComp(#t1, #t2)) , And( TypeComp(#t1, TDType(⟦ string ⟧)), TypeComp(#t1, #t2))) , TDType(⟦ boolean ⟧), Error));
⟦ ⟨Expression#1 ↑t(#t1)⟩ > ⟨Expression#2 ↑t(#t2)⟩ ⟧ ↑t(TypeIf( Or(And( TypeComp(#t1, TDType(⟦ int ⟧)), TypeComp(#t1, #t2)) , And( TypeComp(#t1, TDType(⟦ string ⟧)), TypeComp(#t1, #t2))) , TDType(⟦ boolean ⟧), Error));
⟦ ⟨Expression#1 ↑t(#t1)⟩ <= ⟨Expression#2 ↑t(#t2)⟩ ⟧ ↑t(TypeIf( Or(And( TypeComp(#t1, TDType(⟦ int ⟧)), TypeComp(#t1, #t2)) , And( TypeComp(#t1, TDType(⟦ string ⟧)), TypeComp(#t1, #t2))) , TDType(⟦ boolean ⟧), Error));
⟦ ⟨Expression#1 ↑t(#t1)⟩ >= ⟨Expression#2 ↑t(#t2)⟩ ⟧ ↑t(TypeIf( Or(And( TypeComp(#t1, TDType(⟦ int ⟧)), TypeComp(#t1, #t2)) , And( TypeComp(#t1, TDType(⟦ string ⟧)), TypeComp(#t1, #t2))) , TDType(⟦ boolean ⟧), Error));

⟦ ⟨Expression#1 ↑t(#t1)⟩ == ⟨Expression#2 ↑t(#t2)⟩ ⟧ ↑t(TypeIf(And( Not(TypeComp(#t1, Error)), TypeComp(#t1, #t2)) , TDType(⟦ boolean ⟧), Error));
⟦ ⟨Expression#1 ↑t(#t1)⟩ != ⟨Expression#2 ↑t(#t2)⟩ ⟧ ↑t(TypeIf(And( Not(TypeComp(#t1, Error)), TypeComp(#t1, #t2)) , TDType(⟦ boolean ⟧), Error));

⟦ ⟨Expression#1 ↑t(#t1)⟩ && ⟨Expression#2 ↑t(#t2)⟩ ⟧ ↑t(TypeIf(And( TypeComp(#t1, TDType(⟦ boolean ⟧)), TypeComp(#t1, #t2)) , #t1, Error));

⟦ ⟨Expression#1 ↑t(#t1)⟩ || ⟨Expression#2 ↑t(#t2)⟩ ⟧ ↑t(TypeIf(And( TypeComp(#t1, TDType(⟦ boolean ⟧)), TypeComp(#t1, #t2)) , #t1, Error));

⟦ ⟨Expression#1 ↑t(#t1)⟩ = ⟨Expression#2 ↑t(#t2)⟩ ⟧ ↑t(TypeIf(And(And( Not(TypeComp(#t1, Error)), TypeComp(#t1, #t2)), LVal(#1)) , #t1, Error));

/*
*** This is now done in the inherited section
*/
//⟦ ⟨Expression#1 ↑t(#t1)⟩ = ⟨ObjectLiteral#2 ↑t(#t2)⟩ ⟧ ↑t(TypeIf(And(And( Not(TypeComp(#t1, Error)), TypeComp(#t1, #t2)), LVal(#1)) , #t1, Error));

// Tests for LVal on #1 and than checks if #1 and #2 are int. The mess is due to the reqirements that if #1 is string than #2 can be int OR string
// it also checks if they can be added
⟦ ⟨Expression#1 ↑t(#t1)⟩ += ⟨Expression#2 ↑t(#t2)⟩ ⟧ ↑t(TypeIf(And(LVal(#1), Or( And( TypeComp(#t1, TDType(⟦ int ⟧)), TypeComp(#t1, #t2)) , And( TypeComp(#t1, TDType(⟦ string ⟧)), Or( TypeComp(#t2, TDType(⟦ int ⟧)), TypeComp(#t2, TDType(⟦ string ⟧)))) )), TypeAdds(#t1, #t2), Error));

⟦ ⟨Expression#1⟩ , ⟨Expression#2⟩ ⟧ ↑t(None);

sort Expression | ↑ps ;

/*
*** This is not an elegant solution and if I was redoing this I would make my TD a vector from the start
* I am duplicating code from above just to construct a parameter type vector/list
*/
 
⟦ ⟨SimpleLiteral#1 ↑t(#t1)⟩ ⟧ ↑ps(TDListConst(#t1, TDListEmpty));

⟦ ⟨Expression#1 ↑t(#t1)⟩ ( ⟨Expression#2 ↑ps(#ps1)⟩ ) ⟧ ↑ps(TDListConst( DoCall(#t1 , #ps1)  , TDListEmpty));
⟦ ⟨Expression#1 ↑t(#t1)⟩ ( ) ⟧ ↑ps(TDListConst( DoCall(#t1 , TDListEmpty) , TDListEmpty));

/*
*** This is now done in the inherited section since DoMember needs an environment. DoMember has been converted to DoMemberEnv
*/
//⟦ ⟨Expression#1 ↑t(#t1)⟩ . ⟨ID#2⟩ ⟧ ↑ps(TDListConst( DoMember(#t1 , #2) , TDListEmpty));


⟦ ⟨Expression#1⟩ ( ⟨Expression#2⟩ ) ⟧ ↑ps(TDListEmpty) ;
⟦ ⟨Expression#1⟩ ( ) ⟧ ↑ps(TDListEmpty);
⟦ ⟨Expression#1⟩ . ⟨ID#2⟩ ⟧ ↑ps(TDListEmpty) ;

⟦ ! ⟨Expression#1 ↑t(#t1)⟩ ⟧ ↑ps(TDListConst(TypeIf( TypeComp(#t1, TDType(⟦ boolean ⟧)) , #t1, Error), TDListEmpty));
⟦ - ⟨Expression#1 ↑t(#t1)⟩ ⟧ ↑ps(TDListConst(TypeIf( TypeComp(#t1, TDType(⟦ int ⟧)) , #t1, Error), TDListEmpty));
⟦ + ⟨Expression#1 ↑t(#t1)⟩ ⟧ ↑ps(TDListConst(TypeIf( TypeComp(#t1, TDType(⟦ int ⟧)) , #t1, Error), TDListEmpty));

⟦ ⟨Expression#1 ↑t(#t1)⟩ * ⟨Expression#2 ↑t(#t2)⟩ ⟧ ↑ps(TDListConst(TypeIf(And( TypeComp(#t1, TDType(⟦ int ⟧)), TypeComp(#t1, #t2)) , #t1, Error), TDListEmpty));
⟦ ⟨Expression#1 ↑t(#t1)⟩ / ⟨Expression#2 ↑t(#t2)⟩ ⟧ ↑ps(TDListConst(TypeIf(And( TypeComp(#t1, TDType(⟦ int ⟧)), TypeComp(#t1, #t2)) , #t1, Error), TDListEmpty));
⟦ ⟨Expression#1 ↑t(#t1)⟩ % ⟨Expression#2 ↑t(#t2)⟩ ⟧ ↑ps(TDListConst(TypeIf(And( TypeComp(#t1, TDType(⟦ int ⟧)), TypeComp(#t1, #t2)) , #t1, Error), TDListEmpty));

⟦ ⟨Expression#1 ↑t(#t1)⟩ + ⟨Expression#2 ↑t(#t2)⟩ ⟧ ↑ps(TDListConst(TypeAdds(#t1, #t2), TDListEmpty));
⟦ ⟨Expression#1 ↑t(#t1)⟩ - ⟨Expression#2 ↑t(#t2)⟩ ⟧ ↑ps(TDListConst(TypeIf(And( TypeComp(#t1, TDType(⟦ int ⟧)), TypeComp(#t1, #t2)) , #t1, Error), TDListEmpty));

// TypeIf returns bool or Error based on the firts argument which is just nested And and Ors
⟦ ⟨Expression#1 ↑t(#t1)⟩ < ⟨Expression#2 ↑t(#t2)⟩ ⟧ ↑ps(TDListConst(TypeIf( Or(And( TypeComp(#t1, TDType(⟦ int ⟧)), TypeComp(#t1, #t2)) , And( TypeComp(#t1, TDType(⟦ string ⟧)), TypeComp(#t1, #t2))) , TDType(⟦ boolean ⟧), Error), TDListEmpty));
⟦ ⟨Expression#1 ↑t(#t1)⟩ > ⟨Expression#2 ↑t(#t2)⟩ ⟧ ↑ps(TDListConst(TypeIf( Or(And( TypeComp(#t1, TDType(⟦ int ⟧)), TypeComp(#t1, #t2)) , And( TypeComp(#t1, TDType(⟦ string ⟧)), TypeComp(#t1, #t2))) , TDType(⟦ boolean ⟧), Error), TDListEmpty));
⟦ ⟨Expression#1 ↑t(#t1)⟩ <= ⟨Expression#2 ↑t(#t2)⟩ ⟧ ↑ps(TDListConst(TypeIf( Or(And( TypeComp(#t1, TDType(⟦ int ⟧)), TypeComp(#t1, #t2)) , And( TypeComp(#t1, TDType(⟦ string ⟧)), TypeComp(#t1, #t2))) , TDType(⟦ boolean ⟧), Error), TDListEmpty));
⟦ ⟨Expression#1 ↑t(#t1)⟩ >= ⟨Expression#2 ↑t(#t2)⟩ ⟧ ↑ps(TDListConst(TypeIf( Or(And( TypeComp(#t1, TDType(⟦ int ⟧)), TypeComp(#t1, #t2)) , And( TypeComp(#t1, TDType(⟦ string ⟧)), TypeComp(#t1, #t2))) , TDType(⟦ boolean ⟧), Error), TDListEmpty));

⟦ ⟨Expression#1 ↑t(#t1)⟩ == ⟨Expression#2 ↑t(#t2)⟩ ⟧ ↑ps(TDListConst(TypeIf(And( Not(TypeComp(#t1, Error)), TypeComp(#t1, #t2)) , TDType(⟦ boolean ⟧), Error), TDListEmpty));
⟦ ⟨Expression#1 ↑t(#t1)⟩ != ⟨Expression#2 ↑t(#t2)⟩ ⟧ ↑ps(TDListConst(TypeIf(And( Not(TypeComp(#t1, Error)), TypeComp(#t1, #t2)) , TDType(⟦ boolean ⟧), Error), TDListEmpty));

⟦ ⟨Expression#1 ↑t(#t1)⟩ && ⟨Expression#2 ↑t(#t2)⟩ ⟧ ↑ps(TDListConst(TypeIf(And( TypeComp(#t1, TDType(⟦ boolean ⟧)), TypeComp(#t1, #t2)) , #t1, Error), TDListEmpty));

⟦ ⟨Expression#1 ↑t(#t1)⟩ || ⟨Expression#2 ↑t(#t2)⟩ ⟧ ↑ps(TDListConst(TypeIf(And( TypeComp(#t1, TDType(⟦ boolean ⟧)), TypeComp(#t1, #t2)) , #t1, Error), TDListEmpty));

⟦ ⟨Expression#1 ↑t(#t1)⟩ = ⟨Expression#2 ↑t(#t2)⟩ ⟧ ↑ps(TDListConst(TypeIf(And(And( Not(TypeComp(#t1, Error)), TypeComp(#t1, #t2)), LVal(#1)) , #t1, Error), TDListEmpty));

/*
*** This is now done in the inherited section
*/
//⟦ ⟨Expression#1 ↑t(#t1)⟩ = ⟨ObjectLiteral#2 ↑t(#t2)⟩ ⟧ ↑ps(TDListConst(TypeIf(And(And( Not(TypeComp(#t1, Error)), TypeComp(#t1, #t2)), LVal(#1)) , #t1, Error), TDListEmpty));

// Tests for LVal on #1 and than checks if #1 and #2 are int. The mess is due to the reqirements that if #1 is string than #2 can be int OR string
// it also checks if they can be added
⟦ ⟨Expression#1 ↑t(#t1)⟩ += ⟨Expression#2 ↑t(#t2)⟩ ⟧ ↑ps(TDListConst(TypeIf(And(LVal(#1), Or( And( TypeComp(#t1, TDType(⟦ int ⟧)), TypeComp(#t1, #t2)) , And( TypeComp(#t1, TDType(⟦ string ⟧)), Or( TypeComp(#t2, TDType(⟦ int ⟧)), TypeComp(#t2, TDType(⟦ string ⟧)))) )), TypeAdds(#t1, #t2), Error), TDListEmpty));

// create the list of type descriptors. If the list is empty add the #t2 type otherwise concatinate the lists
// Exp#2 could be a single Exp in that case the vector is just #t1 and #t2 and #ps1 is empty
// if Exp#2 is Exp , Exp then we use the vector #ps1 and add #t1 to it
// the simple function TDListIfEmpty, which returns 2nd or 3rd argument based on 1st, does not seem to work in production 'Exp ( Exp )'
// 		when I just pass is the same values. I described this behavior in 2.3.3
//⟦ ⟨Expression#1 ↑t(#t1)⟩ , ⟨Expression#2 ↑t(#t2) ↑ps(#ps1) ⟩ ⟧ ↑ps(TDListAppend(TDListConst(#t1, TDListEmpty), TDListIfEmpty(#ps1, TDListConst(#t2, TDListEmpty) , #ps1)));

// *** I gave up with the above attempt and recalculated the parameter list everywhere ***
⟦ ⟨Expression#1 ↑ps(#ps1)⟩ , ⟨Expression#2 ↑ps(#ps2) ⟩ ⟧ ↑ps(TDListAppend(#ps1, #ps2));

// ------------------------------------------------------------------------------
sort SimpleLiteral  |  ↑t ;

⟦ ⟨STR#⟩ ⟧ ↑t(TDType(⟦ string ⟧));  
⟦ ⟨INT#⟩ ⟧ ↑t(TDType(⟦ int ⟧));

// ------------------------------------------------------------------------------
sort ObjectLiteral  |  ↑t ;

⟦ { } ⟧  ↑t(Class(TDMapEmpty));

⟦ { ⟨KeyValue#1 ↑mm(#mm1)⟩ ⟨KeyValueTail#2 ↑mm(#mm2)⟩ } ⟧ ↑t(Class(TDMapAppend(#mm1, #mm2)));

// ------------------------------------------------------------------------------
sort KeyValueTail   |  ↑mm ;

⟦ , ⟨KeyValue#1 ↑mm(#mm1)⟩ ⟨KeyValueTail#2 ↑mm(#mm2)⟩ ⟧ ↑mm(TDMapAppend(#mm1, #mm2)) ;

⟦ ⟧ ↑mm(TDMapEmpty);

// ------------------------------------------------------------------------------
sort KeyValue       |  ↑mm ;

⟦ ⟨ID#1⟩ : ⟨Expression#2 ↑t(#t1)⟩ ⟧ ↑mm(TDMapConst(Key(#1), #t1, TDMapEmpty));

// ------------------------------------------------------------------------------


// INHERITED ATTRIBUTES (just e)
// ------------------------------------------------------------------------------
sort Program  | scheme Pe(Program) ↓e ;

Pe(⟦ ⟨Declarations#1⟩ ⟧ ↑#syn) → ⟦ ⟨Declarations Dse(#1)⟩ ⟧ ↑#syn ;

// ------------------------------------------------------------------------------
sort Declarations | scheme Dse(Declarations) ↓e ;

Dse(⟦ ⟨Declaration#D⟩ ⟨Declarations#Ds⟩ ⟧ ↑#syn) → ⟦ ⟨Declaration De(#D)⟩ ⟨Declarations Dse(#Ds)⟩ ⟧ ↑#syn ;
Dse(⟦⟧ ↑#syn) → ⟦⟧ ↑#syn;

// ------------------------------------------------------------------------------
sort Declaration | scheme De(Declaration) ↓e ;

// we need to extend the members with THIS key and class name as type value
// we also need to add all the members and method in this class so that they can be used inside the class

De(⟦ class ⟨ID#1⟩ { ⟨Members#Ms ↑mm(#mm1)⟩ } ⟧ ↑#syn) ↓e(#e) → ⟦ class ⟨ID#1⟩ { ⟨Members Mse(#Ms) ↓e(TDMapAppend(TDMapAppend(TDMapConst(This,TDType(#1),TDMapEmpty), #mm1),#e))⟩ } ⟧ ↑#syn ;

/*
*** Extend statements with the map of parameters and the return type
**  Checking can only be done once env has been recursively passed down 
*   The dependency that is satisfied through the extra carrier scheme DeB
*
**  See Se( ⟦ return ; ⟧ ) below for explanation of why there is a return added to map and a inherited return attribute
*/
De(⟦ function ⟨Type#1⟩ ⟨ID#2⟩ ⟨ArgumentSignature#3 ↑mm(#mm1)⟩ { ⟨Statements#4⟩ } ⟧ ↑#syn) ↓e(#e) → DeB(⟦ function ⟨Type#1⟩ ⟨ID#2⟩ ⟨ArgumentSignature#3⟩ { ⟨Statements Sse(#4) ↓e(TDMapAppend(TDMapAppend(TDMapConst(Return,TDType(#1),TDMapEmpty), #mm1), #e)) ↓r(TDType(#1))⟩ } ⟧ ↑#syn) ↓e(#e); 
{
	| scheme DeB(Declaration) ↓e ;
	DeB( ⟦ function ⟨Type#1⟩ ⟨ID#2⟩ ⟨ArgumentSignature#3 ↑ps(#ps1)⟩ { ⟨Statements#4 ↑ok(#ok1)⟩ } ⟧ ) ↓e(#e) → ⟦ function ⟨Type#1⟩ ⟨ID#2⟩ ⟨ArgumentSignature#3⟩ { ⟨Statements#4⟩ } ⟧ ↑ok(And(#ok1, GoodTypes(#e, TDListAppend(TDListConst(TDType(#1),TDListEmpty) ,#ps1) ,True)));
}

// ------------------------------------------------------------------------------
sort Members | scheme Mse(Members) ↓e ;

// again we have a dependency that is satisfied by the helper scheme that carries the env down first

Mse(⟦ ⟨Member#M⟩ ⟨Members#Ms⟩ ⟧ ↑#syn) ↓e(#e) → MseB(⟦ ⟨Member Me(#M) ↓e(#e)⟩ ⟨Members Mse(#Ms) ↓e(#e)⟩ ⟧ ↑#syn) ↓e(#e); 
{
	| scheme MseB(Members) ↓e ;
	// We do not need to test if Types are good here (i.e. GoodTypes) since its done at the method and variable level
	MseB(⟦ ⟨Member#M ↑ok(#ok1) ↑ps(#ps1)⟩ ⟨Members#Ms ↑ok(#ok2)⟩ ⟧) ↓e(#e) → ⟦ ⟨Member#M⟩ ⟨Members#Ms⟩ ⟧ ↑ok(And(#ok1,#ok2));//**** No longer necessary And( And(GoodTypes(#e, #ps1, True) , #ok1) , #ok2));
}

Mse(⟦⟧ ↑#syn) → ⟦⟧ ↑#syn;
// ------------------------------------------------------------------------------
sort Member | scheme Me(Member)  ↓e ;

/*
*** Extend statements with the map of parameters and the return type
**  Checking can only be done once env has been recursively passed down 
*
**  See Se( ⟦ return ; ⟧ ) below for explanation of why there is a return added to map and a inherited return attribute
*/
Me(⟦ ⟨Type#1⟩ ⟨ID#2⟩ ⟨ArgumentSignature#3 ↑mm(#mm1)⟩ { ⟨Statements#4⟩ } ⟧ ↑#syn) ↓e(#e) → MeB(⟦ ⟨Type#1⟩ ⟨ID#2⟩ ⟨ArgumentSignature#3⟩ { ⟨Statements Sse(#4) ↓e(TDMapAppend(TDMapAppend(TDMapConst(Return,TDType(#1),TDMapEmpty), #mm1), #e)) ↓r(TDType(#1))⟩ } ⟧ ↑#syn) ↓e(#e);
{
	| scheme MeB(Member) ↓e ;
	MeB(⟦ ⟨Type#1⟩ ⟨ID#2⟩ ⟨ArgumentSignature#3 ↑ps(#ps1)⟩ { ⟨Statements#4 ↑ok(#ok1)⟩ } ⟧ ) ↓e(#e) → ⟦ ⟨Type#1⟩ ⟨ID#2⟩ ⟨ArgumentSignature#3⟩ { ⟨Statements#4⟩ } ⟧ ↑ok(And(#ok1, GoodTypes(#e, TDListAppend( TDListConst(TDType(#1),TDListEmpty), #ps1), True)));
	
}

Me(⟦ ⟨Type#1⟩ ⟨ID#2⟩ ; ⟧ ↑ps(#ps1)) ↓e(#e) → ⟦ ⟨Type#1⟩ ⟨ID#2⟩ ; ⟧ ↑ok(GoodTypes(#e, #ps1, True));

// ------------------------------------------------------------------------------
sort Statements | scheme Sse(Statements) ↓e ↓r;


Sse(⟦ ⟨Statement#S ↑mm(#mm1)⟩ ⟨Statements#Ss⟩ ⟧  ↑#syn) ↓e(#e) ↓r(#r) → SseB(⟦ ⟨Statement Se(#S) ↓e(#e) ↓r(#r)⟩ ⟨Statements Sse(#Ss) ↓e(TDMapAppend(#mm1,#e)) ↓r(#r)⟩ ⟧  ↑#syn) ↓e(#e);
{
	| scheme SseB(Statements) ↓e  ↓r;
	SseB(⟦ ⟨Statement#S ↑ok(#ok1) ↑ps(#ps1)⟩ ⟨Statements#Ss ↑ok(#ok2)⟩ ⟧ ↑#syn) ↓e(#e) → ⟦ ⟨Statement#S⟩ ⟨Statements#Ss⟩ ⟧ ↑ok(And( And(GoodTypes(#e, #ps1, True) , #ok1) , #ok2));
}

Sse(⟦⟧ ↑#syn) → ⟦⟧ ↑#syn;

// ------------------------------------------------------------------------------
sort Statement | Se(Statement) ↓e ↓r;

Se(⟦ { ⟨Statements#Ss⟩ } ⟧ ↑#syn) ↓e(#e) ↓r(#r) → ⟦ { ⟨Statements Sse(#Ss) ↓e(#e) ↓r(#r)⟩ } ⟧ ↑#syn ;

Se(⟦ var ⟨Type#1⟩ ⟨ID#2⟩ ; ⟧ ↑#syn) →  ⟦ var ⟨Type#1⟩ ⟨ID#2⟩ ; ⟧ ↑#syn;

Se(⟦ ⟨Expression#E⟩ ; ⟧ ↑#syn) ↓e(#e) → ⟦ ⟨Expression Ee(#E) ↓e(#e)⟩ ; ⟧ ↑#syn ;

Se(⟦ if ( ⟨Expression#E⟩ ) ⟨IfTail#It⟩ ⟧ ↑#syn) ↓e(#e) ↓r(#r) → ⟦ if ( ⟨Expression Ee(#E) ↓e(#e)⟩ ) ⟨IfTail ITe(#It) ↓e(#e) ↓r(#r)⟩ ⟧ ↑#syn ;

Se(⟦ while ( ⟨Expression#E⟩ ) ⟨Statement#S⟩ ⟧ ↑#syn) ↓e(#e) ↓r(#r) → ⟦ while ( ⟨Expression Ee(#E) ↓e(#e)⟩ ) ⟨Statement Se(#S) ↓e(#e) ↓r(#r)⟩ ⟧ ↑#syn ;

// we need to first passdown the inherited e to Exp before we can ask it for type
Se(⟦ return ⟨Expression#E⟩ ; ⟧ ↑#syn) ↓e(#e) ↓r(#r) → SeReturn(⟦ return ⟨Expression Ee(#E) ↓e(#e)⟩ ; ⟧ ↑#syn) ↓e(#e) ↓r(#r) ;
{
	| scheme SeReturn(Statement) ↓e  ↓r;
	// See below for explanation.
	//SeReturn(⟦ return ⟨Expression#E ↑t(#t1)⟩ ; ⟧) ↓e(#e) ↓r(#r) → ⟦ return ⟨Expression#E⟩ ; ⟧ ↑ok(IsSameTypeForObjectLiterals(TDMapLookup(#e, Return ) , #t1));
	SeReturn(⟦ return ⟨Expression#E ↑t(#t1)⟩ ; ⟧) ↓e(#e) ↓r(#r) → ⟦ return ⟨Expression#E⟩ ; ⟧ ↑ok(IsSameType(#r , #t1));//↑ok(TypeComp(#r , #t1));
}
/*
*** problems has bee resolved partially and solved completely with inherited attribute
**  TDMapLookup(#e, Return) now works but I'm leaving the inherited attribute since it was tested with with it.
*   The only thing that does not work with the commented out statement is returning "this" and it should be fixed in 
*   IsSameTypeForObjectLiterals along the same lines as in IsSameType
*
*** The uncommented statement works with all cases!
*/
//Se( ⟦ return ; ⟧ ) ↓e(#e) → ⟦ return ; ⟧ ↑ok(IsSameTypeForObjectLiterals(TDMapLookup(#e, Return), TDType(⟦ void ⟧)) );
Se( ⟦ return ; ⟧ ) ↓e(#e) ↓r(#r)  → ⟦ return ; ⟧ ↑ok(IsSameType(#r, TDType(⟦ void ⟧)) );

Se( ⟦ ; ⟧ ↑#syn) → ⟦ ; ⟧ ↑#syn;

// ------------------------------------------------------------------------------
sort Expression | Ee(Expression) ↓e ;

// the inherited attribute e has to be explicitly passed down even if not needed or it wont be available downstream
// I have reported this as a bug

Ee(⟦ ⟨SimpleLiteral#1⟩ ⟧ ↑#syn) → ⟦ ⟨SimpleLiteral#1⟩ ⟧ ↑#syn;

Ee(⟦ ⟨ID#1⟩ ⟧) ↓e(#e) → ⟦ ⟨ID#1⟩ ⟧ ↑t(TDMapLookup(#e, Key(#1))) ↑ps(TDListConst(TDMapLookup(#e, Key(#1)), TDListEmpty));

// Works!
Ee(⟦ this ⟧) ↓e(#e) → ⟦ this ⟧ ↑t( TDMapLookup(#e, This)) ↑ps(TDListConst(TDMapLookup(#e, This), TDListEmpty));

Ee(⟦ ⟨Expression#1⟩ ( ⟨Expression#2⟩ ) ⟧  ↑#syn) ↓e(#e) → ⟦ ⟨Expression Ee(#1) ↓e(#e)⟩ ( ⟨Expression Ee(#2) ↓e(#e)⟩ ) ⟧  ↑#syn ;

Ee(⟦ ⟨Expression#1⟩ ( ) ⟧ ↑#syn) ↓e(#e) → ⟦ ⟨Expression Ee(#1) ↓e(#e)⟩ ( ) ⟧ ↑#syn ;

Ee(⟦ ⟨Expression#1⟩ . ⟨ID#2⟩ ⟧ ↑#syn) ↓e(#e) → EeBClass(⟦ ⟨Expression Ee(#1) ↓e(#e)⟩ . ⟨ID#2⟩ ⟧ ↑#syn ) ↓e(#e);
{
	| scheme EeBClass(Expression) ↓e ;
	EeBClass(⟦ ⟨Expression#1 ↑t(#t1) ↑ps(#ps1)⟩ . ⟨ID#2⟩ ⟧) ↓e(#e)  → ⟦ ⟨Expression#1⟩ . ⟨ID#2⟩ ⟧ ↑t(DoMemberEnv(#e, #t1, #2)) ↑ps(#ps1);
}

Ee(⟦ ! ⟨Expression#1⟩ ⟧ ↑#syn) ↓e(#e) → ⟦ ! ⟨Expression Ee(#1) ↓e(#e)⟩ ⟧ ↑#syn ;

Ee(⟦ - ⟨Expression#1⟩ ⟧ ↑#syn) ↓e(#e) → ⟦ - ⟨Expression Ee(#1) ↓e(#e)⟩ ⟧ ↑#syn;

Ee(⟦ + ⟨Expression#1⟩ ⟧ ↑#syn) ↓e(#e) → ⟦ + ⟨Expression Ee(#1) ↓e(#e)⟩ ⟧ ↑#syn ;

Ee(⟦ ⟨Expression#1⟩ * ⟨Expression#2⟩ ⟧ ↑#syn) ↓e(#e) → ⟦ ⟨Expression Ee(#1) ↓e(#e)⟩ * ⟨Expression Ee(#2) ↓e(#e)⟩ ⟧ ↑#syn ;
Ee(⟦ ⟨Expression#1⟩ / ⟨Expression#2⟩ ⟧ ↑#syn) ↓e(#e) → ⟦ ⟨Expression Ee(#1) ↓e(#e)⟩ / ⟨Expression Ee(#2) ↓e(#e)⟩ ⟧ ↑#syn ;
Ee(⟦ ⟨Expression#1⟩ % ⟨Expression#2⟩ ⟧ ↑#syn) ↓e(#e) → ⟦ ⟨Expression Ee(#1) ↓e(#e)⟩ % ⟨Expression Ee(#2) ↓e(#e)⟩ ⟧ ↑#syn ;

Ee(⟦ ⟨Expression#1⟩ + ⟨Expression#2⟩ ⟧ ↑#syn) ↓e(#e) → ⟦ ⟨Expression Ee(#1) ↓e(#e)⟩ + ⟨Expression Ee(#2) ↓e(#e)⟩ ⟧ ↑#syn ;
Ee(⟦ ⟨Expression#1⟩ - ⟨Expression#2⟩ ⟧ ↑#syn) ↓e(#e) → ⟦ ⟨Expression Ee(#1) ↓e(#e)⟩ - ⟨Expression Ee(#2) ↓e(#e)⟩ ⟧ ↑#syn ;

Ee(⟦ ⟨Expression#1⟩ < ⟨Expression#2⟩ ⟧ ↑#syn) ↓e(#e) → ⟦ ⟨Expression Ee(#1) ↓e(#e)⟩ < ⟨Expression Ee(#2) ↓e(#e)⟩ ⟧ ↑#syn ;
Ee(⟦ ⟨Expression#1⟩ > ⟨Expression#2⟩ ⟧ ↑#syn) ↓e(#e) → ⟦ ⟨Expression Ee(#1) ↓e(#e)⟩ > ⟨Expression Ee(#2) ↓e(#e)⟩ ⟧ ↑#syn ;
Ee(⟦ ⟨Expression#1⟩ <= ⟨Expression#2⟩ ⟧ ↑#syn) ↓e(#e) → ⟦ ⟨Expression Ee(#1) ↓e(#e)⟩ <= ⟨Expression Ee(#2) ↓e(#e)⟩ ⟧ ↑#syn ;
Ee(⟦ ⟨Expression#1⟩ >= ⟨Expression#2⟩ ⟧ ↑#syn) ↓e(#e) → ⟦ ⟨Expression Ee(#1) ↓e(#e)⟩ >= ⟨Expression Ee(#2) ↓e(#e)⟩ ⟧ ↑#syn ;

Ee(⟦ ⟨Expression#1⟩ == ⟨Expression#2⟩ ⟧ ↑#syn) ↓e(#e) → ⟦ ⟨Expression Ee(#1) ↓e(#e)⟩ == ⟨Expression Ee(#2) ↓e(#e)⟩ ⟧ ↑#syn ;
Ee(⟦ ⟨Expression#1⟩ != ⟨Expression#2⟩ ⟧ ↑#syn) ↓e(#e) → ⟦ ⟨Expression Ee(#1) ↓e(#e)⟩ != ⟨Expression Ee(#2) ↓e(#e)⟩ ⟧ ↑#syn ;

Ee(⟦ ⟨Expression#1⟩ && ⟨Expression#2⟩ ⟧ ↑#syn) ↓e(#e) → ⟦ ⟨Expression Ee(#1) ↓e(#e)⟩ && ⟨Expression Ee(#2) ↓e(#e)⟩ ⟧ ↑#syn ;

Ee(⟦ ⟨Expression#1⟩ || ⟨Expression#2⟩ ⟧ ↑#syn) ↓e(#e) → ⟦ ⟨Expression Ee(#1) ↓e(#e)⟩ || ⟨Expression Ee(#2) ↓e(#e)⟩ ⟧ ↑#syn ;

Ee(⟦ ⟨Expression#1⟩ = ⟨Expression#2⟩ ⟧ ↑#syn) ↓e(#e) → ⟦ ⟨Expression Ee(#1) ↓e(#e)⟩ = ⟨Expression Ee(#2) ↓e(#e)⟩ ⟧ ↑#syn ;

/*
*** We need to pass the env in before we can synthesize type for checking
**  The statement looks complicated but all it does is check if Exp is not an error, is LVal, and if OL is a subset of Exp Type
*   ps is just a list with exactly the same computations for type as above.
*   My t attribute is a single value thats why I also need to create a list of types for function/method parameter checking. Prof. Rose has t as a list to start with
*
*** Exp type initially is somehting like [ classname ], the TDMapLookupTD returns the corresponding Class(TDMap) type for it
**  IsSameTypeForObjectLiterals just checks if OL is submap of Class(TDMap). It also forces the TDMapLookupTD to be computed which seems to be a confusing issue in hacs 
*/
Ee(⟦ ⟨Expression#1⟩ = ⟨ObjectLiteral#2⟩ ⟧ ↑#syn) ↓e(#e) → EeBOL(⟦ ⟨Expression Ee(#1) ↓e(#e)⟩ = ⟨ObjectLiteral OLe(#2) ↓e(#e)⟩ ⟧ ↑#syn) ↓e(#e) ;
{
	| scheme EeBOL (Expression) ↓e ;
	EeBOL(⟦ ⟨Expression#1 ↑t(#t1)⟩ = ⟨ObjectLiteral#2 ↑t(#t2)⟩ ⟧) ↓e(#e) → ⟦ ⟨Expression#1⟩ = ⟨ObjectLiteral#2⟩ ⟧ ↑t(TypeIf(And(And( Not(TypeComp(#t1, Error)), IsSameTypeForObjectLiterals(TDMapLookupTD(#e, #t1), #t2)), LVal(#1)) , #t1, Error)) 
		↑ps(TDListConst( TypeIf(And(And( Not(TypeComp(#t1, Error)), IsSameTypeForObjectLiterals(TDMapLookupTD(#e, #t1), #t2)), LVal(#1)) , #t1, Error) , TDListEmpty)) ;
}

Ee(⟦ ⟨Expression#1⟩ += ⟨Expression#2⟩ ⟧ ↑#syn) ↓e(#e) → ⟦ ⟨Expression Ee(#1) ↓e(#e)⟩ += ⟨Expression Ee(#2) ↓e(#e)⟩ ⟧ ↑#syn ;

Ee(⟦ ⟨Expression#1⟩ , ⟨Expression#2⟩ ⟧ ↑#syn) ↓e(#e) → ⟦ ⟨Expression Ee(#1) ↓e(#e)⟩ , ⟨Expression Ee(#2) ↓e(#e)⟩ ⟧ ↑#syn ;

// ------------------------------------------------------------------------------
sort IfTail | scheme ITe(IfTail) ↓e ↓r;
ITe(⟦ ⟨Statement#1⟩ else ⟨Statement#2⟩ ⟧ ↑#syn) ↓e(#e) ↓r(#r) → ⟦ ⟨Statement Se(#1) ↓e(#e) ↓r(#r)⟩ else ⟨Statement Se(#2) ↓e(#e) ↓r(#r)⟩ ⟧ ↑#syn ;
ITe(⟦ ⟨Statement#1⟩ ⟧  ↑#syn) ↓e(#e) ↓r(#r) → ⟦ ⟨Statement Se(#1) ↓e(#e) ↓r(#r)⟩ ⟧  ↑#syn;

// ------------------------------------------------------------------------------
sort ObjectLiteral  |  scheme OLe(ObjectLiteral) ↓e ;

OLe(⟦ { ⟨KeyValue#1⟩ ⟨KeyValueTail#2⟩ } ⟧  ↑#syn) ↓e(#e) → ⟦ { ⟨KeyValue KVe(#1) ↓e(#e)⟩ ⟨KeyValueTail KVTe(#2) ↓e(#e)⟩ } ⟧  ↑#syn ;

OLe(⟦ { } ⟧ ↑#syn) → ⟦ { } ⟧ ↑#syn;
// ------------------------------------------------------------------------------
sort KeyValueTail   |  scheme KVTe(KeyValueTail)  ↓e ;

KVTe(⟦ , ⟨KeyValue#1⟩ ⟨KeyValueTail#2⟩ ⟧  ↑#syn) ↓e(#e) → ⟦ , ⟨KeyValue KVe(#1) ↓e(#e)⟩ ⟨KeyValueTail KVTe(#2) ↓e(#e)⟩ ⟧  ↑#syn ;

KVTe(⟦⟧ ↑#syn) → ⟦⟧ ↑#syn;
// ------------------------------------------------------------------------------
sort KeyValue       |  scheme KVe(KeyValue)  ↓e ;

KVe(⟦ ⟨ID#1⟩ : ⟨Expression#2⟩ ⟧  ↑#syn) ↓e(#e) →  ⟦ ⟨ID#1⟩ : ⟨Expression Ee(#2) ↓e(#e)⟩ ⟧  ↑#syn ;

// ------------------------------------------------------------------------------
}

