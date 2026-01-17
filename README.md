# Test technique Ruby on rails

* Voici une ébauche d'application RoR. L'objectif de ce test technique est de compléter/corriger/améliorer le code de chaque couche.

## Modèles
* Liste des modèles :
    * Account (compte client Baqio) ;
    * AccountEvent (événement) ;
    * Customer (client) ;
    * Order (commande) ;
    * OrderLine (ligne de commande) ;
    * Invoice (facture) ;
    * Fulfillment (expédition) ;
    * FulfillmentService (transporteur).

* Ecrire les migrations permettant de générer le schéma de base de données. (*)

* Ecrire un seed pour créer quelques commandes en base de données.

* Ecrire les tests Rpec pour couvrir la globalité du code du modèle **Order**. (*)

* Notes :
    * Il sera probablement nécessaire d'ajouter des associations manquantes...
    * Vous pouvez utiliser une base de données de type SQLite pour plus de facilité.

## Services
* Ecrire les tests Rpec pour couvrir la globalité du code de la couche services (*)

* Identifier et réaliser des améliorations dans le code des services (*)

## Contrôleurs et vues
* Identifier et réaliser des améliorations dans la requête index (*)

* Compléter les méthodes éventuellement manquantes, avec les tests Rspec correspondants. (*)

* Remarque : écrire si possible des tests fonctionnels et/ou de requête.

## Nouveau besoin fonctionnel
* Nous souhaitons tracer les modifications réalisées sur certains champs des modèles :
    * Order : total_price, status ;
    * OrderLine : unit_price.

* Réaliser une implémentation de ce besoin sans utiliser de gem existante (*).

## Attentes et contraintes
### Contraintes
* Vous devez créer un projet sur votre compte Github.

* Pour des questions de lisibilité, merci de :
    * faire un premier commit contenant l'initialisation de l'application Rails (7 ou supérieur) ;
    * faire un deuxième commit pour intégrer le code de départ fourni ici (sans modification) ;
    * faire un commit par item développé (*).

* Lorsque votre test est prêt, merci de nous partager votre repository en lecture :
    * Sylvain (https://github.com/Sylvain) ;
    * Jérôme (https://github.com/jlamarque34).

### Attentes
* L'application Rails doit pouvoir être lancée, et l'affichage de la liste de commandes doit fonctionner.

* Les tests doivent s'exécuter sans erreur/failure.

* Dans l'idéal, vos actions sont documentées (notamment les lignes de commande utilisées).

## Remarques
* Le code de départ peut contenir des erreurs et/ou des trous volontaires... A vous de les reboucher :)

* Vous pouvez bien entendu nous contacter pour toute question ou besoin d'information complémentaire

Merci et bon courage 😇