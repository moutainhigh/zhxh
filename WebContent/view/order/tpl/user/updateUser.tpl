<script src="{$P.path}/js/pintuer/pintuer.js"></script>
<div class="container-layout" style="padding: 5px 30px 0px 30px;">
	<div class="doc-demoview doc-viewad0 ">
		<div class="view-body">
			<form id="addUserForm" method="post" class="form-x" onsubmit="return false;">
				<input type="hidden" id="id" name="id" value="{$T.id}" />
				<input type="hidden" id="identity" name="identity" value="{$T.identity}" />
				{#if $P.updatePhone == 0}<input type="hidden" class="input" id="phonenumber" name="phonenumber" size="30" value="{$T.phonenumber}" >{#/if}
				<div class="form-group">
					<div class="label">
						<label for="username">真实姓名</label>
					</div>
					<div class="field">
						<input type="text" class="input" id="username" name="username" size="30" value="{$T.username}" data-validate="required:必填" placeholder="客户姓名[不能为空]">
					</div>
				</div>
				<div class="form-group">
					<div class="label">
						<label for="phonenumber">手机号码</label>
					</div>
					<div class="field">
						<input type="text" class="input" id="phonenumber" name="phonenumber" {#if $P.updatePhone == 0}disabled="disabled"{#/if} size="30" value="{$T.phonenumber}" {#if $P.updatePhone == 1}data-validate="required:必填,mobile:手机号码只能填写数字,ajax#{$P.path}/orderUser/checkPhoneNum.htmls?userid={$T.id}&checkType=update&phoneNum=:手机号码已注册"{#/if} placeholder="手机号码[作为客户登录本系统的帐号。[不能为空,仅数字]">
					</div>
				</div>
				<div class="form-group">
					<div class="label">
						<label for="username">出生日期</label>
					</div>
					<div class="field">
						<input type="text" class="input" id="birthday" name="birthday" value="{$T.birthday}" size="30" placeholder="点击选择">
					</div>
				</div>
				<div class="form-group">
					<div class="label">
						<label for="phonenumber">性别</label>
					</div>
					<div class="field">
						<select class="input" id="sex" name="sex">
							<option {#if $T.sex == 1}selected{#/if} value="1">男</option>
							<option {#if $T.sex == 0}selected{#/if} value="0">女</option>
						</select>
					</div>
				</div>
				{#if $T.identity == 'A' || $T.identity == 'C'}
				<div class="form-group">
					<div class="label">
						<label for="companyname">机构名称</label>
					</div>
					<div class="field">
						<input type="text" class="input" id="companyname" name="companyname" size="30" value="{$T.companyname}" data-validate="required:必填" placeholder="机构名称[机构店名称]">
					</div>
				</div>
				<div class="form-group">
					<div class="label">
						<label for="companypath">机构地址</label>
					</div>
					<div class="field">
						<input type="text" class="input" id="companypath" name="companypath" size="30" value="{$T.companypath}" data-validate="required:必填" placeholder="机构地址[机构的联系地址]">
					</div>
				</div>
				<div class="form-group">
					<div class="label">
						<label for="companyname">机构代码</label>
					</div>
					<div class="field">
						<input type="text" class="input" id="companycode" name="companycode" disabled="disabled" value="{$T.companycode}" size="30" data-validate="required:必填" placeholder="机构代码[与手机号相同]">
					</div>
				</div>
				{#/if}
				<div class="form-group">
					<div class="label">
						<label for="wechar">微信号码</label>
					</div>
					<div class="field">
						<input type="text" class="input" id="wechar" name="wechar" size="30" value="{$T.wechar}" placeholder="微信号码[可不填]">
					</div>
				</div>
				<div class="form-group">
					<div class="label">
						<label for="sort">排序</label>
					</div>
					<div class="field">
						<input type="text" class="input" id="sort" name="sort" size="30" value="{$T.sort}" data-validate="required:必填,number:请填写数字"  placeholder="排序">
					</div>
				</div>
				{#if $P.updatePhone == 1}
				<div class="form-group">
					<div class="label">
						<label for="wechar">验证码</label>
					</div>
					<div class="field">
						<div class="input-group">
							<input type="text" class="input" id="sendcode" name="sendcode" size="50" data-validate="required:必填" placeholder="手机验证码" />
							<span class="addbtn">
				            	<button type="button" class="button huoqu" onclick="getSendCode()">获取验证码</button>
				            </span>
						</div>
					</div>
				</div>
				{#/if}
				<div class="form-group">				
					<div class="field"  style="width:100%;margin-top:10px">
						<a href="javascript:;" style="text-align:center;" class="button bg-sub button-block button-big" onclick="updateUser()">保存</a>
					</div>
				</div>
				<div class="form-group">				
					<div class="field"  style="width:100%;margin-top:5px">
						<a href="javascript:;" style="text-align:center;" class="button bg-main button-block button-big" onclick="resetUserlist()">返回</a>
					</div>
				</div>
			</form>
		</div>
	</div>
	<div class="doc-democode doc-codead0 ">
		<blockquote class="border-sub">
			<p><span style="color:red">填写注意：</span><br>
			1.手机号码必须真实填写，一个手机号码仅能注册一次。<br>
			2.手机号码需接收验证短信，填入验证码才能合法注册。<br>
			3.手机号码同时作为客户登录本系统的帐号及普通会员采购时利益分配的唯一标准代码。
			</p>
		</blockquote>
	</div>
</div>
<script src="{$P.path}/view/order/tpl/user/orderUserUpdata.js"></script>