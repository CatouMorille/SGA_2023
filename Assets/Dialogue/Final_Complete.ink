VAR error = false

Arrivé devant l'église, une lumière t'envahit tout entier. 

Tu penses que ta mort est  
    * [un bête accident]
        ~error = true
        -> ACCIDENT 
    * [un odieux crime ! ]
        -> MURDER
        
=== ACCIDENT ===
Selon toi tu as été tué par
    * [un animal]
        -> 
    * [un humain]
        -> 

=== AccidentAnimal ===
L'animal responsable de ta mort, est 
    * [une vache]
        -> AccidentVache
    * [un canard]+++++++++
        -> AccidentCanard
        

=== AccidentHumain === 

    * [un homme]
    * [une femme]
-> Final

=== AccidentCanard === 
Vous pensez qu'un canard vous a becqueté. 
-> Final




=== MURDERtrue ===
Il y a pas de doute, le meurtrier est 
    * [un homme]
        -> MurderHomme
    * [une femme]
        ~error = true
        -> MurderFemme

=== MurderHomme === 
Et c'est homme, c'est 
    * [ton meilleur pote Adrien]
        -> MurderAdrien
    * [ton patron, M. Roussy]
        ~error = true
        -> MurderAutre

=== MurderAdrien === 
Mais pourquoi ton meilleur pote voudrait-il te tuer ? 
    * [Par jalousie voyons !]
        ~error = true
        -> MurderAPjalousie
    * [Il pense que je l'ai trahi, le bougre !]
        -> MurderAPtrahison


=== MurderAPtrahison === 
Qu'est-ce qui pourrait lui faire croire que je l'ai trahi ?
    * [Sa soeur raconte des sottises à mon encontre !]
            ~error = true
        -> MurderAPsoeur
    * [Sa précieuse poule qui a disparu !]
        -> MurderPoule

=== MurderPoule ===
C'est quoi cette histoire de poule ? 




=== MurderFemme ===
Cette femme, il se pourrait bien que ce soit 
    * [Gwenaëlle, que vous avez croisé au village]
        -> 
    * [Shanti Pugin, la mère de votre meilleur pote]
        -> 

=== MurderAutre === 
Pourquoi ton patron, 
        


    -> END
