
:-ensure_loaded('RTXengine/RTXengine.pl').


/*


R7: IF: contagious(x) & dangerous(x) THEN: isolated(x)
R8: IF: meningitis(x) THEN: dangerous(x)
*/

defrule([name:r1],
        if fever(X) and red_spots(X)      then assert_rtx(measles(X))  ).

defrule([name:r2],
        if runny_nose(X)                  then assert_rtx(cold(X))  ).

defrule([name:r3],
        if cold(X)                        then assert_rtx(contagious(X))  ).

defrule([name:r4],
        if fever(X) and stiff_neck(X)     then assert_rtx(meningitis(X))  ).

defrule([name:r5],
        if measles(X)                     then assert_rtx(contagious(X))  ).

defrule([name:r6],
        if meningitis(X)                  then assert_rtx(contagious(X))  ).

defrule([name:r7],
        if contagious(X) and dangerous(X) then assert_rtx(isolated(X))  ).

defrule([name:r8],
        if meningitis(X)                  then assert_rtx(dangerous(X))  ).




defrule([name: r9, description: 'locomotion'],
        if     has_wings(X)   then assert_rtx(flies(X))
        elseif has_fins(X)    then assert_rtx(swims(X))
        else                       assert_rtx(walks(X))
       ).


facts_helper:-
    retractall_rtx,
    assert(runny_nose(mary)),
    assert(red_spots(mary)),
    assert(stiff_neck(john)),
    assert(fever(mary)),
    assert(fever(john)).



/*
https://www.chegg.com/homework-help/questions-and-answers/consider-following-system-rules-facts-variable-x-stands-patient-redspots-x-stands-patient--q58322585

a) What can be derived from this knowledge base by Forward chaining? Please show your work step by step;

b) How can isolated(john) be derived by Backward chaining? Show your work step by step.

*/
