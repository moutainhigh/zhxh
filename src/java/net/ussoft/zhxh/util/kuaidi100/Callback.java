package net.ussoft.zhxh.util.kuaidi100;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.ussoft.zhxh.util.kuaidi100.pojo.NoticeRequest;
import net.ussoft.zhxh.util.kuaidi100.pojo.NoticeResponse;
import net.ussoft.zhxh.util.kuaidi100.pojo.Result;
import net.ussoft.zhxh.util.kuaidi100.pojo.ResultItem;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 快钱100，订阅回调
 * */
@Controller
public class Callback {

	@RequestMapping(value="/kdcall/callback")
	public void callback(HttpServletRequest request,HttpServletResponse response) throws Exception {
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		NoticeResponse resp = new NoticeResponse();
		resp.setResult(false);
		resp.setReturnCode("500");
		resp.setMessage("保存失败");
		try {
			String param = request.getParameter("param");
			NoticeRequest nReq = JacksonHelper.fromJSON(param,
					NoticeRequest.class);

			Result result = nReq.getLastResult();
			// 处理快递结果
			ArrayList<ResultItem> list = result.getData();
			
			
			resp.setMessage("成功");
			resp.setResult(true);
			resp.setReturnCode("200");
			out.write(JacksonHelper.toJSON(resp)); //这里必须返回，否则认为失败，过30分钟又会重复推送。
		} catch (Exception e) {
			resp.setMessage("保存失败" + e.getMessage());
			out.write(JacksonHelper.toJSON(resp));//保存失败，服务端等30分钟会重复推送。
		}
	}
}
