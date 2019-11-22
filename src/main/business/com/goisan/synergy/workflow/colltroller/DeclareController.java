package com.goisan.synergy.workflow.colltroller;

import com.goisan.synergy.workflow.bean.Declare;
import com.goisan.synergy.workflow.bean.DeclareApprove;
import com.goisan.synergy.workflow.service.DeclareApproveService;
import com.goisan.synergy.workflow.service.DeclareService;
import com.goisan.system.bean.Emp;
import com.goisan.system.bean.PathBean;
import com.goisan.system.service.EmpService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import com.goisan.system.tools.OperatorRTF;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class DeclareController {
@Resource
    private DeclareService declareService;
@Resource
private DeclareApproveService declareApproveService;
private EmpService empService;
    @RequestMapping("/declare/request")
    public ModelAndView DeclareList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/declare/declare");
        return mv;
    }

   
    @ResponseBody
    @RequestMapping("/declare/getDeclareList")
    public Map<String, List<Declare>> getDeclareList(Declare declare) {
        Map<String, List<Declare>> declareMap = new HashMap<String, List<Declare>>();
        declare.setCreator(CommonUtil.getPersonId());
        declare.setCreateDept(CommonUtil.getDefaultDept());
        declareMap.put("data", declareService.getDeclareList(declare));
        return declareMap;
    }

   
    @RequestMapping("/declare/editDeclare")
    public ModelAndView addDeclare() {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/declare/editDeclare");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date + 'T' + time;
        Declare declare = new Declare();
        Emp emp = declareService.getEmpByPersonId(CommonUtil.getPersonId());
        if (null == emp) {

        } else {
            declare.setIdcard(emp.getIdCard());
            declare.setTel(emp.getTel());
            declare.setName(emp.getName());
        }
        declare.setRequestDate(datetime);
        declare.setRequester(declareService.getPersonNameById(CommonUtil.getPersonId()));
        declare.setRequestDept(declareService.getDeptNameById(CommonUtil.getDefaultDept()));
        mv.addObject("head", "职称申报新增");
        mv.addObject("declare", declare);
        return mv;
    }

   
    @ResponseBody
    @RequestMapping("/declare/getDeclareById")
    public ModelAndView getDeclareById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/declare/editDeclare");
        mv.addObject("head", "职称申报修改");
        Declare leave = declareService.getDeclareById(id);
        mv.addObject("declare", leave);
        return mv;

    }

    
    @ResponseBody
    @RequestMapping("/declare/saveDeclare")
    public Message saveStudent(HttpServletRequest request, Declare declare,@RequestParam(value = "file", required = false) MultipartFile file) {
        byte[] bytes;
        String img = null;
        try {
            bytes = file.getBytes();
            BASE64Encoder encoder = new BASE64Encoder();
            img = encoder.encode(bytes);
        } catch (IOException e) {
            e.printStackTrace();
        }
        declare.setImg(img.replace("\\r|\\n", ""));
        if (declare.getId() == null || declare.getId().equals("")) {
            declare.setCreator(CommonUtil.getPersonId());
            declare.setCreateDept(CommonUtil.getDefaultDept());
            declare.setRequester(CommonUtil.getPersonId());
            declare.setId(CommonUtil.getUUID());
            declareService.insertDeclare(declare);
            return new Message(1, "新增成功！", null);
        } else {
            declare.setChanger(CommonUtil.getPersonId());
            declare.setChangeDept(CommonUtil.getDefaultDept());
            declareService.updateDeclareById(declare);
            return new Message(1, "修改成功！", null);
        }

    }

    /**
     * 删除
     */
    @ResponseBody
    @RequestMapping("/declare/deleteDeclareById")
    public Message deleteDeclareById(String id) {
        declareService.deleteDeclareById(id);
        return new Message(1, "删除成功！", null);

    }

    /**
     * 待办业务跳转
     */
    @RequestMapping("/declare/process")
    public ModelAndView leaveProcess() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/declare/declareProcess");
        return mv;
    }

    /**
     * 待办业务初始化
     */
    @ResponseBody
    @RequestMapping("/declare/getProcessList")
    public Map<String, List<Declare>> getProcessList(Declare declare) {
        Map<String, List<Declare>> declareMap = new HashMap<String, List<Declare>>();
        declare.setCreator(CommonUtil.getPersonId());
        declare.setCreateDept(CommonUtil.getDefaultDept());
        declare.setChanger(CommonUtil.getPersonId());
        declare.setChangeDept(CommonUtil.getDefaultDept());
        declareMap.put("data", declareService.getProcessList(declare));
        return declareMap;
    }


    /**
     * 已办业务跳转
     */

    @RequestMapping("/declare/complete")
    public ModelAndView leaveComplete() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/declare/declareComplete");
        return mv;
    }

    /**
     * 已办页面初始化
     */
    @ResponseBody
    @RequestMapping("/declare/getCompleteList")
    public Map<String, List<Declare>> getCompleteList(Declare declare) {
        Map<String, List<Declare>> declareMap = new HashMap<String, List<Declare>>();
        declare.setCreator(CommonUtil.getPersonId());
        declare.setCreateDept(CommonUtil.getDefaultDept());
        declare.setChanger(CommonUtil.getPersonId());
        declare.setChangeDept(CommonUtil.getDefaultDept());
        declareMap.put("data", declareService.getCompleteList(declare));
        return declareMap;
    }


    /**
     * 查看流程轨迹
     */
    @ResponseBody
    @RequestMapping("/declare/auditDeclareById")
    public ModelAndView waitRolById(String id) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/declare/addDeclareProcess");
        Declare declare = declareService.getLeaveBy(id);
        mv.addObject("head", "审批");
        mv.addObject("declare", declare);
        return mv;
    }


    /**
     * 导出
     *
     * @param
     * @param response
     * @throws
     */
    @ResponseBody
    @RequestMapping("/declare/exportInfo")
    public void exportInfo(HttpServletResponse response,String id,String tableName) {

        OperatorRTF operatorRTF = new OperatorRTF();
        OutputStream os = null;
        if (tableName == "T_BG_DECLARE_WF" || "T_BG_DECLARE_WF".equals(tableName)) {

            try {
                Declare declare = declareService.getLeaveBy(id);
            //String tname = cmap.get("b_name") + "考试申请-" + cmap.get("t_year") + "年 " + cmap.get("t_name") + ".rtf";
            String modcontent = operatorRTF.getModContent(PathBean.BASEPATH + File.separator + PathBean.TEMPLATE_PATH + File.separator  + "职称申报表.rtf");
                //*****************************************
                //替换模板标签
                HashMap m = new HashMap();
                m.put("arg1", declare.getName());
                m.put("arg2", declare.getSex());
                m.put("arg3", declare.getNation());
                m.put("arg4", declare.getBirthday() == null || "".equals(declare.getBirthday()) ? "" : declare.getBirthday().replaceAll("-","."));
                m.put("arg5", declare.getPoliticalStatus());
                m.put("arg6", declare.getIdcard());
                m.put("arg7", declare.getWorkTime() == null || "".equals(declare.getWorkTime()) ? "" : declare.getWorkTime().replaceAll("-","."));
                m.put("arg8", declare.getWorkDept());
                m.put("arg9", declare.getAdministrativePost());
                m.put("argA1", declare.getTechnicalPosition());
                m.put("argA2", declare.getAppointmentTime() == null || "".equals(declare.getAppointmentTime()) ? "" : declare.getAppointmentTime().replaceAll("-","."));
                m.put("argA3", declare.getAppliedLevel());
                m.put("argA4", declare.getMajorTime());
                m.put("argA5", declare.getAcademicDegree());
                m.put("argA6", declare.getEducationalLevel());
                m.put("argA7", declare.getSchool());
                m.put("argA8", declare.getMajor());
                m.put("argA9", declare.getGraduateTime() == null || "".equals(declare.getGraduateTime()) ? "" : declare.getGraduateTime().replaceAll("-","."));
                m.put("argB1", declare.getAcquisitionTime());
                m.put("argB2", declare.getOrganizationsPositions());
                m.put("argB3", declare.getAcademicTechnology());
                m.put("argB4", declare.getContinuingEducationTime()== null || "".equals(declare.getContinuingEducationTime()) ? "" : declare.getContinuingEducationTime().replaceAll("-","."));
                m.put("argB5", declare.getPostalAddress());
                m.put("argB6", declare.getPostCode());
                m.put("argB7", declare.getOfficePhone());
                m.put("argB8", declare.getTel());
                m.put("argB9", declare.getEmail());
                m.put("argC1", declare.getRepresentativeAchievements());

                String beginStr = "ffd8ffe000104a464946";
                String endStr = "028a28a0028a28a00ffd9";
                String head = "";
                String foot = "";
                GenerateImage(declare.getImg());
                declare.setImg(GenerateImage(declare.getImg()));
                StringBuffer restr = new StringBuffer();
                InputStream ins = null;

                //获取图片源码
                String filepath = declare.getImg();
                if(new File(filepath).exists()){
                    ins = new FileInputStream( filepath);
                    byte[] b = new byte[1638400];
                    int i =0;
                    restr = new StringBuffer();
                    while ((i = ins.read()) != -1) {
                        String str = i < 16 ? "0" + Integer.toHexString(i) : Integer
                                .toHexString(i);
                        restr.append(str);
                    }
                }

                //获得rtf替换后的源码
                String content = operatorRTF.getRgContent(modcontent, m);

//根据首尾标识 替换 图片
                head = content.substring(0, content.indexOf(beginStr));
                foot = content.substring(content.indexOf(endStr) + endStr.length(), content.length());
                content = head + restr.toString() + foot;
                response.setContentType("application/x-msdownload");
                response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode("职称申报表.rtf", "utf-8"));
                os = response.getOutputStream();
                os.write(content.getBytes());
                os.flush();
            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                try {
                    if (os != null) {
                        os.flush();
                        os.close();
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

        }else{

            try {
                DeclareApprove declareApprove = declareApproveService.getCancelById(id);
                //String tname = cmap.get("b_name") + "考试申请-" + cmap.get("t_year") + "年 " + cmap.get("t_name") + ".rtf";
                String modcontent = operatorRTF.getModContent(PathBean.BASEPATH + File.separator + PathBean.TEMPLATE_PATH + File.separator  + "职称评审审批表.rtf");
                //*****************************************
                //替换模板标签
                HashMap m = new HashMap();
                m.put("arg1", declareApprove.getName());
                m.put("arg2", declareApprove.getSex());
                m.put("arg3", declareApprove.getBirthday() == null || "".equals(declareApprove.getBirthday()) ? "" : declareApprove.getBirthday().replaceAll("-","."));
                m.put("arg4", declareApprove.getEntryTime() == null || "".equals(declareApprove.getEntryTime()) ? "": declareApprove.getEntryTime().replaceAll("-","."));
                m.put("arg5", declareApprove.getEducationalLevel());
                m.put("arg6", declareApprove.getWorkingSeniority());
                m.put("arg7", declareApprove.getSchool());
                m.put("arg8", declareApprove.getAcademicDegree());
                m.put("arg9", declareApprove.getPositionalTitles());
                m.put("argA1", declareApprove.getPresentPost());
                m.put("argA2", declareApprove.getEngageTime() == null || "".equals(declareApprove.getEngageTime()) ? "": declareApprove.getEngageTime().replaceAll("-","."));
                m.put("argA3", declareApprove.getIncumbentPost());
                m.put("argA4", declareApprove.getAppointmentTime() == null || "".equals(declareApprove.getAppointmentTime()) ? "": declareApprove.getAppointmentTime().replaceAll("-","."));
                m.put("argA5", declareApprove.getAppointmentPost());
                m.put("argA6", declareApprove.getRepresentativeAchievements());

                String beginStr = "ffd8ffe000104a464946";
                String endStr = "028a28a0028a28a00ffd9";
                String head = "";
                String foot = "";
                GenerateImage(declareApprove.getImg());
                declareApprove.setImg(GenerateImage(declareApprove.getImg()));
                StringBuffer restr = new StringBuffer();
                InputStream ins = null;

                //获取图片源码
                String filepath = declareApprove.getImg();
                if(new File(filepath).exists()){
                    ins = new FileInputStream( filepath);
                    byte[] b = new byte[1638400];
                    int i =0;
                    restr = new StringBuffer();
                    while ((i = ins.read()) != -1) {
                        String str = i < 16 ? "0" + Integer.toHexString(i) : Integer
                                .toHexString(i);
                        restr.append(str);
                    }
                }
                //获得rtf替换后的源码
                String content = operatorRTF.getRgContent(modcontent, m);
//根据首尾标识 替换 图片
                head = content.substring(0, content.indexOf(beginStr));
                foot = content.substring(content.indexOf(endStr) + endStr.length(), content.length());
                content = head + restr.toString() + foot;
                response.setContentType("application/x-msdownload");
                response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode("职称评审审批表.rtf", "utf-8"));
                os = response.getOutputStream();
                os.write(content.getBytes());
                os.flush();
            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                try {
                    if (os != null) {
                        os.flush();
                        os.close();
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

        }
    }








    //base64字符串转化成图片
    public static String GenerateImage(String imgStr) {   //对字节数组字符串进行Base64解码并生成图片
        if (imgStr == null) //图像数据为空
            return "";
        BASE64Decoder decoder = new BASE64Decoder();
        try {
            //Base64解码
            byte[] b = decoder.decodeBuffer(imgStr);
            for (int i = 0; i < b.length; ++i) {
                if (b[i] < 0) {//调整异常数据
                    b[i] += 256;
                }
            }
            //生成jpeg图片
            String imgFilePath = "d://222.jpg";//新生成的图片
            OutputStream out = new FileOutputStream(imgFilePath);
            out.write(b);
            out.flush();
            out.close();
            return imgFilePath;
        } catch (Exception e) {
            return "";
        }
    }
}
