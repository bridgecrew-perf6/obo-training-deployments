package obo.facts;

import java.util.*;

public class OboApplication {

	String appid;
	String appno;
	Date appdate;
	String apptype;				//NEW OR RENEW
	String constructiontype;	

	String worktype;

	double projectcost;			//computed. 
	double fixedcost;  			//fixed cost
	double highercost;			//whichever is higher = computed or fixed

	int numstoreys;
	double floorarea; 			//deprecated
	double totalfloorarea; 		
	double height;
	int numunits = 1;

	String zoneclass;
	String zone;


	public OboApplication() {}

	public OboApplication(def app) {
        this.appid = app.objid;
        this.appno = app.appno;
        this.appdate = app.appdate;
        this.apptype = app.apptype;

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


