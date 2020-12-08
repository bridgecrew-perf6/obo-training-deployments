<b>Building Permit Evaluation</b>
<br>
<%if( data.appno != null) {%>
App No:    ${data.appno}<br>
<%}%> 
<%if( data.trackingno != null) {%>
Tracking No:    ${data.trackingno}<br>
<%}%> 
Applicant: ${data.applicant.name}<br>
Project Title: ${data.title}<br>
<br>
<br>
We have evaulated your plans and we have some concerns regarding the 
following issues. 
<br>
<br>

<%data.requirements.each { k,v-> %>
	<h2>${k.type.title.toUpperCase()}</h2>
	<table border="1">
		<tr>
			<th>Requirement</th>
			<th>Particulars</th>
			<th width="50">Checked By</th>		
		</tr>
		<%v.each { item-> %>
			<tr>
				<td>${item.parent.type.title} ${item.type.title}</td>
				<td>${item.remarks}</td>
				<td>${item.modifiedby.name}</td>
			</tr>
		<%}%>
	</table>
<%}%>
<br>
<%data.findings.each { k,v-> %>
	<h2>${k.typeid.toUpperCase()}</h2>
	<table border="1">
		<tr>
			<th>Particulars</th>
			<th width="50">Checked By</th>		
		</tr>
		<%v.each { item-> %>
			<tr>
				<td>${item.particulars}</td>
				<td>${item.createdby.name}</td>
			</tr>
		<%}%>
	</table>

<%}%>

<br>
Please address these concerns and resubmit your 
application to this address : <a href="xxx">Specify address</a> or you can contact 
us at ... for clarification.
<br>
Respectfully Yours:<br>
<br>
Office of the Building Official<br>
Legazpi City, Albay
<br>
<br>
This is a system generated email. Please do not reply

