package com.goisan.system.tools;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.bean.CommonBean;
import com.goisan.system.bean.LoginLog;
import com.goisan.system.bean.LoginUser;
import com.goisan.system.service.DeptService;
import com.goisan.system.service.EmpService;
import com.goisan.system.service.LoginUserService;
import com.goisan.system.service.impl.DeptServiceImpl;
import com.goisan.system.service.impl.EmpServiceImpl;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.shiro.SecurityUtils;
import sun.misc.BASE64Decoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.net.InetAddress;
import java.net.InterfaceAddress;
import java.net.NetworkInterface;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by Admin on 2017/4/21.
 */
public class CommonUtil {

    private static EmpService empService = new EmpServiceImpl();
    private static DeptService deptService = new DeptServiceImpl();
    private static Pattern pattern = Pattern.compile("\\d+$");

    public static Set<String> getUserRole() {
        return ((LoginUser) SecurityUtils.getSubject().getPrincipal()).getRoles();
    }

    public static LoginUser getLoginUser() {
        return (LoginUser) SecurityUtils.getSubject().getPrincipal();
    }

    public static java.sql.Timestamp getDate() {
        return new Timestamp(new java.util.Date().getTime());
    }

    public static String getnextId(String maxChildId, String pId) {
        if (maxChildId == null || "".equals(maxChildId)) {
            if ("0".equals(pId)) {
                return "001";
            } else {
                return pId + "001";
            }
        } else if ("0".equals(pId)) {
            int nextid = Integer.parseInt(maxChildId);
            nextid++;
            if (nextid < 10) {
                return "00" + nextid;
            } else if (nextid < 100) {
                return "0" + nextid;
            } else {
                return "" + nextid;
            }
        } else {
            int nextid = Integer.parseInt(maxChildId.substring(maxChildId.length() - 3,
                    maxChildId.length()));
            nextid++;
            if (nextid < 10) {
                return pId + "00" + nextid;
            } else if (nextid < 100) {
                return pId + "0" + nextid;
            } else {
                return pId + +nextid;
            }
        }
    }

    public static String getFileType(String fileName) {
        String fileType = "1";
        if ("bmp、jpg、jpeg、png、gif".contains(getFileExt(fileName))) {
            fileType = "2";
        }
        if ("mp3 wma rm wav midi ape flac".contains(getFileExt(fileName))) {
            fileType = "3";
        }
        if (".avi.wmv.mpeg.mp4.mov.mkv.flv.f4v.m4v.rmvb.rm.3gp.dat.ts.mts.vob".contains(getFileExt(fileName))) {
            fileType = "4";
        }
        return fileType;
    }

    public static String getFileExt(String fileName) {
        return fileName.substring(fileName.lastIndexOf(".") + 1, fileName.length());
    }

    public static String getUUID() {
        return UUID.randomUUID().toString();
    }

    public static Map<String, List> tableMap(List list) {
        Map<String, List> map = new HashMap<String, List>();
        map.put("data", list);
        return map;
    }

    public static String getDefaultDept() {
        return ((LoginUser) SecurityUtils.getSubject().getPrincipal()).getDefaultDeptId();
    }

    public static String getUserAccount() {
        return ((LoginUser) SecurityUtils.getSubject().getPrincipal()).getUserAccount();
    }

    public static String getPersonId() {
        return ((LoginUser) SecurityUtils.getSubject().getPrincipal()).getPersonId();
    }

    public static String getPersonName() {
        return ((LoginUser) SecurityUtils.getSubject().getPrincipal()).getName();
    }

    public static String checkUserAccount(String userAccount, LoginUserService loginUserService) {
        String str = loginUserService.getUserAccount(userAccount);
        if (str == null || "".equals(str)) {
            return userAccount;
        } else {
            Matcher matcher = pattern.matcher(str);
            String[] strs = str.split("\\d+$");
            if (matcher.find()) {
                str = strs[0] + (Integer.parseInt(str.substring(strs[0].length(), str.length()))
                        + 1);
            } else {
                str += '1';
            }
            return checkUserAccount(str, loginUserService);
        }
    }

    //获取 IP，MAC
    public static LoginLog getIpAndMac(LoginLog loginLog, HttpServletRequest request) throws
            Exception {
        String ip = request.getHeader("X-Forwarded-For");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_CLIENT_IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        loginLog.setIp(ip);

/*
        String macAddress = "";
        macAddress = getMacInWindows(ip).trim();
        if (macAddress == null || "".equals(macAddress)) {
            macAddress = getMacInLinux(ip).trim();
        }
        loginLog.setMac(macAddress);
*/

        return loginLog;
    }

