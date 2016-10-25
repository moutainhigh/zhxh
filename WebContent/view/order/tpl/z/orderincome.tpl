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
			<td style="text-align: left;">{$T.billno}</td>
			<td style="text-align: left;">{$T.account_receivable}</td>
			<td style="text-align: left;">{$T.account_real}</td>
			<td style="text-align: left;">{$T.trantypetxt}</td>
			<td style="text-align: left;">{$T.downpayment}</td>
			<td style="text-align: left;">{$T.loan_amount}</td>
			<td style="text-align: left;">{$T.createtime}</td>
			<td style="text-align: left;">{$T.stagesbanktime}</td>
			<td style="text-align: left;">
				{#if $T.status == -1}
					支付失败
				{#elseif $T.status == 0}
					未支付
				{#elseif $T.status == 1}
					支付回执成功
				{#elseif $T.status == 2}
					分期回执成功
				{#/if}
			</td>
			<td style="text-align: left;">{$T.remarks}</td>
		</tr>
	</tbody>
</table>