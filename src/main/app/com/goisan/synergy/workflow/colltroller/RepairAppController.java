package com.goisan.synergy.workflow.colltroller;

import com.github.pagehelper.PageHelper;
import com.goisan.logistics.repair.bean.Repair;
import com.goisan.logistics.repair.service.RepairService;
import com.goisan.system.bean.TableDict;
import com.goisan.system.service.CommonService;
import com.goisan.system.service.EmpService;
import com.goisan.system.service.UserDicService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.JsonUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.io.UnsupportedEncodingException;
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
        Repair repair = new Repair();
        List<Repair> workFlow = repairService.RepairAction(repair);
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
            String repairmanPersonID=empService.getPersonNameById(repair.getRepairmanPersonID());
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

            String obj = "{\"title\":\"" +title+"\", \"id\":\"" +repair.getId()+"\",\"requestFlag\":\""+requestFlag+"\"" +
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
        return mv;
    }
}
