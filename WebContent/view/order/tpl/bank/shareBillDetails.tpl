<div id="details" style="display:none;">
	<div class="panel-head">
		<strong>分润-账单明细</strong>
	</div>
	<div class="panel-body" style="display:none;">
	</div>
	<div class="table-responsive" style="padding:10px;">
		<table class="table table-hover">
			<thead><tr>
				<th>品牌</th>
				<th>商品</th>
				<th>规格</th>
				<th>单价</th>
				<th>数量</th>
				<th>分润金额</th>
			</tr> </thead>
			<tbody>
			{#foreach $T as row}
				<tr>
					<td>{$T.row.brandname}</td>
					<td>{$T.row.productname}</td>
					<td>{$T.row.productsize} </td>
					<td>￥{$P.formatAmount($T.row.price)}</td>
					<td>{$T.row.productnum}</td>
					<td>￥{$P.formatAmount($T.row.skey)}</td>
				</tr>
			{#/for}	
			</tbody>
		</table>
	</div>
</div>
