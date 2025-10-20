<cfsetting showdebugoutput="no">

<cfquery name="getgsetup" datasource="#dts#">
	select * from gsetup
</cfquery>
<cfquery name="getgsetup2" datasource='#dts#'>
	select concat(',.',(repeat('_',decl_uprice))) as decl_uprice 
	from gsetup2
</cfquery>

<cfquery name="getrecordcount" datasource="#dts#">
	select count(itemno) as totalrecord 
	from icitem 
	order by wos_date
</cfquery>
<cfif url.type neq "TR">
<cfquery name='getictran' datasource='#dts#'>
		select * from ictrantemp where type ="#url.type#" and uuid='#url.uuid#'
	</cfquery>
    <cfelse>
    <cfquery name='getictran' datasource='#dts#'>
		select * from ictrantemp where type ="TROU" and uuid='#url.uuid#'
	</cfquery>
    </cfif>
    <cfset tran=url.type>
    <cfset wpitemtax="">
<cfoutput>
	<table align="left" class="data" width="1000px">
    <tr>
<!----
    <input type="hidden" name="refno" id="refno" value="#url.refno#">
	<input type="hidden" name="type" id="type" value="#url.type#">
    <input type="hidden" name="type" id="type" value="#url.uuid#">---->
</tr>
    <tr> 
	<th rowspan="5">Article</th>
    <th rowspan="5">Colour</th>
    <th>38</th>
    <th></th>
    <th>39</th>
    <th></th>
    <th>40</th>
    <th></th>
    <th>41</th>
    <th></th>
    <th>42</th>
    <th></th>
    <th>43</th>
    <th></th>
    <th>44</th>

    <th>45</th>
    <th>46</th>
    <th rowspan="5">Qty<br>PRS</th>
	<th rowspan="5">Unit<br />Price</th>
	<th rowspan="5">Amount</th>
	<th rowspan="5" colspan="2"><div align="center">Action</div></th>
      		</tr>
<tr>
    <th>4</th>
    <th>1/2</th>
    <th>5</th>
    <th>1/2</th>
    <th>6</th>
    <th>1/2</th>
    <th>7</th>
    <th>1/2</th>
    <th>8</th>
    <th>1/2</th>
    <th>9</th>
    <th>1/2</th>
    <th>10</th>

    <th>11</th>
    <th>12</th>
</tr>
<tr>
	<th>22</th>
    <th>1/2</th>
    <th>23</th>
    <th>1/2</th>
    <th>24</th>
    <th>1/2</th>
    <th>25</th>
    <th>1/2</th>
    <th>26</th>
    <th>1/2</th>
    <th>27</th>
    <th>1/2</th>
    <th>28</th>

    <th>29</th>
    <th>30</th>
</tr>
<tr>
	<th>35</th>
    <th></th>
    <th>36</th>
    <th></th>
    <th>37</th>
    <th></th>
    <th>38</th>
    <th></th>
    <th>39</th>
    <th></th>
    <th>40</th>
    <th></th>
    <th>41</th>

    <th>42 </th>
    <th>43 </th>
</tr>
<tr>
	<th>27</th>
    <th></th>
    <th>28</th>
    <th></th>
    <th>29</th>
    <th></th>
    <th>30</th>
    <th></th>
    <th>31</th>
    <th></th>
    <th>32</th>
    <th></th>
    <th>33</th>

    <th>34 </th>
    <th>35 </th>
</tr>

	<cfloop query='getictran'>
