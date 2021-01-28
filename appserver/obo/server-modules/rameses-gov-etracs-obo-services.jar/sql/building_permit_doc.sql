[getSubdocsToAutoCreate]
SELECT * FROM obo_doctype 
WHERE apptype = $P{apptype} 
AND autocreate = 1
AND objid NOT IN ( SELECT doctypeid FROM building_permit_doc WHERE appid = $P{appid} )


[findDocsToReleaseCount]
SELECT COUNT(*) AS count    
FROM building_permit_doc bs 
INNER JOIN building_permit bp ON bs.appid = bp.objid 
INNER JOIN building_permit_task bt ON bp.taskid = bt.taskid 
INNER JOIN obo_doctype od ON bs.doctypeid = od.objid
LEFT JOIN obo_section os ON od.sectionid=os.objid
WHERE od.objid = $P{doctypeid} 
AND bt.state = 'releasing'
AND od.refdoc IS NULL
AND bs.controlid IS NULL
AND od.role IN ( ${roles} )  

[findAllDocsToReleaseCount]
SELECT COUNT(*) AS count    
FROM building_permit_doc bs 
INNER JOIN building_permit bp ON bs.appid = bp.objid 
INNER JOIN building_permit_task bt ON bp.taskid = bt.taskid 
INNER JOIN obo_doctype od ON bs.doctypeid = od.objid
LEFT JOIN obo_section os ON od.sectionid=os.objid
WHERE od.issuetype = 2 
AND bt.state = 'releasing'
AND bs.controlid IS NULL
AND od.refdoc IS NULL
AND od.role IN ( ${roles} )  
AND (CASE WHEN os.org_objid IS NULL THEN 'root' ELSE os.org_objid END) = $P{orgid}


[getSubdocsToEmail]
SELECT sd.*, dt.template, dt.controlnopattern
FROM building_permit_doc sd 
INNER JOIN obo_doctype dt ON sd.doctypeid=dt.objid
WHERE sd.appid = $P{appid}
AND NOT(dt.template IS NULL)

[getDocsThatRequireFees]
SELECT dt.title 
FROM building_permit_doc sd 
INNER JOIN obo_doctype dt ON sd.doctypeid = dt.objid 
WHERE sd.appid = $P{appid} 
AND dt.requirefee = 1 
AND (sd.amount IS NULL OR sd.amount <= 0)