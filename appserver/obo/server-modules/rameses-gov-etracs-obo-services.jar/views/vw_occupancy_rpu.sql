DROP VIEW IF EXISTS vw_occupancy_rpu;
CREATE VIEW vw_occupancy_rpu AS 
SELECT 
 orpt.*, 
 app.apptype,
 app.bldgpermitid,
 app.applicantid,
 app.actualprojectcost,
 app.occupancytypeid,
 app.actualnumunits,
 app.actualnumfloors,
 app.actualtotalfloorarea,
 app.actualheight,
 app.dtactualstarted,
 app.dtactualcompleted,
 app.inspectiondate,
 bp.objid AS bldgappid,
 bp.controlno AS bldgpermitno,
 bp.dtissued AS bldgpermitdtissued,  
 bp.title AS title, 
 bp.location_text,
 op.objid AS occpermitid,
 op.controlno AS occpermitno, 
 op.dtissued AS occpermitdtissued 
FROM occupancy_rpu orpt
INNER JOIN vw_occupancy_permit app  ON orpt.appid=app.objid
INNER JOIN vw_building_permit bp ON app.bldgpermitid=bp.objid 
LEFT JOIN obo_control op ON app.controlid = op.objid 