package net.ussoft.zhxh.web.pc;

public class aa {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		//当前时间戳
		Long oldTime = System.currentTimeMillis();
		System.out.println(oldTime);
		Long oldTime2 = Long.valueOf("1472537174142");
				
		Long s = (System.currentTimeMillis() - oldTime2) / (1000 * 60);
		
		System.out.println(s);
	}

}
