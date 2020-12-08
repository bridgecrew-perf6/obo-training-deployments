[getInspectionsToActivate]
SELECT a.objid FROM occupancy_inspection_type a
WHERE a.objid NOT IN ( SELECT typeid FROM occupancy_inspection WHERE appid = $P{appid})	

