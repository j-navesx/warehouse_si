:-ensure_loaded('RTXengine/RTXEngine.pl').

/*
defrule(  [name: 'rule_incongruent'],
    if true then (
          writeln('rule fired'),
          1 == 2  % the false statement
    )
 ).

*/


defrule([name: r_turn_cell_on],
   if is_cell(X) and temperature(X, Temp) and (Temp >= 25) then
        assert_rtx(turn_cooler_on)
).


defrule([name: r_cell_is_hot],
   if is_cell(X) and temperature(X, Temp) and (Temp >= 25) then
        assert_rtx(is_hot(X))
).


/*
defrule(  [name: 'example_rule'],
    if true then writeln('rule fired')
 ).





defrule([name: 'rule hello', description: 'rule 1 greets'],
    if     say_hello     then writeln('hello everybody!')
    elseif say_goodbye   then writeln('byeeeee!')
    else                      writeln('nothing to tell!')
).
*/

/*
defrule([name: 'r2', priority: 2, description: 'aaa_r2'],
    if if_r2 then writeln(if_r2)
    elseif else_if_r2 then writeln(else_if_r2)
).

defrule([name: 'r3', priority: 3, description: 'aaa_r3'],
    if if_r3 then writeln(if_r3)
    else writeln(else_r3)
).

defrule([name:r4],
    if if_r4 then writeln(if_r4)
    else writeln(else_r4)
).


defrule([name: rule_up_counter],
    if    counter_I(I) and (I<10)    then (
       writeln(counter_I(I)),
       retract(counter_I(_)),
       I2 is I +1,
       assert(counter_I(I2))
    )
    elseif is_undefined(counter_I(_)) then
       assert(counter_I(0))
    else (
          writeln(end_of_counter),
          retractall(counter_I(_)))
    ).


defrule( [name:demo_seq],
  if  not(sequence(_,escreve,_)) and is_undefined(h(1))
  then[

     Seq=[  (true,writeln(aaa)),
            (true,writeln(bbb)),
            (true,writeln(ccc))
         ],
     assert(sequence(1,escreve, Seq)),
     assert(h(1)),
     writeln(fez_outra)
  ]
).


*/

