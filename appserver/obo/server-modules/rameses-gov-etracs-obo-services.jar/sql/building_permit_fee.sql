[getCategorizedFees]
SELECT b.objid, b.item_title, b.grouptitle AS section, b.amount 
FROM 
(SELECT a.*,
CASE a.feegroup
  WHEN  'BUILDING_PERMIT' THEN 'BUILDING PERMIT FEES'
  WHEN  'FIRE' THEN 'FIRE PERMIT FEES'
  WHEN  'ZONING' THEN 'ZONING FEES'
 	ELSE 'OTHER FEES'
END	 
AS grouptitle,
CASE a.feegroup 
   WHEN 'BUILDING_PERMIT' THEN 1000
   WHEN 'ZONING' THEN 2000
   WHEN 'FIRE' THEN 3000	
	 ELSE 4000
END + a.sortorder AS itemorder 	 	 
FROM 
(SELECT bf.objid, oa.title AS item_title, oa.sortorder, bf.amount,  
CASE 
    WHEN NOT(os.org_objid IS NULL) THEN os.objid 
    WHEN od.objid IS NULL THEN 'OTHER'		
		WHEN od.type = 'OTHER' THEN 'OTHER' 
    WHEN od.type = 'ANCILLARY' THEN 'BUILDING_PERMIT' 
    ELSE od.objid  
END  AS feegroup 
FROM building_permit_fee bf 
INNER JOIN obo_itemaccount oa ON bf.itemid = oa.objid 
LEFT JOIN obo_doctype od ON oa.doctypeid = od.objid 
LEFT JOIN obo_section os ON od.sectionid = os.objid 
WHERE bf.appid=$P{appid}) a) b
ORDER BY b.itemorder 