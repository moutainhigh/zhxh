
		<div class="table-responsive-y">
			<table class="table table-hover">
				<thead><tr>
					<th>账单流水号</th>
					<th>日期</th>
					<th>客户名称</th>
					<th>摘要</th>
					<th>金额</th>
				</tr> </thead>
				<tbody>
					<tr>
						<td>{$T.billno}</td>
						<td>{$T.createtime}</td>
						<td>{$T.u_username} </td>
						<td>{$T.trantypetxt} </td>
						<td>￥{$T.account_real}</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="text-right" style="padding: 30px 50px 5px 50px;border-top: solid 0">
			<div>总额：￥<span style="color: red !important" id="total_sum">{$T.account_real}</span></div>
			<br>
			<form name="pay_form" actioin="" method="post" target="_blank">
				<input type="hidden" name="id" value="{$T.id}" />
				<button id="pay_btn" type="button" class="button bg-dot" onclick="payment()">立即支付</button>			
			</form>
		</div>
