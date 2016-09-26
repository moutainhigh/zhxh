<table class="table table-bordered table-hover text-small">
	<tbody>
		<tr class="panel-head">
			<th width="160">品牌</th>
			<th width="*">商品名称</th>
			<th width="160">规格</th>
			<th width="160">数量</th>
			<th width="100">单价</th>
			<th width="100">折扣</th>
			<th width="180">小计</th>
		</tr>
		{#foreach $T as row}
		<tr class="tr" id="{$T.row.id}">
			<td>{$T.row.brandname}</td>
			<td style="text-align: left;">{$T.row.productname}</td>
			<td>{$T.row.productsize}</td>
			<td>{$T.row.quantity}</td>
			<td style="text-align: right;">￥{$T.row.price}</td>
			<td>{$T.row.buyerdis}</td>
			<td style="text-align: right;">￥{$T.row.subtotal}</td>
		</tr>
		{#/for}
	</tbody>
</table>