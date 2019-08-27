package com.goisan.educational.slowexamination.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.educational.slowexamination.bean.SlowExamination;
import com.goisan.educational.slowexamination.service.SlowExaminationService;
import com.goisan.synergy.workflow.service.StampService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Select2;
import com.goisan.system.bean.Tree;
import com.goisan.system.service.ParameterService;
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
import java.util.*;

/**
 * 缓考申请
 */
@Controller
public class SlowExaminationController {
    @Resource
    private SlowExaminationService slowExaminationService;
    @Resource
    private WorkflowService workflowService;
    @Resource
    private StampService stampService;
    @Resource
    private ParameterService parameterService;
    //申请页跳转
    @RequestMapping("/slowExamination/request")
    public ModelAndView SlowExaminationList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/slowExamination/slowExamination");
        return mv;
    }

    //申请页列表初始化
    @ResponseBody
    @RequestMapping("/slowExamination/getSlowExaminationList")
    public Map<String, Object> getSlowExaminationList(SlowExamination slowExamination,int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String,Object> slowExaminationList = new HashMap<String, Object>();
       // Map<String, List<SlowExamination>> softInstallMap = new HashMap<String, List<SlowExamination>>();
        slowExamination.setCreator(CommonUtil.getPersonId());
        slowExamination.setChangeDept(CommonUtil.getDefaultDept());
        List<SlowExamination> list = slowExaminationService.getSlowExaminationList(slowExamination);
        PageInfo<List<SlowExamination>> info = new PageInfo(list);
        slowExaminationList.put("draw", draw);
        slowExaminationList.put("recordsTotal", info.getTotal());
        slowExaminationList.put("recordsFiltered", info.getTotal());
        slowExaminationList.put("data", list);
        //softInstallMap.put("data", slowExaminationService.getSlowExaminationList(slowExamination));
        return slowExaminationList;
    }

    //查询列表
    @ResponseBody
    @RequestMapping("/slowExamination/searchSlowExamination")
    public Map<String, List<SlowExamination>> searchSlowExamination(SlowExamination slowExamination) {
        Map<String, List<SlowExamination>> softMap = new HashMap<String, List<SlowExamination>>();
        slowExamination.setCreator(CommonUtil.getPersonId());
        softMap.put("data", slowExaminationService.getSlowExaminationList(slowExamination));
        return softMap;
    }

    //申请页添加界面跳转
    @ResponseBody
    @RequestMapping("/slowExamination/addSlowExamination")
    public ModelAndView addSlowExaminationInstall() {
        ModelAndView mv = new ModelAndView("/business/educational/slowExamination/editSlowExamination");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date + 'T' + time;
        SlowExamination slowExamination = new SlowExamination();
        slowExamination.setRequestDate(datetime);
        String personName = slowExaminationService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = slowExaminationService.getDeptNameById(CommonUtil.getPersonId());
        String className= slowExaminationService.getClassNameById(CommonUtil.getPersonId());
        String majorCode=slowExaminationService.getMajorCodeById(CommonUtil.getPersonId());
        slowExamination.setRequestDept(deptName);
        slowExamination.setClassId(className);
        slowExamination.setManager(personName);
        slowExamination.setMajorId(majorCode);
        slowExamination.setTermId(parameterService.getParameterValue());
        mv.addObject("head", "新增申请");
        mv.addObject("slowExamination", slowExamination);
        return mv;
    }

    //申请页修改界面跳转
    @ResponseBody
    @RequestMapping("/slowExamination/getSlowExaminationById")
    public ModelAndView getSlowExaminationById(String id) {
        ModelAndView mv = new ModelAndView("/business/educational/slowExamination/editSlowExamination");
        SlowExamination slowExamination = slowExaminationService.getSlowExaminationById(id);
        String majorCode=slowExaminationService.getMajorCodeById(CommonUtil.getPersonId());
        slowExamination.setMajorId(majorCode);
        mv.addObject("head", "申请修改");
        mv.addObject("slowExamination", slowExamination);
        return mv;
    }

    //新增和修改保存
    @ResponseBody
    @RequestMapping("/slowExamination/saveSlowExamination")
    public Message saveSlowExamination(SlowExamination slowExamination) {
        if (slowExamination.getId() == null || slowExamination.equals("") || slowExamination.getId() == "") {
            slowExamination.setCreator(CommonUtil.getPersonId());
            slowExamination.setCreateDept(slowExaminationService.getDeptIdById(CommonUtil.getPersonId()));
            slowExamination.setClassId(slowExaminationService.getClassIdById(CommonUtil.getPersonId()));
            slowExamination.setRequestDept(slowExaminationService.getDeptIdById(CommonUtil.getPersonId()));
            slowExamination.setManager(CommonUtil.getPersonId());
            slowExamination.setId(CommonUtil.getUUID());
            slowExamination.setTermId(parameterService.getParameterValue());
            slowExaminationService.insertSlowExamination(slowExamination);
            return new Message(1, "新增成功！", null);
        } else {
            slowExamination.setChanger(CommonUtil.getPersonId());
            slowExamination.setChangeDept(slowExaminationService.getDeptIdById(CommonUtil.getPersonId()));
            slowExamination.setRequestDept(slowExaminationService.getDeptIdById(CommonUtil.getPersonId()));
            slowExaminationService.updateSlowExaminationById(slowExamination);
            return new Message(1, "修改成功！", null);
        }
    }

    //删除
    @ResponseBody
    @RequestMapping("/slowExamination/deleteSlowExaminationById")
    public Message deleteDeptById(String id) {
        slowExaminationService.deleteSlowExaminationById(id);
        return new Message(1, "删除成功！", null);
    }

    /*查看流程轨迹页面跳转*/
    @ResponseBody
    @RequestMapping("/slowExamination/auditSlowExaminationById")
    public ModelAndView auditSlowExaminationById(String id) {
        ModelAndView mv = new ModelAndView("/business/educational/slowExamination/auditEditSlowExamination");
        SlowExamination slowExamination = slowExaminationService.getSlowExaminationById(id);
        mv.addObject("head", "审批");
        mv.addObject("slowExamination", slowExamination);
        return mv;
    }

    /*待办事项页面跳转*/
    @RequestMapping("/slowExamination/requestProcess")
    public ModelAndView SlowExaminationListProcess() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/slowExamination/slowExaminationProcess");
        return mv;
    }

    /*代办页列表查询*/
    @ResponseBody
    @RequestMapping("/slowExamination/getSlowExaminationProcessList")
    public Map<String, Object> getSlowExaminationProcessList(SlowExamination slowExamination,int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String,Object> slowExaminationList = new HashMap<String, Object>();
       //Map<String, List<SlowExamination>> slowExaminationMap = new HashMap<String, List<SlowExamination>>();
        slowExamination.setCreator(CommonUtil.getPersonId());
        slowExamination.setCreateDept(slowExaminationService.getDeptIdById(CommonUtil.getPersonId()));
        slowExamination.setChanger(CommonUtil.getPersonId());
        slowExamination.setChangeDept(CommonUtil.getDefaultDept());
        List<SlowExamination> list = slowExaminationService.slowExaminationProcessAction(slowExamination);
        PageInfo<List<SlowExamination>> info = new PageInfo(list);
        slowExaminationList.put("draw", draw);
        slowExaminationList.put("recordsTotal", info.getTotal());
        slowExaminationList.put("recordsFiltered", info.getTotal());
        slowExaminationList.put("data", list);
        //slowExaminationMap.put("data", slowExaminationService.slowExaminationProcessAction(slowExamination));
        return slowExaminationList;
    }

    /*已办事项页面跳转*/
    @RequestMapping("/slowExamination/requestComplete")
    public ModelAndView slowExaminationListComplete() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/slowExamination/slowExaminationComplete");
        return mv;
    }

    /*已办页列表查询*/
    @ResponseBody
    @RequestMapping("/slowExamination/getCompleteList")
    public Map<String, Object> getCompleteList(SlowExamination slowExamination,int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String,Object> slowExaminationList = new HashMap<String, Object>();
        slowExamination.setCreator(CommonUtil.getPersonId());
        slowExamination.setChanger(CommonUtil.getPersonId());
        slowExamination.setCreateDept(CommonUtil.getDefaultDept());
        slowExamination.setChangeDept(CommonUtil.getDefaultDept());
        List<SlowExamination> list = slowExaminationService.slowExaminationCompleteAction(slowExamination);
        PageInfo<List<SlowExamination>> info = new PageInfo(list);
        slowExaminationList.put("draw", draw);
        slowExaminationList.put("recordsTotal", info.getTotal());
        slowExaminationList.put("recordsFiltered", info.getTotal());
        slowExaminationList.put("data", list);
        //slowExaminationMap.put("data", slowExaminationService.slowExaminationCompleteAction(slowExamination));
        return slowExaminationList;
    }

    //办理页面跳转
    @ResponseBody
    @RequestMapping("/slowExamination/auditEdit")
    public ModelAndView auditEdit(String id) {
        ModelAndView mv = new ModelAndView("/business/educational/slowExamination/auditEditSlowExamination");
        SlowExamination slowExamination = slowExaminationService.getSlowExaminationById(id);
        String majorCode = slowExaminationService.getMajorCodeById(CommonUtil.getPersonId());
        slowExamination.setMajorId(majorCode);
        mv.addObject("head", "办理");
        mv.addObject("slowExamination", slowExamination);
        return mv;
    }

    //待办修改页面跳转
    @ResponseBody
    @RequestMapping("/slowExamination/auditEditSlowExamination")
    public ModelAndView auditEditSlowExamination(String id) {
        ModelAndView mv = new ModelAndView("/business/educational/slowExamination/addSlowExamination");
        SlowExamination slowExamination = slowExaminationService.getSlowExaminationById(id);
        String majorCode=slowExaminationService.getMajorCodeById(CommonUtil.getPersonId());
        slowExamination.setMajorId(majorCode);
        mv.addObject("head", "修改");
        mv.addObject("slowExamination", slowExamination);
        return mv;
    }

    /**
     * PC端打印
     */
    @ResponseBody
    @RequestMapping("/slowExamination/printSlowExamination")
    public ModelAndView printHallUse(String id) {
        ModelAndView mv = new ModelAndView("/business/educational/slowExamination/printSlowExamination");
        SlowExamination slowExamination = slowExaminationService.getSlowExaminationById(id);
        String workflowName = workflowService.getWorkflowNameByWorkflowCode("T_JW_SLOW_EXAMINATION01");
        String state = stampService.getStateById(id);
        List<Handle> list = stampService.getHandlebyId(id);
        int size = list.size();
        mv.addObject("handleList", list);
        mv.addObject("size", size);
        mv.addObject("state", state);
        mv.addObject("data", slowExamination);
        mv.addObject("workflowName", workflowName);
        return mv;
    }

    //模糊查询部门名称
    @ResponseBody
    @RequestMapping("/slowExamination/selectDept")
    public List<AutoComplete> selectDept() {
        return slowExaminationService.selectDept();
    }

    //模糊查询申请人姓名
    @ResponseBody
    @RequestMapping("/slowExamination/getPerson")
    public List<AutoComplete> getPerson() {
        return slowExaminationService.selectPerson();
    }



    //缓考科目多选
    @ResponseBody
    @RequestMapping("/slowExamination/getCourseSelect")
    public List<Tree> getCourseSelect(SlowExamination slowExamination) {
        List<Select2> selectList = slowExaminationService.getCourseSelect(slowExamination);
        return getDictToTree(selectList);
    }
    //zTree公共方法
    public List<Tree> getDictToTree(List<Select2> selectList) {
        List<Tree> treeList = new ArrayList<Tree>();
        for (int i = 0; i < selectList.size(); i++) {
            Select2 select = selectList.get(i);
            Tree tree = new Tree();
            tree.setId(select.getId());
            tree.setName(select.getText());
            treeList.add(tree);
        }
        return treeList;
    }


}
