#OBO UPDATES
USE @database;

ALTER TABLE `obo_checklist_master` 
ADD COLUMN `system` int(1) ,
ADD COLUMN `evaltypeid` varchar(50),
ADD CONSTRAINT `fk_obo_checklist_master_evaltypeid` FOREIGN KEY (`evaltypeid`) REFERENCES `building_evaluation_type` (`objid`);

ALTER TABLE `obo_checklist_master` 
ADD COLUMN `inspectiontypeid` varchar(50),
ADD CONSTRAINT `fk_obo_checklist_master_inspectiontypeid` FOREIGN KEY (`inspectiontypeid`) REFERENCES `occupancy_inspection_type` (`objid`);

UPDATE obo_checklist_master SET system = 1;

ALTER TABLE `building_evaluation_finding` 
ADD COLUMN `checklistitemid` varchar(50),
ADD CONSTRAINT `fk_building_permit_finding_checklistitemid` FOREIGN KEY (`checklistitemid`) 
REFERENCES `obo_checklist_master` (`objid`);

DROP VIEW IF EXISTS vw_building_evaluation_consolidated; 
CREATE VIEW vw_building_evaluation_consolidated AS 
SELECT 
be.objid, 
be.appid, 
be.typeid, 
bt.title AS type_title,
btk.state,
btk.assignee_objid,
os.org_objid,
CASE WHEN betr.role IS NULL THEN wn.role ELSE betr.role END AS role 
FROM building_evaluation be 
INNER JOIN building_evaluation_task btk ON be.taskid = btk.taskid 
INNER JOIN building_evaluation_type bt ON be.typeid = bt.objid 
INNER JOIN obo_section os ON bt.sectionid = os.objid 
INNER JOIN sys_wf_node wn ON wn.processname = 'building_evaluation' AND wn.name = btk.state 
LEFT JOIN building_evaluation_type_role betr ON betr.typeid = bt.objid AND betr.state = btk.state; 

ALTER TABLE `obo_requirement_type` 
ADD COLUMN `evaltypeid` varchar(50);

ALTER TABLE `building_evaluation_type` 
ADD COLUMN `joinstate` varchar(50);

UPDATE building_evaluation_type SET joinstate = activationstate;

/* rebuild vw_building_evaluation */
DROP VIEW IF EXISTS vw_building_evaluation;
CREATE VIEW vw_building_evaluation AS 
SELECT 
   a.*,
   os.objid AS sectionid,
   os.org_objid AS org_objid,
   et.title AS type_title,
   et.sortindex AS type_sortindex,
   et.joinstate AS type_joinstate,
   app.task_state AS app_task_state, 
   t.state AS task_state,
   t.dtcreated AS task_dtcreated,
   (  SELECT bst.dtcreated  
      FROM building_evaluation_task bst 
      WHERE bst.refid = a.objid AND bst.state = 'start'
      ORDER BY bst.dtcreated ASC 
      LIMIT 1
   ) AS task_startdate,
   (  SELECT bst.dtcreated  
      FROM building_evaluation_task bst 
      WHERE bst.refid = a.objid AND bst.state = 'end'
      ORDER BY bst.dtcreated DESC 
      LIMIT 1
   ) AS task_enddate,
   t.assignee_objid AS task_assignee_objid,
   t.assignee_name AS task_assignee_name,
   t.actor_objid AS task_actor_objid,
   t.actor_name AS task_actor_name,
   sn.title AS task_title,
   sn.tracktime AS task_tracktime

FROM building_evaluation a 
INNER JOIN building_evaluation_task t ON a.taskid = t.taskid 
INNER JOIN building_evaluation_type et ON a.typeid = et.objid 
LEFT JOIN obo_section os ON et.sectionid = os.objid
INNER JOIN sys_wf_node sn ON sn.processname = 'building_evaluation' AND sn.name = t.state 
INNER JOIN vw_building_permit app ON a.appid = app.objid;

