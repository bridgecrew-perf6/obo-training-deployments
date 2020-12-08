DROP VIEW IF EXISTS vw_building_permit_online;
CREATE VIEW vw_building_permit_online AS 
SELECT 
   a.*,
   bt.objid AS occupancytype_objid,
   bt.title AS occupancytype_title,   
   od.objid AS occupancytype_division_objid,
   od.title AS occupancytype_division_title,   
   og.objid AS occupancytype_group_objid,
   og.title AS occupancytype_group_title,

   e.name AS applicant_name,
   e.address_text AS applicant_address_text,
   t.state AS task_state
   
FROM building_permit a 
INNER JOIN obo_occupancy_type bt ON a.occupancytypeid = bt.objid
INNER JOIN obo_occupancy_type_division od ON bt.divisionid = od.objid
INNER JOIN obo_occupancy_type_group og ON od.groupid = og.objid
INNER JOIN building_permit_entity e ON a.applicantid = e.objid
LEFT JOIN building_permit_task t ON a.taskid = t.taskid 
WHERE a.taskid IS NULL
