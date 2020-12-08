[getCategorizedFees]
SELECT b.objid, b.item_title, b.grouptitle AS section, b.amount 
FROM 
(SELECT a.*,
CASE a.feegroup
  WHEN  'OCCUPANCY_PERMIT' THEN 'OCCUPANCY PERMIT FEES'
  WHEN  'FIRE' THEN 'FIRE PERMIT FEES'
  ELSE 'OTHER FEES'
END	 
AS grouptitle,
CASE a.feegroup 
   WHEN 'OCCUPANCY_PERMIT' THEN 1000
   WHEN 'FIRE' THEN 3000	
	 ELSE 4000
END + a.sortorder AS itemorder 	 	 
FROM 
(SELECT bf.objid, oa.title AS item_title, oa.sortorder, bf.amount,  
CASE 
    WHEN NOT(os.org_objid IS NULL) THEN os.objid 
    ELSE 'OCCUPANCY_PERMIT'  
END  AS feegroup 
FROM occupancy_permit_fee bf 
INNER JOIN obo_itemaccount oa ON bf.itemid = oa.objid 
LEFT JOIN obo_doctype od ON oa.doctypeid = od.objid 
LEFT JOIN obo_section os ON od.sectionid = os.objid 
WHERE bf.appid=$P{appid}) a) b
ORDER BY b.itemorder 