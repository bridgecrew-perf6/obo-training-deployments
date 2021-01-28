[getDocumentsToIssue]
SELECT a.* FROM 
(
	SELECT od.objid, od.title, 
	CASE WHEN os.org_objid IS NULL THEN 'root' ELSE os.org_objid END  AS orgid, 
	od.sortorder, od.apptype   
	FROM obo_doctype od
	LEFT JOIN obo_section os ON od.sectionid = os.objid 
	WHERE od.issuetype = 2 
	AND od.refdoc IS NULL
	AND od.role in (${roles})
) a
WHERE a.orgid = $P{orgid}
ORDER BY a.sortorder
