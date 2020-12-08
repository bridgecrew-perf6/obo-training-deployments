DROP VIEW IF EXISTS vw_obo_doctype;
CREATE VIEW vw_obo_doctype AS 
SELECT 
   od.*,
   os.org_objid,
   os.org_name
FROM obo_doctype od 
LEFT JOIN obo_section os ON od.sectionid = os.objid

