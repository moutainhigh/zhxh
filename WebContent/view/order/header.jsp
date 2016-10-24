<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript">
	function sendMessage() {
		layer.prompt({
			formType: 2,
			value: '',
			title: '请输入反馈意见'
		}, function(value, index, elem){
			var parm = {};
			parm.receiveid = "1";
			parm.messagetype = 0;
			parm.messagetxt = value;
			$.ajax({
    			async:false,
                url: "${pageContext.request.contextPath}/orderMessage/sendMessage.htmls",
                data: parm,
                type: "post",
                dataType:"text",
                success: function (json) {
                	layer.msg("提交成功。",{icon:6});
                },
                error: function (jqXHR, textStatus, errorThrown) {
                	layer.msg("提交出现错误，请退出重新登录，再尝试操作。错误代码："+jqXHR.responseText,{icon:6});
                }
           });
		   layer.close(index);
		});
	}
	
	function updateSelf() {
		var pHeight = $(window.parent).height();
   		var pWidth = $(window.parent).width();
		layer.open({
		    type: 2,
		    title:'修改资料',
		    area: ['820px', (pHeight-100) +'px'],
		    fix: false, //不固定
		    maxmin: false,
		    content: "${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/user/updateUser",
		    btn: ['确 定', '取 消'],
		    success:function(layero,index){
		    	//var win = parent.window['layui-layer-iframe' + index].window;
		    	//win.setData(comp,brandid);
		    },
		  	yes: function(index,layero){
		  		var win = window['layui-layer-iframe' + index].window;
		  		var row = win.getData();
		  		
		  		if (row == false) {
		  			layer.msg("数据填写不规范，请检查。",{icon:6});
				}
				else {
					//询问框
			  		layer.confirm('确定要修改信息吗？', {
			  			btn: ['确认', '取消']
			  		},
			  		function()	{
			  			row._state = 'modified';
			  			row.updatePhone = "1";
			  			if (row.identity != "Z") {
			  				row.companycode = row.phonenumber;
			  			}
			  			var rowArr = [];
			  			rowArr.push(row);
			  			var json = JSON.stringify(rowArr);
			  			$.ajax({
			    			async:false,
			                url: "${pageContext.request.contextPath}/orderUser/save.htmls",
			                data: {'objs':json},
			                type: "post",
			                dataType:"text",
			                success: function (text) {
			                 	if (text == 'success') {
			                 		layer.msg("保存成功。",{icon:6});
			                 		layer.close(index);
			                 	}
			                 	else if (text == "codeerror") {
			                 		layer.msg("手机短信验证码错误，请输入正确，再尝试，或与开发商联系。",{icon:5});
			                 	}
			                 	else {
			                 		layer.msg("保存出现问题，请退出重新登录，再尝试，或与开发商联系。",{icon:5});
			                 	}
			                },
			                error: function (jqXHR, textStatus, errorThrown) {
			                	layer.msg("提交出现错误，请退出重新登录，再尝试操作。错误代码："+jqXHR.responseText,{icon:6});
			                }
			           });
			  		}, 
			  		function(){
			  			
			  		});
				}
		  	},
		    end: function(){
		    	//alert(123);
		    }
		});
	}
</script>
    
