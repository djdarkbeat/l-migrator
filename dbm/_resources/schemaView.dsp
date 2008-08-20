
<h3>[$thisTable]</h3>

<div class="tblspecs">
<table>
<tr>
	<td class="label" width="100">Table Type</td>
	<td>[$tableSchemaData->'tableType']</td>
</tr>
<tr>
	<td class="label" width="100">Character Set</td>
	<td>[$tableSchemaData->'charSet']</td>
</tr>
<tr>
	<td class="label" width="100">Primary Key</td>
	<td>[$tableSchemaData->'primaryKey']</td>
</tr>
<tr>
	<td class="label" width="100">Unique Key</td>
	<td>[$tableSchemaData->'uniqueKey']</td>
</tr>
<tr>
	<td class="label" width="100">Indexed Fields</td>
	<td>[$tableSchemaData->'indices']</td>
</tr>
</table>
</div>

<div class="fldspecs">
<table>
<tr class="hdr">
	<td width="120">Field Name</td>
	<td width="200">Field Info</td>
	<td width="100">Null</td>
	<td>Default</td>
</tr>
[iterate: ($tableSchemaData->'fieldRows'), var:'thisField']
<tr class="[if: loop_count%2]altrowA[else]altrowB[/if]">
	<td width="120">[$thisField->(find:'name')]</td>
	<td width="200">[$thisField->(find:'info')]</th></td>
	<td width="100">[$thisField->(find:'null')]</th></td>
	<td>[$thisField->(find:'dflt')]</th></td>
</tr>
[/iterate]
</table>
</div>
