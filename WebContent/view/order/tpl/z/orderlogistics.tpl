<table class="table table-hover">
	<tbody><tr>
		<th style="text-align: left;" width="180">处理时间</th>
		<th style="text-align: left;" width="*">处理信息</th>
	</tr>
	{#foreach $T as row}
		<tr>
			<td style="text-align: left;">{$T.row.handletime}</td>
			<td style="text-align: left;">{$T.row.handleresult}</td>
		</tr>
	{#/for}
</tbody></table>