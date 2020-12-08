package obo.facts;

import java.util.*;

public class BuildingInfo {
	String worktype;

	String apptype;
	double projectcost;			//computed. 
	double fixedcost;  			//fixed cost
	double highercost;			//whichever is higher = computed or fixed

	double floorarea; 			//deprecated
	double totalfloorarea; 		
	double height;
	int numunits = 1;

	String zoneclass;
	String zone;

	public BuildingInfo() {}

	public BuildingInfo(def app) {
		if( app.apptype !=null) this.apptype = app.apptype; 
        if( app.projectcost !=null ) this.projectcost = app.projectcost;
        if( app.fixedcost !=null ) this.fixedcost = app.fixedcost;
        if( app.height !=null ) this.height = app.height;
        if( app.numunits !=null ) this.numunits = app.numunits;
        if( app.totalfloorarea !=null ) this.totalfloorarea = app.totalfloorarea;
        if( app.zoneclass?.objid !=null ) this.zoneclass = app.zoneclass.objid;
        if( app.zone != null ) this.zone = app.zone;

        if( this.fixedcost > this.projectcost ) {
        	this.highercost = this.fixedcost;
        }
        else {
        	this.highercost = this.projectcost;
        }
	}

}


