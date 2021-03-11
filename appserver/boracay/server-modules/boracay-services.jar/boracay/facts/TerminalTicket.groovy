package boracay.facts;

class TerminalTicket {
	
	int numadults;
	int numchildren;
	int numsenior;
	

	public TerminalTicket( def m ) {
		if(m.numadults!=null) this.numadults = m.numadults;
		if(m.numchildren!=null) this.numchildren = m.numchildren;
		if(m.numsenior!=null) this.numsenior = m.numsenior;
	}
}