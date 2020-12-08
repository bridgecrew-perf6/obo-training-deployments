[getDocTypes]
SELECT * FROM obo_doctype 
WHERE objid IN 
(SELECT DISTINCT doctypeid 
FROM obo_checklist_master)

