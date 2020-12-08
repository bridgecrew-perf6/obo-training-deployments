DROP VIEW IF EXISTS vw_occupancy_permit_fee;
CREATE VIEW vw_occupancy_permit_fee AS 
SELECT 
   a.*,
   sd.doctypeid 
FROM occupancy_permit_fee a 
LEFT JOIN occupancy_permit_doc sd ON a.parentid = sd.objid
