VAR error = false

Arrivé devant l'église, une lumière te baigne de sa lumière et une voix résonne dans ta tête. 
« Ô toi, âme égarée ! Arrête-toi un instant. »
    * Qui me parle ?!
    * Non mais oh! T'es qui toi ?
    - -> SaintPierre

=== SaintPierre === 
« Surveille ton langage petit, je suis le seul ici à pouvoir t'aider. As-tu découvert ce qui t'es arrivé ? »
    * Non
        -> Sortie
    * Oui
        -> Pret

=== Sortie === 
« Alors va ! Fouille, interroge et surtout, réfléchis ! Je n'ai pas de temps à perdre avec les idiots. 
Quand tu sauras ce qui t'es arrivé, reviens me voir et je verrai pour te faire entrer au Paradis. »
-> END

=== Pret == =
« C'est bien ! Tu es donc prêt à répondre à mes questions ? »
    * Oui
        -> questionnaire
    * Heu... non en fait, pas vraiment
        -> SortieFache 

=== SortieFache ===
« Alors cesse de me faire perdre mon temps et ne reviens quand tu te sentiras prêt à répondre à mes questions !»
    -> END

=== Questionnaire === 
Bien ! Alors commençaons avec une question facile. Tu penses que ta mort est  
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




=== MURDER ===
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

=== MurderFemme ===
Cette femme, il se pourrait bien que ce soit 
    * [Gwenaëlle, que vous avez croisé au village]
        -> 
    * [Shanti Pugin, la mère de votre meilleur pote]
        -> 

=== MurderAutre === 
Pourquoi ton patron, 

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
Non mais c'est quoi cette histoire de poule ? 
    * [Il pense que j'ai volé sa poule magique !]
        -> MurderVol
    * [Il croît que j'ai fait rôtir l'entier de ses poules !]
        ~error = true
        -> MurderRoti

==== MurderVol === 
Et qu'est-ce qui vraiment arrivé à cette poule ? 
    * [C'est quelqu'un d'autre qui l'a volée !]
        ~error = true
        -> MurderCauseFalse
    * [C'est cette feignasse de Lucien qui l'a tuée !]
        -> MurderCause


==== MurderCause === 
Et comment Adrien a-t-il procédé pour te tuer ? 
    * [Il a déguisé ça en accident !]
        -> MurderTaureau
    * [Il m'a sauvagement poignardé]
        ~error = true
        -> MurderCouteau

=== MurderCouteau === 


=== MurderTaureau === 
Qu'est-ce qu'il a utilisé ? 
    * un taureau avec lequel on travaille
        -> TrueEnding
    * un des canards de l'étang 
        -> PresqueEnding


=== PresqueEnding === 
Tu cries cette phrase, mais personne ne te réponds.  
    * [Saint-Pierre ?]
    * [Hé machin, t'es où ?]
    - -> PresqueEndigSuite

=== PresqueEndigSuite ===     
Tu as beau crier, seuls les murs froids de l'église te renvoient ton propre écho. Tu as pour 

=== TrueEnding === 
Ca y est. Toutes les pièces du puzzle s'agence dans ta tête pendant que tu te confies à Saint-Pierre. 
C'est lui. 
C'est lui, ton meilleur pote. 
C'est lui, Adrien. 
C'est lui qui t'a trahi ! Qui a excité ce satané taureau à l'aide de son foulard rouge pour qu'il te percute en pleine face.
Mais comment a-t-il pu croire que tu le trahirais ? Comment a-t-il pu penser que tu lui volerais sa poule aux oeufs d'or ?
La colère monte : « Adrien m'a encorné avec un taureau ! »
Soudain la voix de Saint-Pierre retentit de nouveau : « Ohlà petit ! Chuis pas sourd ! Crie pas comme ça !  
Bon, j'ai pas toute l'éternité devant moi ! Faudrait voir pour me dire ce que tu veux faire ! 
Tu veux le hanter à tout jamais ou tu te bouges pour venir nous rejoindre ? »
    * [Rejoindre le Paradis, bien sûr !]
        -> END
    * [Rester pour hanter Adrien à tout jamais !]
        -> END

        


    -> END
