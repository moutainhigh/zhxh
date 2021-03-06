
<table class="table table-bordered table-hover text-small update">
	<tbody>
		<tr class="panel-head item">
			<th width="45" align="center"><input type="checkbox" value="1" name="checkall"></th>
			<th width="45">序号</th>
			<th width="80">姓名</th>
			<th width="100">手机号码</th>
			<th width="80">生日</th>
			<th width="50">性别</th>
			<th width="60">身份</th>
			{#if $P.radio_value == 'A' || $P.radio_value == 'C'}
			<th width="150">客户名称</th>
			<th width="200">客户地址</th>
			<th width="100">客户代码</th>
			<th width="120">客户级别</th>
			<th width="80">接收分成</th>
			{#elseif $P.radio_value == 'Z'}
			<th width="100">所属机构代码</th>
			{#/if}
			{#if $P.radio_value == "C"}
			<th width="150">推荐人</th>
			{#/if}
			<th width="80">微信号码</th>
			<th width="50">状态</th>
			<th width="50">排序</th>
			<th width="160">操作</th>
		</tr>
		{#if $P.rowCount > 0}
			{#foreach $T as row}
				<tr class="tr">
					<td align="center"><input type="checkbox" value="{$T.row.id}" name="row_id"></td>
					<td>{($T.row$index+1)+($P.pageIndex * $P.pageSize - $P.pageSize)}</td>
					<td>{$T.row.username}</td>
					<td>{$T.row.phonenumber}</td>
					<td>{$T.row.birthday}</td>
					<td>{#if $T.row.sex == 1}男{#else}女{#/if}</td>
					<td>{$T.row.identitymemo}</td>
					{#if $P.radio_value == 'A' || $P.radio_value == 'C'}
					<td>{$T.row.companyname}</td>
					<td>{$T.row.companypath}</td>
					<td>{$T.row.companycode}</td>
					<td>{$T.row.rank}</td>
					<td id="td_setreturn" v="{$T.row.setreturn}" onmouseover="td_tip(this)" onmouseout="td_tip_over(this)">{#if $T.row.setreturn == 1}正常{#else}<span style="color:red">禁用</span>{#/if}</td>
					{#elseif $P.radio_value == 'Z'}
					<td>{$T.row.belongcode}</td>
					{#/if}
					{#if $P.radio_value == "C"}
					<td>{$T.row.tuijianman}</td>
					{#/if}
					<td>{$T.row.wechar}</td>
					<td id="td_state" v="{$T.row.isopen}" onmouseover="td_tip(this)" onmouseout="td_tip_over(this)">{#if $T.row.isopen == 1}正常{#else}<span style="color:red">禁用</span>{#/if}</td>
					<td>{$T.row.sort}</td>
					<td>
						{#if $T.row.id != "1"}
						<button class="button button-small border-sub" onclick="return setUserDis('{$T.row.id}')">设置客户利益</button>
						{#/if}
					</td>
				</tr>
			{#/for}
		{#else}
			<tr class="tr" style="height:150px;">
				<td align="center" colspan="{#if $P.radio_value == 'C'}17{#elseif $P.radio_value == 'A'}16{#else}12{#/if}">还没有数据...</td>
			</tr>
		{#/if}
		
	</tbody>
</table>
<table class="table table-bordered table-hover text-small" style="border: solid 0px #ddd;">
	<tfoot>
	<tr class="">
		<td width="45" align="center"><input type="checkbox" value="0" name="checkall"></td>
		<td colspan="6" class="tr pr10" style="text-align:left" >
			<a class="batch-op batchActivate" href="javascript:void(0)" onclick="updatebatch(1,'isopen')">批量设置</a>
		</td>
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
						<a href="javascript:void(0);" class="ui-pager-prev" onclick="pageClick({$P.pageIndex-1},'userList')">上一页</a>
					{#/if}
					{#if $P.pageIndex == $P.totalPage || $P.totalPage == 0}
						<a href="javascript:void(0);" class="ui-pager-next">下一页</a>
					{#else}
						<a href="javascript:void(0);" class="ui-pager-next" onclick="pageClick({$P.pageIndex + 1 },'userList')">下一页</a>
					{#/if}
					</div>
				</div>
			</div>
			<span class="page-total">共计：[{$P.rowCount}] 条</span>
		</td>
	</tr>
	</tfoot>
</table>