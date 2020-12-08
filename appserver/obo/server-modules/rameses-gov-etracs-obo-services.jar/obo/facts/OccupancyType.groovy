package obo.facts;

import java.util.*;

public class OccupancyType {

	String division; //objid		
    String group;	 //parentid	
    String type;
	String id;

	//need to deprecate
    String bldgtype; //deprecate this		
    String zoneclass;	

    public OccupancyType() {}

    public OccupancyType(def occ) {
    	if(occ.division?.objid!=null ) this.division = occ.division.objid; 
	    if(occ.group?.objid!=null ) this.group = occ.group.objid; 
	    if(occ.objid ) this.type = occ.objid;
    }


}