/* REBUILD vw_building_evaluation_consolidated */
DROP VIEW IF EXISTS vw_building_evaluation_consolidated; 
CREATE VIEW vw_building_evaluation_consolidated AS 
SELECT 
be.objid, 
be.appid, 
be.typeid, 
bt.title AS type_title,
bt.sortindex,
btk.state,
btk.assignee_objid,
os.org_objid,
CASE WHEN betr.role IS NULL THEN wn.role ELSE betr.role END AS role 
FROM building_evaluation be 
INNER JOIN building_evaluation_task btk ON be.taskid = btk.taskid 
INNER JOIN building_evaluation_type bt ON be.typeid = bt.objid 
INNER JOIN sys_wf_node wn ON wn.processname = 'building_evaluation' AND wn.name = btk.state 
LEFT JOIN building_evaluation_type_role betr ON betr.typeid = bt.objid AND betr.state = btk.state 
LEFT JOIN obo_section os ON bt.sectionid = os.objid;

/* rebuild vw_building_evaluation */
DROP VIEW IF EXISTS vw_building_evaluation;
CREATE VIEW vw_building_evaluation AS 
SELECT 
   a.*,
   os.objid AS sectionid,
   os.org_objid AS org_objid,
   et.title AS type_title,
   et.sortindex AS type_sortindex,
   et.joinstate AS type_joinstate,
   app.task_state AS app_task_state, 
   t.state AS task_state,
   t.dtcreated AS task_dtcreated,
   t.startdate AS task_startdate,
   t.enddate AS task_enddate,
   t.assignee_objid AS task_assignee_objid,
   t.assignee_name AS task_assignee_name,
   t.actor_objid AS task_actor_objid,
   t.actor_name AS task_actor_name,
   sn.title AS task_title,
   sn.tracktime AS task_tracktime

FROM building_evaluation a 
INNER JOIN building_evaluation_task t ON a.taskid = t.taskid 
INNER JOIN building_evaluation_type et ON a.typeid = et.objid 
LEFT JOIN obo_section os ON et.sectionid = os.objid
INNER JOIN sys_wf_node sn ON sn.processname = 'building_evaluation' AND sn.name = t.state 
INNER JOIN vw_building_permit app ON a.appid = app.objid; 

UPDATE obo_checklist_master SET title = REPLACE( title, '{0}', CONCAT('{',SUBSTR(params,1,1),'}') ) WHERE NOT(params IS NULL);
UPDATE obo_checklist_master SET title = REPLACE( title, '{1}', CONCAT('{',SUBSTR(params,3,1),'}') ) WHERE NOT(params IS NULL);
UPDATE obo_checklist_master SET title = REPLACE( title, '{2}', CONCAT('{',SUBSTR(params,5,1),'}') ) WHERE NOT(params IS NULL);

UPDATE obo_checklist_master SET title = REPLACE(title, '{d}', '{n}' ) WHERE title LIKE '%{d}%';

ALTER TABLE `building_evaluation_finding` ADD COLUMN `values` mediumtext NULL;

DROP VIEW IF EXISTS vw_obo_professional_info_lookup;
CREATE VIEW vw_obo_professional_info_lookup  AS    
SELECT 
    pi.*,
    CONCAT( pi.lastname, ', ', pi.firstname, ' ', SUBSTRING( pi.middlename, 0, 1 ), '.' ) AS name, 
   id.caption AS id_type_caption,
   id.title AS id_type_title
FROM obo_professional_info pi  
INNER JOIN obo_professional p ON p.infoid = pi.objid 
LEFT JOIN idtype id ON pi.id_type_name = id.name
UNION ALL 
SELECT 
    pi.*,
    CONCAT( pi.lastname, ', ', pi.firstname, ' ', SUBSTRING( pi.middlename, 0, 1 ), '.' ) AS name, 
   id.caption AS id_type_caption,
   id.title AS id_type_title
FROM obo_professional_info pi  
LEFT JOIN idtype id ON pi.id_type_name = id.name
WHERE pi.prc_idno NOT IN ( SELECT prcno FROM obo_professional );




