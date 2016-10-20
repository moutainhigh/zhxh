<table class="table">
	<tbody>
		<tr>
			<td style="border-top: 0px solid #ddd;" width="200"></td>
			{#if $P.id == '1'}
			<td style="border-top: 0px solid #ddd;" width="100">客户订货单</td>
			<td style="border-top: 0px solid #ddd;" width="100" align="center">订货金额</td>
			<td style="border-top: 0px solid #ddd;" width="100">普通会员订货单</td>
			<td style="border-top: 0px solid #ddd;" width="100" align="center">订货金额</td>
			{#else}
			<td style="border-top: 0px solid #ddd;">订货单</td>
			<td style="border-top: 0px solid #ddd;" width="200" align="right">订货金额</td>
			{#/if}
		</tr>
		<tr>
			<td align="center">今日</td>
			{#if $P.id == '1'}
			<td>{$T.day.num}笔</td>
			<td align="center">￥{$T.day.total}</td>
			<td>{$T.day.p_num}笔</td>
			<td align="center">￥{$T.day.p_total}</td>
			{#else}
			<td>{$T.day.num}笔</td>
			<td align="right">￥{$T.day.total}</td>
			{#/if}
		</tr>
		<tr>
			<td align="center">本月</td>
			{#if $P.id == '1'}
			<td>{$T.month.num}笔</td>
			<td align="center">￥{$T.month.total}</td>
			<td>{$T.month.p_num}笔</td>
			<td align="center">￥{$T.month.p_total}</td>
			{#else}
			<td>{$T.month.num}笔</td>
			<td align="right">￥{$T.month.total}</td>
			{#/if}
		</tr>
		<tr>
			<td align="center">本年</td>
			{#if $P.id == '1'}
			<td>{$T.year.num}笔</td>
			<td align="center">￥{$T.year.total}</td>
			<td>{$T.year.p_num}笔</td>
			<td align="center">￥{$T.year.p_total}</td>
			{#else}
			<td>{$T.year.num}笔</td>
			<td align="right">￥{$T.year.total}</td>
			{#/if}
		</tr>
	</tbody>
</table>
