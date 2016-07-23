

/**
 * 
 * @param chargeitems			选择的收费项目对象集合
 * @param field					未知什么目的
 * @param data					抄表记录
 * @param meterdate				抄表账期名称
 * @param meterman				抄表人
 * @param metercreatetime		抄表日期
 * @param isnewnumber			是否包含本次表数
 * @param print_num				每页行数
 * @param print_row_height		行高
 * @returns {String}
 */

function ajml_html(chargeitems,field,data,meterdate,meterman,metercreatetime,sel_all_projectname,isnewnumber,print_num,print_row_height) {
	var data_json = JSON.parse(data);
	var html = "";
	
	var alllen = chargeitems.length * 2 + 3;
	var num = 0;
	//Math.ceil 是script函数，四舍五入的，用来判断是否达到一页，如果是一页，就给div加上page-break-after: always，强制换页
	for (var i=0;i<Math.ceil(data_json.length/print_num);i++) {
		if (i == (Math.ceil(data_json.length/print_num) -1)) {
			html += "<div class=\"my_show\">";
		}
		else {
			html += "<div class=\"my_show\" style=\"page-break-after: always;\">";
		}
		html += "<table  cellspacing=\"0\" style=\"border-collapse: collapse; border-spacing: 0;background-color: transparent;max-width: 100%\" cellpadding=\"0\" width=\"100%\" class=\"print_font\">";
        html += "<thead>";
        html += "<tr align=\"center\" >";
        html += "<th colspan=\""+alllen+"\">";
        
        html += "<table align=\"center\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" width=\"100%\">";
        html += "<tr align=\"center\">";
        html += "<td align=\"center\" style=\"font-size: 26px;padding-bottom: 10px;padding-top: 0px\" colspan=\"2\" >抄 表 内 容</td>";
        html += "</tr>";
        html += "<tr align=\"center\">";
        html += "<td align=\"center\" style=\"font-size: 14px;padding-bottom: 15px;padding-top: 0px\" colspan=\"2\" >("+sel_all_projectname+")</td>";
        html += "</tr>";
        html += "<tr align=\"center\">";
        html += "<td style=\"font-size: 15px;padding-bottom: 5px;padding-top: 0px\" align=\"left\">&nbsp;&nbsp;抄表账期:"+meterdate+"</td>";
        html += "<td style=\"font-size: 15px;padding-bottom: 5px;padding-top: 0px\" align=\"right\">抄表人:"+meterman+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;抄表日期:"+metercreatetime+"</td>";
        html += "</tr>";
        html += "</table>";
		html += "</th>";
		html += "</tr>";
		html += "<tr style=\"border:1px #000 solid;text-align: center;height:30px\">";
		html += "<th rowspan=\"2\" style=\"border:1px #000 solid;\">序号</th>";
		html += "<th rowspan=\"2\" style=\"border:1px #000 solid;\">单元名称</th>";
		html += "<th rowspan=\"2\" style=\"border:1px #000 solid;\">住户</th>";
		//设置表头的第一行
		for(var m = 0; m < chargeitems.length; m++){
			html += "<th colspan=\"2\" style=\"border:1px #000 solid;\">"+chargeitems[m].code+"</th>";
		}
		html += "</tr>";
		
		html += "</tr>";
		html += "<tr style=\"border:1px #000 solid;text-align: center;height:30px\">";
		//设置第二行
		for(var n = 0; n < chargeitems.length; n++){
			html += "<th style=\"border:1px #000 solid;\">最后表数</th>";
			html += "<th style=\"border:1px #000 solid;\">本次表数</th>";
		}
		html += "</tr>";
		html += "</thead>";
		html += "<tbody >";
		//设置内容
		var rowNumber = Number(i*print_num)+Number(print_num);
		for (var j=i*print_num;j<rowNumber;j++) {
			num++;
			if (j<data_json.length) {
				html += "<tr class=\"content_tr\" style=\"font-size:12px;height:"+print_row_height+"px;border:1px #000 solid;text-align: center\">";
				html += "<td style=\"border:1px #000 solid;\">"+num+"</td>";
				
				if (typeof(data_json[j].unitcode) == "undefined") {
					html += "<td style=\"border:1px #000 solid;\"></td>";
				}
				else {
					html += "<td style=\"border:1px #000 solid;\">"+ data_json[j].unitcode +"</td>";
				}
				if (typeof(data_json[j].leaseunit) == "undefined") {
					html += "<td style=\"border:1px #000 solid;\"></td>";
				}
				else {
					html += "<td style=\"border:1px #000 solid;\">"+ data_json[j].leaseunit +"</td>";
				}
				
				
				for(var n = 0; n < chargeitems.length; n++){
					if (typeof(data_json[j][chargeitems[n].id+"#lastnumber"]) == "undefined" ) {
						html += "<td style=\"border:1px #000 solid;\"></td>";
					}
					else {
						html += "<td style=\"border:1px #000 solid;\">"+data_json[j][chargeitems[n].id+"#lastnumber"]+"</td>";
					}
					if (isnewnumber) {
						if (typeof(data_json[j][chargeitems[n].id+"#newnumber"]) == "undefined") {
							html += "<td style=\"border:1px #000 solid;\"></td>";
						}
						else {
							html += "<td style=\"border:1px #000 solid;\">"+data_json[j][chargeitems[n].id+"#newnumber"]+"</td>";
						}
					}
					else {
						html += "<td style=\"border:1px #000 solid;\"></td>";
					}
				}
				html += "</tr>";
			}else {	//填充满空白格
				html += "<tr class=\"content_tr\" style=\"height:"+print_row_height+"px;border:1px #000 solid;text-align: center\">";
				html += "<td style=\"border:1px #000 solid;\"></td>";
				html += "<td style=\"border:1px #000 solid;\"></td>";
				html += "<td style=\"border:1px #000 solid;\"></td>";
				for(var n = 0; n < chargeitems.length; n++){
					html += "<td style=\"border:1px #000 solid;\"></td>";
					html += "<td style=\"border:1px #000 solid;\"></td>";
				}				

				html += "</tr>";
			}
		}
		html += "</tbody>";
		html += "</table>";
        html += "</div>";
	}
	
	return html;
}

