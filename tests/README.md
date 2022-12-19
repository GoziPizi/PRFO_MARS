## Test des graphs 

## Test des files de priorité

### Test unitaires

### Property Based Testing 

Pour cette partie des tests, on va implementer une version simple mais non eficace des files de priorités et la comparer avec notre implémentations plus complexes pour verifier que notre implémentation complexe fonctionne correctement.

Inspiration : TP QCheck de l'UE validation et verification logiciel

Tout d'abord, il nous faut une liste des commandes que l'on peut réaliser sur notre file de priorité.
On peut réaliser trois actions : 

- Trouver le min 
- Supprimer le min
- Inserer un élément
- Verifier si la liste est vide 

On va generer des listes de commandes à partir de ces differentes commandes unitaires, puis les aplliquer a la fois sur notre implementation complexe et notre implementation simple. 

Il y a trois types de valeurs de retour. 
Soit on recoit un Int, dans le cas ou on recherche le top 
Soit on recoit rien du tout.
Soit on recoit une erreur.
On doit tester toutes ces valeurs de retour.


#### Utilisation 