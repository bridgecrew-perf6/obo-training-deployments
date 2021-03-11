#OBO UPDATES

ALTER TABLE `obo_checklist_master` 
ADD COLUMN `system` int(1) ,
ADD COLUMN `evaltypeid` varchar(50),
ADD CONSTRAINT `fk_obo_checklist_master_evaltypeid` FOREIGN KEY (`evaltypeid`) REFERENCES `building_evaluation_type` (`objid`);

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

ALTER TABLE `obo_legazpi`.`obo_requirement_type` 
ADD COLUMN `evaltypeid` varchar(50);