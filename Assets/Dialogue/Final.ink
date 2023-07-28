VAR error = false

Vous pensez que votre mort est due à 
    * [un accident]
        -> accident 
    * [un acte criminel]
        -> murder
        
=== accident ===
~error = true
Selon vous vous avez été tué
    * une vache
        -> AccidentVache
    * un canard
        -> AccidentCanard
        

=== AccidentVache === 
Vous pensez qu'une vache vous a embroché. 
-> Final

=== AccidentCanard === 
Vous pensez qu'un canard vous a becqueté. 
-> Final


=== murder ===
Vous pensez que c'est
    * Lucien
        -> Lucien
    * Claude
        -> Claude
        
=== Lucien === 
Lucien vous a embroché avec une vache. 
    -> Final
    
=== Claude ===
~error = true   
Vous pensez que Claude vous a empoisonné. 
    -> Final

=== Final ===
{error: Vous hanterez ces lieux à jamais...| Bravo! Vous avez tout compris.}

    -> END
