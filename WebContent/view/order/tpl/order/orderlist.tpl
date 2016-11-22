
<table class="table table-bordered table-hover text-small update">
	<tbody>
		<tr class="panel-head item">
			<!-- th width="30" align="center"><input type="checkbox" value="1" name="id"></th -->
			<th width="4%">序号</th>
			<th width="*">上级机构</th>
			<th width="10%">单号</th>
			<th width="10%">下单时间</th>
			<th width="10%">签收时间</th>
			<th width="9%">金额</th>
			<th width="8%">状态</th>
			<th width="20%">操作</th>
		</tr>
		{#if $P.rowCount > 0}
			{#foreach $T as row}
				<tr class="tr">
					<!-- td align="center"><input type="checkbox" value="1" name="id"></td -->
					<td>{$T.row$index+1}</td>
					<td style="text-align:left">{$T.row.p_compname}</td>
					<td>{$T.row.ordernumber}</td>
					<td>{$T.row.ordertime}</td>
					<td>{$T.row.signtime}</td>
					<td style="text-align: right;">￥{$P.formatAmount($T.row.ordertotal)}</td>
					<td><span class="tag bg-order{$T.row.orderstatus}">{$T.row.orderstatusmemo}</span></td>
					<td><button class="button button-small border-blue" onclick="orderdetails('{$T.row.id}')">订单详情</button>
						{#if $T.row.orderstatus == 0}
							<button class="button button-small border-green" onclick="topayment('{$T.row.id}')">立即支付</button>
							<button class="button button-small border-red" onclick="delorder('{$T.row.id}')">删除</button>
						{#elseif $T.row.orderstatus == 1}
							<button class="button button-small border-red" onclick="cancleorder('{$T.row.id}')">取消订单</button>
						{#elseif $T.row.orderstatus == 2}
							<button class="button button-small border-blue" onclick="signorder('{$T.row.id}')">确认收货</button>
						{#/if}
					</td>
				</tr>
			{#/for}
		{#else}
			<tr class="tr" style="height:150px;">
				<td align="center" colspan="9">还没有数据...</td>
			</tr>
		{#/if}
		
	</tbody>
</table>
<table class="table table-bordered table-hover text-small" style="border: solid 0px #ddd;">
	<tfoot>
	<tr class="">
		<td colspan="9" style="text-align:right" >
			<div class="page">
				<span>每页显示</span>
				<select class="pageSel">
					<option {#if $P.pageSize == 10}selected{#/if}  value="10">10</option>
					<option {#if $P.pageSize == 50}selected{#/if}  value="50">50</option>
					<option {#if $P.pageSize == 100}selected{#/if}  value="100">100</option>
				</select>
				<span>条</span>
				<div class="page-number">
					<span>第</span>
					<input class="ui-pager-inp" type="text" value="{$P.pageIndex}"> 
					<span>页</span>
					<span>共</span>
					<span class="totalPage">{$P.totalPage}</span>
					<span>页</span>
					<div class="pn">
					{#if $P.pageIndex == 1}
						<a href="javascript:void(0);" class="ui-pager-prev">上一页</a>
					{#else}
						<a href="javascript:void(0);" class="ui-pager-prev" onclick="pageClick({$P.pageIndex-1})">上一页</a>
					{#/if}
					{#if $P.pageIndex == $P.totalPage || $P.totalPage == 0}
						<a href="javascript:void(0);" class="ui-pager-next">下一页</a>
					{#else}
						<a href="javascript:void(0);" class="ui-pager-next" onclick="pageClick({$P.pageIndex + 1 })">下一页</a>
					{#/if}
					</div>
				</div>
			</div>
			<span class="page-total">共计：[{$P.rowCount}] 条</span>
		</td>
	</tr>
	</tfoot>
</table>