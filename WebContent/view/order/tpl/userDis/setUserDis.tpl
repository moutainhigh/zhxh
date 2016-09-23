<table class="table table-bordered table-hover text-small">
	<tbody>
		<tr class="panel-head item">
			<th width="45" align="center"></th>
			<th width="45">序号</th>
			<th width="50">图片</th>
			<th width="150">设置者</th>
			<th width="100">被设置者</th>
			<th width="150">机构名称</th>
			<th width="100">品牌</th>
			<th width="150">商品名称</th>
			<th width="60">规格标准</th>
			<th width="60">售价</th>
			<th width="60">采购折扣</th>
			<th width="60">返利标准</th>
			<th width="60">奖励标准</th>
			<th width="60">状态</th>
			<th width="80">操作</th>
		</tr>
		{#if $P.rowCount > 0}
			{#foreach $T as row}
				<tr class="tr">
					<td align="center"><input type="checkbox" value="{$T.row.id}" name="row_id"></td>
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
					<td>{$T.row.rebatesdis}</td>
					<td>{$T.row.bonusesdis}</td>
					<td>{#if $T.row.state==0}<span style="color:red">禁止采购</span>{#else}可采购{#/if}</td>
					<td>
						<button class="button button-small border-sub" onclick="showUserList()">{$T$total}</button>
					</td>
				</tr>
			{#/for}
		{#else}
			<tr class="tr" style="height:150px;">
				<td align="center" colspan="16">还没有数据...{$P.rowCount}</td>
			</tr>
		{#/if}
		
	</tbody>
</table>