[getInspectionsToActivate]
SELECT a.objid FROM 
( 
	SELECT objid FROM occupancy_inspection_type WHERE required = 1 
	UNION ALL 
	SELECT objid FROM occupancy_inspection_type WHERE required = 0 
	AND sectionid IN ( 
		SELECT dt.sectionid FROM occupancy_permit_doc sd 
		INNER JOIN obo_doctype dt ON sd.doctypeid = dt.objid
		WHERE sd.appid = $P{appid}
	)
) a 
WHERE a.objid NOT IN ( SELECT typeid FROM occupancy_inspection WHERE appid = $P{appid} )	

[getSubdocsToActivate]
SELECT bd.objid 
FROM obo_doctype bd 
WHERE bd.autocreate = 1 
AND bd.apptype = 'occupancy'
AND bd.inspectiontypeid = $P{typeid}
AND bd.objid NOT IN ( 
	SELECT doctypeid FROM occupancy_permit_doc WHERE appid = $P{appid}
)

[getDocsThatRequireFees]
SELECT dt.title
FROM occupancy_permit_doc sd
INNER JOIN obo_doctype dt ON sd.doctypeid = dt.objid 
INNER JOIN occupancy_inspection be ON be.appid = sd.appid AND dt.inspectiontypeid = be.typeid 
WHERE be.objid = $P{inpsectionid}
AND dt.requirefee = 1 
AND (sd.amount IS NULL OR sd.amount <= 0)


[getOtherInfos]
SELECT name,datatype,category,unit,caption 
FROM obo_variable
WHERE typeid = $P{typeid}
AND name NOT IN ( 
	SELECT name FROM occupancy_permit_info 
	WHERE appid=$P{appid}
)

