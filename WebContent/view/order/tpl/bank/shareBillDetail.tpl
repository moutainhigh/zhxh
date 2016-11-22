<div class="table-responsive-y">
	<table class="table table-hover">
		<thead><tr>
			<th>订单ID</th>
			<th>下单机构</th>
			<th>分润金额</th>
			<th>分润数量</th>
			<th>记账日期</th>
			<th>状态</th>
			<th>操作</th>
		</tr> </thead>
		<tbody>
		{#if $P.rowCount > 0}
			{#foreach $T as row}
				<tr>
					<td>{$T.row.ordernumber}</td>
					<td>{$T.row.submitname}</td>
					<td>￥{$P.formatAmount($T.row.sharepay)} </td>
					<td>{$T.row.sharenumber} </td>
					<td>{$T.row.sharetime}</td>
					<td>{#if $T.row.sharestate == 0}等待分润{#else}分润完成{#/if}</td>
					<td><a href="javascript:;" onclick="shareDetails('{$P.userid}','{$T.row.orderproductids}')">详情</a>
					</td>
				</tr>
			{#/for}	
		{#else}
			<tr class="tr" style="height:150px;">
				<td align="center" colspan="7">暂无数据...</td>
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
							<a href="javascript:void(0);" class="ui-pager-prev" onclick="pageClick({$P.pageIndex-1},5)">上一页</a>
						{#/if}
						{#if $P.pageIndex == $P.totalPage || $P.totalPage == 0}
							<a href="javascript:void(0);" class="ui-pager-next">下一页</a>
						{#else}
							<a href="javascript:void(0);" class="ui-pager-next" onclick="pageClick({$P.pageIndex + 1 },5)">下一页</a>
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
