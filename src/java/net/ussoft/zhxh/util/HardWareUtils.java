package net.ussoft.zhxh.util;
 
import java.io.BufferedReader;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.LineNumberReader;
 
public class HardWareUtils {
 
    /**
     * 获取主板序列号
     *
     * @return
     */
    public static String getMotherboardSN() {
        String result = "";
        try {
            File file = File.createTempFile("realhowto", ".vbs");
            file.deleteOnExit();
            FileWriter fw = new java.io.FileWriter(file);
 
            String vbs = "Set objWMIService = GetObject(\"winmgmts:\\\\.\\root\\cimv2\")\n"
                    + "Set colItems = objWMIService.ExecQuery _ \n"
                    + "   (\"Select * from Win32_BaseBoard\") \n"
                    + "For Each objItem in colItems \n"
                    + "    Wscript.Echo objItem.SerialNumber \n"
                    + "    exit for  ' do the first cpu only! \n" + "Next \n";
 
            fw.write(vbs);
            fw.close();
            Process p = Runtime.getRuntime().exec(
                    "cscript //NoLogo " + file.getPath());
            BufferedReader input = new BufferedReader(new InputStreamReader(
                    p.getInputStream()));
            String line;
            while ((line = input.readLine()) != null) {
                result += line;
            }
            input.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result.trim();
    }
 
    /**
     * 获取硬盘序列号
     *
     * @param drive
     *            盘符
     * @return
     */
    public static String getHardDiskSN(String drive) {
        String result = "";
        try {
            File file = File.createTempFile("realhowto", ".vbs");
            file.deleteOnExit();
            FileWriter fw = new java.io.FileWriter(file);
 
            String vbs = "Set objFSO = CreateObject(\"Scripting.FileSystemObject\")\n"
                    + "Set colDrives = objFSO.Drives\n"
                    + "Set objDrive = colDrives.item(\""
                    + drive
                    + "\")\n"
                    + "Wscript.Echo objDrive.SerialNumber"; // see note
            fw.write(vbs);
            fw.close();
            Process p = Runtime.getRuntime().exec(
                    "cscript //NoLogo " + file.getPath());
            BufferedReader input = new BufferedReader(new InputStreamReader(
                    p.getInputStream()));
            String line;
            while ((line = input.readLine()) != null) {
                result += line;
            }
            input.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result.trim();
    }
 
    /**
     * 获取CPU序列号
     *
     * @return
     */
    public static String getCPUSerial() {
        String result = "";
        try {
            File file = File.createTempFile("tmp", ".vbs");
            file.deleteOnExit();
            FileWriter fw = new java.io.FileWriter(file);
            String vbs = "Set objWMIService = GetObject(\"winmgmts:\\\\.\\root\\cimv2\")\n"
                    + "Set colItems = objWMIService.ExecQuery _ \n"
                    + "   (\"Select * from Win32_Processor\") \n"
                    + "For Each objItem in colItems \n"
                    + "    Wscript.Echo objItem.ProcessorId \n"
                    + "    exit for  ' do the first cpu only! \n" + "Next \n";
 
            // + "    exit for  \r\n" + "Next";
            fw.write(vbs);
            fw.close();
            Process p = Runtime.getRuntime().exec(
                    "cscript //NoLogo " + file.getPath());
            BufferedReader input = new BufferedReader(new InputStreamReader(
                    p.getInputStream()));
            String line;
            while ((line = input.readLine()) != null) {
                result += line;
            }
            input.close();
            file.delete();
        } catch (Exception e) {
            e.fillInStackTrace();
        }
        if (result.trim().length() < 1 || result == null) {
            result = "无CPU_ID被读取";
        }
        return result.trim();
    }
 
    /**
     * 获取MAC地址
     */
    public static String getMac() {
        String result = "";
        try {
 
            Process process = Runtime.getRuntime().exec("ipconfig /all");
 
            InputStreamReader ir = new InputStreamReader(
                    process.getInputStream());
 
            LineNumberReader input = new LineNumberReader(ir);
 
            String line;
 
            while ((line = input.readLine()) != null)
 
                if (line.indexOf("Physical Address") > 0) {
 
                    String MACAddr = line.substring(line.indexOf("-") - 2);
 
                    result = MACAddr;
 
                }
 
        } catch (java.io.IOException e) {
 
            System.err.println("IOException " + e.getMessage());
 
        }
        return result;
    }
    
    
    //===================linux
    
    /**
     * 获取LinuxCPU序列号
     *
     * @return
     */
    public static String getCPUSerialForLinux() {
        String result = "";
        try {
            String cmd = "dmidecode -t processor | grep 'ID'";
            result = RunLinuxCommand.runCommand(cmd, 1);
        } catch (Exception e) {
            e.fillInStackTrace();
        }
        if (result.trim().length() < 1 || result == null) {
            result = "无CPU_ID被读取";
        }
        return result.trim();
    }
    
    
    //============unit
    
    /**
	 * 获取unix网卡的mac地址.
	 * 
	 * @return mac地址
	 */
	public static String getUnixMACAddress() {
		String mac = null;
		BufferedReader bufferedReader = null;
		Process process = null;
		try {
			// unix下的命令一般取eth0 作为本地主网卡 显示信息中包含有MAC地址信息
			process = Runtime.getRuntime().exec("ifconfig eth0");

			bufferedReader = new BufferedReader(new InputStreamReader(
					process.getInputStream()));
			String line = null;
			int index = -1;
			while ((line = bufferedReader.readLine()) != null) {
				// 寻找标示字符串【hwaddr】物理网卡地址
				index = line.toLowerCase().indexOf("hwaddr");
				// 找到了地址
				if (index >= 0) {
					// 取出mac地址并去除两边空格
					mac = line.substring(index + "hwaddr".length() + 1).trim();

					break;
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (bufferedReader != null) {
					bufferedReader.close();
				}
			} catch (IOException e1) {
				e1.printStackTrace();
			}
			bufferedReader = null;
			process = null;
		}

		return mac;
	}
    
    
    //============mac os 
    /**
	 * mac os x Hardware UUID
	 * 
	 * @return UUID
	 */
	public static String getMacosxUUID() {
		String mac = null;
		BufferedReader bufferedReader = null;
		Process process = null;
		try {
			process = Runtime.getRuntime().exec(
					"system_profiler SPHardwareDataType");
			bufferedReader = new BufferedReader(new InputStreamReader(
					process.getInputStream()));
			String line = null;
			int index = -1;
			while ((line = bufferedReader.readLine()) != null) {
				index = line.toLowerCase().indexOf("hardware uuid");
				if (index >= 0) {
					mac = line.substring(index + "hardware uuid".length() + 1)
							.trim();
					break;
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (bufferedReader != null) {
					bufferedReader.close();
				}
			} catch (IOException e1) {
				e1.printStackTrace();
			}
			bufferedReader = null;
			process = null;
		}

		return mac;
	}
	
	/**
	 * 获取mac os网卡的mac地址.
	 * 
	 * @return mac地址
	 */
	public static String getMacosMACAddress() {
		String mac = null;
		BufferedReader bufferedReader = null;
		Process process = null;
		try {
			// mac os下的命令 一般取ether 作为本地主网卡 显示信息中包含有MAC地址信息
			process = Runtime.getRuntime().exec("/bin/sh -c ifconfig -a");

			bufferedReader = new BufferedReader(new InputStreamReader(
					process.getInputStream()));
			String line = null;
			int index = -1;
			while ((line = bufferedReader.readLine()) != null) {
				index = line.toLowerCase().indexOf("ether");
				if (index >= 0) {
					mac = line.substring(index + "ether".length() + 1).trim();

					break;
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (bufferedReader != null) {
					bufferedReader.close();
				}
			} catch (IOException e1) {
				e1.printStackTrace();
			}
			bufferedReader = null;
			process = null;
		}

		return mac;
	}
    
 
    public static void main(String[] args) throws Exception {
    	String os = System.getProperty("os.name").toLowerCase();
    	
    	if (os.startsWith("windows")) {
    		System.out.println("CPU  SN:" + HardWareUtils.getCPUSerial());
            System.out.println("主板  SN:" + HardWareUtils.getMotherboardSN());
            System.out.println("C盘   SN:" + HardWareUtils.getHardDiskSN("c"));
            System.out.println("MAC  SN:" + HardWareUtils.getMac());
		} else if (os.startsWith("linux") ) {
			System.out.println("CPU sn:" + HardWareUtils.getCPUSerialForLinux());
		} else if (os.startsWith("mac os x")) {
			System.out.println("硬盘 sn:" + getMacosxUUID());
			System.out.println("mac sn:" + getMacosMACAddress());
			
			EncryptionDecryption des = new EncryptionDecryption("jiqima");
			
			String jiqima = des.encrypt(getMacosxUUID());
			System.out.println("机器码：" + jiqima);
			
			String code = des.decrypt(jiqima);
//			String code = des.decrypt("181d986665ec7e3633bbf1ab18382672");
			System.out.println("解码的机器码：" + code);
			
			EncryptionDecryption des2 = new EncryptionDecryption("regist");
			String tmpCode = des2.encrypt(code);
			
			System.out.println("注册码：" + tmpCode);
			
			
			
			
			
		}
    	
        
    }
 
}