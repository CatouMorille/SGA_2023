Mheeeeeuuuuu mheuuuuu. 
    + Mheu ?
        -> Etape1
    + [Partir]
        -> END

=== Etape1 ===
{~Mheeeeeeeeeeuh meuh mheeeeeu.|Mheu mheu !|Mheeeeeuuuuu mheu meh ?|Mheeeeeuuuuu mheu.|Mheu.|Mheeeeeuuuuu !|Mheeeuuuuu mheeeeuuuu mheeeeuuuu !|Mheeeeuuuu....}
    + Mheeeeeeeeeeuh.
        -> Etape2
    + [Partir]
        -> END
        
=== Etape2 ===
{~Mheeeeeeeeeeuh meuh mheeeeeu.|Mheu mheu !|Mheeeeeuuuuu mheu meh ?|Mheeeeeuuuuu mheu.|Mheu.|Mheeeeeuuuuu !|Mheeeuuuuu mheeeeuuuu mheeeeuuuu !|Mheeeeuuuu....|Mheuuuuuh ?|Bon ça va laisse moi tranquille, j'ai de l'herbe à brouter moi !}
    + Mheu!
        -> Etape3
    + [Je suis vraiment en train de parler avec une vache ?]
        -> Etape3
        
=== Etape3 ===
{~Mheeeeeeeeeeuh meuh mheeeeeu.|Mheu mheu !|Mheeeeeuuuuu mheu meh ?|Mheeeeeuuuuu mheu.|Mheu.|Mheeeeeuuuuu !|Mheeeuuuuu mheeeeuuuu mheeeeuuuu !|Mheeeeuuuu....|Mheuuuuuh ?|Bon ça va laisse moi tranquille, j'ai de l'herbe à brouter moi !}
    + Mheeeeu.
        -> Etape4
    + [Partir]
        -> END
        
=== Etape4 ===
{~Mheeeeeeeeeeuh meuh mheeeeeu.|Mheu mheu !|Mheeeeeuuuuu mheu meh ?|Mheeeeeuuuuu mheu.|Mheu.|Mheeeeeuuuuu !|Mheeeuuuuu mheeeeuuuu mheeeeuuuu !|Mheeeeuuuu....|Mheuuuuuh ?|Bon ça va laisse moi tranquille, j'ai de l'herbe à brouter moi !}
    + Mheu mheu ?
        -> Etape5
    + [Partir]
        -> END

=== Etape5 ===
{~Mheeeeeeeeeeuh meuh mheeeeeu.|Mheu mheu !|Mheeeeeuuuuu mheu meh ?|Mheeeeeuuuuu mheu.|Mheu.|Mheeeeeuuuuu !|Mheeeuuuuu mheeeeuuuu mheeeeuuuu !|Mheeeeuuuu....|Mheuuuuuh ?|Bon ça va laisse moi tranquille, j'ai de l'herbe à brouter moi !}
    + Mheh !
        -> Etape1
    + [Partir]
        -> END        


    -> END