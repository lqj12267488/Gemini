package com.goisan.synergy.workflow.colltroller;

import com.github.pagehelper.PageHelper;
import com.goisan.educational.score.service.ScoreChangeService;
import com.goisan.logistics.repair.bean.Repair;
import com.goisan.logistics.repair.service.RepairService;
import com.goisan.system.bean.Files;
import com.goisan.system.bean.RoleEmpDeptRelation;
import com.goisan.system.bean.Select2;
import com.goisan.system.bean.TableDict;
import com.goisan.system.service.CommonService;
import com.goisan.system.service.EmpService;
import com.goisan.system.service.FilesService;
import com.goisan.system.service.UserDicService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.JsonUtils;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
public class RepairAppController {

    @Resource
    private RepairService repairService;
    @Resource
    private EmpService empService;
    @Resource
    private CommonService commonService;
    @Resource
    private UserDicService userDicService;
    @Resource
    private FilesService filesService;
    public static String COM_REPORT_PATH = null;

    @RequestMapping("/repair/repairApp")
    public ModelAndView listNotice(){
        ModelAndView mv=new ModelAndView("/app/synergy/repair/repairList");
        String emJson = getRepairName(1);
        mv.addObject("emJson", emJson);
        return mv;
    }
    /**
     * 列出报修列表*/
    @ResponseBody
    @RequestMapping("/repair/getRepaireName")
    public String getRepairName(int page) {
        //获取当前登录人
        String personId = CommonUtil.getPersonId();
        //获取当前登录人角色
        //是否维修员
        List<RoleEmpDeptRelation> roles = commonService.getRoleByPersonId(personId);
        //是否后勤主管
        List<RoleEmpDeptRelation> roles1 = commonService.getRoleByPersonId1(personId);
        List<Repair> workFlow = null;
        Repair repair = new Repair();
        if (roles.size()==0 && roles1.size()==0){
            //个人
            workFlow = repairService.RepairActionInfo(personId);
        }else if (roles1.size()!=0){
            //后勤主管
            workFlow = repairService.RepairAction(repair);
        }else if (roles.size()!=0 && roles1.size()==0){
            //维修员
            workFlow =  repairService.RepairActionInfoList(personId);
        }

        return getJsonTaskList(workFlow,page);
    }
    /**报修-向前台jsp传数据*/
    public String getJsonTaskList(List<Repair> NoticeList, int page){

        int from = ( page - 1 ) * 10 ;
        int end  = page * 10 ;
        int len = NoticeList.size();
        // 如果 开始序号 > 列表长度  那么不返回数据
        from = from > len ? len+10 :from ;
        // 如果 结束序号 > 列表长度  那么以列表长度 为结束序号
        end = end > len ? len :end ;

        String str ="";
        boolean b =true;
        for(int i=from;i< end;i++ ){
            Repair repair = NoticeList.get(i);
            String title = repair.getRepairTypeShow();
            if(title==null || title==""){
                title="(此报修名称已被删)";
            }
            String requestFlag=repair.getRequestFlag();
            String repairmanPersonID= repair.getPersonIdShow();
//                    empService.getPersonNameById(repair.getRepairmanPersonID());
            if(null==repairmanPersonID && ("维修分配中".equals(repair.getRequestFlag()) || "未提交".equals(repair.getRequestFlag()))){
                repairmanPersonID=repair.getRequestFlag();
            }else{
                repairmanPersonID = "由" + repairmanPersonID + repair.getRequestFlag();
            }
            try {
                title =java.net.URLEncoder.encode(title,"UTF-8");
                title =java.net.URLEncoder.encode(title,"UTF-8");
                requestFlag=java.net.URLEncoder.encode(requestFlag,"UTF-8");
                repairmanPersonID=java.net.URLEncoder.encode(repairmanPersonID,"UTF-8");
            } catch (UnsupportedEncodingException e1) {
                // TODO Auto-generated catch block
                e1.printStackTrace();
            }
            String creator = repair.getCreator();
            String name = empService.selectName(creator);
            /*String res = repair.getFeedbackFlag().equals("1") ? "满意" : "不满意";*/

            String obj = "{\"title\":\"" +title+"\", \"id\":\"" +repair.getRepairID()+"\",\"creator\":\"" +name+"\",\"feedback\":\"" +repair.getFeedbackFlag()+"\",\"requestFlag\":\""+requestFlag+"\"" +
                    ",\"repairmanPersonID\":\""+repairmanPersonID+"\"}" ;

            if(b){
                str =obj;
                b = false;
            }
            else{
                str = str +","+ obj;
            }
        }
        return "["+str+"]";
    }
    @RequestMapping("/repair/listRepairnmbers")
    public ModelAndView listRepairnmbers() {
        ModelAndView mv=new ModelAndView("/app/synergy/repair/repairList");
        String emJson = getRepairName(1);
        mv.addObject("emJson", emJson);

        /*if ("0".equals(type)){
            mv.addObject("typeName", "待办事项");
        }else{
            mv.addObject("typeName", "已办事项");
        }*/

        return mv;
    }

