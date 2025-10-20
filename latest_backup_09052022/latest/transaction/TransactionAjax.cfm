<cfset batchno=0>
<cfsetting showdebugoutput="no">
<cfif isDefined("form.action")>
	<cfset action=form.action>
	<cfif action EQ "">
	
	<!--- getTargetDetail [START] --->
	<cfelseif action EQ "getTargetDetail">
		<cfset targetTable=form.targetTable>
		<cfset custno=form.custno>
		<cfquery name="getTargetDetail" datasource="#dts#">
			SELECT name,name2,add1,add2,add3,add4,attn,daddr1,daddr2,daddr3,daddr4,dattn,phone,phonea,dphone,contact,fax,dfax,e_mail,postalcode
			FROM #targetTable#
			WHERE custno="#custno#"
		</cfquery>
		
		<cfset target={
			NAME="#getTargetDetail.name#",
			NAME2="#getTargetDetail.name2#",
			ADD1="#getTargetDetail.add1#",
			ADD2="#getTargetDetail.add2#",
			ADD3="#getTargetDetail.add3#",
			ADD4="#getTargetDetail.add4#",
			ATTN="#getTargetDetail.attn#",
			DADDR1="#getTargetDetail.daddr1#",
			DADDR2="#getTargetDetail.daddr2#",
			DADDR3="#getTargetDetail.daddr3#",
			DADDR4="#getTargetDetail.daddr4#",
			DATTN="#getTargetDetail.dattn#",
			PHONE="#getTargetDetail.phone#",
			PHONEA="#getTargetDetail.phonea#",
			DPHONE="#getTargetDetail.dphone#",
			CONTACT="#getTargetDetail.contact#",
			FAX="#getTargetDetail.fax#",
			DFAX="#getTargetDetail.dfax#",
			POSTALCODE="#getTargetDetail.postalcode#",
			EMAIL="#getTargetDetail.e_mail#"
		}>
		<cfset target=SerializeJSON(target)>
		<cfset target=cleanXmlString(target)>
		<cfoutput>#target#</cfoutput>
	<!--- getTargetDetail [END] --->
	
	<!--- getItemInfo [START] --->
	<cfelseif action EQ "getItemInfo">
		<cfset itemPriceType=form.itemPriceType>
		<cfset itemno_input=form.itemno_input>
		<cfquery name="getItemInfo" datasource="#dts#">
			SELECT itemno,desp,#itemPriceType# AS itemprice
			FROM icitem 
			WHERE (nonstkitem<>'T' OR nonstkitem IS null)
			AND itemno="#itemno_input#"
		</cfquery>
		<cfset item={
			ITEMNO="#getItemInfo.itemno#",
			DESP="#getItemInfo.desp#",
			ITEMPRICE="#getItemInfo.itemprice#"
		}>
		<cfset item=SerializeJSON(item)>
		<cfset item=cleanXmlString(item)>
		<cfoutput>#item#</cfoutput>
	<!--- getItemInfo [END] --->
	
	<!--- getTaxRate [START] --->
	<cfelseif action EQ "getTaxRate">
		<cfset note_a_input=form.note_a_input>
		<cfquery name="getTaxRate" datasource="#dts#">
			SELECT code,rate1,corr_accno
			FROM taxtable
			WHERE code=<cfqueryparam cfsqltype="cf_sql_varchar" value="#note_a_input#">
		</cfquery>
		<cfset tax={
			CODE="#getTaxRate.code#",
			RATE1="#getTaxRate.rate1#",
			CORR_ACCNO="#getTaxRate.corr_accno#"
		}>
		<cfset tax=SerializeJSON(tax)>
		<cfset tax=cleanXmlString(tax)>
		<cfoutput>#tax#</cfoutput>
	<!--- getTaxRate [END] --->
	
	<!--- updateItem [START] --->
	<cfelseif action EQ "updateItem">
		<cfset taxException=form.taxException>
		<cfset uuid=form.uuid>
		<cfset trancode=form.trancode>
		<cfset itemno_input=form.itemno_input>
		<cfset desp_input=form.desp_input>
		<cfset qty_bil_input=form.qty_bil_input>
		<cfset price_bil_input=form.price_bil_input>
		<cfset amt1_bil=form.amt1_bil>
		<cfset dispec1_input=form.dispec1_input>
		<cfset disamt_bil=form.disamt_bil>
		<cfset note_a_input=form.note_a_input>
		<cfset taxpec1=form.taxpec1>
		<cfset taxamt_bil=form.taxamt_bil>
		<cfset amt_bil=form.amt_bil>
		<cfquery name="getLastTrancode" datasource="#dts#">
			SELECT MAX(trancode) AS LastTrancode
			FROM simpletransactionitemtemp
			WHERE uuid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
		</cfquery>
		<cfif trancode GT getLastTrancode.LastTrancode>
			<cfquery name="insertItem" datasource="#dts#">
				INSERT INTO simpletransactionitemtemp
				(uuid,trancode,itemno,desp,qty_bil,price_bil,amt1_bil,dispec1,disamt_bil,note_a,taxpec1,taxamt_bil,amt_bil)
				VALUES
				(
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#trancode#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno_input#">,
					<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#desp_input#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#qty_bil_input#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#price_bil_input#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#amt1_bil#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#dispec1_input#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#disamt_bil#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#note_a_input#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#taxpec1#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#taxamt_bil#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#amt_bil#">
				)
			</cfquery>
		<cfelse>
			<cfquery name="updateItem" datasource="#dts#">
				UPDATE simpletransactionitemtemp
				SET
					itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno_input#">,
					desp=<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#desp_input#">,
					qty_bil=<cfqueryparam cfsqltype="cf_sql_double" value="#qty_bil_input#">,
					price_bil=<cfqueryparam cfsqltype="cf_sql_double" value="#price_bil_input#">,
					amt1_bil=<cfqueryparam cfsqltype="cf_sql_double" value="#amt1_bil#">,
					dispec1=<cfqueryparam cfsqltype="cf_sql_double" value="#dispec1_input#">,
					disamt_bil=<cfqueryparam cfsqltype="cf_sql_double" value="#disamt_bil#">,
					note_a=<cfqueryparam cfsqltype="cf_sql_varchar" value="#note_a_input#">,
					taxpec1=<cfqueryparam cfsqltype="cf_sql_double" value="#taxpec1#">,
					taxamt_bil=<cfqueryparam cfsqltype="cf_sql_double" value="#taxamt_bil#">,
					amt_bil=<cfqueryparam cfsqltype="cf_sql_double" value="#amt_bil#">	
				WHERE 
				uuid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
				AND trancode=<cfqueryparam cfsqltype="cf_sql_integer" value="#trancode#">
			</cfquery>
		</cfif>
		<cfquery name="getItem" datasource="#dts#">
			SELECT itemno
			FROM icitem 
			WHERE (nonstkitem<>'T' OR nonstkitem IS null)
			ORDER BY itemno
		</cfquery>
        <cfquery name="getTax" datasource="#dts#">
			SELECT code
			FROM taxtable
			WHERE tax_type <> "#taxException#"
		</cfquery>
		<cfquery name="getItemList" datasource="#dts#">
        	SELECT trancode,itemno,desp,qty_bil,price_bil,amt1_bil,dispec1,disamt_bil,note_a,taxpec1,taxamt_bil,amt_bil
            FROM simpletransactionitemtemp
            WHERE uuid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
            ORDER BY trancode ASC
        </cfquery>
		<cfoutput>
		<cfloop query="getItemList">
		<cfset trancode=getItemList.trancode>
		<tr id="#getItemList.trancode#" class="edit_tr">
			<td><img id="insert_#getItemList.trancode#" class="insert_button" alt="insert" src="/images/simpletransaction/insert.png"/></td>
			<td class="edit_td">
				<input type="hidden" id="itemno_input_#getItemList.trancode#" class="editbox itemno_input addline" data-placeholder="Choose an item" value="#getItemList.itemno#" />
			</td>
			<td class="edit_td">
				<input type="text" id="desp_input_#getItemList.trancode#" class="editbox addline" value="#getItemList.desp#" onblur="if(document.getElementById('loadComplete').value==1){document.getElementById('loadComplete').value=0;updateItem(#getItemList.trancode#,'price_bil_input_');};" />
			</td>
			<td class="edit_td">
				<input type="text" id="price_bil_input_#getItemList.trancode#" class="editbox price_bil_input addline" value="#NumberFormat(getItemList.price_bil,'.__')#" onblur="if(document.getElementById('loadComplete').value==1){document.getElementById('loadComplete').value=0;updateItem(#getItemList.trancode#,'qty_bil_input_');};" />
			</td>
			<td class="edit_td">
				<input type="text" id="qty_bil_input_#getItemList.trancode#" class="editbox qty_bil_input addline" value="#NumberFormat(getItemList.qty_bil,'.__')#" onblur="if(document.getElementById('loadComplete').value==1){document.getElementById('loadComplete').value=0;updateItem(#getItemList.trancode#,'note_a_input_');};" />
			</td>
			<td class="edit_td">
				<select id="note_a_input_#getItemList.trancode#" class="editbox note_a_input" onblur="if(document.getElementById('loadComplete').value==1){document.getElementById('loadComplete').value=0;updateItem(#getItemList.trancode#,'itemno_input_');};">
					<option value=""></option>
					<cfloop query="getTax">
						<option value="#code#" <cfif code EQ getItemList.note_a>selected="selected"</cfif>>#code#</option>
					</cfloop>
				</select>
				<input type="hidden" id="taxpec1_#getItemList.trancode#" value="#getItemList.taxpec1#" />
				<input type="hidden" id="taxamt_bil_#getItemList.trancode#" value="#getItemList.taxamt_bil#" />
				<input type="hidden" id="dispec1_input_#getItemList.trancode#" class="dispec1_input" value="#getItemList.dispec1#" />
				<input type="hidden" id="disamt_bil_#getItemList.trancode#" value="#getItemList.disamt_bil#" />
				<input type="hidden" id="amt_bil_#getItemList.trancode#" value="#getItemList.amt_bil#" />
			</td>
			<td><span id="amt1_bil_#getItemList.trancode#" class="text">#NumberFormat(getItemList.amt1_bil,'.__')#</span></td>
			<td><img id="remove_#getItemList.trancode#" class="remove_button" alt="remove" src="/images/simpletransaction/remove.png" /></td>
		</tr>
		</cfloop>
		<cfset trancode=trancode+1>
		<tr id="#trancode#" class="edit_tr last_edit_tr">
			<td><img id="insert_#trancode#" class="insert_button" alt="insert" src="/images/simpletransaction/insert.png"/></td>
			<td class="edit_td">
				<input type="hidden" id="itemno_input_#trancode#" class="editbox itemno_input addline" data-placeholder="Choose an item" />
			</td>
			<td class="edit_td">
				<input type="text" id="desp_input_#trancode#" class="editbox addline" value="" onblur="if(this.value!=''&&document.getElementById('loadComplete').value==1){document.getElementById('loadComplete').value=0;updateItem(#trancode#,'price_bil_input_');}" />
			</td>
			<td class="edit_td">
				<input type="text" id="price_bil_input_#trancode#" class="editbox price_bil_input addline" value="0.00" onblur="if(this.value!=0&&document.getElementById('loadComplete').value==1){document.getElementById('loadComplete').value=0;updateItem(#trancode#,'qty_bil_input_');}" />
			</td>
			<td class="edit_td">
				<input type="text" id="qty_bil_input_#trancode#" class="editbox qty_bil_input addline" value="0.00" onblur="if(this.value!=0&&document.getElementById('loadComplete').value==1){document.getElementById('loadComplete').value=0;updateItem(#trancode#,'note_a_input_');}" />
			</td>
			<td class="edit_td">
				<select id="note_a_input_#trancode#" class="editbox note_a_input" onblur="if(this.value!=''&&document.getElementById('loadComplete').value==1){document.getElementById('loadComplete').value=0;updateItem(#trancode#,'itemno_input_');}">
					<option value=""></option>
					<cfloop query="getTax">
						<option value="#code#">#code#</option>
					</cfloop>
				</select>
				<input type="hidden" id="taxpec1_#trancode#" value="0.00" />
				<input type="hidden" id="taxamt_bil_#trancode#" value="0.00" />
				<input type="hidden" id="dispec1_input_#trancode#" class="dispec1_input" value="#getItemList.dispec1#" />
				<input type="hidden" id="disamt_bil_#trancode#" value="0.00" />
				<input type="hidden" id="amt_bil_#trancode#" value="0.00" />
			</td>
			<td><span id="amt1_bil_#trancode#" class="text">0.00</span></td>
			<td><img id="remove_#trancode#" class="remove_button" alt="remove" src="/images/simpletransaction/remove.png" /></td>
		</tr>
		</cfoutput>
	<!--- updateItem [END] --->
	
	<!--- removeItem [START] --->
	<cfelseif action EQ "removeItem">
    	<cfset taxException=form.taxException>
		<cfset uuid=form.uuid>
		<cfset trancode=form.trancode>
		<cfquery name="removeItem" datasource="#dts#">
			DELETE FROM simpletransactionitemtemp
			WHERE uuid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
			AND trancode=<cfqueryparam cfsqltype="cf_sql_integer" value="#trancode#">
		</cfquery>
		<cfquery name="updateItemTrancode" datasource="#dts#">
			UPDATE simpletransactionitemtemp
			SET trancode=trancode-1
			WHERE uuid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
			AND trancode><cfqueryparam cfsqltype="cf_sql_integer" value="#trancode#">
		</cfquery>
		<cfquery name="getItem" datasource="#dts#">
			SELECT itemno
			FROM icitem 
			WHERE (nonstkitem<>'T' OR nonstkitem IS null)
			ORDER BY itemno
		</cfquery>
        <cfquery name="getTax" datasource="#dts#">
			SELECT code
			FROM taxtable
			WHERE tax_type <> "#taxException#"
		</cfquery>
		<cfquery name="getItemList" datasource="#dts#">
        	SELECT trancode,itemno,desp,qty_bil,price_bil,amt1_bil,dispec1,disamt_bil,note_a,taxpec1,taxamt_bil,amt_bil
            FROM simpletransactionitemtemp
            WHERE uuid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
            ORDER BY trancode ASC
        </cfquery>
		<cfoutput>
		<cfloop query="getItemList">
		<cfset trancode=getItemList.trancode>
		<tr id="#getItemList.trancode#" class="edit_tr">
			<td><img id="insert_#getItemList.trancode#" class="insert_button" alt="insert" src="/images/simpletransaction/insert.png"/></td>
			<td class="edit_td">
				<input type="hidden" id="itemno_input_#getItemList.trancode#" class="editbox itemno_input addline" data-placeholder="Choose an item" value="#getItemList.itemno#" />
			</td>
			<td class="edit_td">
				<input type="text" id="desp_input_#getItemList.trancode#" class="editbox addline" value="#getItemList.desp#" onblur="if(document.getElementById('loadComplete').value==1){document.getElementById('loadComplete').value=0;updateItem(#getItemList.trancode#,'price_bil_input_');};" />
			</td>
			<td class="edit_td">
				<input type="text" id="price_bil_input_#getItemList.trancode#" class="editbox price_bil_input addline" value="#NumberFormat(getItemList.price_bil,'.__')#" onblur="if(document.getElementById('loadComplete').value==1){document.getElementById('loadComplete').value=0;updateItem(#getItemList.trancode#,'qty_bil_input_');};" />
			</td>
			<td class="edit_td">
				<input type="text" id="qty_bil_input_#getItemList.trancode#" class="editbox qty_bil_input addline" value="#NumberFormat(getItemList.qty_bil,'.__')#" onblur="if(document.getElementById('loadComplete').value==1){document.getElementById('loadComplete').value=0;updateItem(#getItemList.trancode#,'note_a_input_');};" />
			</td>
			<td class="edit_td">
				<select id="note_a_input_#getItemList.trancode#" class="editbox note_a_input" onblur="if(document.getElementById('loadComplete').value==1){document.getElementById('loadComplete').value=0;updateItem(#getItemList.trancode#,'itemno_input_');};">
					<option value=""></option>
					<cfloop query="getTax">
						<option value="#code#" <cfif code EQ getItemList.note_a>selected="selected"</cfif>>#code#</option>
					</cfloop>
				</select>
				<input type="hidden" id="taxpec1_#getItemList.trancode#" value="#getItemList.taxpec1#" />
				<input type="hidden" id="taxamt_bil_#getItemList.trancode#" value="#getItemList.taxamt_bil#" />
				<input type="hidden" id="dispec1_input_#getItemList.trancode#" class="dispec1_input" value="#getItemList.dispec1#" />
				<input type="hidden" id="disamt_bil_#getItemList.trancode#" value="#getItemList.disamt_bil#" />
				<input type="hidden" id="amt_bil_#getItemList.trancode#" value="#getItemList.amt_bil#" />
			</td>
			<td><span id="amt1_bil_#getItemList.trancode#" class="text">#NumberFormat(getItemList.amt1_bil,'.__')#</span></td>
			<td><img id="remove_#getItemList.trancode#" class="remove_button" alt="remove" src="/images/simpletransaction/remove.png" /></td>
		</tr>
		</cfloop>
		<cfset trancode=trancode+1>
		<tr id="#trancode#" class="edit_tr last_edit_tr">
			<td><img id="insert_#trancode#" class="insert_button" alt="insert" src="/images/simpletransaction/insert.png"/></td>
			<td class="edit_td">
				<input type="hidden" id="itemno_input_#trancode#" class="editbox itemno_input addline" data-placeholder="Choose an item" />
			</td>
			<td class="edit_td">
				<input type="text" id="desp_input_#trancode#" class="editbox addline" value="" onblur="if(this.value!=''&&document.getElementById('loadComplete').value==1){document.getElementById('loadComplete').value=0;updateItem(#trancode#,'price_bil_input_');}" />
			</td>
			<td class="edit_td">
				<input type="text" id="price_bil_input_#trancode#" class="editbox price_bil_input addline" value="0.00" onblur="if(this.value!=0&&document.getElementById('loadComplete').value==1){document.getElementById('loadComplete').value=0;updateItem(#trancode#,'qty_bil_input_');}" />
			</td>
			<td class="edit_td">
				<input type="text" id="qty_bil_input_#trancode#" class="editbox qty_bil_input addline" value="0.00" onblur="if(this.value!=0&&document.getElementById('loadComplete').value==1){document.getElementById('loadComplete').value=0;updateItem(#trancode#,'note_a_input_');}" />
			</td>
			<td class="edit_td">
				<select id="note_a_input_#trancode#" class="editbox note_a_input" onblur="if(this.value!=''&&document.getElementById('loadComplete').value==1){document.getElementById('loadComplete').value=0;updateItem(#trancode#,'itemno_input_);}">
					<option value=""></option>
					<cfloop query="getTax">
						<option value="#code#">#code#</option>
					</cfloop>
				</select>
				<input type="hidden" id="taxpec1_#trancode#" value="0.00" />
				<input type="hidden" id="taxamt_bil_#trancode#" value="0.00" />
				<input type="hidden" id="dispec1_input_#trancode#" class="dispec1_input" value="#getItemList.dispec1#" />
				<input type="hidden" id="disamt_bil_#trancode#" value="0.00" />
				<input type="hidden" id="amt_bil_#trancode#" value="0.00" />
			</td>
			<td><span id="amt1_bil_#trancode#" class="text">0.00</span></td>
			<td><img id="remove_#trancode#" class="remove_button" alt="remove" src="/images/simpletransaction/remove.png" /></td>
		</tr>
		</cfoutput>		
	<!--- removeItem [END] --->
	
	<!--- insert [START] --->
	<cfelseif action EQ "insert">
		<cfset action=form.action>
		<cfset type=form.type>
		<cfset uuid=form.uuid>
		<cfset targetTable=form.targetTable>
		<cfset targetLedgerTable=form.targetLedgerTable>
		<cfset custno=form.custno>	
		<cfset custinfo=form.custinfo>
		<cfset refno=form.refno>
		<cfset wos_date=form.wos_date>
		<cfset pono=form.pono>
		<cfset currcode=form.currcode>
		<cfset currrate=form.currrate>
		<cfset gross_bil=form.gross_bil>
		<cfset disc_bil=form.disc_bil>
		<cfset net_bil=form.net_bil>
		<cfset tax_bil=form.tax_bil>
		<cfset grand_bil=form.grand_bil>
		<cfset rem10=form.rem10>
		<cfset rem11=form.rem11>		
		<cfset dd=DateFormat(wos_date,"DD")>  
  		<cfif dd GT '12'>
   			<cfset wos_date=DateFormat(wos_date,"YYYY-MM-DD")>
  		<cfelse>
   			<cfset wos_date=DateFormat(wos_date,"YYYY-DD-MM")>
 		 </cfif>
		<cfinvoke component="cfc.Period" method="getCurrentPeriod" dts="#dts#" inputDate="#DateFormat(wos_date,'yyyy-mm-dd')#" returnvariable="fperiod"/>
		<cfset invgross=NumberFormat(gross_bil*currrate,".__")>
		<cfset discount=NumberFormat(disc_bil*currrate,".__")>
		<cfset net=NumberFormat(net_bil*currrate,".__")>
		<cfset tax=NumberFormat(tax_bil*currrate,".__")>
		<cfset grand=NumberFormat(grand_bil*currrate,".__")>
        <cfquery name="getLastRefNo" datasource="#dts#">
            SELECT lastref,refnoused
            FROM last_ref
            WHERE type="#form.type#"
        </cfquery>        
		<cfset refnoCheck = 0>
        <cfif getLastRefNo.refnoused eq "1">
            <cfloop condition="refnoCheck EQ 0">
                <cfquery name="checkExistence" datasource="#dts#">
                    SELECT refno FROM artran WHERE 
                    refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
                    AND type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
                </cfquery>
                <cfif checkExistence.recordcount EQ 0>
                    <cfset refnocheck = 1>
                    <cfquery name="updateLastRef" datasource="#dts#">
                            UPDATE last_ref
                            SET lastref=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
                            WHERE type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
                    </cfquery>
                <cfelse>
                    <cfinvoke component="cfc.refno" method="processNum" oldNum="#refno#" returnvariable="refno" />
                </cfif>
            </cfloop>
        <cfelse> 
            <cfset refno = form.refno>      
        </cfif>        
		<cfquery name="insertArtran" datasource="#dts#">
			INSERT INTO artran
			(
				type,
				custno,
                custinfo,
				refno,
				wos_date,fperiod,
				pono,
				currcode,currrate,
				gross_bil,invgross,
				disc_bil,discount,
				net_bil,net,
				tax_bil,tax,
				grand_bil,grand,
				rem10,rem11,
				created_by,created_on,
				updated_by,updated_on
			)
			VALUES
			(
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#custinfo#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#pono#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#currcode#">,<cfqueryparam cfsqltype="cf_sql_double" value="#currrate#">,
				<cfqueryparam cfsqltype="cf_sql_double" value="#gross_bil#">,<cfqueryparam cfsqltype="cf_sql_double" value="#invgross#">,
				<cfqueryparam cfsqltype="cf_sql_double" value="#disc_bil#">,<cfqueryparam cfsqltype="cf_sql_double" value="#discount#">,
				<cfqueryparam cfsqltype="cf_sql_double" value="#net_bil#">,<cfqueryparam cfsqltype="cf_sql_double" value="#net#">,
				<cfqueryparam cfsqltype="cf_sql_double" value="#tax_bil#">,<cfqueryparam cfsqltype="cf_sql_double" value="#tax#">,
				<cfqueryparam cfsqltype="cf_sql_double" value="#grand_bil#">,<cfqueryparam cfsqltype="cf_sql_double" value="#grand#">,
				<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#rem10#">,<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#rem11#">,
				"#getAuthUser()#",Now(),
				"#getAuthUser()#",Now()				
			)
		</cfquery>
		
		<!--- get last tranno with same batchno(preset 0) and increment it [START] --->
		<cfquery name="getLastTranNo" datasource="#dts#">
			SELECT MAX(tranno) AS lastTranNo
			FROM glpost
			WHERE fperiod!="99"
			AND batchno=<cfqueryparam cfsqltype="cf_sql_integer" value="#batchno#">
		</cfquery>
		<cfif getLastTranNo.lastTranNo EQ "">
			<cfset tranno=1>
		<cfelse>
			<cfset tranno=getLastTranNo.lastTranNo+1>
		</cfif>
		<!--- get last tranno with same batchno(preset 0) and increment it [END] --->		
		
		<!--- get System Currency [START] --->
		<cfquery name="getSystemCurrency" datasource="#dts#">
			SELECT ctycode AS SystemCurrCode
			FROM gsetup
		</cfquery>
		<!--- get System Currency [END] --->
				
		<!--- process ttype,debitamt,creditamt,fcamt,debit_fc,credit_fc,araptype,age [START]  --->
		<!--- process ttype,debitamt,creditamt,fcamt,debit_fc,credit_fc,araptype,age for the target account record line and general account record line are different --->
		<cfif currcode EQ getSystemCurrency.SystemCurrCode>
			<cfset amount=grand_bil>
			<cfset fcamt1=0.00>
		<cfelse>
			<cfset amount=grand>
			<cfset fcamt1=grand_bil>
		</cfif>		
		<cfif type EQ "CN">
			<cfset ttype="RC">
			<cfset debitamt=0>
			<cfset creditamt=amount>
			<cfset fcamt=-fcamt1>
			<cfset debit_fc=0>
			<cfset credit_fc=fcamt1>
			<cfset araptype="C">
			<cfset age=11>
		<cfelseif type EQ "CS">
			<cfset ttype="RD">
			<cfset debitamt=amount>
			<cfset creditamt=0>
			<cfset fcamt=fcamt1>
			<cfset debit_fc=fcamt1>
			<cfset credit_fc=0>
			<cfset araptype="H">
			<cfset age=0>
		<cfelseif type EQ "DN">
			<cfset ttype="RD">
			<cfset debitamt=amount>
			<cfset creditamt=0>
			<cfset fcamt=fcamt1>
			<cfset debit_fc=fcamt1>
			<cfset credit_fc=0>
			<cfset araptype="D">
			<cfset age=0>
		<cfelseif type EQ "INV">
			<cfset ttype="RD">
			<cfset debitamt=amount>
			<cfset creditamt=0>
			<cfset fcamt=fcamt1>
			<cfset debit_fc=fcamt1>
			<cfset credit_fc=0>
			<cfset araptype="I">
			<cfset age=0>
		<cfelseif type EQ "PR">
			<cfset ttype="PD">
			<cfset debitamt=amount>
			<cfset creditamt=0>
			<cfset fcamt=fcamt1>
			<cfset debit_fc=fcamt1>
			<cfset credit_fc=0>
			<cfset araptype="C">
			<cfset age=11>
		<cfelseif type EQ "RC">
			<cfset ttype="PC">
			<cfset debitamt=0>
			<cfset creditamt=amount>
			<cfset fcamt=-fcamt1>
			<cfset debit_fc=0>
			<cfset credit_fc=fcamt1>
			<cfset araptype="I">
			<cfset age=0>
		<cfelse>
			<cfset ttype="">
			<cfset debitamt=0>
			<cfset creditamt=0>
			<cfset fcamt=0>
			<cfset debit_fc=0>
			<cfset credit_fc=0>
			<cfset araptype="">
			<cfset age=0>
		</cfif>
		<!--- process process ttype,debitamt,creditamt,fcamt,debit_fc,credit_fc,araptype,age [END]  --->		
		
		<!--- get desp [START] --->
		<!--- desp for the target account record line and general account record line are different --->
		<cfquery name="getDespForGrandTotalLine" datasource="#dts#">
			SELECT description
			FROM userdefine
			WHERE type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
		</cfquery>
		<!--- get desp [END] --->
		
		<!--- get despe [START] --->
		<!--- despe for the target account record line and general account record line are different --->
		<cfquery name="getDespeForGrandTotalLine" datasource="#dts#">
			SELECT name
			FROM #targetTable#
			WHERE custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">
		</cfquery>
		<!--- get despe [END] --->
		
		<!--- insertGLPostGrandTotalLine [START] --->				
		<cfquery name="insertGLPostGrandTotalLine" datasource="#dts#">
			INSERT INTO glpost
			(
				acc_code,
				accno,
				fperiod,
				date,
				batchno,
				tranno,
				vouc_seq,
				vouc_seq_2,
				ttype,
				reference,
				refno,
				desp,
				despa,
				despb,
				despc,
				despd,
				despe,
				taxpec,
				debitamt,
				creditamt,
				fcamt,
				debit_fc,
				credit_fc,
				exc_rate,
				araptype,
				age,
				source,
				job,
				job2,
				subjob,
				job_value,
				job2_value,
				posted,
				exported,
				exported1,
				exported2,
				exported3,
				rem1,
				rem2,
				rem3,
				rem4,
				rem5,
				rpt_row,
				agent,
				site,
				stran,
				taxpur,
				paymode,
				trdatetime,
				corr_acc,
				accno2,
				accno3,
				date2,
				userid,
				tcurrcode,
				tcurramt,
				issuedate,
				bperiod,
				bdate,
				vperiod,
				origin,
				mperiod,
				created_by,
				updated_by,
				created_on,
				updated_on,
				uuid,
				wht_status,
				whtcustname,
				whtcustadd,
				whtcusttaxid,
				calwhtamt1,
				calwhtamt3,
				calwhtamt2,
				calwhtamt4,
				sequal,
				comuen,
				permitno,
				vouchermark,
				footercurrcode,
				footercurrrate,
				gainloss_postid,
				simple,
				trancode
			)
			VALUES
			(
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#batchno#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#tranno#">,
				"0",
				"0",
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#ttype#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#pono#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDespForGrandTotalLine.description#">,
				"",
				"",
				"",
				"",
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDespeForGrandTotalLine.name#">,
				"0.00",
				<cfqueryparam cfsqltype="cf_sql_double" value="#debitamt#">,
				<cfqueryparam cfsqltype="cf_sql_double" value="#creditamt#">,
				<cfqueryparam cfsqltype="cf_sql_double" value="#fcamt#">,
				<cfqueryparam cfsqltype="cf_sql_double" value="#debit_fc#">,
				<cfqueryparam cfsqltype="cf_sql_double" value="#credit_fc#">,
				<cfqueryparam cfsqltype="cf_sql_double" value="#currrate#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#araptype#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#age#">,
				"",
				"",
				"",
				"",
				"0",
				"0",
				"P",
				"",
				"",
				"",
				"",
				"",
				"",
				"",
				"",
				"0",
				"0",
				"",
				"",
				"",
				"0",
				"",
				Now(),
				"",
				"",
				"",
				"0000-00-00",
				"#getAuthUser()#",
				"",
				"0",
				"0000-00-00",
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
				"0000-00-00",
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
				"",
				"0",
				"#getAuthUser()#",
				"#getAuthUser()#",
				NOW(),
				NOW(),
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">,
				"",
				"",
				"",
				"",
				"0",
				"0",
				"0",
				"0",
				"",
				"",
				"",
				"0",
				"",
				"0",
				"",
				"Y",
				"0"
			)
		</cfquery>
		<!--- insertGLPostGrandTotalLine [END] --->
		
		<!--- insertTargetLedgerTable [START] --->
		<!--- get Entry of Grand Total Line [START] --->
		<cfquery name="getEntryOfGrandTotalLine" datasource="#dts#">
			SELECT entry
			FROM glpost
			WHERE acc_code=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
			AND reference=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
			AND uuid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
			AND trancode="0"
		</cfquery>
		<!--- get Entry of Grand Total Line [END] --->
		
		<cfif currcode EQ getSystemCurrency.SystemCurrCode>
		
			<!--- calculate lastbal [START] --->
				<cfset lastbal=debitamt-creditamt>
			<!--- calculate lastbal [END] --->
			
			<cfquery name="insertTargetLocalLine" datasource="#dts#">
				INSERT INTO #targetLedgerTable#
				(
					entry,
					accno,
					date,
					araptype,
					reference,
					refext,
					accext,
					refno,
					debitamt,
					creditamt,
					paidamt,
					paystatus,
					fullpay,
					desp,
					despa,
					despb,
					despc,
					despd,
					fcamt,
					debit_lc,
					credit_lc,
					exc_rate,
					age,
					posted,
					lastbal,
					payttime,
					new,
					rem1,
					rem2,
					rem4,
					source,
					job,
					agent,
					site,
					stran,
					fperiod,
					batchno,
					tranno,
					created_by,
					updated_by,
					created_on,
					updated_on,
					footercurrcode,
					footercurrrate,
					gainloss_postid,
					simple,
					trancode
				)
				VALUES
				(
					<cfqueryparam cfsqltype="cf_sql_integer" value="#getEntryOfGrandTotalLine.entry#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#araptype#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
					"",
					"",
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#pono#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#debitamt#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#creditamt#">,
					"0",
					"",
					"F",
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDespForGrandTotalLine.description#">,
					"",
					"",
					"",
					"",
					<cfqueryparam cfsqltype="cf_sql_double" value="#fcamt#">,
					"0",
					"0",
					<cfqueryparam cfsqltype="cf_sql_double" value="#currrate#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#age#">,
					"P",
					<cfqueryparam cfsqltype="cf_sql_double" value="#lastbal#">,
					"0",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#batchno#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#tranno#">,
					"#getAuthUser()#",
					"#getAuthUser()#",
					NOW(),
					NOW(),
					"",
					"0",
					"",
					"Y",
					"0"
				)
			</cfquery>			
		<cfelse>
		
			<!--- calculate lastbal [START] --->
				<cfset lastbal=debitamt-creditamt>
			<!--- calculate lastbal [END] --->
			
			<cfquery name="insertTargetLocalLine" datasource="#dts#">
				INSERT INTO #targetLedgerTable#
				(
					entry,
					accno,
					date,
					araptype,
					reference,
					refext,
					accext,
					refno,
					debitamt,
					creditamt,
					paidamt,
					paystatus,
					fullpay,
					desp,
					despa,
					despb,
					despc,
					despd,
					fcamt,
					debit_lc,
					credit_lc,
					exc_rate,
					age,
					posted,
					lastbal,
					payttime,
					new,
					rem1,
					rem2,
					rem4,
					source,
					job,
					agent,
					site,
					stran,
					fperiod,
					batchno,
					tranno,
					created_by,
					updated_by,
					created_on,
					updated_on,
					footercurrcode,
					footercurrrate,
					gainloss_postid,
					simple,
					trancode
				)
				VALUES
				(
					<cfqueryparam cfsqltype="cf_sql_integer" value="#getEntryOfGrandTotalLine.entry#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#araptype#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
					"",
					"",
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#pono#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#debitamt#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#creditamt#">,
					"0",
					"",
					"F",
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDespForGrandTotalLine.description#">,
					"",
					"",
					"",
					"",
					<cfqueryparam cfsqltype="cf_sql_double" value="#fcamt#">,
					"0",
					"0",
					<cfqueryparam cfsqltype="cf_sql_double" value="#currrate#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#age#">,
					"P",
					<cfqueryparam cfsqltype="cf_sql_double" value="#lastbal#">,
					"0",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#batchno#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#tranno#">,
					"#getAuthUser()#",
					"#getAuthUser()#",
					NOW(),
					NOW(),
					"",
					"0",
					"",
					"Y",
					"0"
				)
			</cfquery>
		
			<!--- calculate lastbal [START] --->
				<cfset lastbal=debit_fc-credit_fc>
			<!--- calculate lastbal [END] --->
			
			<cfquery name="insertTargetForeignLine" datasource="#dts#">
				INSERT INTO #targetLedgerTable#
				(
					entry,
					accno,
					date,
					araptype,
					reference,
					refext,
					accext,
					refno,
					debitamt,
					creditamt,
					paidamt,
					paystatus,
					fullpay,
					desp,
					despa,
					despb,
					despc,
					despd,
					fcamt,
					debit_lc,
					credit_lc,
					exc_rate,
					age,
					posted,
					lastbal,
					payttime,
					new,
					rem1,
					rem2,
					rem4,
					source,
					job,
					agent,
					site,
					stran,
					fperiod,
					batchno,
					tranno,
					created_by,
					updated_by,
					created_on,
					updated_on,
					footercurrcode,
					footercurrrate,
					gainloss_postid,
					simple,
					trancode
				)
				VALUES
				(
					<cfqueryparam cfsqltype="cf_sql_integer" value="#getEntryOfGrandTotalLine.entry#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#araptype#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
					"",
					"F",
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#pono#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#debit_fc#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#credit_fc#">,
					"0",
					"",
					"F",
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDespForGrandTotalLine.description#">,
					"",
					"",
					"",
					"",
					<cfqueryparam cfsqltype="cf_sql_double" value="#fcamt#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#debitamt#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#creditamt#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#currrate#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#age#">,
					"P",
					<cfqueryparam cfsqltype="cf_sql_double" value="#lastbal#">,
					"0",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#batchno#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#tranno#">,
					"#getAuthUser()#",
					"#getAuthUser()#",
					NOW(),
					NOW(),
					"",
					"0",
					"",
					"Y",
					"0"
				)
			</cfquery>
		</cfif>		
		<!--- insertTargetLedgerTable [END] --->
		
		<cfquery name="getItemList" datasource="#dts#">
        	SELECT trancode,itemno,desp,qty_bil,price_bil,amt1_bil,dispec1,disamt_bil,note_a,taxpec1,taxamt_bil,amt_bil
            FROM simpletransactionitemtemp
            WHERE uuid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
            ORDER BY trancode ASC
        </cfquery>
		<cfloop query="getItemList">
			<cfset price=price_bil*currrate>
			<cfset price=NumberFormat(price,".__")>	
			<cfset amt1=amt1_bil*currrate>
			<cfset amt1=NumberFormat(amt1,".__")>
			<cfset disamt=disamt_bil*currrate>
			<cfset disamt=NumberFormat(disamt,".__")>
			<cfset amt=amt_bil*currrate>
			<cfset amt=NumberFormat(amt,".__")>
			<cfset taxamt=taxamt_bil*currrate>
			<cfset taxamt=NumberFormat(taxamt,".__")>					
			<cfquery name="insertIctran" datasource="#dts#">
				INSERT INTO ictran
				(
					type,refno,
					custno,
					fperiod,wos_date,
					currrate,
					trancode,itemcount,
					itemno,desp,
					qty_bil,qty,
					price_bil,price,
					amt1_bil,amt1,
					dispec1,disamt_bil,disamt,
					note_a,taxpec1,taxamt_bil,taxamt,taxincl,
					amt_bil,amt					
				)
				VALUES
				(
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#currrate#">,
					"#trancode#","#trancode#",
					"#itemno#","#desp#",
					"#qty_bil#","#qty_bil#",
					"#price_bil#","#price#",
					"#amt1_bil#","#amt1#",
					"#dispec1#","#disamt_bil#","#disamt#",
					"#note_a#","#taxpec1#","#taxamt_bil#","#taxamt#","N",
					"#amt_bil#","#amt#"					
				)
			</cfquery>
			
			<!--- get desp for item and tax line [START] --->
			<cfquery name="getDespForItemAndTaxLine" datasource="#dts#">
				SELECT CONCAT(name,' ',name2) AS name
				FROM #targetTable#
				WHERE custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">
			</cfquery>
			<!--- get desp for item and tax line [END] --->		
			
			<!--- insert Glpost Item Line [START] --->
			<!--- get accno for general account [START] --->
			<cfquery name="getGeneralAccNo" datasource="#dts#">
				SELECT creditsales,purchasereceive
				FROM gsetup
			</cfquery>
			<cfif type EQ "CN" OR type EQ "CS" OR type EQ "DN" OR type EQ "INV">
				<cfset generalAccNo=getGeneralAccNo.creditsales>
			<cfelseif type EQ "PR" OR type EQ "RC">
				<cfset generalAccNo=getGeneralAccNo.purchasereceive>
			<cfelse>
				<cfset generalAccNo="">
			</cfif>
			<!--- get accno for general account [END] --->
			
			<!--- get last tranno with same batchno(preset 0) and increment it [START] --->
			<cfquery name="getLastTranNo" datasource="#dts#">
				SELECT MAX(tranno) AS lastTranNo
				FROM glpost
				WHERE fperiod!="99"
				AND batchno=<cfqueryparam cfsqltype="cf_sql_integer" value="#batchno#">
			</cfquery>
			<cfif getLastTranNo.lastTranNo EQ "">
				<cfset tranno=1>
			<cfelse>
				<cfset tranno=getLastTranNo.lastTranNo+1>
			</cfif>
			<!--- get last tranno with same batchno(preset 0) and increment it [END] --->
			
			<!--- get despe for item line [START] --->
			<cfquery name="getDespeForItemLine" datasource="#dts#">
				SELECT desp
				FROM gldata
				WHERE accno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#generalAccNo#">
			</cfquery>
			<!--- get despe for item line [END] --->
			
			<!--- process ttype,debitamt,creditamt,fcamt,debit_fc,credit_fc,araptype,age [START]  --->
			<!--- process ttype,debitamt,creditamt,fcamt,debit_fc,credit_fc,araptype,age for the target account record line and general account record line are different --->
			<cfif currcode EQ getSystemCurrency.SystemCurrCode>
				<cfset amount=amt_bil>
				<cfset fcamt1=0.00>
			<cfelse>
				<cfset amount=amt>
				<cfset fcamt1=amt_bil>
			</cfif>
			<cfset taxpur=amount>		
			<cfif type EQ "CN">
				<cfset ttype="GD">
				<cfset debitamt=amount>
				<cfset creditamt=0>
				<cfset fcamt=fcamt1>
				<cfset debit_fc=fcamt1>
				<cfset credit_fc=0>
				<cfset araptype="C">
				<cfset age=11>
			<cfelseif type EQ "CS">
				<cfset ttype="GC">
				<cfset debitamt=0>
				<cfset creditamt=amount>
				<cfset fcamt=-fcamt1>
				<cfset debit_fc=0>
				<cfset credit_fc=fcamt1>
				<cfset araptype="H">
				<cfset age=0>
			<cfelseif type EQ "DN">
				<cfset ttype="GC">
				<cfset debitamt=0>
				<cfset creditamt=amount>
				<cfset fcamt=-fcamt1>
				<cfset debit_fc=0>
				<cfset credit_fc=fcamt1>
				<cfset araptype="D">
				<cfset age=0>
			<cfelseif type EQ "INV">
				<cfset ttype="GC">
				<cfset debitamt=0>
				<cfset creditamt=amount>
				<cfset fcamt=-fcamt1>
				<cfset debit_fc=0>
				<cfset credit_fc=fcamt1>
				<cfset araptype="I">
				<cfset age=0>
			<cfelseif type EQ "PR">
				<cfset ttype="GC">
				<cfset debitamt=0>
				<cfset creditamt=amount>
				<cfset fcamt=-fcamt1>
				<cfset debit_fc=0>
				<cfset credit_fc=fcamt1>
				<cfset araptype="C">
				<cfset age=11>
			<cfelseif type EQ "RC">
				<cfset ttype="GD">
				<cfset debitamt=amount>
				<cfset creditamt=0>
				<cfset fcamt=fcamt1>
				<cfset debit_fc=fcamt1>
				<cfset credit_fc=0>
				<cfset araptype="I">
				<cfset age=0>
			<cfelse>
				<cfset ttype="">
				<cfset debitamt=0>
				<cfset creditamt=0>
				<cfset fcamt=0>
				<cfset debit_fc=0>
				<cfset credit_fc=0>
				<cfset araptype="">
				<cfset age=0>
			</cfif>
			<!--- process process ttype,debitamt,creditamt,fcamt,debit_fc,credit_fc,araptype,age [END]  --->
			
			<cfquery name="insertGlpostItemLine" datasource="#dts#">
				INSERT INTO glpost
				(
					acc_code,
					accno,
					fperiod,
					date,
					batchno,
					tranno,
					vouc_seq,
					vouc_seq_2,
					ttype,
					reference,
					refno,
					desp,
					despa,
					despb,
					despc,
					despd,
					despe,
					taxpec,
					debitamt,
					creditamt,
					fcamt,
					debit_fc,
					credit_fc,
					exc_rate,
					araptype,
					age,
					source,
					job,
					job2,
					subjob,
					job_value,
					job2_value,
					posted,
					exported,
					exported1,
					exported2,
					exported3,
					rem1,
					rem2,
					rem3,
					rem4,
					rem5,
					rpt_row,
					agent,
					site,
					stran,
					taxpur,
					paymode,
					trdatetime,
					corr_acc,
					accno2,
					accno3,
					date2,
					userid,
					tcurrcode,
					tcurramt,
					issuedate,
					bperiod,
					bdate,
					vperiod,
					origin,
					mperiod,
					created_by,
					updated_by,
					created_on,
					updated_on,
					uuid,
					wht_status,
					whtcustname,
					whtcustadd,
					whtcusttaxid,
					calwhtamt1,
					calwhtamt3,
					calwhtamt2,
					calwhtamt4,
					sequal,
					comuen,
					permitno,
					vouchermark,
					footercurrcode,
					footercurrrate,
					gainloss_postid,
					simple,
					trancode
				)
				VALUES
				(
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#generalAccNo#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#batchno#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#tranno#">,
					"0",
					"0",
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#ttype#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#pono#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDespForItemAndTaxLine.name#">,
					"",
					"",
					"",
					"",
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDespeForItemLine.desp#">,
					"#taxpec1#",
					<cfqueryparam cfsqltype="cf_sql_double" value="#debitamt#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#creditamt#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#fcamt#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#debit_fc#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#credit_fc#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#currrate#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#araptype#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#age#">,
					"",
					"",
					"",
					"",
					"0",
					"0",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"#note_a#",
					"0",
					"0",
					"",
					"",
					"",
					<cfqueryparam cfsqltype="cf_sql_double" value="#taxpur#">,
					"",
					Now(),
					"",
					"",
					"",
					"0000-00-00",
					"#getAuthUser()#",
					"",
					"0",
					"0000-00-00",
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
					"0000-00-00",
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
					"",
					"0",
					"#getAuthUser()#",
					"#getAuthUser()#",
					NOW(),
					NOW(),
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">,
					"",
					"",
					"",
					"",
					"0",
					"0",
					"0",
					"0",
					"",
					"",
					"",
					"0",
					"",
					"0",
					"",
					"Y",
					"#trancode#"
				)	
			</cfquery>			
			<!--- insert Glpost Item Line [END] --->
			
			<cfif taxpec1 NEQ 0>			
				<!--- insert Glpost Tax Line [START] --->
				<!--- get accno for tax [START] --->
				<cfquery name="getTaxAccNo" datasource="#dts#">
					SELECT corr_accno
					FROM taxtable
					WHERE code="#note_a#"
				</cfquery>
				<!--- get accno for tax [END] --->
			
				<!--- get last tranno with same batchno(preset 0) and increment it [START] --->
				<cfquery name="getLastTranNo" datasource="#dts#">
					SELECT MAX(tranno) AS lastTranNo
					FROM glpost
					WHERE fperiod!="99"
					AND batchno=<cfqueryparam cfsqltype="cf_sql_integer" value="#batchno#">
				</cfquery>
				<cfif getLastTranNo.lastTranNo EQ "">
					<cfset tranno=1>
				<cfelse>
					<cfset tranno=getLastTranNo.lastTranNo+1>
				</cfif>
				<!--- get last tranno with same batchno(preset 0) and increment it [END] --->
			
				<!--- process ttype,debitamt,creditamt,fcamt,debit_fc,credit_fc,araptype,age [START]  --->
				<!--- process ttype,debitamt,creditamt,fcamt,debit_fc,credit_fc,araptype,age for the target account record line and general account record line are different --->
				<cfif currcode EQ getSystemCurrency.SystemCurrCode>
					<cfset amount=taxamt_bil>
					<cfset fcamt1=0.00>
				<cfelse>
					<cfset amount=taxamt>
					<cfset fcamt1=taxamt_bil>
				</cfif>
				<cfset taxpur=amount>		
				<cfif type EQ "CN">
					<cfset ttype="GD">
					<cfset debitamt=amount>
					<cfset creditamt=0>
					<cfset fcamt=fcamt1>
					<cfset debit_fc=fcamt1>
					<cfset credit_fc=0>
					<cfset araptype="C">
					<cfset age=11>
				<cfelseif type EQ "CS">
					<cfset ttype="GC">
					<cfset debitamt=0>
					<cfset creditamt=amount>
					<cfset fcamt=-fcamt1>
					<cfset debit_fc=0>
					<cfset credit_fc=fcamt1>
					<cfset araptype="H">
					<cfset age=0>
				<cfelseif type EQ "DN">
					<cfset ttype="GC">
					<cfset debitamt=0>
					<cfset creditamt=amount>
					<cfset fcamt=-fcamt1>
					<cfset debit_fc=0>
					<cfset credit_fc=fcamt1>
					<cfset araptype="D">
					<cfset age=0>
				<cfelseif type EQ "INV">
					<cfset ttype="GC">
					<cfset debitamt=0>
					<cfset creditamt=amount>
					<cfset fcamt=-fcamt1>
					<cfset debit_fc=0>
					<cfset credit_fc=fcamt1>
					<cfset araptype="I">
					<cfset age=0>
				<cfelseif type EQ "PR">
					<cfset ttype="GC">
					<cfset debitamt=0>
					<cfset creditamt=amount>
					<cfset fcamt=-fcamt1>
					<cfset debit_fc=0>
					<cfset credit_fc=fcamt1>
					<cfset araptype="C">
					<cfset age=11>
				<cfelseif type EQ "RC">
					<cfset ttype="GD">
					<cfset debitamt=amount>
					<cfset creditamt=0>
					<cfset fcamt=fcamt1>
					<cfset debit_fc=fcamt1>
					<cfset credit_fc=0>
					<cfset araptype="I">
					<cfset age=0>
				<cfelse>
					<cfset ttype="">
					<cfset debitamt=0>
					<cfset creditamt=0>
					<cfset fcamt=0>
					<cfset debit_fc=0>
					<cfset credit_fc=0>
					<cfset araptype="">
					<cfset age=0>
				</cfif>
				<!--- process process ttype,debitamt,creditamt,fcamt,debit_fc,credit_fc,araptype,age [END]  --->
			
				<!--- get despe for tax line [START] --->
				<cfquery name="getDespeForTaxLine" datasource="#dts#">
					SELECT desp
					FROM gldata
					WHERE accno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getTaxAccNo.corr_accno#">
				</cfquery>
				<!--- get despe for tax line [END] --->
			
				<cfquery name="insertGlpostTaxLine" datasource="#dts#">
					INSERT INTO glpost
					(
						acc_code,
						accno,
						fperiod,
						date,
						batchno,
						tranno,
						vouc_seq,
						vouc_seq_2,
						ttype,
						reference,
						refno,
						desp,
						despa,
						despb,
						despc,
						despd,
						despe,
						taxpec,
						debitamt,
						creditamt,
						fcamt,
						debit_fc,
						credit_fc,
						exc_rate,
						araptype,
						age,
						source,
						job,
						job2,
						subjob,
						job_value,
						job2_value,
						posted,
						exported,
						exported1,
						exported2,
						exported3,
						rem1,
						rem2,
						rem3,
						rem4,
						rem5,
						rpt_row,
						agent,
						site,
						stran,
						taxpur,
						paymode,
						trdatetime,
						corr_acc,
						accno2,
						accno3,
						date2,
						userid,
						tcurrcode,
						tcurramt,
						issuedate,
						bperiod,
						bdate,
						vperiod,
						origin,
						mperiod,
						created_by,
						updated_by,
						created_on,
						updated_on,
						uuid,
						wht_status,
						whtcustname,
						whtcustadd,
						whtcusttaxid,
						calwhtamt1,
						calwhtamt3,
						calwhtamt2,
						calwhtamt4,
						sequal,
						comuen,
						permitno,
						vouchermark,
						footercurrcode,
						footercurrrate,
						gainloss_postid,
						simple,
						trancode
					)
					VALUES
					(
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getTaxAccNo.corr_accno#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#batchno#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#tranno#">,
						"0",
						"0",
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#ttype#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#pono#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDespForItemAndTaxLine.name#">,
						"",
						"",
						"",
						"",
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDespeForTaxLine.desp#">,
						"#taxpec1#",
						<cfqueryparam cfsqltype="cf_sql_double" value="#debitamt#">,
						<cfqueryparam cfsqltype="cf_sql_double" value="#creditamt#">,
						<cfqueryparam cfsqltype="cf_sql_double" value="#fcamt#">,
						<cfqueryparam cfsqltype="cf_sql_double" value="#debit_fc#">,
						<cfqueryparam cfsqltype="cf_sql_double" value="#credit_fc#">,
						<cfqueryparam cfsqltype="cf_sql_double" value="#currrate#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#araptype#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#age#">,
						"",
						"",
						"",
						"",
						"0",
						"0",
						"",
						"",
						"",
						"",
						"",
						"",
						"",
						"",
						"#note_a#",
						"0",
						"0",
						"",
						"",
						"",
						"0",
						"",
						Now(),
						"",
						"",
						"",
						"0000-00-00",
						"#getAuthUser()#",
						"",
						"0",
						"0000-00-00",
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
						"0000-00-00",
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
						"",
						"0",
						"#getAuthUser()#",
						"#getAuthUser()#",
						NOW(),
						NOW(),
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">,
						"",
						"",
						"",
						"",
						"0",
						"0",
						"0",
						"0",
						"",
						"",
						"",
						"0",
						"",
						"0",
						"",
						"Y",
						"#trancode#"
					)
				</cfquery>
				<!--- insert Glpost Tax Line [END] --->
			</cfif>
		</cfloop>
		<cfoutput>Create transaction successfully.</cfoutput>
	<!--- insert [END] --->
	
	<!--- deleteTransaction [START] --->
	<cfelseif action EQ "deleteTransaction">
		<cfset type=form.type>
		<cfset transactionList=form.transactionList>
		<cfset targetLedgerTable=form.targetLedgerTable>
		<cfquery name="deleteArtran" datasource="#dts#">
        	UPDATE artran
			SET void="Y"
            WHERE type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
            AND refno IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#transactionList#" list="yes">)
        </cfquery>
		<cfquery name="deleteIctran" datasource="#dts#">
        	UPDATE ictran
			SET void="Y"
            WHERE type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
            AND refno IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#transactionList#" list="yes">)
        </cfquery>
		<cfquery name="getGLPostGrandTotalLineEntry" datasource="#dts#">
			SELECT GROUP_CONCAT(entry SEPARATOR ',') AS entry
			FROM glpost
			WHERE acc_code=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
			AND reference IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#transactionList#" list="yes">)
			AND trancode="0"
		</cfquery>
		<cfquery name="deleteGLPost" datasource="#dts#">
			DELETE FROM glpost
			WHERE acc_code=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
			AND reference IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#transactionList#" list="yes">)
		</cfquery>
		<cfquery name="deleteTargetLedgerTable" datasource="#dts#">
			DELETE FROM #targetLedgerTable#
			WHERE entry IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#getGLPostGrandTotalLineEntry.entry#" list="yes">)
		</cfquery>
	<cfoutput>Delete transaction successfully.</cfoutput>
	<!--- deleteTransaction [END] --->
	
	<!--- undeleteTransaction [START] --->
	<cfelseif action EQ "undeleteTransaction">
		<cfset type=form.type>		
		<cfset transactionList=form.transactionList>
		<cfset targetTable=form.targetTable>
		<cfset targetLedgerTable=form.targetLedgerTable>
		<cfquery name="undeleteArtran" datasource="#dts#">
        	UPDATE artran
			SET void=""
            WHERE type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
            AND refno IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#transactionList#" list="yes">)
        </cfquery>		
		<cfset uuid=CreateUUID()>
		
		<!--- get System Currency [START] --->
		<cfquery name="getSystemCurrency" datasource="#dts#">
			SELECT ctycode AS SystemCurrCode
			FROM gsetup
		</cfquery>
		<!--- get System Currency [END] --->
				
		<!--- get undeleted record from artran [START] --->
		<cfquery name="getUndeletedArtran" datasource="#dts#">
			SELECT type,custno,custinfo,refno,wos_date,fperiod,pono,currcode,currrate,gross_bil,invgross,disc_bil,discount,net_bil,net,tax_bil,tax,grand_bil,grand,rem10,rem11
			FROM artran
			WHERE type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
            AND refno IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#transactionList#" list="yes">)
		</cfquery>
		<!--- get undeleted record from artran [END] --->		
		<cfloop query="getUndeletedArtran">
			<!--- set variable get from undeleted artran [START] --->
			<cfset type=getUndeletedArtran.type>
			<cfset custno=getUndeletedArtran.custno>
			<cfset custinfo=getUndeletedArtran.custinfo>
			<cfset refno=getUndeletedArtran.refno>
			<cfset wos_date=DateFormat(#getUndeletedArtran.wos_date#,"YYYY-MM-DD")>
			<cfset fperiod=getUndeletedArtran.fperiod>
			<cfset pono=getUndeletedArtran.pono>
			<cfset currcode=getUndeletedArtran.currcode>
			<cfset currrate=getUndeletedArtran.currrate>
			<cfset gross_bil=getUndeletedArtran.gross_bil>
			<cfset invgross=getUndeletedArtran.invgross>
			<cfset disc_bil=getUndeletedArtran.disc_bil>
			<cfset discount=getUndeletedArtran.discount>
			<cfset net_bil=getUndeletedArtran.net_bil>
			<cfset net=getUndeletedArtran.net>
			<cfset tax_bil=getUndeletedArtran.tax_bil>
			<cfset tax=getUndeletedArtran.tax>
			<cfset grand_bil=getUndeletedArtran.grand_bil>
			<cfset grand=getUndeletedArtran.grand>
			<cfset rem10=getUndeletedArtran.rem10>
			<cfset rem11=getUndeletedArtran.rem11>
			<!--- set variable get from undeleted artran [END] --->
		
			<!--- get last tranno with same batchno(preset 0) and increment it [START] --->
			<cfquery name="getLastTranNo" datasource="#dts#">
				SELECT MAX(tranno) AS lastTranNo
				FROM glpost
				WHERE fperiod!="99"
				AND batchno=<cfqueryparam cfsqltype="cf_sql_integer" value="#batchno#">
			</cfquery>
			<cfif getLastTranNo.lastTranNo EQ "">
				<cfset tranno=1>
			<cfelse>
				<cfset tranno=getLastTranNo.lastTranNo+1>
			</cfif>
			<!--- get last tranno with same batchno(preset 0) and increment it [END] --->		
				
			<!--- process ttype,debitamt,creditamt,fcamt,debit_fc,credit_fc,araptype,age [START]  --->
			<!--- process ttype,debitamt,creditamt,fcamt,debit_fc,credit_fc,araptype,age for the target account record line and general account record line are different --->
			<cfif currcode EQ getSystemCurrency.SystemCurrCode>
				<cfset amount=grand_bil>
				<cfset fcamt1=0.00>
			<cfelse>
				<cfset amount=grand>
				<cfset fcamt1=grand_bil>
			</cfif>		
			<cfif type EQ "CN">
				<cfset ttype="RC">
				<cfset debitamt=0>
				<cfset creditamt=amount>
				<cfset fcamt=-fcamt1>
				<cfset debit_fc=0>
				<cfset credit_fc=fcamt1>
				<cfset araptype="C">
				<cfset age=11>
			<cfelseif type EQ "CS">
				<cfset ttype="RD">
				<cfset debitamt=amount>
				<cfset creditamt=0>
				<cfset fcamt=fcamt1>
				<cfset debit_fc=fcamt1>
				<cfset credit_fc=0>
				<cfset araptype="H">
				<cfset age=0>
			<cfelseif type EQ "DN">
				<cfset ttype="RD">
				<cfset debitamt=amount>
				<cfset creditamt=0>
				<cfset fcamt=fcamt1>
				<cfset debit_fc=fcamt1>
				<cfset credit_fc=0>
				<cfset araptype="D">
				<cfset age=0>
			<cfelseif type EQ "INV">
				<cfset ttype="RD">
				<cfset debitamt=amount>
				<cfset creditamt=0>
				<cfset fcamt=fcamt1>
				<cfset debit_fc=fcamt1>
				<cfset credit_fc=0>
				<cfset araptype="I">
				<cfset age=0>
			<cfelseif type EQ "PR">
				<cfset ttype="PD">
				<cfset debitamt=amount>
				<cfset creditamt=0>
				<cfset fcamt=fcamt1>
				<cfset debit_fc=fcamt1>
				<cfset credit_fc=0>
				<cfset araptype="C">
				<cfset age=11>
			<cfelseif type EQ "RC">
				<cfset ttype="PC">
				<cfset debitamt=0>
				<cfset creditamt=amount>
				<cfset fcamt=-fcamt1>
				<cfset debit_fc=0>
				<cfset credit_fc=fcamt1>
				<cfset araptype="I">
				<cfset age=0>
			<cfelse>
				<cfset ttype="">
				<cfset debitamt=0>
				<cfset creditamt=0>
				<cfset fcamt=0>
				<cfset debit_fc=0>
				<cfset credit_fc=0>
				<cfset araptype="">
				<cfset age=0>
			</cfif>
			<!--- process process ttype,debitamt,creditamt,fcamt,debit_fc,credit_fc,araptype,age [END]  --->		
		
			<!--- get desp [START] --->
			<!--- desp for the target account record line and general account record line are different --->
			<cfquery name="getDespForGrandTotalLine" datasource="#dts#">
				SELECT description
				FROM userdefine
				WHERE type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
			</cfquery>
			<!--- get desp [END] --->
		
			<!--- get despe [START] --->
			<!--- despe for the target account record line and general account record line are different --->
			<cfquery name="getDespeForGrandTotalLine" datasource="#dts#">
				SELECT name
				FROM #targetTable#
				WHERE custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">
			</cfquery>
			<!--- get despe [END] --->
						
			<!--- reinsertGLPostGrandTotalLine [START] --->				
			<cfquery name="reinsertGLPostGrandTotalLine" datasource="#dts#">
				INSERT INTO glpost
				(
					acc_code,
					accno,
					fperiod,
					date,
					batchno,
					tranno,
					vouc_seq,
					vouc_seq_2,
					ttype,
					reference,
					refno,
					desp,
					despa,
					despb,
					despc,
					despd,
					despe,
					taxpec,
					debitamt,
					creditamt,
					fcamt,
					debit_fc,
					credit_fc,
					exc_rate,
					araptype,
					age,
					source,
					job,
					job2,
					subjob,
					job_value,
					job2_value,
					posted,
					exported,
					exported1,
					exported2,
					exported3,
					rem1,
					rem2,
					rem3,
					rem4,
					rem5,
					rpt_row,
					agent,
					site,
					stran,
					taxpur,
					paymode,
					trdatetime,
					corr_acc,
					accno2,
					accno3,
					date2,
					userid,
					tcurrcode,
					tcurramt,
					issuedate,
					bperiod,
					bdate,
					vperiod,
					origin,
					mperiod,
					created_by,
					updated_by,
					created_on,
					updated_on,
					uuid,
					wht_status,
					whtcustname,
					whtcustadd,
					whtcusttaxid,
					calwhtamt1,
					calwhtamt3,
					calwhtamt2,
					calwhtamt4,
					sequal,
					comuen,
					permitno,
					vouchermark,
					footercurrcode,
					footercurrrate,
					gainloss_postid,
					simple,
					trancode
				)
				VALUES
				(
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#DateFormat(wos_date,'YYYY-MM-DD')#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#batchno#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#tranno#">,
					"0",
					"0",
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#ttype#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#pono#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDespForGrandTotalLine.description#">,
					"",
					"",
					"",
					"",
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDespeForGrandTotalLine.name#">,
					"0.00",
					<cfqueryparam cfsqltype="cf_sql_double" value="#debitamt#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#creditamt#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#fcamt#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#debit_fc#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#credit_fc#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#currrate#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#araptype#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#age#">,
					"",
					"",
					"",
					"",
					"0",
					"0",
					"P",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"0",
					"0",
					"",
					"",
					"",
					"0",
					"",
					Now(),
					"",
					"",
					"",
					"0000-00-00",
					"#getAuthUser()#",
					"",
					"0",
					"0000-00-00",
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
					"0000-00-00",
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
					"",
					"0",
					"#getAuthUser()#",
					"#getAuthUser()#",
					NOW(),
					NOW(),
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">,
					"",
					"",
					"",
					"",
					"0",
					"0",
					"0",
					"0",
					"",
					"",
					"",
					"0",
					"",
					"0",
					"",
					"Y",
					"0"
				)
			</cfquery>
			<!--- reinsertGLPostGrandTotalLine [END] --->
		
			<!--- reinsertTargetLedgerTable [START] --->
			<!--- get Entry of Grand Total Line [START] --->
			<cfquery name="getEntryOfGrandTotalLine" datasource="#dts#">
				SELECT entry
				FROM glpost
				WHERE acc_code=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
				AND reference=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
				AND trancode="0"
			</cfquery>
			<!--- get Entry of Grand Total Line [END] --->
		
			<cfif currcode EQ getSystemCurrency.SystemCurrCode>
			
				<!--- calculate lastbal [START] --->
					<cfset lastbal=debitamt-creditamt>
				<!--- calculate lastbal [END] --->
				
				<cfquery name="reinsertTargetLocalLine" datasource="#dts#">
					INSERT INTO #targetLedgerTable#
					(
						entry,
						accno,
						date,
						araptype,
						reference,
						refext,
						accext,
						refno,
						debitamt,
						creditamt,
						paidamt,
						paystatus,
						fullpay,
						desp,
						despa,
						despb,
						despc,
						despd,
						fcamt,
						debit_lc,
						credit_lc,
						exc_rate,
						age,
						posted,
						lastbal,
						payttime,
						new,
						rem1,
						rem2,
						rem4,
						source,
						job,
						agent,
						site,
						stran,
						fperiod,
						batchno,
						tranno,
						created_by,
						updated_by,
						created_on,
						updated_on,
						footercurrcode,
						footercurrrate,
						gainloss_postid,
						simple,
						trancode
					)
					VALUES
					(
						<cfqueryparam cfsqltype="cf_sql_integer" value="#getEntryOfGrandTotalLine.entry#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#DateFormat(wos_date,'YYYY-MM-DD')#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#araptype#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
						"",
						"",
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#pono#">,
						<cfqueryparam cfsqltype="cf_sql_double" value="#debitamt#">,
						<cfqueryparam cfsqltype="cf_sql_double" value="#creditamt#">,
						"0",
						"",
						"F",
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDespForGrandTotalLine.description#">,
						"",
						"",
						"",
						"",
						<cfqueryparam cfsqltype="cf_sql_double" value="#fcamt#">,
						"0",
						"0",
						<cfqueryparam cfsqltype="cf_sql_double" value="#currrate#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#age#">,
						"P",
						<cfqueryparam cfsqltype="cf_sql_double" value="#lastbal#">,
						"0",
						"",
						"",
						"",
						"",
						"",
						"",
						"",
						"",
						"",
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#batchno#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#tranno#">,
						"#getAuthUser()#",
						"#getAuthUser()#",
						NOW(),
						NOW(),
						"",
						"0",
						"",
						"Y",
						"0"
					)
				</cfquery>			
			<cfelse>
		
				<!--- calculate lastbal [START] --->
					<cfset lastbal=debitamt-creditamt>
				<!--- calculate lastbal [END] --->
			
				<cfquery name="reinsertTargetLocalLine" datasource="#dts#">
					INSERT INTO #targetLedgerTable#
					(
						entry,
						accno,
						date,
						araptype,
						reference,
						refext,
						accext,
						refno,
						debitamt,
						creditamt,
						paidamt,
						paystatus,
						fullpay,
						desp,
						despa,
						despb,
						despc,
						despd,
						fcamt,
						debit_lc,
						credit_lc,
						exc_rate,
						age,
						posted,
						lastbal,
						payttime,
						new,
						rem1,
						rem2,
						rem4,
						source,
						job,
						agent,
						site,
						stran,
						fperiod,
						batchno,
						tranno,
						created_by,
						updated_by,
						created_on,
						updated_on,
						footercurrcode,
						footercurrrate,
						gainloss_postid,
						simple,
						trancode
					)
					VALUES
					(
						<cfqueryparam cfsqltype="cf_sql_integer" value="#getEntryOfGrandTotalLine.entry#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#DateFormat(wos_date,'YYYY-MM-DD')#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#araptype#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
						"",
						"",
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#pono#">,
						<cfqueryparam cfsqltype="cf_sql_double" value="#debitamt#">,
						<cfqueryparam cfsqltype="cf_sql_double" value="#creditamt#">,
						"0",
						"",
						"F",
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDespForGrandTotalLine.description#">,
						"",
						"",
						"",
						"",
						<cfqueryparam cfsqltype="cf_sql_double" value="#fcamt#">,
						"0",
						"0",
						<cfqueryparam cfsqltype="cf_sql_double" value="#currrate#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#age#">,
						"P",
						<cfqueryparam cfsqltype="cf_sql_double" value="#lastbal#">,
						"0",
						"",
						"",
						"",
						"",
						"",
						"",
						"",
						"",
						"",
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#batchno#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#tranno#">,
						"#getAuthUser()#",
						"#getAuthUser()#",
						NOW(),
						NOW(),
						"",
						"0",
						"",
						"Y",
						"0"
					)
				</cfquery>
		
				<!--- calculate lastbal [START] --->
					<cfset lastbal=debit_fc-credit_fc>
				<!--- calculate lastbal [END] --->
				
				<cfquery name="reinsertTargetForeignLine" datasource="#dts#">
					INSERT INTO #targetLedgerTable#
					(
						entry,
						accno,
						date,
						araptype,
						reference,
						refext,
						accext,
						refno,
						debitamt,
						creditamt,
						paidamt,
						paystatus,
						fullpay,
						desp,
						despa,
						despb,
						despc,
						despd,
						fcamt,
						debit_lc,
						credit_lc,
						exc_rate,
						age,
						posted,
						lastbal,
						payttime,
						new,
						rem1,
						rem2,
						rem4,
						source,
						job,
						agent,
						site,
						stran,
						fperiod,
						batchno,
						tranno,
						created_by,
						updated_by,
						created_on,
						updated_on,
						footercurrcode,
						footercurrrate,
						gainloss_postid,
						simple,
						trancode
					)
					VALUES
					(
						<cfqueryparam cfsqltype="cf_sql_integer" value="#getEntryOfGrandTotalLine.entry#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#DateFormat(wos_date,'YYYY-MM-DD')#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#araptype#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
						"",
						"F",
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#pono#">,
						<cfqueryparam cfsqltype="cf_sql_double" value="#debit_fc#">,
						<cfqueryparam cfsqltype="cf_sql_double" value="#credit_fc#">,
						"0",
						"",
						"F",
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDespForGrandTotalLine.description#">,
						"",
						"",
						"",
						"",
						<cfqueryparam cfsqltype="cf_sql_double" value="#fcamt#">,
						<cfqueryparam cfsqltype="cf_sql_double" value="#debitamt#">,
						<cfqueryparam cfsqltype="cf_sql_double" value="#creditamt#">,
						<cfqueryparam cfsqltype="cf_sql_double" value="#currrate#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#age#">,
						"P",
						<cfqueryparam cfsqltype="cf_sql_double" value="#lastbal#">,
						"0",
						"",
						"",
						"",
						"",
						"",
						"",
						"",
						"",
						"",
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#batchno#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#tranno#">,
						"#getAuthUser()#",
						"#getAuthUser()#",
						NOW(),
						NOW(),
						"",
						"0",
						"",
						"Y",
						"0"
					)
				</cfquery>
			</cfif>		
			<!--- reinsertTargetLedgerTable [END] --->
		
			<cfquery name="undeleteIctran" datasource="#dts#">
        		UPDATE ictran
				SET void=""
        	    WHERE type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
        	    AND refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
        	</cfquery>
		
			<!--- get undeleted record from ictran [START] --->
			<cfquery name="getUndeletedIctran" datasource="#dts#">
				SELECT type,refno,custno,fperiod,wos_date,currrate,trancode,itemcount,itemno,desp,qty_bil,qty,price_bil,price,amt1_bil,amt1,dispec1,disamt_bil,disamt,note_a,taxpec1,taxamt_bil,taxamt,taxincl,amt_bil,amt
				FROM ictran
				WHERE type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
				AND refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
			</cfquery>
			<!--- get undeleted record from ictran [END] --->
		
			<!--- reinsert undeleted item and tax record into glpost [START] --->
			<cfloop query="getUndeletedIctran">
				<cfset price=price_bil*currrate>
				<cfset price=NumberFormat(price,".__")>	
				<cfset amt1=amt1_bil*currrate>
				<cfset amt1=NumberFormat(amt1,".__")>
				<cfset disamt=disamt_bil*currrate>
				<cfset disamt=NumberFormat(disamt,".__")>
				<cfset amt=amt_bil*currrate>
				<cfset amt=NumberFormat(amt,".__")>
				<cfset taxamt=taxamt_bil*currrate>
				<cfset taxamt=NumberFormat(taxamt,".__")>					
						
				<!--- get desp for item and tax line [START] --->
				<cfquery name="getDespForItemAndTaxLine" datasource="#dts#">
					SELECT CONCAT(name,' ',name2) AS name
					FROM #targetTable#
					WHERE custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">
				</cfquery>
				<!--- get desp for item and tax line [END] --->		
			
				<!--- insert Glpost Item Line [START] --->
				<!--- get accno for general account [START] --->
				<cfquery name="getGeneralAccNo" datasource="#dts#">
					SELECT creditsales,purchasereceive
					FROM gsetup
				</cfquery>
				<cfif type EQ "CN" OR type EQ "CS" OR type EQ "DN" OR type EQ "INV">
					<cfset generalAccNo=getGeneralAccNo.creditsales>
				<cfelseif type EQ "PR" OR type EQ "RC">
					<cfset generalAccNo=getGeneralAccNo.purchasereceive>
				<cfelse>
					<cfset generalAccNo="">
				</cfif>
				<!--- get accno for general account [END] --->
			
				<!--- get last tranno with same batchno(preset 0) and increment it [START] --->
				<cfquery name="getLastTranNo" datasource="#dts#">
					SELECT MAX(tranno) AS lastTranNo
					FROM glpost
					WHERE fperiod!="99"
					AND batchno=<cfqueryparam cfsqltype="cf_sql_integer" value="#batchno#">
				</cfquery>
				<cfif getLastTranNo.lastTranNo EQ "">
					<cfset tranno=1>
				<cfelse>
					<cfset tranno=getLastTranNo.lastTranNo+1>
				</cfif>
				<!--- get last tranno with same batchno(preset 0) and increment it [END] --->
			
				<!--- get despe for item line [START] --->
				<cfquery name="getDespeForItemLine" datasource="#dts#">
					SELECT desp
					FROM gldata
					WHERE accno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#generalAccNo#">
				</cfquery>
				<!--- get despe for item line [END] --->
			
				<!--- process ttype,debitamt,creditamt,fcamt,debit_fc,credit_fc,araptype,age [START]  --->
				<!--- process ttype,debitamt,creditamt,fcamt,debit_fc,credit_fc,araptype,age for the target account record line and general account record line are different --->
				<cfif currcode EQ getSystemCurrency.SystemCurrCode>
					<cfset amount=amt_bil>
					<cfset fcamt1=0.00>
				<cfelse>
					<cfset amount=amt>
					<cfset fcamt1=amt_bil>
				</cfif>
				<cfset taxpur=amount>		
				<cfif type EQ "CN">
					<cfset ttype="GD">
					<cfset debitamt=amount>
					<cfset creditamt=0>
					<cfset fcamt=fcamt1>
					<cfset debit_fc=fcamt1>
					<cfset credit_fc=0>
					<cfset araptype="C">
					<cfset age=11>
				<cfelseif type EQ "CS">
					<cfset ttype="GC">
					<cfset debitamt=0>
					<cfset creditamt=amount>
					<cfset fcamt=-fcamt1>
					<cfset debit_fc=0>
					<cfset credit_fc=fcamt1>
					<cfset araptype="H">
					<cfset age=0>
				<cfelseif type EQ "DN">
					<cfset ttype="GC">
					<cfset debitamt=0>
					<cfset creditamt=amount>
					<cfset fcamt=-fcamt1>
					<cfset debit_fc=0>
					<cfset credit_fc=fcamt1>
					<cfset araptype="D">
					<cfset age=0>
				<cfelseif type EQ "INV">
					<cfset ttype="GC">
					<cfset debitamt=0>
					<cfset creditamt=amount>
					<cfset fcamt=-fcamt1>
					<cfset debit_fc=0>
					<cfset credit_fc=fcamt1>
					<cfset araptype="I">
					<cfset age=0>
				<cfelseif type EQ "PR">
					<cfset ttype="GC">
					<cfset debitamt=0>
					<cfset creditamt=amount>
					<cfset fcamt=-fcamt1>
					<cfset debit_fc=0>
					<cfset credit_fc=fcamt1>
					<cfset araptype="C">
					<cfset age=11>
				<cfelseif type EQ "RC">
					<cfset ttype="GD">
					<cfset debitamt=amount>
					<cfset creditamt=0>
					<cfset fcamt=fcamt1>
					<cfset debit_fc=fcamt1>
					<cfset credit_fc=0>
					<cfset araptype="I">
					<cfset age=0>
				<cfelse>
					<cfset ttype="">
					<cfset debitamt=0>
					<cfset creditamt=0>
					<cfset fcamt=0>
					<cfset debit_fc=0>
					<cfset credit_fc=0>
					<cfset araptype="">
					<cfset age=0>
				</cfif>
				<!--- process process ttype,debitamt,creditamt,fcamt,debit_fc,credit_fc,araptype,age [END]  --->
			
				<cfquery name="reinsertGlpostItemLine" datasource="#dts#">
					INSERT INTO glpost
					(
						acc_code,
						accno,
						fperiod,
						date,
						batchno,
						tranno,
						vouc_seq,
						vouc_seq_2,
						ttype,
						reference,
						refno,
						desp,
						despa,
						despb,
						despc,
						despd,
						despe,
						taxpec,
						debitamt,
						creditamt,
						fcamt,
						debit_fc,
						credit_fc,
						exc_rate,
						araptype,
						age,
						source,
						job,
						job2,
						subjob,
						job_value,
						job2_value,
						posted,
						exported,
						exported1,
						exported2,
						exported3,
						rem1,
						rem2,
						rem3,
						rem4,
						rem5,
						rpt_row,
						agent,
						site,
						stran,
						taxpur,
						paymode,
						trdatetime,
						corr_acc,
						accno2,
						accno3,
						date2,
						userid,
						tcurrcode,
						tcurramt,
						issuedate,
						bperiod,
						bdate,
						vperiod,
						origin,
						mperiod,
						created_by,
						updated_by,
						created_on,
						updated_on,
						uuid,
						wht_status,
						whtcustname,
						whtcustadd,
						whtcusttaxid,
						calwhtamt1,
						calwhtamt3,
						calwhtamt2,
						calwhtamt4,
						sequal,
						comuen,
						permitno,
						vouchermark,
						footercurrcode,
						footercurrrate,
						gainloss_postid,
						simple,
						trancode
					)
					VALUES
					(
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#generalAccNo#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#DateFormat(wos_date,'YYYY-MM-DD')#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#batchno#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#tranno#">,
						"0",
						"0",
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#ttype#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#pono#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDespForItemAndTaxLine.name#">,
						"",
						"",
						"",
						"",
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDespeForItemLine.desp#">,
						"#taxpec1#",
						<cfqueryparam cfsqltype="cf_sql_double" value="#debitamt#">,
						<cfqueryparam cfsqltype="cf_sql_double" value="#creditamt#">,
						<cfqueryparam cfsqltype="cf_sql_double" value="#fcamt#">,
						<cfqueryparam cfsqltype="cf_sql_double" value="#debit_fc#">,
						<cfqueryparam cfsqltype="cf_sql_double" value="#credit_fc#">,
						<cfqueryparam cfsqltype="cf_sql_double" value="#currrate#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#araptype#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#age#">,
						"",
						"",
						"",
						"",
						"0",
						"0",
						"",
						"",
						"",
						"",
						"",
						"",
						"",
						"",
						"#note_a#",
						"0",
						"0",
						"",
						"",
						"",
						<cfqueryparam cfsqltype="cf_sql_double" value="#taxpur#">,
						"",
						Now(),
						"",
						"",
						"",
						"0000-00-00",
						"#getAuthUser()#",
						"",
						"0",
						"0000-00-00",
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
						"0000-00-00",
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
						"",
						"0",
						"#getAuthUser()#",
						"#getAuthUser()#",
						NOW(),
						NOW(),
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">,
						"",
						"",
						"",
						"",
						"0",
						"0",
						"0",
						"0",
						"",
						"",
						"",
						"0",
						"",
						"0",
						"",
						"Y",
						"#trancode#"
					)	
				</cfquery>			
				<!--- insert Glpost Item Line [END] --->
			
				<cfif taxpec1 NEQ 0>			
					<!--- insert Glpost Tax Line [START] --->
					<!--- get accno for tax [START] --->
					<cfquery name="getTaxAccNo" datasource="#dts#">
						SELECT corr_accno
						FROM taxtable
						WHERE code="#note_a#"
					</cfquery>
					<!--- get accno for tax [END] --->
			
					<!--- get last tranno with same batchno(preset 0) and increment it [START] --->
					<cfquery name="getLastTranNo" datasource="#dts#">
						SELECT MAX(tranno) AS lastTranNo
						FROM glpost
						WHERE fperiod!="99"
						AND batchno=<cfqueryparam cfsqltype="cf_sql_integer" value="#batchno#">
					</cfquery>
					<cfif getLastTranNo.lastTranNo EQ "">
						<cfset tranno=1>
					<cfelse>
						<cfset tranno=getLastTranNo.lastTranNo+1>
					</cfif>
					<!--- get last tranno with same batchno(preset 0) and increment it [END] --->
			
					<!--- process ttype,debitamt,creditamt,fcamt,debit_fc,credit_fc,araptype,age [START]  --->
					<!--- process ttype,debitamt,creditamt,fcamt,debit_fc,credit_fc,araptype,age for the target account record line and general account record line are different --->
					<cfif currcode EQ getSystemCurrency.SystemCurrCode>
						<cfset amount=taxamt_bil>
						<cfset fcamt1=0.00>
					<cfelse>
						<cfset amount=taxamt>
						<cfset fcamt1=taxamt_bil>
					</cfif>
					<cfset taxpur=amount>		
					<cfif type EQ "CN">
						<cfset ttype="GD">
						<cfset debitamt=amount>
						<cfset creditamt=0>
						<cfset fcamt=fcamt1>
						<cfset debit_fc=fcamt1>
						<cfset credit_fc=0>
						<cfset araptype="C">
						<cfset age=11>
					<cfelseif type EQ "CS">
						<cfset ttype="GC">
						<cfset debitamt=0>
						<cfset creditamt=amount>
						<cfset fcamt=-fcamt1>
						<cfset debit_fc=0>
						<cfset credit_fc=fcamt1>
						<cfset araptype="H">
						<cfset age=0>
					<cfelseif type EQ "DN">
						<cfset ttype="GC">
						<cfset debitamt=0>
						<cfset creditamt=amount>
						<cfset fcamt=-fcamt1>
						<cfset debit_fc=0>
						<cfset credit_fc=fcamt1>
						<cfset araptype="D">
						<cfset age=0>
					<cfelseif type EQ "INV">
						<cfset ttype="GC">
						<cfset debitamt=0>
						<cfset creditamt=amount>
						<cfset fcamt=-fcamt1>
						<cfset debit_fc=0>
						<cfset credit_fc=fcamt1>
						<cfset araptype="I">
						<cfset age=0>
					<cfelseif type EQ "PR">
						<cfset ttype="GC">
						<cfset debitamt=0>
						<cfset creditamt=amount>
						<cfset fcamt=-fcamt1>
						<cfset debit_fc=0>
						<cfset credit_fc=fcamt1>
						<cfset araptype="C">
						<cfset age=11>
					<cfelseif type EQ "RC">
						<cfset ttype="GD">
						<cfset debitamt=amount>
						<cfset creditamt=0>
						<cfset fcamt=fcamt1>
						<cfset debit_fc=fcamt1>
						<cfset credit_fc=0>
						<cfset araptype="I">
						<cfset age=0>
					<cfelse>
						<cfset ttype="">
						<cfset debitamt=0>
						<cfset creditamt=0>
						<cfset fcamt=0>
						<cfset debit_fc=0>
						<cfset credit_fc=0>
						<cfset araptype="">
						<cfset age=0>
					</cfif>
					<!--- process process ttype,debitamt,creditamt,fcamt,debit_fc,credit_fc,araptype,age [END]  --->
			
					<!--- get despe for tax line [START] --->
					<cfquery name="getDespeForTaxLine" datasource="#dts#">
						SELECT desp
						FROM gldata
						WHERE accno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getTaxAccNo.corr_accno#">
					</cfquery>
					<!--- get despe for tax line [END] --->
			
					<cfquery name="insertGlpostTaxLine" datasource="#dts#">
						INSERT INTO glpost
						(
							acc_code,
							accno,
							fperiod,
							date,
							batchno,
							tranno,
							vouc_seq,
							vouc_seq_2,
							ttype,
							reference,
							refno,
							desp,
							despa,
							despb,
							despc,
							despd,
							despe,
							taxpec,
							debitamt,
							creditamt,
							fcamt,
							debit_fc,
							credit_fc,
							exc_rate,
							araptype,
							age,
							source,
							job,
							job2,
							subjob,
							job_value,
							job2_value,
							posted,
							exported,
							exported1,
							exported2,
							exported3,
							rem1,
							rem2,
							rem3,
							rem4,
							rem5,
							rpt_row,
							agent,
							site,
							stran,
							taxpur,
							paymode,
							trdatetime,
							corr_acc,
							accno2,
							accno3,
							date2,
							userid,
							tcurrcode,
							tcurramt,
							issuedate,
							bperiod,
							bdate,
							vperiod,
							origin,
							mperiod,
							created_by,
							updated_by,
							created_on,
							updated_on,
							uuid,
							wht_status,
							whtcustname,
							whtcustadd,
							whtcusttaxid,
							calwhtamt1,
							calwhtamt3,
							calwhtamt2,
							calwhtamt4,
							sequal,
							comuen,
							permitno,
							vouchermark,
							footercurrcode,
							footercurrrate,
							gainloss_postid,
							simple,
							trancode
						)
						VALUES
						(
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#getTaxAccNo.corr_accno#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#DateFormat(wos_date,'YYYY-MM-DD')#">,
							<cfqueryparam cfsqltype="cf_sql_integer" value="#batchno#">,
							<cfqueryparam cfsqltype="cf_sql_integer" value="#tranno#">,
							"0",
							"0",
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#ttype#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#pono#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDespForItemAndTaxLine.name#">,
							"",
							"",
							"",
							"",
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDespeForTaxLine.desp#">,
							"#taxpec1#",
							<cfqueryparam cfsqltype="cf_sql_double" value="#debitamt#">,
							<cfqueryparam cfsqltype="cf_sql_double" value="#creditamt#">,
							<cfqueryparam cfsqltype="cf_sql_double" value="#fcamt#">,
							<cfqueryparam cfsqltype="cf_sql_double" value="#debit_fc#">,
							<cfqueryparam cfsqltype="cf_sql_double" value="#credit_fc#">,
							<cfqueryparam cfsqltype="cf_sql_double" value="#currrate#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#araptype#">,
							<cfqueryparam cfsqltype="cf_sql_integer" value="#age#">,
							"",
							"",
							"",
							"",
							"0",
							"0",
							"",
							"",
							"",
							"",
							"",
							"",
                            "",
                            "",
							"#note_a#",
							"0",
							"0",
							"",
							"",
							"",
							"0",
							"",
							Now(),
							"",
							"",
							"",
							"0000-00-00",
							"#getAuthUser()#",
							"",
							"0",
							"0000-00-00",
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
							"0000-00-00",
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
							"",
							"0",
							"#getAuthUser()#",
							"#getAuthUser()#",
							NOW(),
							NOW(),
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">,
							"",
							"",
							"",
							"",
							"0",
							"0",
							"0",
							"0",
							"",
							"",
							"",
							"0",
							"",
							"0",
							"",
							"Y",
							"#trancode#"
						)
					</cfquery>
					<!--- insert Glpost Tax Line [END] --->
				</cfif>
			</cfloop>
			<!--- reinsert undeleted item and tax record into glpost [END] --->
		</cfloop>
	<cfoutput>Un-delete transaction successfully.</cfoutput>
	<!--- undeleteTransaction [END] --->
	
	<!--- getTransactionInfo [START] --->
	<cfelseif action EQ "getTransactionInfo">
		<cfset type=form.type>
		<cfset selectedRefno=form.selectedRefno>
		<cfquery name="getTransactionInfo" datasource="#dts#">
        	SELECT custno,custinfo,wos_date,pono,currcode,currrate,gross_bil,disc_bil,net_bil,tax_bil,grand_bil,rem10,rem11
            FROM artran
            WHERE type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
            AND refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#selectedRefno#">
        </cfquery>
		<cfquery name="getItemList" datasource="#dts#">
        	SELECT dispec1
            FROM ictran
            WHERE type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
			AND refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#selectedRefno#">
            ORDER BY trancode ASC
        </cfquery>
		<cfset transaction={
			CUSTNO="#getTransactionInfo.custno#",
			CUSTINFO="#getTransactionInfo.custinfo#",
			WOS_DATE="#DateFormat(getTransactionInfo.wos_date,'dd/mm/yyyy')#",
			PONO="#getTransactionInfo.pono#",
			DISPEC1="#getItemList.dispec1#",
			CURRCODE="#getTransactionInfo.currcode#",
			CURRRATE="#getTransactionInfo.currrate#",
			GROSS_BIL="#getTransactionInfo.gross_bil#",
			DISC_BIL="#getTransactionInfo.disc_bil#",
			NET_BIL="#getTransactionInfo.net_bil#",
			TAX_BIL="#getTransactionInfo.tax_bil#",
			GRAND_BIL="#getTransactionInfo.grand_bil#",
			REM10="#getTransactionInfo.rem10#",
			REM11="#getTransactionInfo.rem11#"
		}>
		<cfset transaction=SerializeJSON(transaction)>
		<cfset transaction=cleanXmlString(transaction)>
		<cfoutput>#transaction#</cfoutput>
	<!--- getTransactionInfo [END] --->
	
	<!--- getTransactionItem [START] --->
	<cfelseif action EQ "getTransactionItem">
		<cfset type=form.type>
		<cfset selectedRefno=form.selectedRefno>
		<cfset uuid=form.uuid>		
		<cfset taxException=form.taxException>
		<cfquery name="getIctran" datasource="#dts#">
        	SELECT trancode,itemno,desp,qty_bil,price_bil,amt1_bil,dispec1,disamt_bil,note_a,taxpec1,taxamt_bil,amt_bil
			FROM ictran
            WHERE type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
			AND refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#selectedRefno#">
            ORDER BY trancode ASC
        </cfquery>
		<cfloop query="getIctran">
			<cfquery name="insertItem" datasource="#dts#">
				INSERT INTO simpletransactionitemtemp
				(uuid,trancode,itemno,desp,qty_bil,price_bil,amt1_bil,dispec1,disamt_bil,note_a,taxpec1,taxamt_bil,amt_bil)
				VALUES
				(
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#getIctran.trancode#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#getIctran.itemno#">,
					<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#getIctran.desp#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#getIctran.qty_bil#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#getIctran.price_bil#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#getIctran.amt1_bil#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#getIctran.dispec1#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#getIctran.disamt_bil#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#getIctran.note_a#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#getIctran.taxpec1#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#getIctran.taxamt_bil#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#getIctran.amt_bil#">
				)
			</cfquery>
		</cfloop>		
		<cfquery name="getItem" datasource="#dts#">
			SELECT itemno
			FROM icitem 
			WHERE (nonstkitem<>'T' OR nonstkitem IS null)
			ORDER BY itemno
		</cfquery>
        <cfquery name="getTax" datasource="#dts#">
			SELECT code
			FROM taxtable
			WHERE tax_type <> "#taxException#"
		</cfquery>
		<cfquery name="getItemList" datasource="#dts#">
        	SELECT trancode,itemno,desp,qty_bil,price_bil,amt1_bil,dispec1,disamt_bil,note_a,taxpec1,taxamt_bil,amt_bil
            FROM simpletransactionitemtemp
            WHERE uuid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
            ORDER BY trancode ASC
        </cfquery>
		<cfoutput>
		<cfloop query="getItemList">
		<cfset trancode=getItemList.trancode>
		<tr id="#getItemList.trancode#" class="edit_tr">
			<td><img id="insert_#getItemList.trancode#" class="insert_button" alt="insert" src="/images/simpletransaction/insert.png"/></td>
			<td class="edit_td">
				<input type="hidden" id="itemno_input_#getItemList.trancode#" class="editbox itemno_input addline" data-placeholder="Choose an item" value="#getItemList.itemno#" />
			</td>
			<td class="edit_td">
				<input type="text" id="desp_input_#getItemList.trancode#" class="editbox addline" value="#getItemList.desp#" onblur="if(document.getElementById('loadComplete').value==1){document.getElementById('loadComplete').value=0;updateItem(#getItemList.trancode#,'price_bil_input_');};" />
			</td>
			<td class="edit_td">
				<input type="text" id="price_bil_input_#getItemList.trancode#" class="editbox price_bil_input addline" value="#NumberFormat(getItemList.price_bil,'.__')#" onblur="if(document.getElementById('loadComplete').value==1){document.getElementById('loadComplete').value=0;updateItem(#getItemList.trancode#,'qty_bil_input_');};" />
			</td>
			<td class="edit_td">
				<input type="text" id="qty_bil_input_#getItemList.trancode#" class="editbox qty_bil_input addline" value="#NumberFormat(getItemList.qty_bil,'.__')#" onblur="if(document.getElementById('loadComplete').value==1){document.getElementById('loadComplete').value=0;updateItem(#getItemList.trancode#,'note_a_input_');};" />
			</td>
			<td class="edit_td">
				<select id="note_a_input_#getItemList.trancode#" class="editbox note_a_input" onblur="if(document.getElementById('loadComplete').value==1){document.getElementById('loadComplete').value=0;updateItem(#getItemList.trancode#,'itemno_input_');};">
					<option value=""></option>
					<cfloop query="getTax">
						<option value="#code#" <cfif code EQ getItemList.note_a>selected="selected"</cfif>>#code#</option>
					</cfloop>
				</select>
				<input type="hidden" id="taxpec1_#getItemList.trancode#" value="#getItemList.taxpec1#" />
				<input type="hidden" id="taxamt_bil_#getItemList.trancode#" value="#getItemList.taxamt_bil#" />
				<input type="hidden" id="dispec1_input_#getItemList.trancode#" class="dispec1_input" value="#getItemList.dispec1#" />
				<input type="hidden" id="disamt_bil_#getItemList.trancode#" value="#getItemList.disamt_bil#" />
				<input type="hidden" id="amt_bil_#getItemList.trancode#" value="#getItemList.amt_bil#" />
			</td>
			<td><span id="amt1_bil_#getItemList.trancode#" class="text">#NumberFormat(getItemList.amt1_bil,'.__')#</span></td>
			<td><img id="remove_#getItemList.trancode#" class="remove_button" alt="remove" src="/images/simpletransaction/remove.png" /></td>
		</tr>
		</cfloop>
		<cfset trancode=trancode+1>
		<tr id="#trancode#" class="edit_tr last_edit_tr">
			<td><img id="insert_#trancode#" class="insert_button" alt="insert" src="/images/simpletransaction/insert.png"/></td>
			<td class="edit_td">
				<input type="hidden" id="itemno_input_#trancode#" class="editbox itemno_input addline" data-placeholder="Choose an item" />
			</td>
			<td class="edit_td">
				<input type="text" id="desp_input_#trancode#" class="editbox addline" value="" onblur="if(this.value!=''&&document.getElementById('loadComplete').value==1){document.getElementById('loadComplete').value=0;updateItem(#trancode#,'price_bil_input_');}" />
			</td>
			<td class="edit_td">
				<input type="text" id="price_bil_input_#trancode#" class="editbox price_bil_input addline" value="0.00" onblur="if(this.value!=0&&document.getElementById('loadComplete').value==1){document.getElementById('loadComplete').value=0;updateItem(#trancode#,'qty_bil_input_');}" />
			</td>
			<td class="edit_td">
				<input type="text" id="qty_bil_input_#trancode#" class="editbox qty_bil_input addline" value="0.00" onblur="if(this.value!=0&&document.getElementById('loadComplete').value==1){document.getElementById('loadComplete').value=0;updateItem(#trancode#,'note_a_input_');}" />
			</td>
			<td class="edit_td">
				<select id="note_a_input_#trancode#" class="editbox note_a_input" onblur="if(this.value!=''&&document.getElementById('loadComplete').value==1){document.getElementById('loadComplete').value=0;updateItem(#trancode#,'itemno_input_');}">
					<option value=""></option>
					<cfloop query="getTax">
						<option value="#code#">#code#</option>
					</cfloop>
				</select>
				<input type="hidden" id="taxpec1_#trancode#" value="0.00" />
				<input type="hidden" id="taxamt_bil_#trancode#" value="0.00" />
				<input type="hidden" id="dispec1_input_#trancode#" class="dispec1_input" value="#getItemList.dispec1#" />
				<input type="hidden" id="disamt_bil_#trancode#" value="0.00" />
				<input type="hidden" id="amt_bil_#trancode#" value="0.00" />
			</td>
			<td><span id="amt1_bil_#trancode#" class="text">0.00</span></td>
			<td><img id="remove_#trancode#" class="remove_button" alt="remove" src="/images/simpletransaction/remove.png" /></td>
		</tr>
		</cfoutput>
	<!--- getTransactionItem [END] --->
	
	<!--- update [START] --->
	<cfelseif action EQ "update">
		<cfset action=form.action>
		<cfset type=form.type>
		<cfset uuid=form.uuid>
		<cfset targetTable=form.targetTable>
		<cfset targetLedgerTable=form.targetLedgerTable>
		<cfset custno=form.custno>	
		<cfset custinfo=form.custinfo>
		<cfset refno=form.refno>
		<cfset wos_date=form.wos_date>
		<cfset pono=form.pono>
		<cfset currcode=form.currcode>
		<cfset currrate=form.currrate>
		<cfset gross_bil=form.gross_bil>
		<cfset disc_bil=form.disc_bil>
		<cfset net_bil=form.net_bil>
		<cfset tax_bil=form.tax_bil>
		<cfset grand_bil=form.grand_bil>
		<cfset rem10=form.rem10>
		<cfset rem11=form.rem11>
		<cfset dd=DateFormat(wos_date,"DD")>  
  		<cfif dd GT '12'>
   			<cfset wos_date=DateFormat(wos_date,"YYYY-MM-DD")>
  		<cfelse>
   			<cfset wos_date=DateFormat(wos_date,"YYYY-DD-MM")>
 		 </cfif>
		<cfinvoke component="cfc.Period" method="getCurrentPeriod" dts="#dts#" inputDate="#DateFormat(wos_date,'yyyy-mm-dd')#" returnvariable="fperiod"/>
		<cfset invgross=NumberFormat(gross_bil*currrate,".__")>
		<cfset discount=NumberFormat(disc_bil*currrate,".__")>
		<cfset net=NumberFormat(net_bil*currrate,".__")>
		<cfset tax=NumberFormat(tax_bil*currrate,".__")>
		<cfset grand=NumberFormat(grand_bil*currrate,".__")>
		<cfquery name="updateArtran" datasource="#dts#">
			UPDATE artran
			SET
				custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">,
                custinfo=<cfqueryparam cfsqltype="cf_sql_varchar" value="#custinfo#">,
				wos_date=<cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,
				fperiod=<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
				pono=<cfqueryparam cfsqltype="cf_sql_varchar" value="#pono#">,
				currcode=<cfqueryparam cfsqltype="cf_sql_varchar" value="#currcode#">,
				currrate=<cfqueryparam cfsqltype="cf_sql_double" value="#currrate#">,
				gross_bil=<cfqueryparam cfsqltype="cf_sql_double" value="#gross_bil#">,
				invgross=<cfqueryparam cfsqltype="cf_sql_double" value="#invgross#">,
				disc_bil=<cfqueryparam cfsqltype="cf_sql_double" value="#disc_bil#">,
				discount=<cfqueryparam cfsqltype="cf_sql_double" value="#discount#">,
				net_bil=<cfqueryparam cfsqltype="cf_sql_double" value="#net_bil#">,
				net=<cfqueryparam cfsqltype="cf_sql_double" value="#net#">,
				tax_bil=<cfqueryparam cfsqltype="cf_sql_double" value="#tax_bil#">,
				tax=<cfqueryparam cfsqltype="cf_sql_double" value="#tax#">,
				grand_bil=<cfqueryparam cfsqltype="cf_sql_double" value="#grand_bil#">,
				grand=<cfqueryparam cfsqltype="cf_sql_double" value="#grand#">,
				rem10=<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#rem10#">,
				rem11=<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#rem11#">,
				updated_by="#getAuthUser()#",
				updated_on=Now()
			WHERE type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
			AND refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
		</cfquery>
		
		<!--- get despe [START] --->
		<!--- despe for the target account record line and general account record line are different --->
		<cfquery name="getDespeForGrandTotalLine" datasource="#dts#">
			SELECT name
			FROM #targetTable#
			WHERE custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">
		</cfquery>
		<!--- get despe [END] --->
		
		<!--- get System Currency [START] --->
		<cfquery name="getSystemCurrency" datasource="#dts#">
			SELECT ctycode AS SystemCurrCode
			FROM gsetup
		</cfquery>
		<!--- get System Currency [END] --->
				
		<!--- process ttype,debitamt,creditamt,fcamt,debit_fc,credit_fc,araptype,age [START]  --->
		<!--- process ttype,debitamt,creditamt,fcamt,debit_fc,credit_fc,araptype,age for the target account record line and general account record line are different --->
		<cfif currcode EQ getSystemCurrency.SystemCurrCode>
			<cfset amount=grand_bil>
			<cfset fcamt1=0.00>
		<cfelse>
			<cfset amount=grand>
			<cfset fcamt1=grand_bil>
		</cfif>		
		<cfif type EQ "CN">
			<cfset ttype="RC">
			<cfset debitamt=0>
			<cfset creditamt=amount>
			<cfset fcamt=-fcamt1>
			<cfset debit_fc=0>
			<cfset credit_fc=fcamt1>
			<cfset araptype="C">
			<cfset age=11>
		<cfelseif type EQ "CS">
			<cfset ttype="RD">
			<cfset debitamt=amount>
			<cfset creditamt=0>
			<cfset fcamt=fcamt1>
			<cfset debit_fc=fcamt1>
			<cfset credit_fc=0>
			<cfset araptype="H">
			<cfset age=0>
		<cfelseif type EQ "DN">
			<cfset ttype="RD">
			<cfset debitamt=amount>
			<cfset creditamt=0>
			<cfset fcamt=fcamt1>
			<cfset debit_fc=fcamt1>
			<cfset credit_fc=0>
			<cfset araptype="D">
			<cfset age=0>
		<cfelseif type EQ "INV">
			<cfset ttype="RD">
			<cfset debitamt=amount>
			<cfset creditamt=0>
			<cfset fcamt=fcamt1>
			<cfset debit_fc=fcamt1>
			<cfset credit_fc=0>
			<cfset araptype="I">
			<cfset age=0>
		<cfelseif type EQ "PR">
			<cfset ttype="PD">
			<cfset debitamt=amount>
			<cfset creditamt=0>
			<cfset fcamt=fcamt1>
			<cfset debit_fc=fcamt1>
			<cfset credit_fc=0>
			<cfset araptype="C">
			<cfset age=11>
		<cfelseif type EQ "RC">
			<cfset ttype="PC">
			<cfset debitamt=0>
			<cfset creditamt=amount>
			<cfset fcamt=-fcamt1>
			<cfset debit_fc=0>
			<cfset credit_fc=fcamt1>
			<cfset araptype="I">
			<cfset age=0>
		<cfelse>
			<cfset ttype="">
			<cfset debitamt=0>
			<cfset creditamt=0>
			<cfset fcamt=0>
			<cfset debit_fc=0>
			<cfset credit_fc=0>
			<cfset araptype="">
			<cfset age=0>
		</cfif>
		<!--- process process ttype,debitamt,creditamt,fcamt,debit_fc,credit_fc,araptype,age [END]  --->
		
		<!--- Update GLPost GrandTotal Line [START] --->
		<cfquery name="updateGLPostGrandTotalLine" datasource="#dts#">
			UPDATE glpost
			SET
				accno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">,
				fperiod=<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
				date=<cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,
				refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#pono#">,
				despe=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDespeForGrandTotalLine.name#">,
				debitamt=<cfqueryparam cfsqltype="cf_sql_double" value="#debitamt#">,
				creditamt=<cfqueryparam cfsqltype="cf_sql_double" value="#creditamt#">,
				fcamt=<cfqueryparam cfsqltype="cf_sql_double" value="#fcamt#">,
				debit_fc=<cfqueryparam cfsqltype="cf_sql_double" value="#debit_fc#">,
				credit_fc=<cfqueryparam cfsqltype="cf_sql_double" value="#credit_fc#">,
				exc_rate=<cfqueryparam cfsqltype="cf_sql_double" value="#currrate#">,
				
				bperiod=<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
				vperiod=<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
				updated_by="#getAuthUser()#",
				updated_on=NOW()				
			WHERE acc_code=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
			AND reference=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
			AND trancode="0"
		</cfquery>
		<!--- Update GLPost GrandTotal Line [END] --->
		
		<!--- Update Target Ledger Table [START] --->
		<!--- get Entry, Tranno, desp of Grand Total Line [START] --->
		<cfquery name="getEntryOfGrandTotalLine" datasource="#dts#">
			SELECT entry,tranno,desp
			FROM glpost
			WHERE acc_code=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
			AND reference=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
			AND trancode="0"
		</cfquery>
		<cfset tranno=getEntryOfGrandTotalLine.tranno>
		<cfset description=getEntryOfGrandTotalLine.desp>
		<!--- get Entry, Tranno, desp of Grand Total Line [END] --->
		
		<!--- get created_by, created_on FROM Existing Target Ledger Table Record [START] --->
		<cfquery name="getCreatedByCreatedOn" datasource="#dts#">
			SELECT created_by,created_on
			FROM #targetLedgerTable#
			WHERE entry=<cfqueryparam cfsqltype="cf_sql_integer" value="#getEntryOfGrandTotalLine.entry#">
			LIMIT 1
		</cfquery>
		<cfset originalCreatedBy=getCreatedByCreatedOn.created_by>
		<cfset originalCreatedOn=getCreatedByCreatedOn.created_on>
		<!--- get created_by, created_on FROM Existing Target Ledger Table Record [END] --->
		
		<!--- delete Existing Target Ledger Table Record [START] --->
		<cfquery name="deleteExistingTargetLedgerTableRecord" datasource="#dts#">
			DELETE FROM #targetLedgerTable#
			WHERE entry=<cfqueryparam cfsqltype="cf_sql_integer" value="#getEntryOfGrandTotalLine.entry#">
		</cfquery>
		<!--- delete Existing Target Ledger Table Record [END] --->
		
		<cfif currcode EQ getSystemCurrency.SystemCurrCode>
		
			<!--- calculate lastbal [START] --->
				<cfset lastbal=debitamt-creditamt>
			<!--- calculate lastbal [END] --->
			
			<cfquery name="insertTargetLocalLine" datasource="#dts#">
				INSERT INTO #targetLedgerTable#
				(
					entry,
					accno,
					date,
					araptype,
					reference,
					refext,
					accext,
					refno,
					debitamt,
					creditamt,
					paidamt,
					paystatus,
					fullpay,
					desp,
					despa,
					despb,
					despc,
					despd,
					fcamt,
					debit_lc,
					credit_lc,
					exc_rate,
					age,
					posted,
					lastbal,
					payttime,
					new,
					rem1,
					rem2,
					rem4,
					source,
					job,
					agent,
					site,
					stran,
					fperiod,
					batchno,
					tranno,
					created_by,
					updated_by,
					created_on,
					updated_on,
					footercurrcode,
					footercurrrate,
					gainloss_postid,
					simple,
					trancode
				)
				VALUES
				(
					<cfqueryparam cfsqltype="cf_sql_integer" value="#getEntryOfGrandTotalLine.entry#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#araptype#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
					"",
					"",
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#pono#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#debitamt#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#creditamt#">,
					"0",
					"",
					"F",
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#description#">,
					"",
					"",
					"",
					"",
					<cfqueryparam cfsqltype="cf_sql_double" value="#fcamt#">,
					"0",
					"0",
					<cfqueryparam cfsqltype="cf_sql_double" value="#currrate#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#age#">,
					"P",
					<cfqueryparam cfsqltype="cf_sql_double" value="#lastbal#">,
					"0",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#batchno#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#tranno#">,
					"#originalCreatedBy#",
					"#getAuthUser()#",
					"#originalCreatedOn#",
					NOW(),
					"",
					"0",
					"",
					"Y",
					"0"
				)
			</cfquery>			
		<cfelse>
		
			<!--- calculate lastbal [START] --->
				<cfset lastbal=debitamt-creditamt>
			<!--- calculate lastbal [END] --->
			
			<cfquery name="insertTargetLocalLine" datasource="#dts#">
				INSERT INTO #targetLedgerTable#
				(
					entry,
					accno,
					date,
					araptype,
					reference,
					refext,
					accext,
					refno,
					debitamt,
					creditamt,
					paidamt,
					paystatus,
					fullpay,
					desp,
					despa,
					despb,
					despc,
					despd,
					fcamt,
					debit_lc,
					credit_lc,
					exc_rate,
					age,
					posted,
					lastbal,
					payttime,
					new,
					rem1,
					rem2,
					rem4,
					source,
					job,
					agent,
					site,
					stran,
					fperiod,
					batchno,
					tranno,
					created_by,
					updated_by,
					created_on,
					updated_on,
					footercurrcode,
					footercurrrate,
					gainloss_postid,
					simple,
					trancode
				)
				VALUES
				(
					<cfqueryparam cfsqltype="cf_sql_integer" value="#getEntryOfGrandTotalLine.entry#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#araptype#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
					"",
					"",
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#pono#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#debitamt#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#creditamt#">,
					"0",
					"",
					"F",
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#description#">,
					"",
					"",
					"",
					"",
					<cfqueryparam cfsqltype="cf_sql_double" value="#fcamt#">,
					"0",
					"0",
					<cfqueryparam cfsqltype="cf_sql_double" value="#currrate#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#age#">,
					"P",
					<cfqueryparam cfsqltype="cf_sql_double" value="#lastbal#">,
					"0",
					"",

					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#batchno#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#tranno#">,
					"#originalCreatedBy#",
					"#getAuthUser()#",
					"#originalCreatedOn#",
					NOW(),
					"",
					"0",
					"",
					"Y",
					"0"
				)
			</cfquery>
		
			<!--- calculate lastbal [START] --->
				<cfset lastbal=debit_fc-credit_fc>
			<!--- calculate lastbal [END] --->
			
			<cfquery name="insertTargetForeignLine" datasource="#dts#">
				INSERT INTO #targetLedgerTable#
				(
					entry,
					accno,
					date,
					araptype,
					reference,
					refext,
					accext,
					refno,
					debitamt,
					creditamt,
					paidamt,
					paystatus,
					fullpay,
					desp,
					despa,
					despb,
					despc,
					despd,
					fcamt,
					debit_lc,
					credit_lc,
					exc_rate,
					age,
					posted,
					lastbal,
					payttime,
					new,
					rem1,
					rem2,
					rem4,
					source,
					job,
					agent,
					site,
					stran,
					fperiod,
					batchno,
					tranno,
					created_by,
					updated_by,
					created_on,
					updated_on,
					footercurrcode,
					footercurrrate,
					gainloss_postid,
					simple,
					trancode
				)
				VALUES
				(
					<cfqueryparam cfsqltype="cf_sql_integer" value="#getEntryOfGrandTotalLine.entry#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#araptype#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
					"",
					"F",
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#pono#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#debit_fc#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#credit_fc#">,
					"0",
					"",
					"F",
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#description#">,
					"",
					"",
					"",
					"",
					<cfqueryparam cfsqltype="cf_sql_double" value="#fcamt#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#debitamt#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#creditamt#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#currrate#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#age#">,
					"P",
					<cfqueryparam cfsqltype="cf_sql_double" value="#lastbal#">,
					"0",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#batchno#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#tranno#">,
					"#originalCreatedBy#",
					"#getAuthUser()#",
					"#originalCreatedOn#",
					NOW(),
					"",
					"0",
					"",
					"Y",
					"0"
				)
			</cfquery>
		</cfif>	
		<!--- Update Target Ledger Table [END] --->
		
		<cfquery name="deleteIctran" datasource="#dts#">
			DELETE FROM ictran
			WHERE type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
			AND refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
		</cfquery>
		
		<!--- Delete GLPost Item And Tax Line [START] --->
		<cfquery name="deleteGLPostItemAndTaxLine" datasource="#dts#">
			DELETE FROM glpost
			WHERE acc_code=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
			AND reference=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
			AND trancode!="0"
		</cfquery>
		<!--- Delete GLPost Item And Tax Line [END] --->
		
		<cfquery name="getItemList" datasource="#dts#">
        	SELECT trancode,itemno,desp,qty_bil,price_bil,amt1_bil,dispec1,disamt_bil,note_a,taxpec1,taxamt_bil,amt_bil
            FROM simpletransactionitemtemp
            WHERE uuid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
            ORDER BY trancode ASC
        </cfquery>
		<cfloop query="getItemList">
			<cfset price=price_bil*currrate>
			<cfset price=NumberFormat(price,".__")>	
			<cfset amt1=amt1_bil*currrate>
			<cfset amt1=NumberFormat(amt1,".__")>
			<cfset disamt=disamt_bil*currrate>
			<cfset disamt=NumberFormat(disamt,".__")>
			<cfset amt=amt_bil*currrate>
			<cfset amt=NumberFormat(amt,".__")>
			<cfset taxamt=taxamt_bil*currrate>
			<cfset taxamt=NumberFormat(taxamt,".__")>					
			<cfquery name="insertIctran" datasource="#dts#">
				INSERT INTO ictran
				(
					type,refno,
					custno,
					fperiod,wos_date,
					currrate,
					trancode,itemcount,
					itemno,desp,
					qty_bil,qty,
					price_bil,price,
					amt1_bil,amt1,
					dispec1,disamt_bil,disamt,
					note_a,taxpec1,taxamt_bil,taxamt,taxincl,
					amt_bil,amt					
				)
				VALUES
				(
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#currrate#">,
					"#trancode#","#trancode#",
					"#itemno#","#desp#",
					"#qty_bil#","#qty_bil#",
					"#price_bil#","#price#",
					"#amt1_bil#","#amt1#",
					"#dispec1#","#disamt_bil#","#disamt#",
					"#note_a#","#taxpec1#","#taxamt_bil#","#taxamt#","N",
					"#amt_bil#","#amt#"					
				)
			</cfquery>		
			
			<!--- get desp for item and tax line [START] --->
			<cfquery name="getDespForItemAndTaxLine" datasource="#dts#">
				SELECT CONCAT(name,' ',name2) AS name
				FROM #targetTable#
				WHERE custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">
			</cfquery>
			<!--- get desp for item and tax line [END] --->
			
			<!--- get created_by, created_on, uuid from the existing record [START] --->
			<cfquery name="getOriginalCreatedByCreatedOn" datasource="#dts#">
				SELECT created_by,created_on, uuid
				FROM glpost
				WHERE entry=<cfqueryparam cfsqltype="cf_sql_integer" value="#getEntryOfGrandTotalLine.entry#">
			</cfquery>
			<cfset originalCreatedBy=getOriginalCreatedByCreatedOn.created_by>
			<cfset originalCreatedOn=getOriginalCreatedByCreatedOn.created_on>
			<cfset originalUUID=getOriginalCreatedByCreatedOn.uuid>
			<!--- get created_by, created_on, uuid from the existing record [END] --->		
			
			<!--- insert Glpost Item Line [START] --->
			<!--- get accno for general account [START] --->
			<cfquery name="getGeneralAccNo" datasource="#dts#">
				SELECT creditsales,purchasereceive
				FROM gsetup
			</cfquery>
			<cfif type EQ "CN" OR type EQ "CS" OR type EQ "DN" OR type EQ "INV">
				<cfset generalAccNo=getGeneralAccNo.creditsales>
			<cfelseif type EQ "PR" OR type EQ "RC">
				<cfset generalAccNo=getGeneralAccNo.purchasereceive>
			<cfelse>
				<cfset generalAccNo="">
			</cfif>
			<!--- get accno for general account [END] --->
			
			<!--- get last tranno with same batchno(preset 0) and increment it [START] --->
			<cfquery name="getLastTranNo" datasource="#dts#">
				SELECT MAX(tranno) AS lastTranNo
				FROM glpost
				WHERE fperiod!="99"
				AND batchno=<cfqueryparam cfsqltype="cf_sql_integer" value="#batchno#">
			</cfquery>
			<cfif getLastTranNo.lastTranNo EQ "">
				<cfset tranno=1>
			<cfelse>
				<cfset tranno=getLastTranNo.lastTranNo+1>
			</cfif>
			<!--- get last tranno with same batchno(preset 0) and increment it [END] --->
			
			<!--- get despe for item line [START] --->
			<cfquery name="getDespeForItemLine" datasource="#dts#">
				SELECT desp
				FROM gldata
				WHERE accno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#generalAccNo#">
			</cfquery>
			<!--- get despe for item line [END] --->
			
			<!--- process ttype,debitamt,creditamt,fcamt,debit_fc,credit_fc,araptype,age [START]  --->
			<!--- process ttype,debitamt,creditamt,fcamt,debit_fc,credit_fc,araptype,age for the target account record line and general account record line are different --->
			<cfif currcode EQ getSystemCurrency.SystemCurrCode>
				<cfset amount=amt_bil>
				<cfset fcamt1=0.00>
			<cfelse>
				<cfset amount=amt>
				<cfset fcamt1=amt_bil>
			</cfif>
			<cfset taxpur=amount>		
			<cfif type EQ "CN">
				<cfset ttype="GD">
				<cfset debitamt=amount>
				<cfset creditamt=0>
				<cfset fcamt=fcamt1>
				<cfset debit_fc=fcamt1>
				<cfset credit_fc=0>
				<cfset araptype="C">
				<cfset age=11>
			<cfelseif type EQ "CS">
				<cfset ttype="GC">
				<cfset debitamt=0>
				<cfset creditamt=amount>
				<cfset fcamt=-fcamt1>
				<cfset debit_fc=0>
				<cfset credit_fc=fcamt1>
				<cfset araptype="H">
				<cfset age=0>
			<cfelseif type EQ "DN">
				<cfset ttype="GC">
				<cfset debitamt=0>
				<cfset creditamt=amount>
				<cfset fcamt=-fcamt1>
				<cfset debit_fc=0>
				<cfset credit_fc=fcamt1>
				<cfset araptype="D">
				<cfset age=0>
			<cfelseif type EQ "INV">
				<cfset ttype="GC">
				<cfset debitamt=0>
				<cfset creditamt=amount>
				<cfset fcamt=-fcamt1>
				<cfset debit_fc=0>
				<cfset credit_fc=fcamt1>
				<cfset araptype="I">
				<cfset age=0>
			<cfelseif type EQ "PR">
				<cfset ttype="GC">
				<cfset debitamt=0>
				<cfset creditamt=amount>
				<cfset fcamt=-fcamt1>
				<cfset debit_fc=0>
				<cfset credit_fc=fcamt1>
				<cfset araptype="C">
				<cfset age=11>
			<cfelseif type EQ "RC">
				<cfset ttype="GD">
				<cfset debitamt=amount>
				<cfset creditamt=0>
				<cfset fcamt=fcamt1>
				<cfset debit_fc=fcamt1>
				<cfset credit_fc=0>
				<cfset araptype="I">
				<cfset age=0>
			<cfelse>
				<cfset ttype="">
				<cfset debitamt=0>
				<cfset creditamt=0>
				<cfset fcamt=0>
				<cfset debit_fc=0>
				<cfset credit_fc=0>
				<cfset araptype="">
				<cfset age=0>
			</cfif>
			<!--- process ttype,debitamt,creditamt,fcamt,debit_fc,credit_fc,araptype,age [END]  --->
			
			<cfquery name="insertGlpostItemLine" datasource="#dts#">
				INSERT INTO glpost
				(
					acc_code,
					accno,
					fperiod,
					date,
					batchno,
					tranno,
					vouc_seq,
					vouc_seq_2,
					ttype,
					reference,
					refno,
					desp,
					despa,
					despb,
					despc,
					despd,
					despe,
					taxpec,
					debitamt,
					creditamt,
					fcamt,
					debit_fc,
					credit_fc,
					exc_rate,
					araptype,
					age,
					source,
					job,
					job2,
					subjob,
					job_value,
					job2_value,
					posted,
					exported,
					exported1,
					exported2,
					exported3,
					rem1,
					rem2,
					rem3,
					rem4,
					rem5,
					rpt_row,
					agent,
					site,
					stran,
					taxpur,
					paymode,
					trdatetime,
					corr_acc,
					accno2,
					accno3,
					date2,
					userid,
					tcurrcode,
					tcurramt,
					issuedate,
					bperiod,
					bdate,
					vperiod,
					origin,
					mperiod,
					created_by,
					updated_by,
					created_on,
					updated_on,
					uuid,
					wht_status,
					whtcustname,
					whtcustadd,
					whtcusttaxid,
					calwhtamt1,
					calwhtamt3,
					calwhtamt2,
					calwhtamt4,
					sequal,
					comuen,
					permitno,
					vouchermark,
					footercurrcode,
					footercurrrate,
					gainloss_postid,
					simple,
					trancode
				)
				VALUES
				(
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#generalAccNo#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#batchno#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#tranno#">,
					"0",
					"0",
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#ttype#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#pono#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDespForItemAndTaxLine.name#">,
					"",
					"",
					"",
					"",
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDespeForItemLine.desp#">,
					"#taxpec1#",
					<cfqueryparam cfsqltype="cf_sql_double" value="#debitamt#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#creditamt#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#fcamt#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#debit_fc#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#credit_fc#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#currrate#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#araptype#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#age#">,
					"",
					"",
					"",
					"",
					"0",
					"0",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"#note_a#",
					"0",
					"0",
					"",
					"",
					"",
					<cfqueryparam cfsqltype="cf_sql_double" value="#taxpur#">,
					"",
					"#originalCreatedOn#",
					"",
					"",
					"",
					"0000-00-00",
					"#originalCreatedBy#",
					"",
					"0",
					"0000-00-00",
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
					"0000-00-00",
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
					"",
					"0",
					"#originalCreatedBy#",
					"#getAuthUser()#",
					"#originalCreatedOn#",
					NOW(),
					"#originalUUID#",
					"",
					"",
					"",
					"",
					"0",
					"0",
					"0",
					"0",
					"",
					"",
					"",
					"0",
					"",
					"0",
					"",
					"Y",
					"#trancode#"
				)	
			</cfquery>			
			<!--- insert Glpost Item Line [END] --->
			
			<cfif taxpec1 NEQ 0>
				<!--- insert Glpost Tax Line [START] --->
				<!--- get accno for tax [START] --->
				<cfquery name="getTaxAccNo" datasource="#dts#">
					SELECT corr_accno
					FROM taxtable
					WHERE code="#note_a#"
				</cfquery>
				<!--- get accno for tax [END] --->
			
				<!--- get last tranno with same batchno(preset 0) and increment it [START] --->
				<cfquery name="getLastTranNo" datasource="#dts#">
					SELECT MAX(tranno) AS lastTranNo
					FROM glpost
					WHERE fperiod!="99"
					AND batchno=<cfqueryparam cfsqltype="cf_sql_integer" value="#batchno#">
				</cfquery>
				<cfif getLastTranNo.lastTranNo EQ "">
					<cfset tranno=1>
				<cfelse>
					<cfset tranno=getLastTranNo.lastTranNo+1>
				</cfif>
				<!--- get last tranno with same batchno(preset 0) and increment it [END] --->
			
				<!--- process ttype,debitamt,creditamt,fcamt,debit_fc,credit_fc,araptype,age [START]  --->
				<!--- process ttype,debitamt,creditamt,fcamt,debit_fc,credit_fc,araptype,age for the target account record line and general account record line are different --->
				<cfif currcode EQ getSystemCurrency.SystemCurrCode>
					<cfset amount=taxamt_bil>
					<cfset fcamt1=0.00>
				<cfelse>
					<cfset amount=taxamt>
					<cfset fcamt1=taxamt_bil>
				</cfif>
				<cfset taxpur=amount>		
				<cfif type EQ "CN">
					<cfset ttype="GD">
					<cfset debitamt=amount>
					<cfset creditamt=0>
					<cfset fcamt=fcamt1>
					<cfset debit_fc=fcamt1>
					<cfset credit_fc=0>
					<cfset araptype="C">
					<cfset age=11>
				<cfelseif type EQ "CS">
					<cfset ttype="GC">
					<cfset debitamt=0>
					<cfset creditamt=amount>
					<cfset fcamt=-fcamt1>
					<cfset debit_fc=0>
					<cfset credit_fc=fcamt1>
					<cfset araptype="H">
					<cfset age=0>
				<cfelseif type EQ "DN">
					<cfset ttype="GC">
					<cfset debitamt=0>
					<cfset creditamt=amount>
					<cfset fcamt=-fcamt1>
					<cfset debit_fc=0>
					<cfset credit_fc=fcamt1>
					<cfset araptype="D">
					<cfset age=0>
				<cfelseif type EQ "INV">
					<cfset ttype="GC">
					<cfset debitamt=0>
					<cfset creditamt=amount>
					<cfset fcamt=-fcamt1>
					<cfset debit_fc=0>
					<cfset credit_fc=fcamt1>
					<cfset araptype="I">
					<cfset age=0>
				<cfelseif type EQ "PR">
					<cfset ttype="GC">
					<cfset debitamt=0>
					<cfset creditamt=amount>
					<cfset fcamt=-fcamt1>
					<cfset debit_fc=0>
					<cfset credit_fc=fcamt1>
					<cfset araptype="C">
					<cfset age=11>
				<cfelseif type EQ "RC">
					<cfset ttype="GD">
					<cfset debitamt=amount>
					<cfset creditamt=0>
					<cfset fcamt=fcamt1>
					<cfset debit_fc=fcamt1>
					<cfset credit_fc=0>
					<cfset araptype="I">
					<cfset age=0>
				<cfelse>
					<cfset ttype="">
					<cfset debitamt=0>
					<cfset creditamt=0>
					<cfset fcamt=0>
					<cfset debit_fc=0>
					<cfset credit_fc=0>
					<cfset araptype="">
					<cfset age=0>
				</cfif>
				<!--- process process ttype,debitamt,creditamt,fcamt,debit_fc,credit_fc,araptype,age [END]  --->
			
				<!--- get despe for tax line [START] --->
				<cfquery name="getDespeForTaxLine" datasource="#dts#">
					SELECT desp
					FROM gldata
					WHERE accno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getTaxAccNo.corr_accno#">
				</cfquery>
				<!--- get despe for tax line [END] --->
			
				<cfquery name="insertGlpostTaxLine" datasource="#dts#">
					INSERT INTO glpost
					(
						acc_code,
						accno,
						fperiod,
						date,
						batchno,
						tranno,
						vouc_seq,
						vouc_seq_2,
						ttype,
						reference,
						refno,
						desp,
						despa,
						despb,
						despc,
						despd,
						despe,
						taxpec,
						debitamt,
						creditamt,
						fcamt,
						debit_fc,
						credit_fc,
						exc_rate,
						araptype,
						age,
						source,
						job,
						job2,
						subjob,
						job_value,
						job2_value,
						posted,
						exported,
						exported1,
						exported2,
						exported3,
						rem1,
						rem2,
						rem3,
						rem4,
						rem5,
						rpt_row,
						agent,
						site,
						stran,
						taxpur,
						paymode,
						trdatetime,
						corr_acc,
						accno2,
						accno3,
						date2,
						userid,
						tcurrcode,
						tcurramt,
						issuedate,
						bperiod,
						bdate,
						vperiod,
						origin,
						mperiod,
						created_by,
						updated_by,
						created_on,
						updated_on,
						uuid,
						wht_status,
						whtcustname,
						whtcustadd,
						whtcusttaxid,
						calwhtamt1,
						calwhtamt3,
						calwhtamt2,
						calwhtamt4,
						sequal,
						comuen,
						permitno,
						vouchermark,
						footercurrcode,
						footercurrrate,
						gainloss_postid,
						simple,
						trancode
					)
					VALUES
					(
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getTaxAccNo.corr_accno#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#batchno#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#tranno#">,
						"0",
						"0",
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#ttype#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#pono#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDespForItemAndTaxLine.name#">,
						"",
						"",
						"",
						"",
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDespeForTaxLine.desp#">,
						"#taxpec1#",
						<cfqueryparam cfsqltype="cf_sql_double" value="#debitamt#">,
						<cfqueryparam cfsqltype="cf_sql_double" value="#creditamt#">,
						<cfqueryparam cfsqltype="cf_sql_double" value="#fcamt#">,
						<cfqueryparam cfsqltype="cf_sql_double" value="#debit_fc#">,
						<cfqueryparam cfsqltype="cf_sql_double" value="#credit_fc#">,
						<cfqueryparam cfsqltype="cf_sql_double" value="#currrate#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#araptype#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#age#">,
						"",
						"",
						"",
						"",
						"0",
						"0",
						"",
						"",
						"",
						"",
						"",
						"",
                        "",
                        "",
						"#note_a#",
						"0",
						"0",
						"",
						"",
						"",
						"0",
						"",
						"#originalCreatedOn#",
						"",
						"",
						"",
						"0000-00-00",
						"#originalCreatedBy#",
						"",
						"0",
						"0000-00-00",
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
						"0000-00-00",
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
						"",
						"0",
						"#originalCreatedBy#",
						"#getAuthUser()#",
						"#originalCreatedOn#",
						NOW(),
						"#originalUUID#",
						"",
						"",
						"",
						"",
						"0",
						"0",
						"0",
						"0",
						"",
						"",
						"",
						"0",
						"",
						"0",
						"",
						"Y",
						"#trancode#"
					)
				</cfquery>
				<!--- insert Glpost Tax Line [END] --->
			</cfif>
		</cfloop>
		<cfoutput>Update transaction successfully.</cfoutput>
	<!--- update [END] --->
	
	<!--- getCustNoPattern [START] --->
	<cfelseif action EQ "getCustNoPattern">
		<cfquery name="getCustNoPattern" datasource="#dts#">
			SELECT debtorfr,debtorto,creditorfr,creditorto
			FROM gsetup
		</cfquery>
		<cfset custNoPattern={
			DEBTORFR="#getCustNoPattern.debtorfr#",
			DEBTORTO="#getCustNoPattern.debtorto#",
			CREDITORFR="#getCustNoPattern.creditorfr#",
			CREDITORTO="#getCustNoPattern.creditorto#"
		}>
		<cfset custNoPattern=SerializeJSON(custNoPattern)>
		<cfset custNoPattern=cleanXmlString(custNoPattern)>
		<cfoutput>#custNoPattern#</cfoutput>
	<!--- getCustNoPattern [END] --->
	
	<!--- insertTarget [START] --->
	<cfelseif action EQ "insertTarget">
		<cfset target=form.target>
		<cfset targetTable=form.targetTable>
		<cfset custno=form.custno>
		<cfset name=form.name>
		<cfset name2=form.name2>
		<cfset comuen=form.comuen>
		<cfset e_mail=form.e_mail>
		<cfset phone=form.phone>
		<cfset phonea=form.phonea>
		<cfset fax=form.fax>
		<cfset currcode=form.currcode>
		<cfset add1=form.add1>
		<cfset add2=form.add2>
		<cfset add3=form.add3>
		<cfset add4=form.add4>
		<cfset country=form.country>
		<cfset postalcode=form.postalcode>		
		<cfquery name="getCurrencyRate" datasource="#dts#">
			SELECT currency,currency1,currrate
			FROM currency
			WHERE currcode="#currcode#"
		</cfquery>
		<cfquery name="insertTarget" datasource="#dts#">
			INSERT INTO #targetTable#
			(
				custno,
				name,
				name2,
				comuen,
				e_mail,
				phone,
				phonea,
				fax,
				currcode,
				currency,
				currency1,
				add1,
				add2,
				add3,
				add4,
				country,
				postalcode,
				created_by,
				updated_by,
				created_on,
				updated_on
			)
			VALUES
			(
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#name#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#name2#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#comuen#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#e_mail#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#phone#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#phonea#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#fax#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#currcode#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getCurrencyRate.currency#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getCurrencyRate.currency1#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#add1#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#add2#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#add3#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#add4#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#country#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#postalcode#">,
				"#getAuthUser()#",
				"#getAuthUser()#",
				NOW(),
				NOW()
			)
		</cfquery>
		<cfoutput>#getCurrencyRate.currrate#</cfoutput>
	<!--- insertTarget [END] --->
	
	<!--- checkTargetCustno [START] --->
	<cfelseif action EQ "checkTargetCustno">
		<cfset targetTable=form.targetTable>
		<cfset custno=form.custno>	
		<cfquery name="checkTargetCustno" datasource="#dts#">
			SELECT COUNT(custno) AS custNoCount
			FROM #targetTable#
			WHERE custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">
		</cfquery>
		<cfoutput>#checkTargetCustno.custNoCount#</cfoutput>
	<!--- checkTargetCustno [END] --->
	
	<!--- checkItemNo [START] --->
	<cfelseif action EQ "checkItemNo">
		<cfset itemno=form.itemno>	
		<cfquery name="checkItemNo" datasource="#dts#">
			SELECT COUNT(itemno) AS itemNoCount
			FROM icitem
			WHERE itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#">
		</cfquery>
		<cfoutput>#checkItemNo.itemNoCount#</cfoutput>
	<!--- checkItemNo [END] --->
	
	<!--- addItem [START] --->
	<cfelseif action EQ "addItem">
		<cfset itemPriceType=form.itemPriceType>
		<cfset itemno=form.itemno>
		<cfset desp=form.desp>
		<cfset itemprice=form.itemprice>
		<cfquery name="addItem" datasource="#dts#">
			INSERT INTO icitem
			(
				itemno,
				desp,
				#itemPriceType#,
				created_by,
				created_on,
				updated_by,
				updated_on
			)
			VALUES
			(
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#desp#">,
				<cfqueryparam cfsqltype="cf_sql_double" value="#itemprice#">,
				"#getAuthUser()#",
				NOW(),
				"#getAuthUser()#",
				NOW()
			)
		</cfquery>
		<cfoutput>New Item added successfully.</cfoutput>
	<!--- addItem [END] --->
	
	<!--- copy [START] --->
	<cfelseif action EQ "copy">
		<cfset action=form.action>
		<cfset type=form.type>
		<cfset uuid=form.uuid>
		<cfset targetTable=form.targetTable>
		<cfset targetLedgerTable=form.targetLedgerTable>
		<cfset custno=form.custno>	
		<cfset custinfo=form.custinfo>
		<cfset refno=form.refno>
		<cfset wos_date=form.wos_date>
		<cfset pono=form.pono>
		<cfset currcode=form.currcode>
		<cfset currrate=form.currrate>
		<cfset gross_bil=form.gross_bil>
		<cfset disc_bil=form.disc_bil>
		<cfset net_bil=form.net_bil>
		<cfset tax_bil=form.tax_bil>
		<cfset grand_bil=form.grand_bil>
		<cfset rem10=form.rem10>
		<cfset rem11=form.rem11>		
		<cfset dd=DateFormat(wos_date,"DD")>  
  		<cfif dd GT '12'>
   			<cfset wos_date=DateFormat(wos_date,"YYYY-MM-DD")>
  		<cfelse>
   			<cfset wos_date=DateFormat(wos_date,"YYYY-DD-MM")>
 		 </cfif>
		<cfinvoke component="cfc.Period" method="getCurrentPeriod" dts="#dts#" inputDate="#DateFormat(wos_date,'yyyy-mm-dd')#" returnvariable="fperiod"/>
		<cfset invgross=NumberFormat(gross_bil*currrate,".__")>
		<cfset discount=NumberFormat(disc_bil*currrate,".__")>
		<cfset net=NumberFormat(net_bil*currrate,".__")>
		<cfset tax=NumberFormat(tax_bil*currrate,".__")>
		<cfset grand=NumberFormat(grand_bil*currrate,".__")>
		<cfset refnoCheck = 0>
		<cfloop condition="refnoCheck EQ 0">
			<cfquery name="checkExistence" datasource="#dts#">
        		SELECT refno FROM artran WHERE 
        		refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
				AND type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
        	</cfquery>
			<cfif checkExistence.recordcount EQ 0>
				<cfset refnocheck = 1>
				<cfquery name="updateLastRef" datasource="#dts#">
						UPDATE last_ref
						SET lastref=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
						WHERE type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
				</cfquery>
			<cfelse>
				<cfinvoke component="cfc.refno" method="processNum" oldNum="#refno#" returnvariable="refno" />
			</cfif>
		</cfloop>
		<cfquery name="insertArtran" datasource="#dts#">
			INSERT INTO artran
			(
				type,
				custno,
                custinfo,
				refno,
				wos_date,fperiod,
				pono,
				currcode,currrate,
				gross_bil,invgross,
				disc_bil,discount,
				net_bil,net,
				tax_bil,tax,
				grand_bil,grand,
				rem10,rem11,
				created_by,created_on,
				updated_by,updated_on
			)
			VALUES
			(
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#custinfo#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#pono#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#currcode#">,<cfqueryparam cfsqltype="cf_sql_double" value="#currrate#">,
				<cfqueryparam cfsqltype="cf_sql_double" value="#gross_bil#">,<cfqueryparam cfsqltype="cf_sql_double" value="#invgross#">,
				<cfqueryparam cfsqltype="cf_sql_double" value="#disc_bil#">,<cfqueryparam cfsqltype="cf_sql_double" value="#discount#">,
				<cfqueryparam cfsqltype="cf_sql_double" value="#net_bil#">,<cfqueryparam cfsqltype="cf_sql_double" value="#net#">,
				<cfqueryparam cfsqltype="cf_sql_double" value="#tax_bil#">,<cfqueryparam cfsqltype="cf_sql_double" value="#tax#">,
				<cfqueryparam cfsqltype="cf_sql_double" value="#grand_bil#">,<cfqueryparam cfsqltype="cf_sql_double" value="#grand#">,
				<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#rem10#">,<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#rem11#">,
				"#getAuthUser()#",Now(),
				"#getAuthUser()#",Now()				
			)
		</cfquery>
		
		<!--- get last tranno with same batchno(preset 0) and increment it [START] --->
		<cfquery name="getLastTranNo" datasource="#dts#">
			SELECT MAX(tranno) AS lastTranNo
			FROM glpost
			WHERE fperiod!="99"
			AND batchno=<cfqueryparam cfsqltype="cf_sql_integer" value="#batchno#">
		</cfquery>
		<cfif getLastTranNo.lastTranNo EQ "">
			<cfset tranno=1>
		<cfelse>
			<cfset tranno=getLastTranNo.lastTranNo+1>
		</cfif>
		<!--- get last tranno with same batchno(preset 0) and increment it [END] --->		
		
		<!--- get System Currency [START] --->
		<cfquery name="getSystemCurrency" datasource="#dts#">
			SELECT ctycode AS SystemCurrCode
			FROM gsetup
		</cfquery>
		<!--- get System Currency [END] --->
				
		<!--- process ttype,debitamt,creditamt,fcamt,debit_fc,credit_fc,araptype,age [START]  --->
		<!--- process ttype,debitamt,creditamt,fcamt,debit_fc,credit_fc,araptype,age for the target account record line and general account record line are different --->
		<cfif currcode EQ getSystemCurrency.SystemCurrCode>
			<cfset amount=grand_bil>
			<cfset fcamt1=0.00>
		<cfelse>
			<cfset amount=grand>
			<cfset fcamt1=grand_bil>
		</cfif>		
		<cfif type EQ "CN">
			<cfset ttype="RC">
			<cfset debitamt=0>
			<cfset creditamt=amount>
			<cfset fcamt=-fcamt1>
			<cfset debit_fc=0>
			<cfset credit_fc=fcamt1>
			<cfset araptype="C">
			<cfset age=11>
		<cfelseif type EQ "CS">
			<cfset ttype="RD">
			<cfset debitamt=amount>
			<cfset creditamt=0>
			<cfset fcamt=fcamt1>
			<cfset debit_fc=fcamt1>
			<cfset credit_fc=0>
			<cfset araptype="H">
			<cfset age=0>
		<cfelseif type EQ "DN">
			<cfset ttype="RD">
			<cfset debitamt=amount>
			<cfset creditamt=0>
			<cfset fcamt=fcamt1>
			<cfset debit_fc=fcamt1>
			<cfset credit_fc=0>
			<cfset araptype="D">
			<cfset age=0>
		<cfelseif type EQ "INV">
			<cfset ttype="RD">
			<cfset debitamt=amount>
			<cfset creditamt=0>
			<cfset fcamt=fcamt1>
			<cfset debit_fc=fcamt1>
			<cfset credit_fc=0>
			<cfset araptype="I">
			<cfset age=0>
		<cfelseif type EQ "PR">
			<cfset ttype="PD">
			<cfset debitamt=amount>
			<cfset creditamt=0>
			<cfset fcamt=fcamt1>
			<cfset debit_fc=fcamt1>
			<cfset credit_fc=0>
			<cfset araptype="C">
			<cfset age=11>
		<cfelseif type EQ "RC">
			<cfset ttype="PC">
			<cfset debitamt=0>
			<cfset creditamt=amount>
			<cfset fcamt=-fcamt1>
			<cfset debit_fc=0>
			<cfset credit_fc=fcamt1>
			<cfset araptype="I">
			<cfset age=0>
		<cfelse>
			<cfset ttype="">
			<cfset debitamt=0>
			<cfset creditamt=0>
			<cfset fcamt=0>
			<cfset debit_fc=0>
			<cfset credit_fc=0>
			<cfset araptype="">
			<cfset age=0>
		</cfif>
		<!--- process process ttype,debitamt,creditamt,fcamt,debit_fc,credit_fc,araptype,age [END]  --->		
		
		<!--- get desp [START] --->
		<!--- desp for the target account record line and general account record line are different --->
		<cfquery name="getDespForGrandTotalLine" datasource="#dts#">
			SELECT description
			FROM userdefine
			WHERE type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
		</cfquery>
		<!--- get desp [END] --->
		
		<!--- get despe [START] --->
		<!--- despe for the target account record line and general account record line are different --->
		<cfquery name="getDespeForGrandTotalLine" datasource="#dts#">
			SELECT name
			FROM #targetTable#
			WHERE custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">
		</cfquery>
		<!--- get despe [END] --->
		
		<!--- insertGLPostGrandTotalLine [START] --->				
		<cfquery name="insertGLPostGrandTotalLine" datasource="#dts#">
			INSERT INTO glpost
			(
				acc_code,
				accno,
				fperiod,
				date,
				batchno,
				tranno,
				vouc_seq,
				vouc_seq_2,
				ttype,
				reference,
				refno,
				desp,
				despa,
				despb,
				despc,
				despd,
				despe,
				taxpec,
				debitamt,
				creditamt,
				fcamt,
				debit_fc,
				credit_fc,
				exc_rate,
				araptype,
				age,
				source,
				job,
				job2,
				subjob,
				job_value,
				job2_value,
				posted,
				exported,
				exported1,
				exported2,
				exported3,
				rem1,
				rem2,
				rem3,
				rem4,
				rem5,
				rpt_row,
				agent,
				site,
				stran,
				taxpur,
				paymode,
				trdatetime,
				corr_acc,
				accno2,
				accno3,
				date2,
				userid,
				tcurrcode,
				tcurramt,
				issuedate,
				bperiod,
				bdate,
				vperiod,
				origin,
				mperiod,
				created_by,
				updated_by,
				created_on,
				updated_on,
				uuid,
				wht_status,
				whtcustname,
				whtcustadd,
				whtcusttaxid,
				calwhtamt1,
				calwhtamt3,
				calwhtamt2,
				calwhtamt4,
				sequal,
				comuen,
				permitno,
				vouchermark,
				footercurrcode,
				footercurrrate,
				gainloss_postid,
				simple,
				trancode
			)
			VALUES
			(
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#batchno#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#tranno#">,
				"0",
				"0",
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#ttype#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#pono#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDespForGrandTotalLine.description#">,
				"",
				"",
				"",
				"",
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDespeForGrandTotalLine.name#">,
				"0.00",
				<cfqueryparam cfsqltype="cf_sql_double" value="#debitamt#">,
				<cfqueryparam cfsqltype="cf_sql_double" value="#creditamt#">,
				<cfqueryparam cfsqltype="cf_sql_double" value="#fcamt#">,
				<cfqueryparam cfsqltype="cf_sql_double" value="#debit_fc#">,
				<cfqueryparam cfsqltype="cf_sql_double" value="#credit_fc#">,
				<cfqueryparam cfsqltype="cf_sql_double" value="#currrate#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#araptype#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#age#">,
				"",
				"",
				"",
				"",
				"0",
				"0",
				"P",
				"",
				"",
				"",
				"",
				"",
				"",
				"",
				"",
				"0",
				"0",
				"",
				"",
				"",
				"0",
				"",
				Now(),
				"",
				"",
				"",
				"0000-00-00",
				"#getAuthUser()#",
				"",
				"0",
				"0000-00-00",
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
				"0000-00-00",
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
				"",
				"0",
				"#getAuthUser()#",
				"#getAuthUser()#",
				NOW(),
				NOW(),
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">,
				"",
				"",
				"",
				"",
				"0",
				"0",
				"0",
				"0",
				"",
				"",
				"",
				"0",
				"",
				"0",
				"",
				"Y",
				"0"
			)
		</cfquery>
		<!--- insertGLPostGrandTotalLine [END] --->
		
		<!--- insertTargetLedgerTable [START] --->
		<!--- get Entry of Grand Total Line [START] --->
		<cfquery name="getEntryOfGrandTotalLine" datasource="#dts#">
			SELECT entry
			FROM glpost
			WHERE acc_code=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
			AND reference=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
			AND uuid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
			AND trancode="0"
		</cfquery>
		<!--- get Entry of Grand Total Line [END] --->
		
		<cfif currcode EQ getSystemCurrency.SystemCurrCode>
		
			<!--- calculate lastbal [START] --->
				<cfset lastbal=debitamt-creditamt>
			<!--- calculate lastbal [END] --->
			
			<cfquery name="insertTargetLocalLine" datasource="#dts#">
				INSERT INTO #targetLedgerTable#
				(
					entry,
					accno,
					date,
					araptype,
					reference,
					refext,
					accext,
					refno,
					debitamt,
					creditamt,
					paidamt,
					paystatus,
					fullpay,
					desp,
					despa,
					despb,
					despc,
					despd,
					fcamt,
					debit_lc,
					credit_lc,
					exc_rate,
					age,
					posted,
					lastbal,
					payttime,
					new,
					rem1,
					rem2,
					rem4,
					source,
					job,
					agent,
					site,
					stran,
					fperiod,
					batchno,
					tranno,
					created_by,
					updated_by,
					created_on,
					updated_on,
					footercurrcode,
					footercurrrate,
					gainloss_postid,
					simple,
					trancode
				)
				VALUES
				(
					<cfqueryparam cfsqltype="cf_sql_integer" value="#getEntryOfGrandTotalLine.entry#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#araptype#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
					"",
					"",
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#pono#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#debitamt#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#creditamt#">,
					"0",
					"",
					"F",
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDespForGrandTotalLine.description#">,
					"",
					"",
					"",
					"",
					<cfqueryparam cfsqltype="cf_sql_double" value="#fcamt#">,
					"0",
					"0",
					<cfqueryparam cfsqltype="cf_sql_double" value="#currrate#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#age#">,
					"P",
					<cfqueryparam cfsqltype="cf_sql_double" value="#lastbal#">,
					"0",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#batchno#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#tranno#">,
					"#getAuthUser()#",
					"#getAuthUser()#",
					NOW(),
					NOW(),
					"",
					"0",
					"",
					"Y",
					"0"
				)
			</cfquery>			
		<cfelse>
		
			<!--- calculate lastbal [START] --->
				<cfset lastbal=debitamt-creditamt>
			<!--- calculate lastbal [END] --->
			
			<cfquery name="insertTargetLocalLine" datasource="#dts#">
				INSERT INTO #targetLedgerTable#
				(
					entry,
					accno,
					date,
					araptype,
					reference,
					refext,
					accext,
					refno,
					debitamt,
					creditamt,
					paidamt,
					paystatus,
					fullpay,
					desp,
					despa,
					despb,
					despc,
					despd,
					fcamt,
					debit_lc,
					credit_lc,
					exc_rate,
					age,
					posted,
					lastbal,
					payttime,
					new,
					rem1,
					rem2,
					rem4,
					source,
					job,
					agent,
					site,
					stran,
					fperiod,
					batchno,
					tranno,
					created_by,
					updated_by,
					created_on,
					updated_on,
					footercurrcode,
					footercurrrate,
					gainloss_postid,
					simple,
					trancode
				)
				VALUES
				(
					<cfqueryparam cfsqltype="cf_sql_integer" value="#getEntryOfGrandTotalLine.entry#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#araptype#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
					"",
					"",
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#pono#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#debitamt#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#creditamt#">,
					"0",
					"",
					"F",
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDespForGrandTotalLine.description#">,
					"",
					"",
					"",
					"",
					<cfqueryparam cfsqltype="cf_sql_double" value="#fcamt#">,
					"0",
					"0",
					<cfqueryparam cfsqltype="cf_sql_double" value="#currrate#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#age#">,
					"P",
					<cfqueryparam cfsqltype="cf_sql_double" value="#lastbal#">,
					"0",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#batchno#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#tranno#">,
					"#getAuthUser()#",
					"#getAuthUser()#",
					NOW(),
					NOW(),
					"",
					"0",
					"",
					"Y",
					"0"
				)
			</cfquery>
		
			<!--- calculate lastbal [START] --->
				<cfset lastbal=debit_fc-credit_fc>
			<!--- calculate lastbal [END] --->
			
			<cfquery name="insertTargetForeignLine" datasource="#dts#">
				INSERT INTO #targetLedgerTable#
				(
					entry,
					accno,
					date,
					araptype,
					reference,
					refext,
					accext,
					refno,
					debitamt,
					creditamt,
					paidamt,
					paystatus,
					fullpay,
					desp,
					despa,
					despb,
					despc,
					despd,
					fcamt,
					debit_lc,
					credit_lc,
					exc_rate,
					age,
					posted,
					lastbal,
					payttime,
					new,
					rem1,
					rem2,
					rem4,
					source,
					job,
					agent,
					site,
					stran,
					fperiod,
					batchno,
					tranno,
					created_by,
					updated_by,
					created_on,
					updated_on,
					footercurrcode,
					footercurrrate,
					gainloss_postid,
					simple,
					trancode
				)
				VALUES
				(
					<cfqueryparam cfsqltype="cf_sql_integer" value="#getEntryOfGrandTotalLine.entry#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#araptype#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
					"",
					"F",
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#pono#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#debit_fc#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#credit_fc#">,
					"0",
					"",
					"F",
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDespForGrandTotalLine.description#">,
					"",
					"",
					"",
					"",
					<cfqueryparam cfsqltype="cf_sql_double" value="#fcamt#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#debitamt#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#creditamt#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#currrate#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#age#">,
					"P",
					<cfqueryparam cfsqltype="cf_sql_double" value="#lastbal#">,
					"0",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#batchno#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#tranno#">,
					"#getAuthUser()#",
					"#getAuthUser()#",
					NOW(),
					NOW(),
					"",
					"0",
					"",
					"Y",
					"0"
				)
			</cfquery>
		</cfif>		
		<!--- insertTargetLedgerTable [END] --->
		
		<cfquery name="getItemList" datasource="#dts#">
        	SELECT trancode,itemno,desp,qty_bil,price_bil,amt1_bil,dispec1,disamt_bil,note_a,taxpec1,taxamt_bil,amt_bil
            FROM simpletransactionitemtemp
            WHERE uuid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
            ORDER BY trancode ASC
        </cfquery>
		<cfloop query="getItemList">
			<cfset price=price_bil*currrate>
			<cfset price=NumberFormat(price,".__")>	
			<cfset amt1=amt1_bil*currrate>
			<cfset amt1=NumberFormat(amt1,".__")>
			<cfset disamt=disamt_bil*currrate>
			<cfset disamt=NumberFormat(disamt,".__")>
			<cfset amt=amt_bil*currrate>
			<cfset amt=NumberFormat(amt,".__")>
			<cfset taxamt=taxamt_bil*currrate>
			<cfset taxamt=NumberFormat(taxamt,".__")>					
			<cfquery name="insertIctran" datasource="#dts#">
				INSERT INTO ictran
				(
					type,refno,
					custno,
					fperiod,wos_date,
					currrate,
					trancode,itemcount,
					itemno,desp,
					qty_bil,qty,
					price_bil,price,
					amt1_bil,amt1,
					dispec1,disamt_bil,disamt,
					note_a,taxpec1,taxamt_bil,taxamt,taxincl,
					amt_bil,amt					
				)
				VALUES
				(
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#currrate#">,
					"#trancode#","#trancode#",
					"#itemno#","#desp#",
					"#qty_bil#","#qty_bil#",
					"#price_bil#","#price#",
					"#amt1_bil#","#amt1#",
					"#dispec1#","#disamt_bil#","#disamt#",
					"#note_a#","#taxpec1#","#taxamt_bil#","#taxamt#","N",
					"#amt_bil#","#amt#"					
				)
			</cfquery>
			
			<!--- get desp for item and tax line [START] --->
			<cfquery name="getDespForItemAndTaxLine" datasource="#dts#">
				SELECT CONCAT(name,' ',name2) AS name
				FROM #targetTable#
				WHERE custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">
			</cfquery>
			<!--- get desp for item and tax line [END] --->		
			
			<!--- insert Glpost Item Line [START] --->
			<!--- get accno for general account [START] --->
			<cfquery name="getGeneralAccNo" datasource="#dts#">
				SELECT creditsales,purchasereceive
				FROM gsetup
			</cfquery>
			<cfif type EQ "CN" OR type EQ "CS" OR type EQ "DN" OR type EQ "INV">
				<cfset generalAccNo=getGeneralAccNo.creditsales>
			<cfelseif type EQ "PR" OR type EQ "RC">
				<cfset generalAccNo=getGeneralAccNo.purchasereceive>
			<cfelse>
				<cfset generalAccNo="">
			</cfif>
			<!--- get accno for general account [END] --->
			
			<!--- get last tranno with same batchno(preset 0) and increment it [START] --->
			<cfquery name="getLastTranNo" datasource="#dts#">
				SELECT MAX(tranno) AS lastTranNo
				FROM glpost
				WHERE fperiod!="99"
				AND batchno=<cfqueryparam cfsqltype="cf_sql_integer" value="#batchno#">
			</cfquery>
			<cfif getLastTranNo.lastTranNo EQ "">
				<cfset tranno=1>
			<cfelse>
				<cfset tranno=getLastTranNo.lastTranNo+1>
			</cfif>
			<!--- get last tranno with same batchno(preset 0) and increment it [END] --->
			
			<!--- get despe for item line [START] --->
			<cfquery name="getDespeForItemLine" datasource="#dts#">
				SELECT desp
				FROM gldata
				WHERE accno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#generalAccNo#">
			</cfquery>
			<!--- get despe for item line [END] --->
			
			<!--- process ttype,debitamt,creditamt,fcamt,debit_fc,credit_fc,araptype,age [START]  --->
			<!--- process ttype,debitamt,creditamt,fcamt,debit_fc,credit_fc,araptype,age for the target account record line and general account record line are different --->
			<cfif currcode EQ getSystemCurrency.SystemCurrCode>
				<cfset amount=amt_bil>
				<cfset fcamt1=0.00>
			<cfelse>
				<cfset amount=amt>
				<cfset fcamt1=amt_bil>
			</cfif>
			<cfset taxpur=amount>		
			<cfif type EQ "CN">
				<cfset ttype="GD">
				<cfset debitamt=amount>
				<cfset creditamt=0>
				<cfset fcamt=fcamt1>
				<cfset debit_fc=fcamt1>
				<cfset credit_fc=0>
				<cfset araptype="C">
				<cfset age=11>
			<cfelseif type EQ "CS">
				<cfset ttype="GC">
				<cfset debitamt=0>
				<cfset creditamt=amount>
				<cfset fcamt=-fcamt1>
				<cfset debit_fc=0>
				<cfset credit_fc=fcamt1>
				<cfset araptype="H">
				<cfset age=0>
			<cfelseif type EQ "DN">
				<cfset ttype="GC">
				<cfset debitamt=0>
				<cfset creditamt=amount>
				<cfset fcamt=-fcamt1>
				<cfset debit_fc=0>
				<cfset credit_fc=fcamt1>
				<cfset araptype="D">
				<cfset age=0>
			<cfelseif type EQ "INV">
				<cfset ttype="GC">
				<cfset debitamt=0>
				<cfset creditamt=amount>
				<cfset fcamt=-fcamt1>
				<cfset debit_fc=0>
				<cfset credit_fc=fcamt1>
				<cfset araptype="I">
				<cfset age=0>
			<cfelseif type EQ "PR">
				<cfset ttype="GC">
				<cfset debitamt=0>
				<cfset creditamt=amount>
				<cfset fcamt=-fcamt1>
				<cfset debit_fc=0>
				<cfset credit_fc=fcamt1>
				<cfset araptype="C">
				<cfset age=11>
			<cfelseif type EQ "RC">
				<cfset ttype="GD">
				<cfset debitamt=amount>

				<cfset creditamt=0>
				<cfset fcamt=fcamt1>
				<cfset debit_fc=fcamt1>
				<cfset credit_fc=0>
				<cfset araptype="I">
				<cfset age=0>
			<cfelse>
				<cfset ttype="">
				<cfset debitamt=0>
				<cfset creditamt=0>
				<cfset fcamt=0>
				<cfset debit_fc=0>
				<cfset credit_fc=0>
				<cfset araptype="">
				<cfset age=0>
			</cfif>
			<!--- process process ttype,debitamt,creditamt,fcamt,debit_fc,credit_fc,araptype,age [END]  --->
			
			<cfquery name="insertGlpostItemLine" datasource="#dts#">
				INSERT INTO glpost
				(
					acc_code,
					accno,
					fperiod,
					date,
					batchno,
					tranno,
					vouc_seq,
					vouc_seq_2,
					ttype,
					reference,
					refno,
					desp,
					despa,
					despb,
					despc,
					despd,
					despe,
					taxpec,
					debitamt,
					creditamt,
					fcamt,
					debit_fc,
					credit_fc,
					exc_rate,
					araptype,
					age,
					source,
					job,
					job2,
					subjob,
					job_value,
					job2_value,
					posted,
					exported,
					exported1,
					exported2,
					exported3,
					rem1,
					rem2,
					rem3,
					rem4,
					rem5,
					rpt_row,
					agent,
					site,
					stran,
					taxpur,
					paymode,
					trdatetime,
					corr_acc,
					accno2,
					accno3,
					date2,
					userid,
					tcurrcode,
					tcurramt,
					issuedate,
					bperiod,
					bdate,
					vperiod,
					origin,
					mperiod,
					created_by,
					updated_by,
					created_on,
					updated_on,
					uuid,
					wht_status,
					whtcustname,
					whtcustadd,
					whtcusttaxid,
					calwhtamt1,
					calwhtamt3,
					calwhtamt2,
					calwhtamt4,
					sequal,
					comuen,
					permitno,
					vouchermark,
					footercurrcode,
					footercurrrate,
					gainloss_postid,
					simple,
					trancode
				)
				VALUES
				(
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#generalAccNo#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#batchno#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#tranno#">,
					"0",
					"0",
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#ttype#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#pono#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDespForItemAndTaxLine.name#">,
					"",
					"",
					"",
					"",
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDespeForItemLine.desp#">,
					"#taxpec1#",
					<cfqueryparam cfsqltype="cf_sql_double" value="#debitamt#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#creditamt#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#fcamt#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#debit_fc#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#credit_fc#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#currrate#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#araptype#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#age#">,
					"",
					"",
					"",
					"",
					"0",
					"0",
					"",
					"",
					"",
					"",
					"",
					"",
                    "",
                    "",
					"#note_a#",
					"0",
					"0",
					"",
					"",
					"",
					<cfqueryparam cfsqltype="cf_sql_double" value="#taxpur#">,
					"",
					Now(),
					"",
					"",
					"",
					"0000-00-00",
					"#getAuthUser()#",
					"",
					"0",
					"0000-00-00",
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
					"0000-00-00",
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
					"",
					"0",
					"#getAuthUser()#",
					"#getAuthUser()#",
					NOW(),
					NOW(),
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">,
					"",
					"",
					"",
					"",
					"0",
					"0",
					"0",
					"0",
					"",
					"",
					"",
					"0",
					"",
					"0",
					"",
					"Y",
					"#trancode#"
				)	
			</cfquery>			
			<!--- insert Glpost Item Line [END] --->
			
			<cfif taxpec1 NEQ 0>			
				<!--- insert Glpost Tax Line [START] --->
				<!--- get accno for tax [START] --->
				<cfquery name="getTaxAccNo" datasource="#dts#">
					SELECT corr_accno
					FROM taxtable
					WHERE code="#note_a#"
				</cfquery>
				<!--- get accno for tax [END] --->
			
				<!--- get last tranno with same batchno(preset 0) and increment it [START] --->
				<cfquery name="getLastTranNo" datasource="#dts#">
					SELECT MAX(tranno) AS lastTranNo
					FROM glpost
					WHERE fperiod!="99"
					AND batchno=<cfqueryparam cfsqltype="cf_sql_integer" value="#batchno#">
				</cfquery>
				<cfif getLastTranNo.lastTranNo EQ "">
					<cfset tranno=1>
				<cfelse>
					<cfset tranno=getLastTranNo.lastTranNo+1>
				</cfif>
				<!--- get last tranno with same batchno(preset 0) and increment it [END] --->
			
				<!--- process ttype,debitamt,creditamt,fcamt,debit_fc,credit_fc,araptype,age [START]  --->
				<!--- process ttype,debitamt,creditamt,fcamt,debit_fc,credit_fc,araptype,age for the target account record line and general account record line are different --->
				<cfif currcode EQ getSystemCurrency.SystemCurrCode>
					<cfset amount=taxamt_bil>
					<cfset fcamt1=0.00>
				<cfelse>
					<cfset amount=taxamt>
					<cfset fcamt1=taxamt_bil>
				</cfif>
				<cfset taxpur=amount>		
				<cfif type EQ "CN">
					<cfset ttype="GD">
					<cfset debitamt=amount>
					<cfset creditamt=0>
					<cfset fcamt=fcamt1>
					<cfset debit_fc=fcamt1>
					<cfset credit_fc=0>
					<cfset araptype="C">
					<cfset age=11>
				<cfelseif type EQ "CS">
					<cfset ttype="GC">
					<cfset debitamt=0>
					<cfset creditamt=amount>
					<cfset fcamt=-fcamt1>
					<cfset debit_fc=0>
					<cfset credit_fc=fcamt1>
					<cfset araptype="H">
					<cfset age=0>
				<cfelseif type EQ "DN">
					<cfset ttype="GC">
					<cfset debitamt=0>
					<cfset creditamt=amount>
					<cfset fcamt=-fcamt1>
					<cfset debit_fc=0>
					<cfset credit_fc=fcamt1>
					<cfset araptype="D">
					<cfset age=0>
				<cfelseif type EQ "INV">
					<cfset ttype="GC">
					<cfset debitamt=0>
					<cfset creditamt=amount>
					<cfset fcamt=-fcamt1>
					<cfset debit_fc=0>
					<cfset credit_fc=fcamt1>
					<cfset araptype="I">
					<cfset age=0>
				<cfelseif type EQ "PR">
					<cfset ttype="GC">
					<cfset debitamt=0>
					<cfset creditamt=amount>
					<cfset fcamt=-fcamt1>
					<cfset debit_fc=0>
					<cfset credit_fc=fcamt1>
					<cfset araptype="C">
					<cfset age=11>
				<cfelseif type EQ "RC">
					<cfset ttype="GD">
					<cfset debitamt=amount>
					<cfset creditamt=0>
					<cfset fcamt=fcamt1>
					<cfset debit_fc=fcamt1>
					<cfset credit_fc=0>
					<cfset araptype="I">
					<cfset age=0>
				<cfelse>
					<cfset ttype="">
					<cfset debitamt=0>
					<cfset creditamt=0>
					<cfset fcamt=0>
					<cfset debit_fc=0>
					<cfset credit_fc=0>
					<cfset araptype="">
					<cfset age=0>
				</cfif>
				<!--- process process ttype,debitamt,creditamt,fcamt,debit_fc,credit_fc,araptype,age [END]  --->
			
				<!--- get despe for tax line [START] --->
				<cfquery name="getDespeForTaxLine" datasource="#dts#">
					SELECT desp
					FROM gldata
					WHERE accno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getTaxAccNo.corr_accno#">
				</cfquery>
				<!--- get despe for tax line [END] --->
			
				<cfquery name="insertGlpostTaxLine" datasource="#dts#">
					INSERT INTO glpost
					(
						acc_code,
						accno,
						fperiod,
						date,
						batchno,
						tranno,
						vouc_seq,
						vouc_seq_2,
						ttype,
						reference,
						refno,
						desp,
						despa,
						despb,
						despc,
						despd,
						despe,
						taxpec,
						debitamt,
						creditamt,
						fcamt,
						debit_fc,
						credit_fc,
						exc_rate,
						araptype,
						age,
						source,
						job,
						job2,
						subjob,
						job_value,
						job2_value,
						posted,
						exported,
						exported1,
						exported2,
						exported3,
						rem1,
						rem2,
						rem3,
						rem4,
						rem5,
						rpt_row,
						agent,
						site,
						stran,
						taxpur,
						paymode,
						trdatetime,
						corr_acc,
						accno2,
						accno3,
						date2,
						userid,
						tcurrcode,
						tcurramt,
						issuedate,
						bperiod,
						bdate,
						vperiod,
						origin,
						mperiod,
						created_by,
						updated_by,
						created_on,
						updated_on,
						uuid,
						wht_status,
						whtcustname,
						whtcustadd,
						whtcusttaxid,
						calwhtamt1,
						calwhtamt3,
						calwhtamt2,
						calwhtamt4,
						sequal,
						comuen,
						permitno,
						vouchermark,
						footercurrcode,
						footercurrrate,
						gainloss_postid,
						simple,
						trancode
					)
					VALUES
					(
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getTaxAccNo.corr_accno#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#batchno#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#tranno#">,
						"0",
						"0",
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#ttype#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#pono#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDespForItemAndTaxLine.name#">,
						"",
						"",
						"",
						"",
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDespeForTaxLine.desp#">,
						"#taxpec1#",
						<cfqueryparam cfsqltype="cf_sql_double" value="#debitamt#">,
						<cfqueryparam cfsqltype="cf_sql_double" value="#creditamt#">,
						<cfqueryparam cfsqltype="cf_sql_double" value="#fcamt#">,
						<cfqueryparam cfsqltype="cf_sql_double" value="#debit_fc#">,
						<cfqueryparam cfsqltype="cf_sql_double" value="#credit_fc#">,
						<cfqueryparam cfsqltype="cf_sql_double" value="#currrate#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#araptype#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#age#">,
						"",
						"",
						"",
						"",
						"0",
						"0",
						"",
						"",
						"",
						"",
						"",
						"",
                        "",
                        "",
						"#note_a#",
						"0",
						"0",
						"",
						"",
						"",
						"0",
						"",
						Now(),
						"",
						"",
						"",
						"0000-00-00",
						"#getAuthUser()#",
						"",
						"0",
						"0000-00-00",
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
						"0000-00-00",
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
						"",
						"0",
						"#getAuthUser()#",
						"#getAuthUser()#",
						NOW(),
						NOW(),
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">,
						"",
						"",
						"",
						"",
						"0",
						"0",
						"0",
						"0",
						"",
						"",
						"",
						"0",
						"",
						"0",
						"",
						"Y",
						"#trancode#"
					)
				</cfquery>
				<!--- insert Glpost Tax Line [END] --->
			</cfif>
		</cfloop>
		<cfoutput>Create transaction successfully.</cfoutput>
	<!--- copy [END] --->
	
	</cfif>
</cfif>

<!--- cleanXmlString [START] --->
<cffunction name="cleanXmlString" access="public" returntype="any" output="false" hint="Replace non-valid XML characters">
    <cfargument name="dirty" type="string" required="true" hint="Input string">
    <cfset var cleaned = "" />
    <cfset var patterns = "" />
    <cfset var replaces = "" />
    <cfset patterns = chr(8216) & "," & chr(8217) & "," & chr(8220) & "," & chr(8221) & "," & chr(8212) & "," & chr(8213) & "," & chr(8230) />
    <cfset patterns = patterns & "," & chr(1) & "," & chr(2) & "," & chr(3) & "," & chr(4) & "," & chr(5) & "," & chr(6) & "," & chr(7) & "," & chr(8) />
    <cfset patterns = patterns & "," & chr(14) & "," & chr(15) & "," & chr(16) & "," & chr(17) & "," & chr(18) & "," & chr(19) />
    <cfset patterns = patterns & "," & chr(20) & "," & chr(21) & "," & chr(22) & "," & chr(23) & "," & chr(24) & "," & chr(25) />
    <cfset patterns = patterns & "," & chr(26) & "," & chr(27) & "," & chr(28) & "," & chr(29) & "," & chr(30) & "," & chr(31) />
	<cfset replaces = replaces & "',',"","",--,--,..." />
    <cfset replaces = replaces & ",-, , , , , , , " />
    <cfset replaces = replaces & ", , , , , , " />
    <cfset replaces = replaces & ", , , , , , " />
    <cfset replaces = replaces & ", , , , , , " />
	<cfset cleaned = ReplaceList(arguments.dirty, patterns, replaces) />
	<cfreturn cleaned />
</cffunction>
<!--- cleanXmlString [END] --->