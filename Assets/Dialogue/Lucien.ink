Lucien Bärtschi est, comme d'habitude, en train de dormir à poings fermés. 
    + [Le réveiller]
        -> awake
    + [Le laisser dormir]
        -> asleep
        
=== awake ===
« C'est quoi c'raffut ?! C'est quand même pas possible, quand c'est pas c'tablard de taureau qui beugle, y'a quelqu'un pour v'nir me réveiller ! Y'a pas moyen de faire un somme par ici ! »
    + [Désolé mec, mais je suis mort et j'ai besoin de ton aide.]
        -> aide
    + [Arrête ton char ! Tu passes ta journée à dormir !]
        -> aide

            
=== aide ===
« Parbleu ! Damien, c'est toi ? Mais t'étais pas mort ?! »
    + [Ouais il semblerait bien...]
        -> taureau
    + [Ah ben bravo, quelle perspicacité !]
        -> taureau
            
=== taureau === 
« J'pensais pas dire ça un jour, mais tu m'manques ! Depuis qu't'es plus là, y'a plus personne pour faire entendre raison à c'taureau des enfers. Il est beau énervé et meugle non stop ! Même ton collègue ose plus l'approcher ! »
    + [Ça m'étonne pas, j'ai toujours été meilleur que lui !]
        -> best
    + [C'est bizarre, ce taureau est plutôt calme d'habitude !]
        -> quiet

=== best ===
« Vu comme t'es prétentieux, j'comprends mieux pourquoi ton collègue t'a traité de tous les noms avant qu'tu trépasses ! 
    -> enerve
    
=== quiet ===
« Alors vu comme ton collègue était r'monté contre toi juste avant qu'tu trépasses, autant t'dire que ça m'étonne pas qu'ça a déteint sur l'taureau ! 
    -> enerve

=== enerve ===
R'garde-moi pas avec ces yeux ronds ! Chais pas du tout t'dire la raison d'sa colère ! <br>Tout c'que chais, c'est qu'ça m'a réveillé et qu'là, j'ai encore du sommeil en r'tard ! »
-> END

=== asleep ===
       « Zzzzzz... taureau... Zzzzzz... dormir... Zzzzzz.... arrête de beugler... Zzzzzz... manger du steak... Zzzzzz... »
    -> END
