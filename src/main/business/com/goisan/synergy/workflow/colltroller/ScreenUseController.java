package com.goisan.synergy.workflow.colltroller;

import com.goisan.synergy.workflow.bean.ScreenUse;
import com.goisan.synergy.workflow.service.ScreenUseService;
import com.goisan.synergy.workflow.service.StampService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.service.FilesService;
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
 * Created by Administrator on 2017/6/28.
 */
@Controller
public class ScreenUseController {
    @Resource
    private ScreenUseService screenUseService;
    @Resource
    private FilesService filesService;
    @Resource
    private WorkflowService workflowService;
    @Resource
    private StampService stampService;
    /*
    RequestMapping 是数据库中的resource_url字段的数据
    mav.setViewName 是存放jsp路径的
     */

    /**
     * 大屏幕首页跳转
     */
    @RequestMapping("/screenUse/screenUseList")
    public ModelAndView screenUseList(){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/screenUse/screenUseList");
        return mv;
    }

    /**
     * 管理页面
     */
    @ResponseBody
    @RequestMapping("/screenUse/getScreenUseList")
    public Map<String,List<ScreenUse>> getScreenUseList(ScreenUse screenUse){
        Map<String,List<ScreenUse>> screenUseMap = new HashMap<String, List<ScreenUse>>();
        screenUse.setCreator(CommonUtil.getPersonId());
        screenUse.setCreateDept(CommonUtil.getDefaultDept());
        screenUseMap.put("data",screenUseService.screenUseAction(screenUse));
        return screenUseMap;
    }

    /**
     * 新增页面
     */
    @RequestMapping("/screenUse/editScreenUse")
    public ModelAndView addScreenUse(){
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/screenUse/editScreenUse");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String dateTime = date + 'T' + time;
        ScreenUse screenUse = new ScreenUse();
        screenUse.setRequestDate(dateTime);
        screenUse.setUsingTime(dateTime);
        String personName = screenUseService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = screenUseService.getDeptNameById(CommonUtil.getDefaultDept());
        screenUse.setRequester(personName);
        screenUse.setRequestDept(deptName);
        mv.addObject("head","新增申请");
        mv.addObject("screenUse",screenUse);
        return mv;
    }

    /**
     * 修改页面
     */
    @ResponseBody
    @RequestMapping("/screenUse/getScreenUseById")
    public ModelAndView getScreenUseById(String id){
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/screenUse/editScreenUse");
        ScreenUse screenUse = screenUseService.getScreenUseById(id);
        mv.addObject("head","大屏幕申请修改");
        mv.addObject("screenUse",screenUse);
        return mv;
    }

    /**
     * 新增及修改
     */
    @ResponseBody
    @RequestMapping("/screenUse/saveScreenUse")
    public Message saveScreenUse(ScreenUse screenUse){
        screenUse.setCreateTime(CommonUtil.getDate());
        if(screenUse.getId() == null || screenUse.getId().equals("")){
            screenUse.setCreator(CommonUtil.getPersonId());
            screenUse.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
            screenUse.setId(CommonUtil.getUUID());
            screenUse.setRequester(CommonUtil.getPersonId());
            screenUse.setRequestDept(CommonUtil.getDefaultDept());
            screenUseService.insertScreenUse(screenUse);
            return new Message(1,"新增成功!",null);
        }else{
            screenUse.setRequester(CommonUtil.getPersonId());
            screenUse.setRequestDept(CommonUtil.getDefaultDept());
            screenUse.setChanger(CommonUtil.getPersonId());
            screenUse.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            screenUseService.updateScreenUse(screenUse);
            return new Message(1,"修改成功!",null);
        }
    }

    /**
     * 删除方法
     */
    @ResponseBody
    @RequestMapping("/screenUse/deleteScreenUseById")
    public Message deleteRoleById(String id){
        screenUseService.deleteScreenUseById(id);
        filesService.delFilesByBusinessId(id);
        return new Message(1,"删除成功!",null);
    }

