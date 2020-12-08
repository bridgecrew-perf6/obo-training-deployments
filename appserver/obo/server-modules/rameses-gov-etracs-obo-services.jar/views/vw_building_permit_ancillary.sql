DROP VIEW IF EXISTS vw_building_permit_doc;
CREATE VIEW vw_building_permit_doc AS 
SELECT 
   a.*,
    pt.title,
    pt.sortorder    
FROM building_permit_doc a 
INNER JOIN obo_doctype pt ON a.doctypeid = pt.objid 

