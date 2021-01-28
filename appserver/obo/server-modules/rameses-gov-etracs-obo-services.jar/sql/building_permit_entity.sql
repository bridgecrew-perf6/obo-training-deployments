[cleanUpEntity]
DELETE FROM building_permit_entity 
WHERE appid = $P{appid} 
AND objid NOT IN ( SELECT ba.applicantid 
		FROM building_permit ba 
		WHERE ba.objid=$P{appid} )
AND objid NOT IN ( SELECT ownerid FROM building_permit_rpu WHERE appid=$P{appid} )

[findOrphan]
SELECT COUNT(*) AS counter 
FROM building_permit_entity 
WHERE appid = $P{appid} 
AND objid NOT IN ( 
		SELECT ba.applicantid 
		FROM building_permit ba 
		WHERE ba.objid=$P{appid} )
AND objid NOT IN ( SELECT ownerid FROM building_permit_rpu WHERE appid=$P{appid} )