[getCategorizedFees]
SELECT a.tag, SUM( a.amount ) AS amount   
FROM 
( 
SELECT rt.tag, bf.amount 
FROM obo_itemaccount oi 
INNER JOIN obo_itemaccount_report_tag rt ON rt.itemid = oi.objid 
INNER JOIN building_permit_fee bf ON bf.itemid = oi.objid  
WHERE bf.appid = $P{appid}
AND rt.tag LIKE 'BUILDING_PERMIT_REPORT:%' 
) a  GROUP BY a.tag 

UNION ALL 

SELECT 'BUILDING_PERMIT_REPORT:OTHER' AS tag , SUM(bf.amount) AS amount
FROM building_permit_fee bf
WHERE bf.appid = $P{appid}
AND bf.itemid NOT IN ( 
	SELECT aa.itemid 
	FROM obo_itemaccount_report_tag aa 
	WHERE aa.tag LIKE 'BUILDING_PERMIT_REPORT:%' )