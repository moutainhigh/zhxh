<table class="table">
	<tbody>
		{#if $P.rowCount > 0}
			{#foreach $T as row}
			<tr>
				<td style="border-top: 0px solid #ddd;"><a href="javascript:;" title="{$T.row.messagetxt}" onclick="showMessage('{$T.row.id}')">[<span style="color: red">{$T.row.sendname}</span>] {#if $T.row.messagetxt.length > 20}{$T.row.messagetxt.substring(0,20)}...{#else}{$T.row.messagetxt}{#/if}</a></td>
				<td style="border-top: 0px solid #ddd;" width="200" align="right">{$T.row.messagetime}</td>
			</tr>
			{#/for}
		{#else}
			<tr class="tr" style="height:150px;">
				<td align="center" colspan="2">还没有数据...</td>
			</tr>
		{#/if}
	</tbody>
</table>