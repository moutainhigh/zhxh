/*
 * 收款单、收款通知单打印。
 * wangf
 */

/*
 * printcode:	打印类型，要打印什么
 */
function create_print_html(printcode,field,otherPar) {
	//案卷目录
	if (printcode == 'AJML') {
		return ajml_html(field,otherPar.data,otherPar.path);
	}
	
}

function chargenote_html(data,barcode) {
	//系统使用单位名称
	var sysunitname = data.sysunitname;
	//打印的副标题
	var print_type = data.print_type;
	//单元名称
	var unitcode = data.unitcode;
	//单据号（收款单号）
	var notecode = data.notecode;
	//住户
	var leasename = data.leasename;
	//住户电话
	var phonenumber = data.phonenumber;
	//制表人
	var chargeman = data.chargeman;
	//收费人员（经办人）
	var jbr = data.jbr;
	//收费人员（经办人）电话
	var jbrphone = data.jbrphone;
	//收费日期
//	var d = new Date();
//	var vYear = d.getFullYear();
//	var vMon = d.getMonth() + 1;
//	var vDay = d.getDate();
//	var chargedate = vYear + "-";
//	chargedate += vMon < 10 ? "0" + vMon : vMon;
//	chargedate += "-";
//	chargedate += vDay < 10 ? "0" + vDay : vDay;
	//打印日期
	var printdate = data.printdate;
	
	var data_json = data.book;//JSON.parse(data);
	var html = "";
	var num = 0;
	var totalmoney = 0;
	for (var i=0;i<Math.ceil(data_json.length/4);i++) {
//		if (i == (Math.ceil(data_json.length/4) -1)) {
//			html += "<div class=\"my_show\">";
//		}
//		else {
//			html += "<div class=\"my_show\" style=\"page-break-after: always;\">";
//		}
		
		html += "<div class=\"my_show\">";
		html += "<div style=\"page-break-after:always\">";
		
		html += "<table style=\"width:100%;top: 0px\" class=\"print_font\">";
		
		html += "<tr>";
		html += "<td align=\"center\" style=\"padding-left:110px;\" colspan=\"4\"><span style=\"font-size:20px; font-weight:bold;text-align:center\">"+sysunitname+"</span></td>";
		html += "<td align=\"center\" rowspan=\"2\" width=\"130px\"><img style=\"height:60px;width:60px\" src=\""+barcode+"\" /></td>";
		html += "</tr>";
		
		html += "<tr>";
		html += "<td align=\"center\" style=\"padding-left:110px;\" colspan=\"4\"><span style=\"text-decoration:underline;font-size:18px;text-align:center\">"+print_type+"</span></td>";
		html += "</tr>";
		
		html += "<tr>";
		html += "<td><span style=\"font-size:12px; font-weight:bold;text-align:center\">单元编号:</span>"+unitcode+"</td>";
		html += "<td><span style=\"font-size:12px; font-weight:bold;text-align:center\">住户:</span>"+leasename+"</td>";
		html += "<td><span style=\"font-size:12px; font-weight:bold;text-align:center\">住户电话:</span>"+phonenumber+"</td>";
		html += "<td align=\"right\" colspan=\"2\"><span style=\"font-size:12px; font-weight:bold;text-align:center\">单据号:</span>"+notecode+"</td>";
		html += "</tr>";
		
		html += "<tr>";
    	html += "<td colspan=\"5\" style=\"height:150px;\" valign=\"top\">";
    	
    	html += "<table cellspacing=\"0\" style=\"border-collapse: collapse; border-spacing: 0;\" width=\"100%\">";
    	html += "<tr style=\"font-size:12px;border:1px #000 solid;text-align: center;height: 26px\">";
		html += "<td widtd='20px' style=\"border:1px #000 solid;\">序号</td>";
		html += "<td style=\"border:1px #000 solid;\">收费项目</td>";
		html += "<td style=\"border:1px #000 solid;\">起</td>";
		html += "<td style=\"border:1px #000 solid;\">止</td>";
		html += "<td widtd='70px' style=\"border:1px #000 solid;\">数量</td>";
		html += "<td widtd='32px' style=\"border:1px #000 solid;\">单价</td>";
		html += "<td widtd='32px' style=\"border:1px #000 solid;\">金额</td>";
		html += "<td widtd='32px' style=\"border:1px #000 solid;\">备注</td>";
		html += "</tr>";
		
    	for (var j=i*4;j<i*4+4;j++) {
    		num++;
			if (j<data_json.length) {
				if (!isNaN(data_json[j].paidsum)) {
					if (data_json[j].itemtype == 1 || data_json[j].iswatch == 1) {
						totalmoney += data_json[j].paidsum;
	                }
	                else {
	                	totalmoney = totalmoney - data_json[j].paidsum;
	                }
				};
                
				
				html += "<tr class=\"content_tr\" style=\"font-size:12px;height:26px;border:1px #000 solid;text-align: center\">";
				html += "<td style=\"border:1px #000 solid;\">"+ num +"</td>";
				html += "<td style=\"border:1px #000 solid;\"> "+ data_json[j].itemcode  +"</td>";
				html += "<td style=\"border:1px #000 solid;\"> "+ data_json[j].lastnumber + "</td>";
				html += "<td style=\"border:1px #000 solid;\"> "+ data_json[j].newnumber +"</td>";
				html += "<td style=\"border:1px #000 solid;\">"+ data_json[j].chargenumber +"</td>";
				html += "<td style=\"border:1px #000 solid;\">"+ (typeof(data_json[j].chargeprice) == "undefined" ? '' : data_json[j].chargeprice) +"</td>";
				if (data_json[j].itemtype == 1) {
					html += "<td style=\"border:1px #000 solid;\">"+ data_json[j].paidsum +"</td>";
				}
				else {
					html += "<td style=\"border:1px #000 solid;\">-"+ data_json[j].paidsum +"</td>";
				}
				html += "<td style=\"border:1px #000 solid;\">"+ (typeof(data_json[j].bookmemo) == "undefined" ? '' : data_json[j].bookmemo) +"</td>";
				html += "</tr>";
			}
			else {
				html += "<tr class=\"content_tr\" style=\"height:26px;border:1px #000 solid;text-align: center\">";
				html += "<td style=\"border:1px #000 solid;\"></td>";
				html += "<td style=\"border:1px #000 solid;\"></td>";
				html += "<td style=\"border:1px #000 solid;\"></td>";
				html += "<td style=\"border:1px #000 solid;\"></td>";
				html += "<td style=\"border:1px #000 solid;\"></td>";
				html += "<td style=\"border:1px #000 solid;\"></td>";
				html += "<td style=\"border:1px #000 solid;\"></td>";
				html += "<td style=\"border:1px #000 solid;\"></td>";
				html += "</tr>";
			}
		}
    	//添加合计
    	if (i+1 == Math.ceil(data_json.length/4)) {
    		html += "<tr class=\"content_tr\" style=\"font-size:12px;height:30px;border:1px #000 solid;text-align: center\">";
    		html += "<td style=\"border:1px #000 solid;\"></td>";
    		html += "<td style=\"border:1px #000 solid;\">总计(￥)</td>";
    		html += "<td style=\"border:1px #000 solid;\"></td>";
    		html += "<td style=\"border:1px #000 solid;\"></td>";
    		html += "<td style=\"border:1px #000 solid;\"></td>";
    		html += "<td style=\"border:1px #000 solid;\"></td>";
    		html += "<td style=\"border:1px #000 solid;\">"+totalmoney+"</td>";
    		html += "<td style=\"border:1px #000 solid;\"></td>";
    		html += "</tr>";
    	}
		
    	html += "</table>";
    	html += "</td>";
    	html += "</tr>";
    	
    	html += "<tr>";
		html += "<td><span style=\"font-size:12px; font-weight:bold;text-align:center\">项目经理:</span>"+jbr+"</td>";
		html += "<td><span style=\"font-size:12px; font-weight:bold;text-align:center\">联系电话：</span>"+jbrphone+"</td>";
		html += "<td><span style=\"font-size:12px; font-weight:bold;text-align:center\">制表人:</span>"+chargeman+"</td>";
		html += "<td align=\"right\" colspan=\"2\"><span style=\"font-size:12px; font-weight:bold;text-align:center\">打印日期：</span>"+printdate+"</td>";
		
		html += "</tr>";
		
		html += "</table>";
		if (print_type == '收款通知单') {
			html += "<span style=\"margin-left: 2px;font-size:12px; font-weight:bold;text-align:center\">请客户接到此通知单后3日内到物业办公室缴费，盖章有效。</span>"
		}
		else if (print_type == '收款单') {
			html += "<span style=\"margin-left: 2px;font-size:12px; font-weight:bold;text-align:center\">此单据为我公司缴费凭证，请妥善保管，盖章有效。</span>"
		}
        html += "</div>";
		html += "</div>";
	}
	
	return html;
}

