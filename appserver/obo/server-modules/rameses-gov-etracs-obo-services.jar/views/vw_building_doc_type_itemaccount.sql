DROP VIEW IF EXISTS vw_obo_doctype_itemaccount; 
CREATE VIEW vw_obo_doctype_itemaccount AS 
SELECT 
   a.objid,
   a.title,
   e.typeid 
FROM obo_itemaccount a 
INNER JOIN obo_doctype_itemaccount e ON a.objid = e.itemid 