    @RequestMapping("/repair/toAddRepairApp")
    public ModelAndView toAddRepairApp() {
        ModelAndView mv = new ModelAndView("app/synergy/repair/repairEdit");
        TableDict tableDict = new TableDict();
        tableDict.setTableName(" T_SYS_USERDIC ");
        tableDict.setId(" dic_code ");
        tableDict.setText(" dic_name ");
        tableDict.setWhere(" WHERE 1 = 1 and dic_type='BXLXGL' and VALID_FLAG=1 ");
        tableDict.setOrderby(" order by create_time desc ");
        String pdept = empService.getDeptNameById(CommonUtil.getDefaultDept());
        mv.addObject("dics", commonService.getTableDict(tableDict));
        mv.addObject("pdept", pdept);
        return mv;
    }

    /**
     * 查询维修任务
     */
    @RequestMapping("/repairTaskApp/result")
    public ModelAndView listRepairTask() {
        ModelAndView mv = new ModelAndView("/app/synergy/repair/repairTaskList");
        String emJson = getRepairTaskName(1);
        mv.addObject("emJson", emJson);
        return mv;
    }

    /**
     * 查询维修任务分配数据
     *
     * @param page
     * @return
     */
    @ResponseBody
    @RequestMapping("/repair/getRepairTaskName")
    public String getRepairTaskName(int page) {
        Repair repair = new Repair();
        repair.setCreator(CommonUtil.getPersonId());
        repair.setCreateDept(CommonUtil.getDefaultDept());
        repair.setLevel(CommonUtil.getLoginUser().getLevel());
        List<Repair> workFlow = repairService.distributionInfo(repair);
        return getJsonRepairTaskList(workFlow, page);
    }

    /**
     * 拼接维修任务分配数据
     *
     * @param NoticeList
     * @param page
     * @return
     */
    public String getJsonRepairTaskList(List<Repair> NoticeList, int page) {

        int from = (page - 1) * 10;
        int end = page * 10;
        int len = NoticeList.size();
        // 如果 开始序号 > 列表长度  那么不返回数据
        from = from > len ? len + 10 : from;
        // 如果 结束序号 > 列表长度  那么以列表长度 为结束序号
        end = end > len ? len : end;

        String str = "";
        boolean b = true;
        for (int i = from; i < end; i++) {
            Repair repair = NoticeList.get(i);
            String title = repair.getRepairTypeShow();
            if (title == null || title.equals("")) {
                title = "(此报修名称已被删)";
            }
            String requestFlag = repair.getRequestFlag();
            String repairID = repair.getId();
            String repairmanPersonID = empService.getPersonNameById1(repairID);
            if (null == repairmanPersonID) {
                repairmanPersonID = "维修分配中";
            } else {
                repairmanPersonID = "由" + repairmanPersonID + repair.getRequestFlag();
            }
            try {
                title = java.net.URLEncoder.encode(title, "UTF-8");
                title = java.net.URLEncoder.encode(title, "UTF-8");
                if (requestFlag == null)
                    requestFlag = "0";
                requestFlag = java.net.URLEncoder.encode(requestFlag, "UTF-8");
                repairmanPersonID = java.net.URLEncoder.encode(repairmanPersonID, "UTF-8");
                repairmanPersonID = java.net.URLEncoder.encode(repairmanPersonID, "UTF-8");
            } catch (UnsupportedEncodingException e1) {
                // TODO Auto-generated catch block
                e1.printStackTrace();
            }

            String obj = "{\"title\":\"" + title + "\", \"id\":\"" + repair.getId() + "\", \"repairID\":\"" + repair.getRepairID() + "\", \"requestFlagShow\":\"" + repair.getRequestFlagShow() + "\",\"requestFlag\":\"" + requestFlag + "\"" +
                    ",\"repairmanPersonID\":\"" + repairmanPersonID + "\"}";

            if (b) {
                str = obj;
                b = false;
            } else {
                str = str + "," + obj;
            }
        }
        return "[" + str + "]";
    }

