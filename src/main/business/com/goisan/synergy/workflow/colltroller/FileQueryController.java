package com.goisan.synergy.workflow.colltroller;

import com.goisan.synergy.workflow.bean.FileQuery;
import com.goisan.synergy.workflow.service.FileQueryService;
import com.goisan.synergy.workflow.service.StampService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import com.goisan.workflow.bean.Handle;
import com.goisan.workflow.service.WorkflowService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * Created by znw on 2017/5/6.
 */
@Controller
public class FileQueryController {

    @Resource
    private FileQueryService fileQueryService;
    @Resource
    private WorkflowService workflowService;
    @Resource
    private StampService stampService;


    /**
         * 档案查询申请跳转
         * request by hanyue
         * modify by hanyue
         * @return
    */
    @RequestMapping("/fileQuery/request")
    public ModelAndView fileQueryList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/fileQuery/fileQuery");
        return mv;
    }

    /**
     * 档案查询URL
     *  url by hanyue
     *  modify by hanyue
     * @param fileQuery
     * @return
     */
    @ResponseBody
    @RequestMapping("/fileQuery/getFileQueryList")
    public Map<String,List<FileQuery>> getFileQueryList(FileQuery fileQuery) {
        Map<String, List<FileQuery>> fileQueryMap = new HashMap<String, List<FileQuery>>();
        fileQuery.setCreator(CommonUtil.getPersonId());
        fileQuery.setCreateDept(CommonUtil.getDefaultDept());
        fileQueryMap.put("data", fileQueryService.getFileQueryList(fileQuery));
        return fileQueryMap;
    }
    /**
     * 档案查询新增
     * add by hanyue
     * modify by hanyue
     * @return
     */
    @RequestMapping("/fileQuery/editFileQuery")
    public ModelAndView addFileQuery() {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/fileQuery/editFileQuery");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+'T'+time;
        String personName = fileQueryService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = fileQueryService.getDeptNameById(CommonUtil.getDefaultDept());
        FileQuery fileQuery=new FileQuery();
        fileQuery.setRequester(personName);
        fileQuery.setRequestDate(datetime);
        fileQuery.setRequestDept(deptName);
        mv.addObject("head", "档案查询新增");
        mv.addObject("fileQuery", fileQuery);
        return mv;
    }
    /**
     * 档案查询修改
     * update by hanyue
     * modify by hanyue
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/fileQuery/getFileQueryById")
    public ModelAndView getFileQueryById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/fileQuery/editFileQuery");
        FileQuery fileQuery = fileQueryService.getFileQueryById(id);
        mv.addObject("head", "档案查询修改");
        mv.addObject("fileQuery", fileQuery);
        return mv;
    }
    /**
     * 保存档案查询
     * save by hanyue
     * modify by hanyue
     * @param fileQuery
     * @return
     */
    @ResponseBody
    @RequestMapping("/fileQuery/saveFileQuery")
    public Message saveFileQuery(FileQuery fileQuery){
        if(fileQuery.getId()==null || fileQuery.getId().equals("")){
            fileQuery.setCreator(CommonUtil.getPersonId());
            fileQuery.setCreateDept(CommonUtil.getDefaultDept());
            fileQuery.setRequester(CommonUtil.getPersonId());
            fileQuery.setRequestDept(CommonUtil.getDefaultDept());
            fileQuery.setId(CommonUtil.getUUID());
            fileQueryService.insertFileQuery(fileQuery);
            return new Message(1, "新增成功！", null);
        }else{
            fileQuery.setRequester(CommonUtil.getPersonId());
            fileQuery.setRequestDept(CommonUtil.getDefaultDept());
            fileQuery.setChanger(CommonUtil.getPersonId());
            fileQuery.setChangeDept(CommonUtil.getDefaultDept());
            fileQueryService.updateFileQueryById(fileQuery);
            return new Message(1, "修改成功！", null);
        }
    }
    /**
     * 删除档案查询
     * delete by hanyue
     * modify by hanyue
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/fileQuery/deleteFileQueryById")
    public Message deleteFileQueryById(String id) {
        fileQueryService.deleteFileQueryById(id);
        return new Message(1, "删除成功！", null);
    }
    /**
     * 部门自动提示框
     * dept by hanyue
     * modify by hanyue
     * @return
     */
    @ResponseBody
    @RequestMapping("/fileQuery/autoCompleteDept")
    public List<AutoComplete> autoCompleteDept() {
        return fileQueryService.autoCompleteDept();
    }
    /**
     * 人员自动提示框
     * person by hanyue
     * modify by hanyue
     * @return
     */
    @ResponseBody
    @RequestMapping("/fileQuery/autoCompleteEmployee")
    public List<AutoComplete> autoCompleteEmployee() {
        return fileQueryService.autoCompleteEmployee();
    }
    /**
     * 代办业务跳转
     * agency business by hanyue
     * modify by hanyue
     * @return
     */
    @RequestMapping("/fileQuery/process")
    public ModelAndView fileQueryProcess() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/fileQuery/fileQueryProcess");
        return mv;
    }
    /**
     * 代办业务初始化
     * agency business initialize by hanyue
     * modify by hanyue
     * @param fileQuery
     * @return
     */
    @ResponseBody
    @RequestMapping("/fileQuery/getProcessList")
    public Map<String, List<FileQuery>> getProcessList(FileQuery fileQuery) {
        Map<String, List<FileQuery>> fileQueryMap = new HashMap<String, List<FileQuery>>();
        fileQuery.setCreator(CommonUtil.getPersonId());
        fileQuery.setCreateDept(CommonUtil.getDefaultDept());
        fileQuery.setChanger(CommonUtil.getPersonId());
        fileQuery.setChangeDept(CommonUtil.getDefaultDept());
        fileQueryMap.put("data", fileQueryService.getProcessList(fileQuery));
        return fileQueryMap;
    }

    /**
     * 已办业务跳转
     * already done business by hanyue
     * modify by hanyue
     * @return
     */
    @RequestMapping("/fileQuery/complete")
    public ModelAndView fileQueryComplete() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/fileQuery/fileQueryComplete");
        return mv;
    }
    /**
     * 已办页面初始化
     * already done business initialize by hanyue
     * modify by hanyue
     * @param fileQuery
     * @return
     */
    @ResponseBody
    @RequestMapping("/fileQuery/getCompleteList")
    public Map<String, List<FileQuery>> getCompleteList(FileQuery fileQuery) {
        Map<String, List<FileQuery>> fileQueryMap = new HashMap<String, List<FileQuery>>();
        fileQuery.setCreator(CommonUtil.getPersonId());
        fileQuery.setCreateDept(CommonUtil.getDefaultDept());
        fileQuery.setChanger(CommonUtil.getPersonId());
        fileQuery.setChangeDept(CommonUtil.getDefaultDept());
        fileQueryMap.put("data", fileQueryService.getCompleteList(fileQuery));
        return fileQueryMap;
    }

    /**
     * 待办修改
     * agency update by hanyue
     * modify by hanyue
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/fileQuery/auditFileQueryEdit")
    public ModelAndView auditFileQueryEdit(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/fileQuery/editFileQueryProcess");
        FileQuery fileQuery = fileQueryService.getFileQueryById(id);
        mv.addObject("head", "修改");
        mv.addObject("fileQuery", fileQuery);
        return mv;
    }
    /**
     * 查看流程轨迹
     * process trajectory by hanyue
     * modify by hanyue
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/fileQuery/auditFileQueryById")
    public ModelAndView waitRoleById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/fileQuery/addFileQueryProcess");
        FileQuery fileQuery = fileQueryService.getFileQueryById(id);
        mv.addObject("head", "审批");
        mv.addObject("fileQuery", fileQuery);
        return mv;
    }
    /**PC端打印*/
    @ResponseBody
    @RequestMapping("/fileQuery/printFileQuery")
    public ModelAndView printHallUse(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/fileQuery/printFileQuery");
        String workflowName = workflowService.getWorkflowNameByWorkflowCode("T_BG_FILEQUERY_WF01");
        FileQuery fileQuery = fileQueryService.getFileQueryById(id);
        String state = stampService.getStateById(id);
        List<Handle> list= stampService.getHandlebyId(id);
        int size=list.size();
        mv.addObject("handleList", list);
        mv.addObject("size",size);
        mv.addObject("state",state);
        mv.addObject("data", fileQuery);
        mv.addObject("workflowName", workflowName);
        return mv;
    }

}