    public static String getMacInWindows(final String ip) {
        String result = "";
        String[] cmd = {
                "cmd",
                "/c",
                "ping " + ip
        };
        String[] another = {
                "cmd",
                "/c",
                "arp -a"
        };

        String cmdResult = "";
        String line = "";
        try {
            Runtime rt = Runtime.getRuntime();
            Process proc = rt.exec(cmd);
            proc.waitFor(); //已经执行完第一个命令，准备执行第二个命令
            proc = rt.exec(another);
            InputStreamReader is = new InputStreamReader(proc.getInputStream());
            BufferedReader br = new BufferedReader(is);
            while ((line = br.readLine()) != null) {
                cmdResult += line;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        result = "";
        String regExp = "((([0-9,A-F,a-f]{1,2}" + "-" + "){1,5})[0-9,A-F,a-f]{1,2})";
        Pattern pattern = Pattern.compile(regExp);
        Matcher matcher = pattern.matcher(cmdResult);
        while (matcher.find()) {
            result = matcher.group(1);
            if (cmdResult.indexOf(ip) <= cmdResult.lastIndexOf(matcher.group(1))) {
                break; //如果有多个IP,只匹配本IP对应的Mac.
            }
        }
        return result;
    }

    /**
     * @param ip           目标ip,一般在局域网内
     * @param sourceString 命令处理的结果字符串
     * @param macSeparator mac分隔符号
     * @return mac地址，用上面的分隔符号表示
     */
    public static String filterMacAddress(final String ip, final String sourceString, final
    String macSeparator) {
        String result = "";
        String regExp = "((([0-9,A-F,a-f]{1,2}" + macSeparator + "){1,5})[0-9,A-F,a-f]{1,2})";
        Pattern pattern = Pattern.compile(regExp);
        Matcher matcher = pattern.matcher(sourceString);
        while (matcher.find()) {
            result = matcher.group(1);
            if (sourceString.indexOf(ip) <= sourceString.lastIndexOf(matcher.group(1))) {
                break; //如果有多个IP,只匹配本IP对应的Mac.
            }
        }
        return result;
    }

    /**
     * @param ip 目标ip
     * @return Mac Address
     */
    public static String getMacInLinux(final String ip) {
        String result = "";
        String[] cmd = {
                "/bin/sh",
                "-c",
                "ping " + ip + " -c 2 && arp -a"
        };
        String cmdResult = "";
        String line = "";
        try {
            Process proc = Runtime.getRuntime().exec(cmd);
            InputStreamReader is = new InputStreamReader(proc.getInputStream());
            BufferedReader br = new BufferedReader(is);
            while ((line = br.readLine()) != null) {
                cmdResult += line;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        result = filterMacAddress(ip, cmdResult, ":");
        return result;
    }

    public static void save(BaseBean bean) {
        bean.setCreator(getPersonId());
        bean.setCreateTime(getDate());
        bean.setCreateDept(getDefaultDept());
    }

    public static void update(BaseBean bean) {
        bean.setChanger(getPersonId());
        bean.setChangeTime(getDate());
        bean.setChangeDept(getDefaultDept());
    }

    public static String jsonUtil(Object o) {
        ObjectMapper mapper = new ObjectMapper();
        String json = null;
        try {
            json = mapper.writeValueAsString(o);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        return json;
    }

    public static String now(String format) {
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        return sdf.format(new Date());
    }

    public static Timestamp formatData(String format, String date) {
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        Date time = null;
        try {
            time = sdf.parse(date);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return new Timestamp(time.getTime());
    }

    public static String formatData(String format, java.sql.Date date) {
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        String time = null;
        try {
            time = sdf.format(new Date(date.getTime()));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return time;
    }

    public static String changeToString(HSSFCell obj) {
        String str = "";
        if (null != obj) {
            str = obj.toString();
        }
        return str;
    }

    public static String doublechangeToString(HSSFCell obj) {
        String str = "";
        if (null != obj) {
            str = obj.toString();
            str = str.replace(" ", "");
        }
        if (str.equals(""))
            str = "0";
        return str;
    }

    public static String toStringHSSFRowObj(HSSFCell obj) {
        String str = "";
        if (null != obj) {
            str = obj.toString();
            str = str.replace(" ", "");
            if (str.equals(""))
                str = "0";
            str = new DecimalFormat("0.00").format(Double.parseDouble(str));
        }
        return str;
    }

    public static String toIdcardCheck(String Idcard) {
        Idcard = Idcard.replace(" ", "");
        Idcard = Idcard.substring(0, Idcard.length()).toUpperCase();
        return Idcard;
    }

    public static java.sql.Date formatExcelDate(String date) throws ParseException {
        String[] strs = date.split("-");
        if ("一月".equals(strs[1])) {
            strs[1] = "01";
        } else if ("二月".equals(strs[1])) {
            strs[1] = "02";
        } else if ("三月".equals(strs[1])) {
            strs[1] = "03";
        } else if ("四月".equals(strs[1])) {
            strs[1] = "04";
        } else if ("五月".equals(strs[1])) {
            strs[1] = "05";
        } else if ("六月".equals(strs[1])) {
            strs[1] = "06";
        } else if ("七月".equals(strs[1])) {
            strs[1] = "07";
        } else if ("八月".equals(strs[1])) {
            strs[1] = "08";
        } else if ("九月".equals(strs[1])) {
            strs[1] = "09";
        } else if ("十月".equals(strs[1])) {
            strs[1] = "10";
        } else if ("十一月".equals(strs[1])) {
            strs[1] = "11";
        } else if ("十二月".equals(strs[1])) {
            strs[1] = "12";
        }
        date = "";
        date += strs[0] + "-" + strs[1] + "-" + strs[2];
        SimpleDateFormat format = new SimpleDateFormat("dd-MM-yyyy", Locale.SIMPLIFIED_CHINESE);
        return new java.sql.Date(format.parse(date).getTime());

    }

    public static int changeToInteger(HSSFCell obj) {
        int str = 0;
        if (null != obj) {
            Float a = Float.parseFloat(String.valueOf(obj));
            str = Math.round(a);
        }
        return str;
    }

    public static boolean generateImage(String imgStr, String path) {
        if (imgStr == null) {
            return false;
        }
        BASE64Decoder decoder = new BASE64Decoder();
        OutputStream out = null;
        byte[] b = new byte[0];
        try {
            out = new FileOutputStream(new File(path));
            b = decoder.decodeBuffer(imgStr);
            out.write(b);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                out.flush();
                out.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return true;
    }

    public static String getprojectName() {
        String xxmc= CommonBean.getParamValue("SZXXMC");
        return xxmc;
    }

    public static String getLoginPhotoUrl(LoginUser loginUser, String path) {
        if (null == loginUser.getPhotoUrl() || "".equals(loginUser.getPhotoUrl())) {
            return "dmitry_b.jpg";
        } else {
            String uploadFilePath = new File(path).getParentFile().getParent()
                    .toString();
            uploadFilePath += "/userImg/" + loginUser.getPersonId();//+"."+type;
            File tempFile = new File(uploadFilePath);
            if (tempFile.exists()) {
                return loginUser.getPhotoUrl();
            } else {
                return "dmitry_b.jpg";
            }
        }
    }

    public static String getRemoteAddr(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_CLIENT_IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        return ip;
    }

    public static String getFormUUIDBySession(HttpServletRequest request){

        HttpSession session = request.getSession();

        if(session != null){

            return (String)session.getAttribute("formToken");
        }

        return "";
    }

    public static String setFormUUIDToSession(HttpServletRequest request){

        String uuid = getUUID();
        HttpSession session = request.getSession();

        if(session != null){

            session.setAttribute("formToken",uuid);
        }

        return uuid;
    }

    /**因为一台机器不一定只有一个网卡呀，所以返回的是数组是很合理的**/
    public static List<String> getMacList() throws Exception {
        java.util.Enumeration<NetworkInterface> en = NetworkInterface.getNetworkInterfaces();
        StringBuilder sb = new StringBuilder();
        ArrayList<String> tmpMacList=new ArrayList<>();
        while(en.hasMoreElements()){
            NetworkInterface iface = en.nextElement();
            List<InterfaceAddress> addrs = iface.getInterfaceAddresses();
            for(InterfaceAddress addr : addrs) {
                InetAddress ip = addr.getAddress();
                NetworkInterface network = NetworkInterface.getByInetAddress(ip);
                if(network==null){continue;}
                byte[] mac = network.getHardwareAddress();
                if(mac==null){continue;}
                sb.delete( 0, sb.length() );
                for (int i = 0; i < mac.length; i++) {sb.append(String.format("%02X%s", mac[i], (i < mac.length - 1) ? "-" : ""));}
                tmpMacList.add(sb.toString());
            }        }
        if(tmpMacList.size()<=0){return tmpMacList;}
        /***去重，别忘了同一个网卡的ipv4,ipv6得到的mac都是一样的，肯定有重复，下面这段代码是。。流式处理1.8***/
        HashSet h = new HashSet(tmpMacList);
        tmpMacList.clear();
        tmpMacList.addAll(h);
//        List<String> unique = tmpMacList.stream().distinct().collect(Collectors.toList());
        return tmpMacList;
    }
//    public static void main(String[] args) throws Exception {
//        System.out.println("进行 multi net address 测试===》");
//        List<String> macs=getMacList();
//        System.out.println("本机的mac网卡的地址有："+macs);
//    }
}
