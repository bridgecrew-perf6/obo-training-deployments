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