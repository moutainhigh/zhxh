
<div class="panel">
	<div class="panel border-sub">
		<div class="panel-head">
			<strong>我的采购商家</strong>
		</div>
		<div class="panel-body" id="">
			<table class="table">
				<tbody>
					<tr>
						<td style="border-top: 0px solid #ddd;" width="200">单位名称</td>
						<td style="border-top: 0px solid #ddd;">负责人</td>
						<td style="border-top: 0px solid #ddd;" width="200" align="right">操作</td>
					</tr>
					{#foreach $T as row}
						<tr>
							<td>{$T.row.companyname}</td>
							<td>{$T.row.username}</td>
							<td align="right"><a href="javascript:;" onclick="getParentDis('{$T.row.id}')" class="button border-blue button-small">查看采购利益</a></td>
						</tr>
					{#/for}
				</tbody>
			</table>
		</div>
	</div>
</div>
