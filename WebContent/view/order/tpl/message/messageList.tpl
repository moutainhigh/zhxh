<table class="table table-bordered table-hover text-small">
	<tbody>
		<tr class="panel-head item">
			<th width="45" align="center"><input type="checkbox" value="1" name="checkall"></th>
			<th width="45">序号</th>
			<th width="100">发送者</th>
			<th width="100">接收者</th>
			<th width="80">消息分类</th>
			<th width="*">消息内容</th>
			<th width="60">状态</th>
			<th width="150">时间</th>
			<th width="100">操作</th>
		</tr>
		{#if $P.rowCount > 0}
			{#foreach $T as row}
				<tr class="tr" id="{$T.row.id}">
					<td align="center"><input type="checkbox" value="{$T.row.id}" name="row_id"></td>
					<td>{($T.row$index+1)+($P.pageIndex * $P.pageSize - $P.pageSize)}</td>
					<td>{$T.row.sendname}</td>
					<td>{$T.row.receivename}</td>
					<td>{#if $T.row.messagetype == 0}系统消息{#elseif $T.row.messagetype == 1}业务消息{#else}站内信{#/if}</td>
					<td>{$T.row.messagetxt}</td>
					<td>{#if $T.row.messagestate == 0}<span style="color:red">未读</span>{#else}已读{#/if}</td>
					<td>{$T.row.messagetime}</td>
					<td>
						{#if $T.row.messagestate == 0}
						<a href="javascript:;" class="button button-small border-sub" onclick="return setMessageState('{$T.row.id}')">已读</a>
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
		<td width="45" align="center"><input type="checkbox" value="0" name="checkall"></td>
		<td colspan="3" class="tr pr10" style="text-align:left" >
			<a class="batch-op batchActivate" href="javascript:void(0)" onclick="updatebatch(1,'messagestate')">批量已读</a> | 
			<a class="batch-op batchActivate" href="javascript:void(0)" onclick="delbatch()">批量删除</a> | 
			<a class="batch-op batchInactivate" href="javascript:void(0)" onclick="reload()">刷新</a>
		</td>
		<td colspan="5" style="text-align:right" >
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