<script src="${pageContext.request.contextPath}/js/layer2.4/layer.js" type="text/javascript"></script>
<div class="layout doc-header fixed box-shadow-small" style="z-index: 9;">
	<div class="container-layout doc-naver">
		<div class="line">
			<div class="x3 doc-logo" >
				<!-- <button class="button icon-navicon margin-top float-right" data-target="#doc-header-pintuer">
				</button>
				<a href="/">
					<img src="images/logo.png" width="180" height="40" alt="拼图" class="ring-hover">
				</a> -->
				<p class="text-sub text-big" style="margin-left:30px; line-height: 40px;margin-bottom: 0px;">集丽科技采购分销平台</p>
			</div>
			<div class="x9 doc-nav " style="text-align: right;">
				<ul class="nav nav-inline nav-navicon padding-small-top nav-menu" id="doc-header-pintuer" style="margin-right: 50px">
					<li>
						<a class="" href="javascript:;">
							<span><img src="${pageContext.request.contextPath}/images/user_man.png" width="22" class="radius-circle"></span>
							${sessionScope.pc_user_sessiion.username == ""?sessionScope.pc_user_sessiion.companyname:sessionScope.pc_user_sessiion.username  } 
							<span class="downward"></span>
						</a>
						<ul class="drop-menu">
							<li><a class="icon-user" target="_blank" href="javascript:;" onclick="updateSelf()"> 修改资料</a></li>
							<li><a class="icon-key" target="_blank" href="javascript:;"> 修改密码</a></li>
						</ul>
					</li>
					<%-- <li class="active">
						<a class="" href="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/message/messageList&param={'radio_value':'2'}">
							<span class="icon-envelope-o"></span>&nbsp;
							<span id="m2Top">
							<c:if test="${sessionScope.order_message2_session > 0}">
							<span class="badge bg-blue">${sessionScope.order_message2_session}+</span>
							</c:if>
							</span>
							<span class="downward"></span>
						</a>
						<ul class="drop-menu">
							<span id="m2Num">
							<c:if test="${sessionScope.order_message2_session > 0}">
							<li><a class="" href="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/message/messageList&param={'radio_value':'2'}"><span class="icon-envelope"></span>&nbsp;您有${sessionScope.order_message2_session}封邮件</a></li>
							</c:if>
							</span>
							<li><a class="bg-gray" href="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/message/messageList&param={'radio_value':'2'}"><span class="icon-envelope"></span>&nbsp;查阅更多...</a></li>
						</ul>
					</li> --%>
					<li>
						<a class="" href="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/message/messageList&param={'radio_value':'1'}">
							<span class="icon-bell-o"></span>&nbsp;
							<span id="m1m0Top">
							<c:if test="${sessionScope.order_message1_session > 0 || sessionScope.order_message0_session > 0}">
							<span class="badge bg-green">${sessionScope.order_message1_session+sessionScope.order_message0_session }+</span>
							</c:if>
							</span>
							<span class="downward"></span>
						</a>
						<ul class="drop-menu">
							<span id="m1Num">
							<c:if test="${sessionScope.order_message1_session > 0}">
							<li><a class="" href="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/message/messageList&param={'radio_value':'1'}"><span class="icon-comment"></span>&nbsp;您有${sessionScope.order_message1_session }条未读业务消息</a></li>
							</c:if>
							</span>
							<span id="m0Num">
							<c:if test="${sessionScope.order_message0_session > 0}">
							<li><a class="" href="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/message/messageList&param={'radio_value':'0'}"><span class="icon-comment"></span>&nbsp;您有${sessionScope.order_message0_session }条未读系统消息</a></li>
							</c:if>
							</span>
							<li><a class="bg-gray" href="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/message/messageList&param={'radio_value':'1'}"><span class="icon-envelope"></span>&nbsp;查看更多...</a></li>
						</ul>
					</li>
					<li>
						<a href="javascript:;"><span class="icon-comment-o"></span>&nbsp;客服<span class="downward"></span></a>
						<ul class="drop-menu">
							<li><a href="javascript:;">在线客服</a></li>
							<li><a href="javascript:;" onclick="sendMessage()">意见反馈</a></li>
							<li><a href="javascript:;" style="background-color: #00a7e4;color: #fff;">400-400-4000</a></li>
							<li><a href="javascript:;" style="background-color: #00a7e4;color: #fff;">7*24小时服务</a></li>
						</ul>
					</li>
					<li><a class="" href="javascript:;" onclick="logout()"><span class="icon-sign-out"></span>注销</a></li>
				</ul>
			</div>
		</div>
	</div>
</div>
<script>
	function logout(){
		parent.window.location.href = '${pageContext.request.contextPath}/pcMain/plogout.htmls';
	}
	
	function resetMessage(json) {
		/* $("#m2Top").html("");
		if (json.m2 > 0) {
			$("#m2Top").html('<span class="badge bg-blue">'+json.m2+'+</span>');
		} */
		/* $("#m2Num").html("");
		if (json.m2 > 0) {
			$("#m2Num").html('<li><a class="" href="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/message/messageList&param={\'radio_value\':\'2\'}"><span class="icon-envelope"></span>&nbsp;您有'+json.m2+'封邮件</a></li>');
		} */
		
		$("#m1m0Top").html("");
		var aa = json.m1+json.m0;
		if (json.m1 > 0 || json.m0 > 0) {
			$("#m1m0Top").html('<span class="badge bg-green">'+aa+'+</span>');
		}
		
		$("#m1Num").html("");
		if (json.m1 > 0) {
			$("#m1Num").html('<li><a class="" href="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/message/messageList&param={\'radio_value\':\'1\'}"><span class="icon-comment"></span>&nbsp;您有'+json.m1+'条未读业务消息</a></li>');
		}
		$("#m0Num").html("");
		if (json.m0 > 0) {
			$("#m0Num").html('<li><a class="" href="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/message/messageList&param={\'radio_value\':\'0\'}"><span class="icon-comment"></span>&nbsp;您有'+json.m0+'条未读系统消息</a></li>');
		}
	}
</script>