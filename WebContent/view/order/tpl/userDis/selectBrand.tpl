
<table class="table table-bordered table-hover text-small userBrand">
	<tbody>
		<tr class="panel-head item">
			<th width="45" align="center"><input type="checkbox" value="1" name="checkall"></th>
			<th width="45">序号</th>
			<th width="80">品牌Logo</th>
			<th width="*">品牌名称</th>
		</tr>
		{#if $P.rowCount > 0}
			{#foreach $T as row}
				<tr class="tr">
					<td align="center"><input type="checkbox" value="{$T.row.id}" name="row_id"></td>
					<td>{($T.row$index+1)}</td>
					<td>{#if $T.row.brandlogo != ""}<img src="{$P.path}/{$T.row.brandlogo}" height="30px">{#/if}</td>
					<td>{$T.row.brandname}</td>
				</tr>
			{#/for}
		{#else}
			<tr class="tr" style="height:150px;">
				<td align="center" colspan="4">还没有数据...请先添加品牌</td>
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
			<span class="page-total">共计：[{$P.rowCount}] 条</span>
		</td>
	</tr>
	</tfoot>
</table>
