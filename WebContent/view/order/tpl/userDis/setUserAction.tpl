<table class="table table-bordered table-hover text-small">
	<tbody>
		<tr class="panel-head item">
			<th width="45" align="center"></th>
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
					<td>{$T.row$index+1}</td>
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
						<button class="button button-small border-sub" onclick="showUserList()">返回</button>
					</td>
				</tr>
			{#/for}
		{#else}
			<tr class="tr" style="height:150px;">
				<td align="center" colspan="15">还没有数据...</td>
			</tr>
		{#/if}
		
	</tbody>
</table>