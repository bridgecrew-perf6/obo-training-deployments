DROP VIEW IF EXISTS vw_obo_occupancy_type;
CREATE VIEW vw_obo_occupancy_type AS 
SELECT 
ot.*,  
od.objid AS division_objid,
od.title AS division_title,
og.objid AS group_objid,
og.title AS group_title
FROM obo_occupancy_type ot
INNER JOIN obo_occupancy_type_division od ON ot.divisionid = od.objid
INNER JOIN obo_occupancy_type_group og ON od.groupid = og.objid