    /**
     * 获取部门自动完成框
     */
    @ResponseBody
    @RequestMapping("/screenUse/getDept")
    public List<AutoComplete> getDept(){
        return screenUseService.selectDept();
    }

    /**
     * 获取人员自动完成框
     */
    @ResponseBody
    @RequestMapping("/screenUse/getPerson")
    public List<AutoComplete> getPerson(){
        return screenUseService.selectPerson();
    }

    //待办业务跳转
    @RequestMapping("/screenUse/process")
    public ModelAndView screenUseListProcess() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/screenUse/screenUseProcess");
        return mv;
    }
    /**
     * 待办页
     */
    @ResponseBody
    @RequestMapping("/screenUse/getScreenUseListProcess")
    public Map<String, List<ScreenUse>> getScreenUseListProcess(ScreenUse screenUse) {
        Map<String, List<ScreenUse>> screenUseMap = new HashMap<String, List<ScreenUse>>();
        if ("%%".equals(screenUse.getRequestDept())){
            screenUse.setRequestDept(null);
        }
        if ("%%".equals(screenUse.getRequester())){
            screenUse.setRequester(null);
        }
        screenUse.setCreator(CommonUtil.getPersonId());
        screenUse.setCreateDept(CommonUtil.getDefaultDept());
        screenUse.setChanger(CommonUtil.getPersonId());
        screenUse.setChangeDept(CommonUtil.getDefaultDept());
        screenUseMap.put("data", screenUseService.getScreenUseListProcess(screenUse));
        return screenUseMap;
    }
    //已办业务跳转
    @RequestMapping("/screenUse/complete")
    public ModelAndView screenUseListComplete() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/screenUse/screenUseComplete");
        return mv;
    }
    /**
     * 已办页
     */
    @ResponseBody
    @RequestMapping("/screenUse/getScreenUseListComplete")
    public Map<String, List<ScreenUse>> getScreenUseListComplete(ScreenUse screenUse) {
        Map<String, List<ScreenUse>> screenUseMap = new HashMap<String, List<ScreenUse>>();
        screenUse.setCreator(CommonUtil.getPersonId());
        screenUse.setCreateDept(CommonUtil.getDefaultDept());
        screenUse.setChanger(CommonUtil.getPersonId());
        screenUse.setChangeDept(CommonUtil.getDefaultDept());
        screenUseMap.put("data", screenUseService.getScreenUseListComplete(screenUse));
        return screenUseMap;
    }
    //待办修改
    @ResponseBody
    @RequestMapping("/screenUse/auditScreenUseEdit")
    public ModelAndView auditScreenUseEdit(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/screenUse/editScreenUseProcess");
        ScreenUse screenUse = screenUseService.getScreenUseById(id);
        mv.addObject("head", "修改");
        mv.addObject("screenUse", screenUse);
        return mv;
    }
    //查看流程轨迹
    @ResponseBody
    @RequestMapping("/screenUse/auditScreenUseById")
    public ModelAndView waitRoleById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/screenUse/auditScreenUse");
        ScreenUse screenUse = screenUseService.getScreenUseById(id);

        mv.addObject("head", "审批");
        mv.addObject("screenUse", screenUse);
        return mv;
    }


    /**
     * 测试
     */
    @RequestMapping("/screenUse/screenUseTest")
    public ModelAndView screenUseTest(){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/screenUse/screenUseTest");
        return mv;
    }
    /**PC端打印*/
    @ResponseBody
    @RequestMapping("/screenUse/printScreenUse")
    public ModelAndView printHallUse(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/screenUse/printScreenUse");
        ScreenUse screenUse = screenUseService.getScreenUseById(id);
        String workflowName = workflowService.getWorkflowNameByWorkflowCode("T_BG_SCREENUSE_WF01");
        String state = stampService.getStateById(id);
        List<Handle> list= stampService.getHandlebyId(id);
        int size=list.size();
        mv.addObject("handleList", list);
        mv.addObject("size",size);
        mv.addObject("state",state);
        mv.addObject("workflowName",workflowName);
        mv.addObject("data", screenUse);
        return mv;
    }

}
