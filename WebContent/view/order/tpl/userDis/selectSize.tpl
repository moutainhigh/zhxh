
<table class="table table-bordered table-hover text-small userBrand">
	<tbody>
		<tr class="panel-head item">
			<th width="45" align="center"><input type="checkbox" value="1" name="checkall"></th>
			<th width="45">序号</th>
			<th width="50">图片</th>
			<th width="350">商品名称</th>
			<th width="100">规格标准</th>
			<th width="100">单价</th>
			<th width="100">排序</th>
		</tr>
		{#if $P.rowCount > 0}
			{#foreach $T as row}
				<tr class="tr">
					<td align="center"><input type="checkbox" value="{$T.row.id}" name="row_id"></td>
					<td>{$T.row$index+1}</td>
					<td>{#if $T.row.productpic != ""}<img src="{$P.path}/{$T.row.productpic}" height="30px">{#/if}</td>
					<td>{$T.row.productname}</td>
					<td>{$T.row.productsize}</td>
					<td>{$T.row.price}</td>
					<td>{$T.row.sizesort}</td>
				</tr>
			{#/for}
		{#else}
			<tr class="tr" style="height:150px;">
				<td align="center" colspan="7">没有数据...</td>
			</tr>
		{#/if}
		
	</tbody>
</table>
<table class="table table-bordered table-hover text-small" style="border: solid 0px #ddd;">
	<tfoot>
	<tr class="">
		<td width="45" align="center"></td>
		<td colspan="6" class="tr pr10" style="text-align:left" >
			
		</td>
		<td colspan="9" style="text-align:right" >
			<div class="page">
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
						<a href="javascript:void(0);" class="ui-pager-prev" onclick="pageClick({$P.pageIndex-1},'userBrand')">上一页</a>
					{#/if}
					{#if $P.pageIndex == $P.totalPage || $P.totalPage == 0}
						<a href="javascript:void(0);" class="ui-pager-next">下一页</a>
					{#else}
						<a href="javascript:void(0);" class="ui-pager-next" onclick="pageClick({$P.pageIndex + 1 },'userBrand')">下一页</a>
					{#/if}
					</div>
				</div>
			</div>
			<span class="page-total">共计：[{$P.rowCount}] 条</span>
		</td>
	</tr>
	</tfoot>
</table>
