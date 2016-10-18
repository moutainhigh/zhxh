<table class="table table-bordered table-hover text-small">
	<tbody>
		<tr class="panel-head item">
			<th width="45" align="center"><input type="checkbox" value="1" name="checkall"></th>
			<th width="45">序号</th>
			<th id="tip_username" width="*">姓名</th>
			<th width="150">手机号码</th>
			<th width="80">生日</th>
			<th width="100">性别</th>
			<th width="100">身份</th>
			<th width="150">所属机构代码</th>
			<th width="100">微信号码</th>
			<th width="80">状态</th>
			<th width="80">排序</th>
			<th width="200">操作</th>
		</tr>
		{#if $P.rowCount > 0}
			{#foreach $T as row}
				<tr class="tr" id="{$T.row.id}">
					<td align="center"><input type="checkbox" value="{$T.row.id}" name="row_id"></td>
					<td>{($T.row$index+1)+($P.pageIndex * $P.pageSize - $P.pageSize)}</td>
					<td class="u" editor="textbox" vtype="required;" field="username">{$T.row.username}</td>
					<td>{$T.row.phonenumber}</td>
					<td>{$T.row.birthday}</td>
					<td class="u" editor="combobox" editdate="[{'id':'0','text':'女'},{'id':'1','text':'男'}]" field="sex">{#if $T.row.sex == 1}男{#else}女{#/if}</td>
					<td>{$T.row.identitymemo}</td>
					<td>{$T.row.belongcode}</td>
					<td class="u" editor="textbox" vtype="" field="wechar">{$T.row.wechar}</td>
					<td id="td_state" v="{$T.row.isopen}" onmouseover="td_tip(this)" onmouseout="td_tip_over(this)">{#if $T.row.isopen == 1}正常{#else}<span style="color:red">禁用</span>{#/if}</td>
					<td class="u" editor="textbox" vtype="required;int" field="sort">{$T.row.sort}</td>
					<td>
						<a href="javascript:;" class="button button-small border-sub" onclick="return showUpdateUser('{$T.row.id}')">修改</a>
						<a id="newOrder" href="javascript:;" class="button button-small border-sub" onclick="addOrder('{$T.row.id}')">分期购</a>
						<a id="orderList" href="javascript:;" class="button button-small border-sub">历史订单</a>
					</td>
				</tr>
			{#/for}
		{#else}
			<tr class="tr" style="height:150px;">
				<td align="center" colspan="12">还没有数据...</td>
				
			</tr>
		{#/if}
		
	</tbody>
</table>
<table class="table table-bordered table-hover text-small" style="border: solid 0px #ddd;">
	<tfoot>
	<tr class="">
		<td align="center" width="45"><input type="checkbox" value="0" name="checkall"></td>
		<td colspan="4" class="tr pr10" style="text-align:left" >
			<a class="batch-op batchInactivate" href="javascript:void(0)" onclick="delbatch()">批量删除</a> | 
			<a class="batch-op batchInactivate" href="javascript:void(0)" onclick="reload()">刷新</a>
		</td>
		<td colspan="11" style="text-align:right" >
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