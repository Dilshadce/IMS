<cfquery datasource='#dts#' name='updateartranaddonremark'>
Update artran set rem30 = '#form.remark30#', rem31 = '#form.remark31#',
			rem32 = '#form.remark32#', rem33 = '#form.remark33#', rem34 = '#form.remark34#', rem35 = '#form.remark35#',rem36 = '#form.remark36#', rem37 = '#form.remark37#', rem38 = '#form.remark38#',rem39 = '#form.remark39#',rem40 = '#form.remark40#', rem41 = '#form.remark41#',
			rem42 = '#form.remark42#', rem43 = '#form.remark43#', rem44 = '#form.remark44#', rem45 = '#form.remark45#',rem46 = '#form.remark46#', rem47 = '#form.remark47#', rem48 = '#form.remark48#',rem49 = '#form.remark49#'
            where refno = '#form.currefno#' and type = '#tran#'
		</cfquery>