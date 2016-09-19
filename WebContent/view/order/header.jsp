<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="layout doc-header fixed box-shadow-small" style="z-index: 9;">
	<div class="container-layout doc-naver">
		<div class="line">
			<div class="x3 doc-logo" >
				<!-- <button class="button icon-navicon margin-top float-right" data-target="#doc-header-pintuer">
				</button>
				<a href="/">
					<img src="images/logo.png" width="180" height="40" alt="拼图" class="ring-hover">
				</a> -->
				<p class="text-sub text-big" style="margin-left:30px; line-height: 40px;margin-bottom: 0px;">众恒信和采购分销平台</p>
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
							<li><a class="icon-user" target="_blank" href="javascript:;"> 修改资料</a></li>
							<li><a class="icon-key" target="_blank" href="javascript:;"> 修改密码</a></li>
						</ul>
					</li>
					<li class="active">
						<a class="" href="javascript:;">
							<span class="icon-envelope-o"></span>&nbsp;
							<span class="badge bg-blue">5+</span>
							<span class="downward"></span>
						</a>
						<ul class="drop-menu">
							<li><a class="" target="_blank" href="javascript:;"><span class="icon-envelope"></span>&nbsp;您有16封邮件</a></li>
							<li><a class="bg-gray" target="_blank" href="javascript:;"><span class="icon-envelope"></span>&nbsp;查阅更多...</a></li>
						</ul>
					</li>
					<li>
						<a class="" href="javascript:;">
							<span class="icon-bell-o"></span>&nbsp;
							<span class="badge bg-green">99+</span>
							<span class="downward"></span>
						</a>
						<ul class="drop-menu">
							<li><a class="" target="_blank" href="javascript:;"><span class="icon-comment"></span>&nbsp;您有26条未读消息</a></li>
							<li><a class="" target="_blank" href="javascript:;"><span class="icon-comments"></span>&nbsp;您有13条回复消息</a></li>
							<li><a class="bg-gray" target="_blank" href="javascript:;"><span class="icon-envelope"></span>&nbsp;查看更多...</a></li>
						</ul>
					</li>
					<li>
						<a href="javascript:;"><span class="icon-comment-o"></span>&nbsp;客服<span class="downward"></span></a>
						<ul class="drop-menu">
							<li><a href="/react.html">在线客服</a></li>
							<li><a href="/weixin/index.html">意见反馈</a></li>
							<li><a href="javascript:;" style="background-color: #00a7e4;color: #fff;">400-400-4000</a></li>
							<li><a href="javascript:;" style="background-color: #00a7e4;color: #fff;">7*24小时服务</a></li>
						</ul>
					</li>
					<li><a class="" target="_blank" href="login.html"><span class="icon-sign-out"></span>注销</a></li>
				</ul>
			</div>
		</div>
	</div>
</div>