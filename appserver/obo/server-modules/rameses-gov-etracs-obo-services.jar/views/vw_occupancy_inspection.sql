DROP VIEW IF EXISTS vw_occupancy_inspection;
CREATE VIEW vw_occupancy_inspection AS 
SELECT 
   a.*,
   app.bldgpermitid,
   et.title AS type_title,
   et.sortindex AS type_sortindex,
   app.task_state AS app_task_state, 
   t.state AS task_state,
   t.dtcreated AS task_dtcreated,
   t.startdate AS task_startdate,
   t.enddate AS task_enddate,
   t.assignee_objid AS task_assignee_objid,
   t.assignee_name AS task_assignee_name,
   t.actor_objid AS task_actor_objid,
   t.actor_name AS task_actor_name,
   (SELECT title FROM sys_wf_node WHERE processname = 'occupancy_inspection' AND name=t.state) AS task_title,
   0 AS task_timediff,
    os.objid AS sectionid,
   os.org_objid AS org_objid

FROM occupancy_inspection a 
INNER JOIN occupancy_inspection_task t ON a.taskid = t.taskid 
INNER JOIN occupancy_inspection_type et ON a.typeid = et.objid 
INNER JOIN vw_occupancy_permit app ON a.appid = app.objid 
LEFT JOIN obo_section os ON et.sectionid = os.objid