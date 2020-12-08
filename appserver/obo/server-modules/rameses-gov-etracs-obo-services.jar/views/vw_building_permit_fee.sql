DROP VIEW IF EXISTS vw_building_permit_fee;
CREATE VIEW vw_building_permit_fee AS 
SELECT 
   a.*,
   sd.doctypeid 
FROM building_permit_fee a 
LEFT JOIN building_permit_doc sd ON a.parentid = sd.objid
