<cfif isdefined('form.batchlist')>
<cfoutput>
<cfset batchnewlist = form.batchlist>
<cfquery name="checkexisted" datasource="#dts#">
SELECT id,submited_by,submited_on,batchno FROM argiro WHERE batchno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.batchlist#" separator="," list="yes">) and appstatus in ("Approved","Pending") ORDER BY submited_on
</cfquery>

<cfif checkexisted.recordcount neq 0>
<h2>Please note the following batch(es) was/were submitted earlier and will not be re-submitted:</h2>
<table>
<tr>
<th>Batch No</th>
<th>Submited By</th>
<th>Submited On</th>
</tr>
<cfloop query="checkexisted">
<tr>
<td>#checkexisted.batchno#</td>
<td>#checkexisted.submited_by#</td>
<th>#dateformat(checkexisted.submited_on,'dd/mm/yyyy')#</th>
</tr>
<cfset batchnewlist = listdeleteat(batchnewlist,listfindnocase(batchnewlist,checkexisted.batchno))>
</cfloop>
</table>
<h2>Remaining batch(es) successfully submitted for approval.</h2>
<cfelse>
<h2>Batch(es) successfully submitted for approval.</h2>
</cfif>
<cfloop list="#batchnewlist#" index="a">
<cfquery name="checknosubmit" datasource="#dts#">
SELECT batchno FROM argiro
WHERE batchno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#a#"> and appstatus in ("Approved","Pending")
</cfquery>

<cfif checknosubmit.recordcount eq 0>


<cfquery name="insertrecords" datasource="#dts#">
INSERT INTO argiro
(
  `uuid`,
  `batchno`,
  `invgross`,
  `gstamt`,
  `totalinv`,
  `eegross`,
  `reimb`,
  `dedamt`,
  `eecpf`,
  `funddd`,
  `netpay`,
  `ercpf`,
  `sdf`,
  `invless`,
  `ibasicpay`,
    `ipaidlvl`,
    `iot`,
    `ipayded`,
    `ipbaws`,
    `ipbawsext`,
    `ibackoverpay`,
    `icpf`,
    `isdf`,
    `iadminfee`,
    `irebate`,
    `ins`,
    `iaddcharges`,
    `pbasicpay`,
    `ppaidlvl`,
    `pot`,
    `ppayded`,
    `ppbaws`,
    `pbackoverpay`,
    `pns`,
    `approvedbydate`,
  `submited_by`,
  `submited_on`,
  `appstatus`
)
SELECT 
  uuid,
  batchno,
  invgross,
  gstamt,
  totalinv,
  eegross,
  reimb,
  dedamt,
  eecpf,
  funddd,
  netpay,
  ercpf,
  sdf,
  invless,
  ibasicpay,
    ipaidlvl,
    iot,
    ipayded,
    ipbaws,
    ipbawsext,
    ibackoverpay,
    icpf,
    isdf,
    iadminfee,
    irebate,
    ins,
    iaddcharges,
    pbasicpay,
    ppaidlvl,
    pot,
    ppayded,
    ppbaws,
    pbackoverpay,
    pns,
    approvedbydate,
  "#getauthuser()#",
  now(),
  "Pending"
  FROM
  argirotemp
  WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.uuidfield#">
  and batchno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#a#">
</cfquery>

<cfquery name="getlastinsertid" datasource="#dts#">
SELECT LAST_INSERT_ID() as lastid
</cfquery>

<cfquery name="insertrow" datasource="#dts#">
INSERT INTO icgiro
(
  `uuid`,
  `batchno`,
  `giropaydate`,
  `invoiceno`,
  `custid`,
  `customer`,
  `invoicegross`,
  `gstamt`,
  `totalinv`,
  `multipleassign`,
  `empno`,
  `empname`,
  `chequeno`,
  `eegross`,
  `reimb`,
  `deduction`,
  `eecpf`,
  `funddd`,
  `netpay`,
  `ercpf`,
  `sdfamt`,
  `invless`,
  `ibasicpay`,
    `ipaidlvl`,
    `iot`,
    `ipayded`,
    `ipbaws`,
    `ipbawsext`,
    `ibackoverpay`,
    `icpf`,
    `isdf`,
    `iadminfee`,
    `irebate`,
    `ins`,
    `iaddcharges`,
    `pbasicpay`,
    `ppaidlvl`,
    `pot`,
    `ppayded`,
    `ppbaws`,
    `pbackoverpay`,
    `pns`,
  `mainid`
)
SELECT
  uuid,
  batchno,
  giropaydate,
  invoiceno,
  custid,
  customer,
  invoicegross,
  gstamt,
  totalinv,
  multipleassign,
  empno,
  empname,
  chequeno,
  eegross,
  reimb,
  deduction,
  eecpf,
  funddd,
  netpay,
  ercpf,
  sdfamt,
  invless,
  ibasicpay,
    ipaidlvl,
    iot,
    ipayded,
    ipbaws,
    ipbawsext,
    ibackoverpay,
    icpf,
    isdf,
    iadminfee,
    irebate,
    ins,
    iaddcharges,
    pbasicpay,
    ppaidlvl,
    pot,
    ppayded,
    ppbaws,
    pbackoverpay,
    pns,
  "#getlastinsertid.lastid#"
FROM
icgirotemp
WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.uuidfield#">
  and batchno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#a#">
</cfquery>

<cfquery name="getnoofempno" datasource="#dts#">
SELECT batchno FROM icgiro WHERE mainid = "#getlastinsertid.lastid#" GROUP BY empno
</cfquery>

<cfquery name="updatenoofempno" datasource="#dts#">
UPDATE argiro SET noofempno = "#getnoofempno.recordcount#" WHERE id = "#getlastinsertid.lastid#"
</cfquery>

<cfquery name="lockbatch" datasource="#dts#">
UPDATE assignmentslip SET 
locked = "Y"
,locked_on = now()
WHERE batches = <cfqueryparam cfsqltype="cf_sql_varchar" value="#a#">
</cfquery>

<cfquery name="lockbatch" datasource="#dts#">
UPDATE assignbatches SET locked = "Y" WHERE batches = <cfqueryparam cfsqltype="cf_sql_varchar" value="#a#">
</cfquery>

</cfif>
</cfloop>

</cfoutput>
</cfif>