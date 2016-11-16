<table class="table table-bordered table-hover text-small userDis">
	<tbody>
		<tr class="panel-head item">
			<th width="45" align="center"><input type="checkbox" value="1" name="checkall_dis"></th>
			<th width="45">序号</th>
			<th width="50">图片</th>
			<th width="150">设置者</th>
			<th width="100">被设置者</th>
			<th width="180">机构名称</th>
			<th width="100">品牌</th>
			<th width="150">商品名称</th>
			<th width="60">规格标准</th>
			<th width="60">单价</th>
			<th width="60">采购折扣</th>
			{#if $P.radio_value == 'C'}
			<th width="60">返利标准</th>
			<th width="60">奖励标准</th>
			{#/if}
			<th width="60">状态</th>
		</tr>
		{#if $P.rowCount > 0}
			{#foreach $T as row}
				<tr class="tr">
					<td align="center"><input type="checkbox" value="{$T.row.id}" name="row_id_dis"></td>
					<td>{$T.row$index+1}</td>
					<td>{#if $T.row.productpic != ""}<img src="{$P.path}{$T.row.productpic}" height="30px" />{#/if} </td>
					<td>{$T.row.parentname}</td>
					<td>{$T.row.username}</td>
					<td>{$T.row.companyname}</td>
					<td>{$T.row.brandname}</td>
					<td>{$T.row.productname}</td>
					<td>{$T.row.productsize}</td>
					<td>{$T.row.price}</td>
					<td>{$T.row.buyerdis}</td>
					{#if $P.radio_value == 'C'}
					<td>{$T.row.rebatesdis}</td>
					<td>{$T.row.bonusesdis}</td>
					{#/if}
					<td>{#if $T.row.state==0}<span style="color:red">禁止采购</span>{#else}可采购{#/if}</td>
				</tr>
			{#/for}
		{#else}
			<tr class="tr" style="height:150px;">
				<td align="center" colspan="{#if $P.radio_value == 'C'}14{#else}12{#/if}">还没有数据...首先选择品牌再添加商品采购利益标准</td>
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
						<a href="javascript:void(0);" class="ui-pager-prev" onclick="pageClick({$P.pageIndex-1},'userDis')">上一页</a>
					{#/if}
					{#if $P.pageIndex == $P.totalPage || $P.totalPage == 0}
						<a href="javascript:void(0);" class="ui-pager-next">下一页</a>
					{#else}
						<a href="javascript:void(0);" class="ui-pager-next" onclick="pageClick({$P.pageIndex + 1 },'userDis')">下一页</a>
					{#/if}
					</div>
				</div>
			</div>
			<span class="page-total">共计：[{$P.rowCount}] 条</span>
		</td>
	</tr>
	</tfoot>
</table>