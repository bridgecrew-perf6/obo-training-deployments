[getAllowedTypes]
SELECT DISTINCT y.objid, y.title, y.sortindex
FROM 
(SELECT z.* FROM 
(SELECT bet.objid, bet.sortindex, bet.title, swf.name, IFNULL( betr.role, swf.role) AS role, IFNULL(os.org_objid, 'root') AS orgid     
FROM building_evaluation_type bet
LEFT JOIN obo_section os ON bet.sectionid = os.objid 
INNER JOIN sys_wf_node swf ON swf.processname = 'building_evaluation' 	
LEFT JOIN building_evaluation_type_role betr ON betr.typeid = bet.objid AND betr.state = swf.name
WHERE swf.name NOT IN ( 'start', 'end' )
AND swf.tracktime = 1) z
WHERE z.role IN ( ${roles} ) 
AND z.orgid = $P{orgid}
) y
ORDER BY y.sortindex

[getAllTaskCount]
SELECT COUNT(*) AS count   
FROM  
(SELECT bt.state, typ.objid AS section, IFNULL(os.org_objid, 'root') AS orgid, 
IFNULL( betr.role, sn.role ) AS role
FROM building_evaluation_task bt
INNER JOIN building_evaluation be ON bt.taskid = be.taskid 
INNER JOIN building_evaluation_type typ ON be.typeid = typ.objid
LEFT JOIN obo_section os ON typ.sectionid = os.objid
INNER JOIN sys_wf_node sn ON sn.processname = 'building_evaluation' AND sn.name = bt.state 
LEFT JOIN building_evaluation_type_role betr ON betr.typeid = typ.objid AND betr.state = bt.state
WHERE bt.assignee_objid IS NULL 
AND bt.enddate IS NULL
AND sn.tracktime = 1) z
WHERE z.role IN ( ${roles} )
AND z.orgid = $P{orgid}

[getNodeListTaskCountBySection]
SELECT z.state, COUNT(*) AS count   
FROM  
(SELECT bt.state, typ.objid AS section, IFNULL(os.org_objid, 'root') AS orgid, 
IFNULL( betr.role, sn.role ) AS role
FROM building_evaluation_task bt
INNER JOIN building_evaluation be ON bt.taskid = be.taskid 
INNER JOIN building_evaluation_type typ ON be.typeid = typ.objid
LEFT JOIN obo_section os ON typ.sectionid = os.objid 
INNER JOIN sys_wf_node sn ON sn.processname = 'building_evaluation' AND sn.name = bt.state 
LEFT JOIN building_evaluation_type_role betr ON betr.typeid = typ.objid AND betr.state = bt.state
WHERE bt.assignee_objid IS NULL 
AND bt.enddate IS NULL
AND sn.tracktime = 1) z
WHERE z.section = $P{sectionid} 
AND z.role IN ( ${roles} )
GROUP BY z.state 
