Lucien Brätschi est, comme d'habitude, en train de dormir à poings fermés. 
    + [Le réveiller]
        -> awake
    + [Le laisser dormir]
        -> asleep
        
=== awake ===
« C'est quoi c'raffut ?! 
C'est quand même pas possible, quand c'est pas c'tablard de taureau qui beugle, y'a quelqu'un pour venir me réveiller ! Y'a pas moyen de faire un somme par ici ! »
    + [Désolé mec, mais je suis mort et j'ai besoin de ton aide.]
        -> aide
    + [Arrête ton char ! Tu passes ta journée à dormir !]
        -> aide

            
=== aide ===
« Parbleu ! Damien, C'est toi ? Mais t'étais pas mort ?! »
    + [Ouais il semblerait bien...]
        -> taureau
    + [Ah ben bravo, quelle perspicacité !]
        -> taureau
            
=== taureau === 
« J'pensais pas dire ça un jour, mais tu m'manques ! 
Depuis qu't'es plus là, y'a plus personne pour faire entendre raison à c'taureau des enfers. Il est beau énervé et meugle non stop ! Même ton collègue ose plus l'approcher ! »
    + [Ca m'étonne pas, j'ai toujours été meilleur que lui !]
        -> best
    + [C'est bizarre, ce taureau est plutôt calme d'habitude !]
        -> quiet

=== best ===
« En tout cas, on sait maintenant qui est le plus modeste des deux ! C'est pas tout ça, mais je retourne dormir, moi ! »
    -> END
    
=== quiet ===
« Tout c'que j'sais, c'est qu'là il me manque des siestes ! Alors si tu m'en veux pas, j'vais r'tourner pioncer moi. »
    -> END

=== asleep ===
       « Zzzzzz... taureau... Zzzzzz... dormir... Zzzzzz.... arrête de beugler... Zzzzzz... manger du steak... Zzzzzz... »
    -> END
