[getEvaluationsToActivate]
SELECT a.objid FROM 
( 
	SELECT objid FROM building_evaluation_type WHERE required = 1 AND activationstate = $P{state}
	UNION ALL 
	SELECT objid FROM building_evaluation_type WHERE required = 0 AND activationstate = $P{state}
	AND sectionid IN ( 
		SELECT dt.sectionid FROM building_permit_doc sd 
		INNER JOIN obo_doctype dt ON sd.doctypeid = dt.objid
		WHERE sd.appid = $P{appid}
	)
) a 
WHERE a.objid NOT IN ( SELECT typeid FROM building_evaluation WHERE appid = $P{appid})	

[getDocsThatRequireFees]
SELECT dt.title 
FROM building_permit_doc sd 
INNER JOIN obo_doctype dt ON sd.doctypeid = dt.objid 
INNER JOIN building_evaluation_type bet ON bet.sectionid = dt.sectionid 
INNER JOIN building_evaluation be ON be.typeid = bet.objid 
WHERE be.objid = $P{evaluationid}
AND be.appid = sd.appid 
AND dt.requirefee = 1 
AND (sd.amount IS NULL OR sd.amount <= 0)