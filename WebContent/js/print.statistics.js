function ajml_html(title_data,content_data, projectname, termcode) {
	var title_json = JSON.parse(title_data);
	var content = JSON.parse(content_data)
	var content_json = content.data;
	
	//除了水电以外的费用，如物业费
	var chargecollist = title_json[0];
	//水费
	var watercollist = title_json[1];
	//电费
	var powercollist = title_json[2];
	
	var watermergelen = watercollist.length + 1;
	
	var powermergelen = powercollist.length + 1;
	
	var alllen = chargecollist.length + 2 + watermergelen + powermergelen ;	
	
	var html = "";
	
	//Math.ceil 是script函数，四舍五入的，用来判断是否达到一页，如果是一页，就给div加上page-break-after: always，强制换页
	for (var i=0;i<Math.ceil(content_json.length/15);i++) {
	if (i == (Math.ceil(content_json.length/15) -1)) {	
			html += "<div class=\"my_show\">";
		}
		else {
			html += "<div class=\"my_show\" style=\"page-break-after: always;\">";
		}
		html += "<table cellspacing=\"0\" style=\"border-collapse: collapse; border-spacing: 0;background-color: transparent;max-width: 100%\" cellpadding=\"0\" width=\"100%\" class=\"print_font\">";
        html += "<thead>";
        html += "<tr>";
        html += "<th colspan=\""+alllen+"\">";
        html += "<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" width=\"100%\">";
        html += "<tr align=\"center\">";
        html += "<td style=\"font-size: 26px;padding-bottom: 45px;padding-top: 0px\" align=\"center\" colspan=\"2\">&nbsp;&nbsp;台账统计</td>";
        html += "</tr>";
     
        html += "<tr align=\"center\">";
        html += "<td style=\"font-size: 15px;padding-bottom: 15px;padding-top: 0px\" align=\"left\">&nbsp;&nbsp;项目名称: "+projectname+"</td>";
        html += "<td style=\"font-size: 15px;padding-bottom: 15px;padding-top: 0px\" align=\"right\">台账账期: "+termcode+"&nbsp;&nbsp;</td>";        
        html += "</tr>";
        
        html += "</table>";
        
		html += "</th>";
		html += "</tr>";
		html += "<tr style=\"border:1px #000 solid;text-align: center;height: 50px\">";
		
		html += "<th rowspan=\"2\" style=\"border:1px #000 solid;\">单元名称</th>";
		//设置表头的第一行
		//先设置除了水电以为的费用（不用合并单元格）
		for(var m = 0; m < chargecollist.length; m++){
			html += "<th rowspan=\"2\" style=\"border:1px #000 solid;\">"+chargecollist[m].chargeitemcode+"</th>";			
		}
		//设置水费及水费合计

		for(var n = 0; n < watercollist.length; n++){
			if (n == 0){
				html += "<th colspan=\""+watermergelen+"\" style=\"border:1px #000 solid;\">水费</th>";	
			}
			//html += "<th tyle=\"border:1px #000 solid;\"></th>";
		}
		//html += "<th style=\"border:1px #000 solid;\"></th>";
		//设置电费及电费合计 powercollist
		for(var k = 0; k < powercollist.length ; k++){
			if (k == 0){
				html += "<th colspan=\""+powermergelen+"\" style=\"border:1px #000 solid;\">电费</th>";	
			}			
//			html += "<th style=\"border:1px #000 solid;\"></th>";			
		}	
		//html += "<th style=\"border:1px #000 solid;\"></th>";
		
		//设置总合计
		html += "<th rowspan=\"2\" style=\"border:1px #000 solid;\">合计</th>";
		
		html += "</tr>";
		//html += "</tr>";
		
		html += "<tr style=\"border:1px #000 solid;text-align: center;height: 50px\">";
		//设置第二行
		
		for(var a = 0; a < watercollist.length; a++){
			html += "<th style=\"border:1px #000 solid;\">"+watercollist[a].chargeitemcode+"</th>";			
		}
		html += "<th style=\"border:1px #000 solid;\">合计</th>";
		
		//设置电费及电费合计 powercollist
		for(var b = 0; b < powercollist.length; b++){
			html += "<th style=\"border:1px #000 solid;\">"+powercollist[b].chargeitemcode+"</th>";			
		}
		html += "<th style=\"border:1px #000 solid;\">合计</th>";

		html += "</tr>";
		html += "</thead>";
		html += "<tbody >";
		
	
		//设置内容
		for (var j=i*15;j<i*15+15;j++) {
			if (j<content_json.length) {
				html += "<tr class=\"content_tr\" style=\"font-size:12px;height:50px;border:1px #000 solid;text-align: center\">";
				var contentEntry = content_json[j]; 
				for(var key in contentEntry){
					var tmp = key;
					html += "<td style=\"border:1px #000 solid;\">"+ contentEntry[tmp] +"</td>";					
				}

				html += "</tr>";				
			}else {	//这里判断在全部打印完后，填充满空白格
				html += "<tr class=\"content_tr\" style=\"height:50px;border:1px #000 solid;text-align: center\">";
				for(var n = 0; n < alllen ; n++){
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

