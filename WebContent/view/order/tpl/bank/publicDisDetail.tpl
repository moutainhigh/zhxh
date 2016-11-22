<div id="details" style="display:none;">
	<div class="panel-head">
		<strong>账单明细</strong>
	</div>
	<div class="panel-body" style="display:none;">
	</div>
	<div class="table-responsive" style="padding:10px;">
		<table class="table table-hover">
			<thead><tr>
				<th>商品名称</th>
				<th>数量</th>
				<th>金额</th>
				<th>剩余数量</th>
				<th>日期</th>
				<th>订单号</th>
				<th>下单机构</th>
				<th>上级机构</th>
			</tr> </thead>
			<tbody>
			{#foreach $T as row}
				<tr>
					<td>{$T.row.productname}</td>
					<td align="center">{$T.row.detailsnum}</td>
					<td>￥{$P.formatAmount($T.row.detailspay)}</td>
					<td align="center">{$T.row.nextrebatesnum}</td>
					<td>{$T.row.createtime}</td>
					<td>{$T.row.ordernumber} </td>
					<td>{$T.row.ucompanyname}</td>
					<td>{$T.row.acompanyname}</td>
				</tr>
			{#/for}	
			</tbody>
		</table>
	</div>
</div>