    @RequestMapping("/repair/repairApp2")
    public ModelAndView repairApp(Repair repair, String flag) {
        ModelAndView mv = new ModelAndView("/app/synergy/repair/repairList2");
        repair.setCreator(CommonUtil.getPersonId());
        repair.setCreateDept(CommonUtil.getDefaultDept());
        PageHelper.startPage(1, 10);
        List<Repair> ll = repairService.repairDefine(repair);
        for (Repair repair1 : ll) {
            String[] name_id = repair1.getItemName().split(",");
            String newname = "";
            for (int j = 0; j < name_id.length; j++) {
                String a = name_id[j];
                String name = userDicService.getDicName(a);
                if (name != null) {
                    newname = newname + name + ",";
                }
            }
            if(!"".equals(newname)) newname = newname.substring(0,newname.length()-1);
            repair1.setItemNameShow(newname);
        }
        mv.addObject("emJson", JsonUtils.toJson(ll));
        mv.addObject("flag", flag);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/repair/getRepairApp")
    public List<Repair> getRepairApp(Repair repair, int page, String flag) {
        if ("1".equals(flag)) {
            repair.setRepairmanPersonID(CommonUtil.getPersonId());
        } else {
            repair.setCreator(CommonUtil.getPersonId());
            repair.setCreateDept(CommonUtil.getDefaultDept());
        }
        PageHelper.startPage(page, 10, false);
        List<Repair> ll = repairService.repairDefine(repair);
        for (Repair repair1 : ll) {
            String[] name_id = repair1.getItemName().split(",");
            String newname = "";
            for (int j = 0; j < name_id.length; j++) {
                String a = name_id[j];
                String name = userDicService.getDicName(a);
                if (name != null) {
                    newname = newname + name + ",";
                }
            }
            if(!"".equals(newname)) newname = newname.substring(0,newname.length()-1);
            repair1.setItemNameShow(newname);
        }
        return ll;
    }

    @RequestMapping("/repair/repair")
    public ModelAndView repair(String id, String flag) {
        ModelAndView mv = new ModelAndView("/app/synergy/repair/repair");
        Repair repair = repairService.getRepairById(id);
        String[] name_id = repair.getItemName().split(",");
        StringBuilder newname = new StringBuilder();
        for (String a : name_id) {
            String name = userDicService.getDicName(a);
            if (name != null) {
                newname.append(name).append(",");
            }
        }
        if(newname.length()>0){
            repair.setItemNameShow(newname.substring(0, newname.length() - 1));
        }else {
            repair.setItemNameShow("");
        }
        mv.addObject("repair", repair);
        mv.addObject("flag", flag);
        /**
         * 维修状态
         */
        mv.addObject("reflag",commonService.getSysDict("WXLCZT", " (dic_code='2' or dic_code='3')"));
        return mv;
    }

    @RequestMapping("/repair/repairFeedback")
    public ModelAndView repairFeedback(String id,String repairmanPersonID){
        ModelAndView modelAndView = new ModelAndView("/app/synergy/repair/repairFeedback");
        modelAndView.addObject("id",id);
        if ("未提交".equals(repairmanPersonID)){
            modelAndView.addObject("msg","1");
            String emJson = getRepairName(1);
            modelAndView.addObject("emJson", emJson);
            modelAndView.setViewName("/app/synergy/repair/repairList");
        }
        return modelAndView;
    }

    @RequestMapping("/repair/saveFeedbackInfo")
    @ResponseBody
    public Message saveFeedbackInfo(@RequestParam("feedbackFlag")String feedbackFlag,@RequestParam("fback")String fback,@RequestParam("id")String id){
        try {
            repairService.saveFeedbackInfo(feedbackFlag,fback,id);
            return new Message(1,"反馈成功",null);
        } catch (Exception e) {
            e.printStackTrace();
            return new Message(1,"反馈失败",null);
        }

    }


    @ResponseBody
    @RequestMapping("/app/files/insertFiles1")
    public void appUpload(@RequestParam(value = "file", required = false) MultipartFile[] files, HttpServletRequest request) {
        COM_REPORT_PATH = new File(this.getClass().getResource("/").getPath()).getParentFile()
                .getParentFile().getPath();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        String urlParten = "/files/%s/%s";
        for (MultipartFile file : files) {
            String fileName = file.getOriginalFilename();
            if (!"".equals(fileName)) {
                String path = String.format(urlParten, request.getParameter("tableName"),
                        sdf.format(new Date()));
                String url = path + "/" + CommonUtil.getUUID()
                        + fileName.substring(fileName.indexOf("."));
                FileOutputStream fos = null;
                try {
                    File f = new File(COM_REPORT_PATH + path);
                    f.mkdirs();
                    fos = new FileOutputStream(new File(COM_REPORT_PATH + url));
                    fos.write(file.getBytes());
                } catch (FileNotFoundException e) {
                    e.printStackTrace();
                } catch (IOException e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (fos != null) {
                            fos.close();
                        }
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
                Files uploadFiles = new Files();
                uploadFiles.setFileId(CommonUtil.getUUID());
                uploadFiles.setFileName(fileName);
                uploadFiles.setFileType(fileName.substring(fileName.lastIndexOf(".") + 1));
                uploadFiles.setFileUrl(url);
                uploadFiles.setBusinessId(request.getParameter("businessId"));
                uploadFiles.setTableName(request.getParameter("tableName"));
                uploadFiles.setBusinessType(request.getParameter("businessType"));
                uploadFiles.setCreator(CommonUtil.getPersonId());
                uploadFiles.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
                filesService.insertFiles(uploadFiles);
            }
        }
    }

}
