-- Mission A :Exploration et Audit (SQL) 1.Inventaire : Compter le nombre d'engins par site.
SELECT id_site, COUNT(id_engin) AS nombre_engins
FROM engins 
GROUP BY id_site;

--2.Verification : Identifier s_il y a des jours ou la production a ete nulle (Tonnage = 0).
SELECT date_prod ,tonnage_brut
FROM production p 
WHERE tonnage_brut = 0;

--3. Jointure de controle : Afficher la liste des engins avec le nom de leur site respectif (au lieu de l_ID).
SELECT id_engin, nom
FROM engins e 
JOIN sites s
     ON e.id_site = s.id_site;

-- Mission B: Intelligence Métier et KPIs (SQL Avancé) Production Totale : Somme du tonnage brut par Province et par Type de Minerai.
SELECT province, type_minerai, SUM(tonnage_brut) AS production_totale
FROM production p 
JOIN sites s 
    ON p.id_site = s.id_site 
GROUP BY s.province, p.type_minerai;

--2.Calcul du "Contenu Fin" : Le tonnage de metal pur (Tonnage Brut * Teneur %).
SELECT tonnage_brut, teneur, (tonnage_brut*teneur/100) AS contenu_fin
FROM  production p;

--3.Analyse Financiere : Chiffre d_affaires total par site (Tonnage Vendu * Prix Unitaire).
SELECT e.id_site,prix_unitaire_usd, tonnage_vendu, (tonnage_vendu*prix_unitaire_usd) AS chiffre_d_affaires
FROM exportations e 
GROUP BY e.id_site, prix_unitaire_usd, tonnage_vendu;

--4Alerte Teneur : Lister les sites dont la teneur moyenne est inferieure a 2.5% (seuil de rentabilite).
SELECT  id_site, AVG(p.teneur) AS seuil_de_rentabilite
FROM production p 
GROUP BY  id_site
HAVING AVG(p.teneur) < 2.5;