function chargenote_html_merge(printinfo,data) {
	//系统使用单位名称
	var sysunitname = printinfo.sysunitname;
	//打印的副标题
	var print_type = printinfo.print_type;
	var barcode = printinfo.barcode;
//	//单元名称
//	var unitcode = printinfo.unitcode;
//	//单据号（收款单号）
//	var notecode = data.notecode;
	//住户
	var leasename = printinfo.leasename;
	//住户电话
	var phonenumber = printinfo.phonenumber;
	//制表人
	var chargeman = printinfo.chargeman;
	//收费人员（经办人）
	var jbr = printinfo.jbr;
	//收费人员（经办人）电话
	var jbrphone = printinfo.jbrphone;
	//打印日期
	var printdate = printinfo.printdate;
	
	//处理数据
	var data_json = [];
	var books = {};
	for (var i=0;i<data.length;i++) {
		books = data[i].book;
		for(var j = 0;j<books.length;j++) {
			books[j].unitcode = data[i].unitcode;
			books[j].nodecode = data[i].notecode;
			data_json.push(books[j]);
		}
	}
	
	//var data_json = data;//JSON.parse(data);
	var html = "";
	var num = 0;
	var totalmoney = 0;
	for (var i=0;i<Math.ceil(data_json.length/4);i++) {
//		if (i == (Math.ceil(data_json.length/4) -1)) {
//			html += "<div class=\"my_show\">";
//		}
//		else {
//			html += "<div class=\"my_show\" style=\"page-break-after: always;\">";
//		}
		
		html += "<div class=\"my_show\">";
		html += "<div style=\"page-break-after:always\">";
		
		html += "<table style=\"width:100%;top: 0px\" class=\"print_font\">";
		
		html += "<tr>";
		html += "<td align=\"center\" style=\"padding-left:110px;\" colspan=\"4\"><span style=\"font-size:20px; font-weight:bold;text-align:center\">"+sysunitname+"</span></td>";
		html += "<td align=\"center\" rowspan=\"2\" width=\"130px\"><img style=\"height:60px;width:60px\" src=\""+barcode+"\" /></td>";
		html += "</tr>";
		
		html += "<tr>";
		html += "<td align=\"center\" style=\"padding-left:110px;\" colspan=\"4\"><span style=\"text-decoration:underline;font-size:18px;text-align:center\">"+print_type+"</span></td>";
		html += "</tr>";
		
		html += "<tr>";
		html += "<td><span style=\"font-size:12px; font-weight:bold;text-align:center\">单元编号:</span></td>";
		html += "<td><span style=\"font-size:12px; font-weight:bold;text-align:center\">住户:</span>"+leasename+"</td>";
		html += "<td><span style=\"font-size:12px; font-weight:bold;text-align:center\">住户电话:</span>"+phonenumber+"</td>";
		html += "<td align=\"right\" colspan=\"2\"><span style=\"font-size:12px; font-weight:bold;text-align:center\">单据号:</span></td>";
		html += "</tr>";
		
		html += "<tr>";
		html += "<td colspan=\"5\" style=\"height:150px;\" valign=\"top\">";
		
		html += "<table cellspacing=\"0\" style=\"border-collapse: collapse; border-spacing: 0;\" width=\"100%\">";
		html += "<tr style=\"font-size:12px;border:1px #000 solid;text-align: center;height: 26px\">";
		html += "<td widtd='20px' style=\"border:1px #000 solid;\">序号</td>";
		html += "<td style=\"border:1px #000 solid;\">单元</td>";
		html += "<td style=\"border:1px #000 solid;\">收款单</td>";
		html += "<td style=\"border:1px #000 solid;\">收费项目</td>";
		html += "<td style=\"border:1px #000 solid;\">起</td>";
		html += "<td style=\"border:1px #000 solid;\">止</td>";
		html += "<td widtd='70px' style=\"border:1px #000 solid;\">数量</td>";
		html += "<td widtd='32px' style=\"border:1px #000 solid;\">单价</td>";
		html += "<td widtd='32px' style=\"border:1px #000 solid;\">金额</td>";
		html += "<td widtd='32px' style=\"border:1px #000 solid;\">备注</td>";
		html += "</tr>";
		
		for (var j=i*4;j<i*4+4;j++) {
			num++;
			if (j<data_json.length) {
				if (!isNaN(data_json[j].paidsum)) {
					if (data_json[j].itemtype == 1 || data_json[j].iswatch == 1) {
						totalmoney += data_json[j].paidsum;
					}
					else {
						totalmoney = totalmoney - data_json[j].paidsum;
					}
				};
				
				
				html += "<tr class=\"content_tr\" style=\"font-size:12px;height:26px;border:1px #000 solid;text-align: center\">";
				html += "<td style=\"border:1px #000 solid;\">"+ num +"</td>";
				html += "<td style=\"border:1px #000 solid;\"> "+ data_json[j].unitcode  +"</td>";
				html += "<td style=\"border:1px #000 solid;\"> "+ data_json[j].nodecode  +"</td>";
				html += "<td style=\"border:1px #000 solid;\"> "+ data_json[j].itemcode  +"</td>";
				html += "<td style=\"border:1px #000 solid;\"> "+ data_json[j].lastnumber + "</td>";
				html += "<td style=\"border:1px #000 solid;\"> "+ data_json[j].newnumber +"</td>";
				html += "<td style=\"border:1px #000 solid;\">"+ data_json[j].chargenumber +"</td>";
				html += "<td style=\"border:1px #000 solid;\">"+ (typeof(data_json[j].chargeprice) == "undefined" ? '' : data_json[j].chargeprice) +"</td>";
				if (data_json[j].itemtype == 1) {
					html += "<td style=\"border:1px #000 solid;\">"+ data_json[j].paidsum +"</td>";
				}
				else {
					html += "<td style=\"border:1px #000 solid;\">-"+ data_json[j].paidsum +"</td>";
				}
				html += "<td style=\"border:1px #000 solid;\">"+ (typeof(data_json[j].bookmemo) == "undefined" ? '' : data_json[j].bookmemo) +"</td>";
				html += "</tr>";
			}
			else {
				html += "<tr class=\"content_tr\" style=\"height:26px;border:1px #000 solid;text-align: center\">";
				html += "<td style=\"border:1px #000 solid;\"></td>";
				html += "<td style=\"border:1px #000 solid;\"></td>";
				html += "<td style=\"border:1px #000 solid;\"></td>";
				html += "<td style=\"border:1px #000 solid;\"></td>";
				html += "<td style=\"border:1px #000 solid;\"></td>";
				html += "<td style=\"border:1px #000 solid;\"></td>";
				html += "<td style=\"border:1px #000 solid;\"></td>";
				html += "<td style=\"border:1px #000 solid;\"></td>";
				html += "<td style=\"border:1px #000 solid;\"></td>";
				html += "<td style=\"border:1px #000 solid;\"></td>";
				html += "</tr>";
			}
		}
		//添加合计
		if (i+1 == Math.ceil(data_json.length/4)) {
			html += "<tr class=\"content_tr\" style=\"font-size:12px;height:30px;border:1px #000 solid;text-align: center\">";
			html += "<td style=\"border:1px #000 solid;\"></td>";
			html += "<td style=\"border:1px #000 solid;\">总计(￥)</td>";
			html += "<td style=\"border:1px #000 solid;\"></td>";
			html += "<td style=\"border:1px #000 solid;\"></td>";
			html += "<td style=\"border:1px #000 solid;\"></td>";
			html += "<td style=\"border:1px #000 solid;\"></td>";
			html += "<td style=\"border:1px #000 solid;\"></td>";
			html += "<td style=\"border:1px #000 solid;\"></td>";
			html += "<td style=\"border:1px #000 solid;\">"+totalmoney+"</td>";
			html += "<td style=\"border:1px #000 solid;\"></td>";
			html += "</tr>";
		}
		
		html += "</table>";
		html += "</td>";
		html += "</tr>";
		
		html += "<tr>";
		html += "<td><span style=\"font-size:12px; font-weight:bold;text-align:center\">项目经理:</span>"+jbr+"</td>";
		html += "<td><span style=\"font-size:12px; font-weight:bold;text-align:center\">联系电话：</span>"+jbrphone+"</td>";
		html += "<td><span style=\"font-size:12px; font-weight:bold;text-align:center\">制表人:</span>"+chargeman+"</td>";
		html += "<td align=\"right\" colspan=\"2\"><span style=\"font-size:12px; font-weight:bold;text-align:center\">打印日期：</span>"+printdate+"</td>";
		
		html += "</tr>";
		
//		html += "<tr>";
//		if (print_type == '收款通知单') {
//			html += "<td align=\"left\" font-size:12px; colspan=\"4\">请客户接到此通知单后3日内到物业办公室缴费，盖章有效。</td>"
//		}
//		else if (print_type == '收款单') {
//			html += "<span style=\"margin-left: 2px;top: 0px;font-size:12px; font-weight:bold;text-align:center\">此单据为我公司缴费凭证，请妥善保管，盖章有效。</span>"
//		}
		
		html += "</table>";
		if (print_type == '收款通知单') {
			html += "<span style=\"margin-left: 2px;top: 0px;font-size:12px; font-weight:bold;text-align:center\">请客户接到此通知单后3日内到物业办公室缴费，盖章有效。</span>"
		}
		else if (print_type == '收款单') {
			html += "<span style=\"margin-left: 2px;top: 0px;font-size:12px; font-weight:bold;text-align:center\">此单据为我公司缴费凭证，请妥善保管，盖章有效。</span>"
		}
		html += "</div>";
		html += "</div>";
	}
	
	return html;
}

