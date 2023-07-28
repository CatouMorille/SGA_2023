VAR error = false
VAR reaction = ""
VAR PresqueEndingCause = ""
VAR FalseEndingCause = ""
VAR caractere = ""
VAR angry = false
VAR neutre = false

Une silhouette étrange et lumineuse se tient devant ta tombe. 
Elle t'interpelle : « Ô toi, âme égarée ! Arrête-toi un instant. »
    * [Mais t'es apparue quand toi?!]
        ~reaction = "et j'apparais quand je veux ! J"
    * [Pardon, mais t'es qui toi ?!]
        ~reaction = "figures-toi ! Et j"
    - -> StePierrette

=== StePierrette === 
« Surveille ton langage petit ! Je suis Sainte Pierrette {reaction}e suis la seule ici à pouvoir t'aider. 
As-tu découvert ce qui t'es arrivé ? »
    * [Non]
        -> Sortie
    * [Oui]
        -> Pret

=== Sortie === 
« Alors va ! Fouille, interroge et surtout, réfléchis ! Je n'ai pas de temps à perdre avec les idiots. 
Quand tu sauras ce qui t'es arrivé, reviens me voir et je verrai si je peux te faire entrer au Paradis. »
-> END

=== Pret == =
« C'est bien ! Tu es donc prêt à répondre à mes questions ? »
    * [Oui !]
        -> questionnaire
    * [Heu... non en fait, pas vraiment...]
        -> SortieFache 

=== SortieFache ===
« Alors cesse de me faire perdre mon temps et ne reviens quand tu sauras vraiment ce qui t'es arrivé !»
    -> END

=== Questionnaire === 
Bien ! Alors commençons avec une question facile. Tu penses que ta mort est  
    * [un bête accident]
        ~error = true
        -> ACCIDENT 
    * [un odieux crime ! ]
        -> MURDER
        
=== ACCIDENT ===
Selon toi tu as été tué par
    * [un taureau]
        -> AccidentVache
    * [un canard]
        -> AccidentCanard

=== AccidentCanard === 
Vous avez soudain une illumation : « C'est exactement ça ! Un canard enragé m'a bequeté jusqu'à ce que mort s'en suive quand je passais au bord de l'étang ! »
~VAR angry = true
-> FalseEnding


=== AccidentVache ===
Et comment ce taureau t'a-t-il tué ? 
    * [il m'a encorné]
        -> AccidentEncorne
    * [il m'a écrasé de tout son poids]
        -> AccidentEcrase

=== AccidentEncorne === 
Et qu'est-ce qui aurait provoqué ce comportement ? 
    * [ta propre incompétence]
        -> AccidentIncompetent
    * [quelqu'un l'a volontairement excité]
        -> AccidentExcite

=== AccidentIncompetent === 
« Si tu es aussi doué avec les bêtes que pour les enquêtes, ça ne m'étonnerait pas du tout ! »
-> FalseEnding


=== AccidentExcite === 
Qui pourrait être cette personne ?
    * [ton meilleur pote Adrien]
        ~PresqueEndingCause = "C'est ça ! Comme on travaille ensemble, Adrien a dû exciter involontairement le taureau !"
        -> PresqueEndingRationnel
    * [ton patron, M. Roussy]
        ~FalseEndingCause = "M. Roussy connaît tellement peu ses bêtes qu'il a dû invonlontairement exciter le taureau lorsque je travaillais !"
        -> FalseEnding


=== AccidentEcrase === 
« Et selon toi la vache serait tombée d'où ?! Du toit d'une maison peut-être ?! » 
-> FalseEnding


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
    * [Gwenaëlle, que vous avez croisée au village]
        -> RaisonGwen
    * [Shanti Pugin, la mère de votre meilleur pote]
        -> RaisonFantome 

=== RaisonGwen === 
Pourquoi Gwenaëlle aurait-elle voulu te tuer ? 
    * [Par jalousie]
        ~FalseEndingCause : "jalousie"
        -> FalseEndingGwen
    * [Par cupidité]
        ~FalseEndingCause : "cupidité"
        -> FalseEndingGwen

=== FalseEndingGwen == 
« Ah non mais ça suffit ces clichés sur les femmes ! Elles ne sont pas toutes des créatures remplie de {FalseEndingCause} quand même !»
-> FalseEnding

=== RaisonFantome === 
Ca tombe sous le sens ! Tu t'écries : « C'est certainement parce qu'elle ne supportait pas le lien que j'avais avec son fils »
Sainte Pierrette tape violemment sa crosse au sol, hors d'elle. « Mais voyons ! Shanti Pugin est morte depuis des mois ! »
-> FalseEnding

=== MurderAutre === 
Pourquoi ton patron, voudrait-il donc te tuer ? 
    * [pour mon insolence]
        ~caractere = "C'est donc mon mauvais caractère qui m'a coûté la vie ?!"
        -> FalseEndingCause
    * [pour mon caractère de cochon]
        ~caractere = "C'est donc mon mauvais caractère qui m'a coûté la vie ?!"
        -> FalseEndingCause


=== MurderAdrien === 
Mais pourquoi ton meilleur pote voudrait-il te tuer ? 
    * [Par jalousie voyons !]
        ~error = true
        ~FalseEndingCause
        -> FalseEnding
    * [Il pense que je l'ai trahi, le bougre !]
        -> MurderAPtrahison


=== MurderAPtrahison === 
Qu'est-ce qui pourrait lui faire croire que je l'ai trahi ?
    * [Sa soeur raconte des sottises à mon encontre !]
            ~error = true
        -> PresqueEndingGwen
    * [Sa précieuse poule qui a disparu !]
        -> MurderPoule

=== MurderPoule ===
Non mais c'est quoi cette histoire de poule ? 
    * [Il pense que j'ai volé sa poule magique !]
        -> MurderVol
    * [Il croît que j'ai fait rôtir l'entier de ses poules !]
        ~error = true
        ~PresqueEndingCause = "C'est donc ma légendaire gourmandise qui m'a tué ?"
        -> PresqueEndingAneries

==== MurderVol === 
Et qu'est-ce qui vraiment arrivé à cette poule ? 
    * [C'est quelqu'un d'autre qui l'a volée !]
        ~error = true
        ~PresqueEndingCause = "C'est horrible ! Adrien m'a tué pour le crime de quelqu'un d'autre !"
        -> PresqueEndingRationnel
    * [C'est cette feignasse de Lucien qui l'a tuée !]
        -> MurderCause


==== MurderCause === 
Et comment Adrien a-t-il procédé pour te tuer ? 
    * [Il a déguisé ça en accident !]
        -> MurderTaureau
    * [Il m'a sauvagement poignardé]
        ~PresqueEndingCause = "Ce saligaud, il m'a poignardé dans le dos !"
        -> PresqueEndingRationnel

=== MurderTaureau === 
Qu'est-ce qu'il a utilisé ? 
    * [un taureau avec lequel on travaille]
        -> TrueEnding
    * [un des canards de l'étang]
        ~PresqueEndingCause = "Ce saligaud, il a entraîné un canard pour venir me picorer les entrailles !"
        -> PresqueEndingAneries


=== PresqueEndingGwen === 
Les pièces du puzzle s'agencent alors que tu réponds aux questions de Sainte Pierrette. 
Tu t'écries : « Ce serait donc sa soeur, Gwenaëlle, qui lui a monté la bourrichon contre moi ?! » 
Sainte Pierrette secoue la tête : « Faudrait voir pour arrêter d'accuser toujours les femmes aussi ! »
Cette accusation gratuite semble l'avoir visiblement énervée.  

=== PresqueEndingRationnel === 
Les pièces du puzzle s'agencent alors que tu réponds aux questions de Sainte Pierrette. 
Tu t'écries : « {PresqueEndingCause} » 


=== PresqueEndingAneries === 
Les pièces du puzzle s'agencent alors que tu réponds aux questions de Sainte Pierrette. 
Tu t'écries : « {PresqueEndingCause} » 
Sainte Pierrette secoue la tête : « Faudrait voir pour arrêter d'inventer des âneries quand même ! »
Puis elle reprend, un peu plus conciliante.  
        -> PresqueEnding

=== FalseEndingCause === 
Les pièces du puzzle s'agencent alors que tu réponds aux questions de Sainte Pierrette. 
Tu t'écries : « {FalseEndingCause} » 
-> FalseEnding


=== FalseEnding ===
{angry : Sainte Pierrette tape violemment sa crosse au sol, hors d'elle. « Ah non hein ! J'ai pas de temps à perdre avec des âneries, moi ! »|Sainte Pierrette soupire et te regarde d'un air dépité.} 
« Est-ce que je t'ai dit que je détestais perdre mon temps ?
Allez, va refaire un tour et ne reviens que quand tu auras réfléchis un peu ! Je n'ai pas de temps à perdre avec les idiots ! »
-> END


=== PresqueEnding === 
« C'est quand même dommage d'échouer si près du but ! Allez, réfléchis encore un peu et reviens me voir !
Mais traîne pas, j'ai d'autres morts à aller voir, moi !»
-> END


=== TrueEnding === 
Ca y est. Toutes les pièces du puzzle s'agencent dans ta tête pendant que tu te confies à Sainte Pierrette. 
C'est lui. 
C'est lui, ton meilleur pote. 
C'est lui, Adrien. 
C'est lui qui t'a trahi ! Qui a excité ce satané taureau à l'aide de son foulard rouge pour qu'il te percute en pleine face.
Mais comment a-t-il pu croire que tu le trahirais ? Comment a-t-il pu penser que tu lui volerais sa poule aux oeufs d'or ?
La colère monte : « Adrien m'a encorné avec un taureau ! »
Soudain la voix de Sainte Pierrette retentit de nouveau : « Ohlà petit ! Chuis pas sourde ! Crie pas comme ça !  
Bon, c'est pas tout ça, mais j'ai pas toute l'éternité devant moi ! 
Faudrait voir pour me dire ce que tu veux faire : hanter à tout jamais celui qui t'a trahi ou tu te bouges pour venir nous rejoindre ? »
    * [Je viens au Paradis, bien sûr !]
        -> END
    * [Adrien doit payer !]
        -> END

        


    -> END
