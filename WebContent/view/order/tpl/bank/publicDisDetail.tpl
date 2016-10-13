
<div class="table-responsive-y">
	<table class="table table-hover">
		<thead><tr>
			<th>商品名称</th>
			<th>数量</th>
			<th>金额</th>
			<th>日期</th>
			<th>订单号</th>
			<th>机构名称</th>
		</tr> </thead>
		<tbody>
		{#if $P.rowCount > 0}
			{#foreach $T as row}
				<tr>
					<td>{$T.row.productname}</td>
					<td>{$T.row.detailsnum}</td>
					<td>{$T.row.detailspay}</td>
					<td>{$T.row.createtime}</td>
					<td>{$T.row.ordernumber} </td>
					<td>￥{$T.row.acompanyname}</td>
				</tr>
			{#/for}	
		{#else}
			<tr class="tr" style="height:150px;">
				<td align="center" colspan="6">暂无数据...</td>
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
							<a href="javascript:void(0);" class="ui-pager-prev" onclick="pageClick({$P.pageIndex-1},4)">上一页</a>
						{#/if}
						{#if $P.pageIndex == $P.totalPage || $P.totalPage == 0}
							<a href="javascript:void(0);" class="ui-pager-next">下一页</a>
						{#else}
							<a href="javascript:void(0);" class="ui-pager-next" onclick="pageClick({$P.pageIndex + 1 },4)">下一页</a>
						{#/if}
						</div>
					</div>
				</div>
				<span class="page-total">共计：[{$P.rowCount}] 条</span>
			</td>
		</tr>
		</tfoot>
	</table>
</div>
