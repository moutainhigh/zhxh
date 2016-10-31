<div class="panel border-sub">
	<div class="panel-head">
		<strong>普通会员订单信息</strong>
	</div>
	<div id="myOrder" class="panel-body">
		<table class="table">
			<tbody>
				<tr>
					<td style="border-top: 0px solid #ddd;" widtd="100" align="center">序号</td>
					<td style="border-top: 0px solid #ddd;" widtd="100" align="left">商家名称</td>
					<td style="border-top: 0px solid #ddd;" widtd="100" align="left">购买人</td>
					<td style="border-top: 0px solid #ddd;" widtd="100" align="left">提交人</td>
					<td style="border-top: 0px solid #ddd;" widtd="100" align="left">订单号</td>
					<td style="border-top: 0px solid #ddd;" widtd="100" align="left">下单时间</td>
					<td style="border-top: 0px solid #ddd;" widtd="100" align="center">订单金额</td>
					<td style="border-top: 0px solid #ddd;" widtd="80">状态</td>
				</tr>
				<tr class="tr">
					<td align="center">1</td>
					<td>{$T.order.p_username}</td>
					<td>{$T.order.u_username}</td>
					<td>{$T.order.s_username}</td>
					<td>{$T.order.ordernumber}</td>
					<td>{$T.order.ordertime}</td>
					<td style="text-align: center;">￥{$T.order.ordertotal}</td>
					<td><span class="tag bg-order{$T.order.orderstatus}">{$T.order.orderstatusmemo}</span></td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
<br>
<div class="panel border-sub">
	<div class="panel-head">
		<strong>参与分配利润机构详细</strong>
	</div>
	<div id="myOrder" class="panel-body">
		<table class="table">
			<tbody>
				<tr>
					<td style="border-top: 0px solid #ddd;" widtd="100" align="center">序号</td>
					<td style="border-top: 0px solid #ddd;" widtd="100" align="left">提交订单机构</td>
					<td style="border-top: 0px solid #ddd;" widtd="100" align="left">分润机构名称</td>
					<td style="border-top: 0px solid #ddd;" widtd="100" align="center">分润金额(元)</td>
					<td style="border-top: 0px solid #ddd;" widtd="100" align="center">分润数量</td>
					<td style="border-top: 0px solid #ddd;" widtd="100">记账时间</td>
					<td style="border-top: 0px solid #ddd;" widtd="80">状态</td>
					<td style="border-top: 0px solid #ddd;" widtd="200" align="left">备注</td>
				</tr>
				{#foreach $T.sbList as row}
					<tr class="tr">
						<td align="center">{$T.row$index+1}</td>
						<td>{$T.row.submitname}</td>
						<td>{$T.row.username}</td>
						<td align="center">￥{$T.row.sharepay}</td>
						<td align="center">{$T.row.sharenumber}</td>
						<td>{$T.row.sharetime}</td>
						<td>{#if $T.row.sharestate == 0}等待分润{#else}分润完成{#/if}</span></td>
						<td>{$T.row.remarks}</td>
					</tr>
				{#/for}
			</tbody>
		</table>
	</div>
</div>
<br>
<div class="panel border-sub">
	<div class="panel-head">
		<strong>订单商品分配利润明细</strong>
	</div>
	<div id="myOrder" class="panel-body">
		<table class="table">
			<tbody>
				<tr>
					<td style="border-top: 0px solid #ddd;" widtd="100" align="center">序号</td>
					<td style="border-top: 0px solid #ddd;" widtd="100" align="left">品牌</td>
					<td style="border-top: 0px solid #ddd;" widtd="*" align="left">商品名称</td>
					<td style="border-top: 0px solid #ddd;" widtd="80">规格</td>
					<td style="border-top: 0px solid #ddd;" widtd="100" align="center">数量</td>
					<td style="border-top: 0px solid #ddd;" widtd="100" align="center">单价</td>
					<td style="border-top: 0px solid #ddd;" widtd="100" align="center">折扣</td>
					<td style="border-top: 0px solid #ddd;" widtd="100" align="center">小计</td>
				</tr>
				{#foreach $T.products as row}
					<tr class="tr">
						<td align="center">{$T.row$index+1}</td>
						<td>{$T.row.brandname}</td>
						<td style="text-align: left;">{$T.row.productname}</td>
						<td>{$T.row.productsize}</td>
						<td align="center">{$T.row.productnum}</td>
						<td align="center">￥{$T.row.price}</td>
						<td>{$T.row.buyerdis}</td>
						<td style="text-align: right;">￥{$T.row.subtotal_txt}</td>
					</tr>
				{#/for}
			</tbody>
		</table>
	</div>
</div><br>
<div class="panel border-sub">
	<div class="panel-head">
		<strong>订单支付明细</strong>
	</div>
	<div id="myOrder" class="panel-body">
		<table class="table">
			<tbody>
				<tr>
					<td style="border-top: 0px solid #ddd;" widtd="100" align="left">支付流水单号</td>
					<td style="border-top: 0px solid #ddd;" widtd="100" align="left">应收款</td>
					<td style="border-top: 0px solid #ddd;" widtd="100" >实收款</td>
					<td style="border-top: 0px solid #ddd;" widtd="100" >支付类型</td>
					<td style="border-top: 0px solid #ddd;" widtd="100">首付款</td>
					<td style="border-top: 0px solid #ddd;" widtd="100">贷款额</td>
					<td style="border-top: 0px solid #ddd;" widtd="100">提交时间</td>
					<td style="border-top: 0px solid #ddd;" widtd="100">确认支付时间</td>
					<td style="border-top: 0px solid #ddd;" widtd="100">支付状态</td>
					<td style="border-top: 0px solid #ddd;" widtd="100">描述</td>
				</tr>
					<tr class="tr">
						<td align="left">{$T.income.billno}</td>
						<td>￥{$T.income.account_receivable}</td>
						<td>￥{$T.income.account_real}</td>
						<td>{$T.income.trantypetxt}</td>
						<td>{$T.income.downpayment}</td>
						<td>{$T.income.loan_amount}</td>
						<td>{$T.income.createtime}</td>
						<td>{$T.income.banktime}</td>
						<td>
							{#if $T.income.status == -1}
								支付失败
							{#elseif $T.income.status == 0}
								未支付
							{#elseif $T.income.status == 1}
								支付回执成功
							{#elseif $T.income.status == 2}
								分期回执成功
							{#/if}
						</td>
						<td >{$T.income.remarks}</td>
					</tr>
			</tbody>
		</table>
	</div>
</div>