<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';setID('#getictran.itemno#');">
		<td>#listgetat(itemno,1,'-')#</td>
		<td><font face='Arial, Helvetica, sans-serif'>#listgetat(itemno,2,'-')#</font></td>
        <cfquery name="getitemsize" datasource='#dts#'>
        select sizeid from icitem where itemno='#getictran.itemno#' 
        </cfquery>
        <td>
        <cfif lcase(getitemsize.sizeid) eq 'male size'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '38.0'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'm/f inch'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '4.0'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'm/f cm'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '22.0'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'female size'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '35.0'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'children size '>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '27.0'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        </cfif>
        </td>
        <td>
        <cfif lcase(getitemsize.sizeid) eq 'male size'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '38.5'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'm/f inch'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '4.5'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'm/f cm'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '22.5'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'female size'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '35.5'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'children size '>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '27.5'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        </cfif>
        </td>
        <td>
        <cfif lcase(getitemsize.sizeid) eq 'male size'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '39.0'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'm/f inch'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '5.0'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'm/f cm'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '23.0'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'female size'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '36.0'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'children size '>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '28.0'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        </cfif>
        </td>
        <td>
        <cfif lcase(getitemsize.sizeid) eq 'male size'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '39.5'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'm/f inch'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '5.5'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'm/f cm'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '23.5'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'female size'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '36.5'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'children size '>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '28.5'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        </cfif>
        </td>
        <td>
        <cfif lcase(getitemsize.sizeid) eq 'male size'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '40.0'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'm/f inch'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '6.0'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'm/f cm'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '24.0'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'female size'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '37.0'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'children size '>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '29.0'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        </cfif>
        </td>
        <td>
       <cfif lcase(getitemsize.sizeid) eq 'male size'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '40.5'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'm/f inch'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '6.5'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'm/f cm'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '24.5'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'female size'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '37.5'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'children size '>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '29.5'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        </cfif>
        </td>
        <td>
        <cfif lcase(getitemsize.sizeid) eq 'male size'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '41.0'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'm/f inch'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '7.0'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'm/f cm'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '25.0'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'female size'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '38.0'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'children size '>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '30.0'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        </cfif>
        </td>
        <td>
        <cfif lcase(getitemsize.sizeid) eq 'male size'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '41.5'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'm/f inch'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '7.5'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'm/f cm'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '25.5'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'female size'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '38.5'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'children size '>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '30.5'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        </cfif>
        </td>
        <td>
        <cfif lcase(getitemsize.sizeid) eq 'male size'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '42.0'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'm/f inch'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '8.0'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'm/f cm'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '26.0'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'female size'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '39.0'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'children size '>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '31.0'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        </cfif>
        </td>
        <td>
        <cfif lcase(getitemsize.sizeid) eq 'male size'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '42.5'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'm/f inch'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '8.5'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'm/f cm'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '26.5'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'female size'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '39.5'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'children size '>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '31.5'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        </cfif>
        </td>
        <td>
        <cfif lcase(getitemsize.sizeid) eq 'male size'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '43.0'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'm/f inch'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '9.0'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'm/f cm'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '27.0'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'female size'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '40.0'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'children size '>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '32.0'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        </cfif>
        </td>
		<td>
		<cfif lcase(getitemsize.sizeid) eq 'male size'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '43.5'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'm/f inch'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '9.5'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'm/f cm'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '27.5'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'female size'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '40.5'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'children size'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '32.5'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        </cfif>
        </td>
        <td>
        <cfif lcase(getitemsize.sizeid) eq 'male size'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '44.0'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'm/f inch'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '10.0'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'm/f cm'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '28.0'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'female size'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '41.0'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'children size '>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '33.0'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        </cfif>
        </td>
        <!---<td>
        <cfif lcase(getitemsize.sizeid) eq 'male size'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '44.5'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'm/f inch'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '10.5'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'm/f cm'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '28.5'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'female size'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '41.5'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        </cfif>
        </td>--->
        <td>
        <cfif lcase(getitemsize.sizeid) eq 'male size'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '45.0'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'm/f inch'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '11.0'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'm/f cm'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '29.0'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'female size'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '42.0'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'children size '>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '34.0'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        </cfif>
        </td>
        <td>
        <cfif lcase(getitemsize.sizeid) eq 'male size'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '46.0'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'm/f inch'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '11.5'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'm/f cm'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '29.5'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'female size'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '43.0'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        <cfelseif lcase(getitemsize.sizeid) eq 'children size '>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '35.0'>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        </cfif>
        </td>
        <td>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </td>
        <td><div align='right'><font face='Arial, Helvetica, sans-serif'>#numberFormat(Price_bil,',_.__')#</font></div></td>
		<td><div align='right'><font face='Arial, Helvetica, sans-serif'>#numberFormat(amt_bil,',_.__')#</font></div></td>
       

		<td>
        <div align="center">
        <a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="ColdFusion.Window.show('edititem');">EDIT</a></div></td>
        <td><div align="center"><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="ajaxFunction(document.getElementById('ajaxField2'),'deleteproductsAjax.cfm?type=#url.type#&uuid=#url.uuid#&itemno=#URLENCODEDFORMAT(getictran.itemno)#');setTimeout('refreshlist();',1000);setTimeout('recalculateamt();',1000);">DELETE</a></div>
				
                
                </td><div id="ajaxField2" name="ajaxField2">
                </div>
	</tr>
    
   	</cfloop>
    <cfquery name="getsum" datasource="#dts#">
SELECT SUM(amt1_bil) as sumsubtotal,count(itemno) as countitemno FROM ictrantemp where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#" />
</cfquery>
    <input type="hidden" name="hiditemcount" id="hiditemcount" value="#getsum.countitemno#" />
    	</table>
        
        </cfoutput>