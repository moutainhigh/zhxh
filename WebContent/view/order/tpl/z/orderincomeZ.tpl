<h4>支付信息</h4>
<hr class="">
<div class="table-responsive income" style="margin-bottom: 20px">
	<table class="table table-hover">
		<tbody>
			<tr>
				<th style="text-align: left;" width="180">支付流水单号</th>
				<th style="text-align: left;" width="180">应收款</th>
				<th style="text-align: left;" width="180">实收款</th>
				<th style="text-align: left;" width="180">支付类型</th>
				<th style="text-align: left;" width="180">首付款</th>
				<th style="text-align: left;" width="180">贷款额</th>
				<th style="text-align: left;" width="180">提交时间</th>
				<th style="text-align: left;" width="180">确认支付时间</th>
				<th style="text-align: left;" width="180">支付状态</th>
				<th style="text-align: left;" width="180">描述</th>
			</tr>
			<tr>
				<td style="text-align: left;">{$T.income.billno}</td>
				<td style="text-align: left;">{$T.income.account_receivable}</td>
				<td style="text-align: left;">{$T.income.account_real}</td>
				<td style="text-align: left;">{$T.income.trantypetxt}</td>
				<td style="text-align: left;">{$T.income.downpayment}</td>
				<td style="text-align: left;">{$T.income.loan_amount}</td>
				<td style="text-align: left;">{$T.income.createtime}</td>
				<td style="text-align: left;">{$T.income.banktime}</td>
				<td style="text-align: left;">
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
				<td style="text-align: left;">{$T.income.remarks}</td>
			</tr>
		</tbody>
	</table>
</div>
<h4>参与分配利润机构详细</h4>
<hr class="">
<div class="table-responsive" style="margin-bottom: 20px">
	<table class="table table-hover">
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
<h4>订单商品分配利润明细</h4>
<hr class="">
<div class="table-responsive" style="margin-bottom: 20px">
	<table class="table table-hover">
		<tbody>
			<tr>
				<td style="border-top: 0px solid #ddd;" widtd="100" align="center">序号</td>
				<td style="border-top: 0px solid #ddd;" widtd="100" align="left">品牌</td>
				<td style="border-top: 0px solid #ddd;" widtd="*" align="left">商品名称</td>
				<td style="border-top: 0px solid #ddd;" widtd="80">规格</td>
				<td style="border-top: 0px solid #ddd;" widtd="100" align="center">数量</td>
				<td style="border-top: 0px solid #ddd;" widtd="100" align="center">单价</td>
				<td style="border-top: 0px solid #ddd;" widtd="100" align="center">小计</td>
				<td style="border-top: 0px solid #ddd;" widtd="100" align="left">分润明细</td>
			</tr>
			{#foreach $T.products as row}
				<tr class="tr">
					<td align="center">{$T.row$index+1}</td>
					<td>{$T.row.brandname}</td>
					<td style="text-align: left;">{$T.row.productname}</td>
					<td>{$T.row.productsize}</td>
					<td align="center">{$T.row.productnum}</td>
					<td align="center">￥{$T.row.price}</td>
					<td align="center">￥{$T.row.price*$T.row.productnum}</td>
					<td align="left">{$T.row.sharevalue}</td>
				</tr>
			{#/for}
		</tbody>
	</table>
</div>

