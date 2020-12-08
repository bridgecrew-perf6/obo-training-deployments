DROP VIEW IF EXISTS vw_occupancy_permit_doc; 
CREATE VIEW vw_occupancy_permit_doc AS 
SELECT 
   a.*,
   os.org_objid AS org_objid,
   bt.state AS appstate,
   bt.assignee_objid AS appuserid,
   iss.controlno,
   iss.dtissued,
   iss.expirydate,
   iss.issuedby_name,
   iss.issuedby_objid,
   iss.remarks AS issue_remarks,
   iss.template,
   od.sectionid
FROM occupancy_permit_doc a  
INNER JOIN obo_doctype od ON a.doctypeid = od.objid 
LEFT JOIN obo_control iss ON a.controlid = iss.objid 
INNER JOIN occupancy_permit ba ON a.appid = ba.objid 
INNER JOIN occupancy_permit_task bt ON ba.taskid = bt.taskid 
LEFT JOIN obo_section os ON od.sectionid = os.objid
