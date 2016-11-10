<script src="{$P.path}"></script>

		<div class="container-layout" style="padding: 5px 30px 0px 30px;">
			<div class="doc-demoview doc-viewad0 ">
				<div class="view-body">
					<form id="pay2bankForm" method="post" class="form-x" onsubmit="return false;">
						<input type="hidden" name="parentid" value="{$P.parentid}" />
						<input type="hidden" name="trantype" value="{$P.trantype}" />
						<div class="form-group">
							<div class="label">
								<label for="province_city">城市</label>
							</div>
							<div class="field">
								<input type="text" class="input" id="province_city" name="province_city" size="30" data-validate="required:必填，例如：北京—bj" placeholder='中文字符 ,只需要城市名，不需要省份名。也不要带"市""自治区（县）"'>
							</div>
						</div>
						<div class="form-group">
							<div class="label">
								<label for="bankName">银行名称</label>
							</div>
							<div class="field">
								<input type="text" class="input" id="bankName" name="bankName" size="30" data-validate="required:必填，例如：招商银行" placeholder='银行名称 请填写银行的标准名'>
							</div>
						</div>
						<div class="form-group">
							<div class="label">
								<label for="kaihuhang">开户行</label>
							</div>
							<div class="field">
								<input type="text" class="input" id="kaihuhang" name="kaihuhang" size="30" data-validate="required:必填" placeholder='银行卡开户行的名称'>
							</div>
						</div>
						<div class="form-group">
							<div class="label">
								<label for="creditName">收款人</label>
							</div>
							<div class="field">
								<input type="text" class="input" id="creditName" name="creditName" size="30" data-validate="required:必填" placeholder="收款人姓名，必须与银行卡账户名相同">
							</div>
						</div>
						<div class="form-group">
							<div class="label">
								<label for="bankCardNumber">银行卡号</label>
							</div>
							<div class="field">
								<input type="text" class="input" id="bankCardNumber" name="bankCardNumber" size="30" data-validate="required:必填" placeholder="银行卡号">
							</div>
						</div>
						<div class="form-group">
							<div class="label">
								<label for="amount">金额</label>
							</div>
							<div class="field">
								<input type="text" class="input" id="amount" name="amount" size="30" value="{$P.amount}" data-validate="required:必填,number:请填写数字"  placeholder="提现金额">
							</div>
						</div>
						<div class="form-group">
							<div class="label">
								<label for="remarks">备注</label>
							</div>
							<div class="field">
								<input type="text" class="input" id="remarks" name="remarks" size="30" value="" placeholder="备注">
							</div>
						</div>
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
						<div class="form-group">				
							<div class="field float-right"  style="margin-top:10px">
								<a href="javascript:;" style="text-align:center;" class="button bg-dot" onclick="save_ithdrawal_bill()">提 交</a>
							</div>
						</div>
					</form>
				</div>
			</div>
			<div class="doc-democode doc-codead0 ">
				<blockquote class="border-yellow doc-quoteyellow">
					<strong>提现须知：</strong>
					1.提交申请后，系统资金账户会直接冲减。<br>
					2.提现手续费为每笔1元。<br>
					3.提交申请后，资金到账时间为T+3，如未到账请联系平台。<br>
				</blockquote>
			</div>
		</div>

