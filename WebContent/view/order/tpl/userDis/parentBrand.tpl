
<div class="table-responsive-y">
	<table class="table table-hover">
		<thead>
		<tr class="">
			<th width="45">序号</th>
			<th width="80">品牌Logo</th>
			<th width="*">品牌名称</th>
			<th width="100">操作</th>
		</tr>
		</thead>
		<tbody>
		{#if $P.rowCount > 0}
			{#foreach $T as row}
				<tr class="tr">
					<td style="line-height: 30px;">{($T.row$index+1)+($P.pageIndex * $P.pageSize - $P.pageSize)}</td>
					<td>{#if $T.row.brandlogo != ""}<img src="{$P.path}/{$T.row.brandlogo}" height="30px">{#/if}</td>
					<td style="line-height: 30px;">{$T.row.brandname}</td>
					<td><a href="javascript:;" onclick="getUserDis('{$T.row.id}')" class="button border-blue button-small">查看商品</a></td>
				</tr>
			{#/for}
		{#else}
			<tr class="tr" style="height:150px;">
				<td align="center" colspan="5">暂无数据...</td>
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
					<select id="pageBrandSel" class="pageSel">
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
							<a href="javascript:void(0);" class="ui-pager-prev" onclick="pageClick({$P.pageIndex-1},'brand')">上一页</a>
						{#/if}
						{#if $P.pageIndex == $P.totalPage || $P.totalPage == 0}
							<a href="javascript:void(0);" class="ui-pager-next">下一页</a>
						{#else}
							<a href="javascript:void(0);" class="ui-pager-next" onclick="pageClick({$P.pageIndex + 1 },'brand')">下一页</a>
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
