package com.goisan.synergy.workflow.colltroller;

import com.goisan.synergy.workflow.bean.ITSuppliesRepair;
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
 * Created by Administrator on 2017/5/3 0003.
 */
@Controller
public class ITSuppliesRepairController {
    @Resource
    private com.goisan.synergy.workflow.service.ITSuppliesRepairService ITSuppliesRepairService;
    @Resource
    private WorkflowService workflowService;
    @Resource
    private StampService stampService;
/*
申请业务
 */
    @RequestMapping("/itsuppliesrepair/request")
    public ModelAndView ITSuppliesRepairList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/ITsuppliesRepair/ITsuppliesRepair");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/ITSuppliesRepair/getITSuppliesRepairList")
    public Map<String, List<ITSuppliesRepair>> getITSuppliesRepairList() {
        Map<String, List<ITSuppliesRepair>> ITSuppliesRepairMap = new HashMap<String, List<ITSuppliesRepair>>();
        ITSuppliesRepair ITSuppliesRepair = new ITSuppliesRepair();
        ITSuppliesRepair.setCreator(CommonUtil.getPersonId());
        ITSuppliesRepair.setCreateDept(CommonUtil.getDefaultDept());
        ITSuppliesRepairMap.put("data", ITSuppliesRepairService.ITSuppliesRepairAction(ITSuppliesRepair));
        return ITSuppliesRepairMap;
    }

    @ResponseBody
    @RequestMapping("/ITSuppliesRepair/deleteITSuppliesRepairById")
    public Message deleteDeptById(String id) {
        ITSuppliesRepairService.deleteITSuppliesRepairById(id);
        return new Message(1, "删除成功！", null);
    }

    @ResponseBody
    @RequestMapping("/ITSuppliesRepair/getITSuppliesRepairById")
    public ModelAndView getRoleById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/ITsuppliesRepair/editITSuppliesRepair");
        ITSuppliesRepair ITSuppliesRepair = ITSuppliesRepairService.getITSuppliesRepairById(id);
        mv.addObject("head", "修改");
        mv.addObject("ITSuppliesRepair", ITSuppliesRepair);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/ITSuppliesRepair/updateITSuppliesRepairById")
    public Message updateITSuppliesRepairById(ITSuppliesRepair ITSuppliesRepair) {
        if (ITSuppliesRepair.getId() == null || ITSuppliesRepair.getId().equals("") || ITSuppliesRepair.getId() == "") {
            ITSuppliesRepair.setCreator(CommonUtil.getPersonId());
            ITSuppliesRepair.setCreateDept(CommonUtil.getDefaultDept());
            ITSuppliesRepair.setManager(CommonUtil.getPersonId());
            ITSuppliesRepair.setRequestDept(CommonUtil.getDefaultDept());
            ITSuppliesRepairService.insertITSuppliesRepair(ITSuppliesRepair);
            return new Message(1, "新增成功！", null);
        } else {
            ITSuppliesRepair.setManager(CommonUtil.getPersonId());
            ITSuppliesRepair.setRequestDept(CommonUtil.getDefaultDept());
            ITSuppliesRepair.setChanger(CommonUtil.getPersonId());
            ITSuppliesRepair.setChangeDept(CommonUtil.getDefaultDept());
            ITSuppliesRepairService.updateITSuppliesRepairById(ITSuppliesRepair);
            return new Message(1, "修改成功！", null);
        }
    }

    @ResponseBody
    @RequestMapping("/ITSuppliesRepair/addITsuppliesRepair")
    public ModelAndView addITSuppliesRepair() {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/ITsuppliesRepair/editITSuppliesRepair");
        ITSuppliesRepair ITSuppliesRepair = new ITSuppliesRepair();
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+'T'+time;
        String personName = ITSuppliesRepairService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = ITSuppliesRepairService.getDeptNameById(CommonUtil.getDefaultDept());
        ITSuppliesRepair.setManager(personName);
        ITSuppliesRepair.setRequestDate(datetime);
        ITSuppliesRepair.setRequestDept(deptName);
        mv.addObject("ITSuppliesRepair", ITSuppliesRepair);
        mv.addObject("head", "新增申请");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/ITSuppliesRepair/searchITSuppliesRepair")
    public Map<String, List<ITSuppliesRepair>> searchITSuppliesRepair(ITSuppliesRepair ITSuppliesRepair) {
        Map<String, List<com.goisan.synergy.workflow.bean.ITSuppliesRepair>> ITSuppliesRepairMap = new HashMap<String, List<com.goisan.synergy.workflow.bean.ITSuppliesRepair>>();
        ITSuppliesRepair.setCreator(CommonUtil.getPersonId());
        ITSuppliesRepair.setCreateDept(CommonUtil.getDefaultDept());
        ITSuppliesRepairMap.put("data", ITSuppliesRepairService.getITSuppliesRepairList(ITSuppliesRepair));
        return ITSuppliesRepairMap;
    }

    @ResponseBody
    @RequestMapping("/ITSuppliesRepair/getDept")
    public List<AutoComplete> getDept() {
        return ITSuppliesRepairService.selectDept();
    }

    @ResponseBody
    @RequestMapping("/ITSuppliesRepair/getPerson")
    public List<AutoComplete> getPerson() {
        return ITSuppliesRepairService.selectPerson();
    }

    //代办跳转
    @RequestMapping("/itsuppliesrepair/process")
    public ModelAndView process() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/ITsuppliesRepair/ITsuppliesRepairProcess");
        return mv;
    }
    //已办跳转
    @RequestMapping("/itsuppliesrepair/complete")
    public ModelAndView complete() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/ITsuppliesRepair/ITsuppliesRepairComplete");
        return mv;
    }

    //待办页面初始化
    @ResponseBody
    @RequestMapping("/itsuppliesrepair/getProcessList")
    public Map<String, List<ITSuppliesRepair>> getProcessList(ITSuppliesRepair iTSuppliesRepair) {
        Map<String, List<ITSuppliesRepair>> ITSuppliesRepairMap = new HashMap<String, List<ITSuppliesRepair>>();
        iTSuppliesRepair.setCreator(CommonUtil.getPersonId());
        iTSuppliesRepair.setCreateDept(CommonUtil.getDefaultDept());
        iTSuppliesRepair.setChanger(CommonUtil.getPersonId());
        iTSuppliesRepair.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
        ITSuppliesRepairMap.put("data", ITSuppliesRepairService.getProcessList(iTSuppliesRepair));
        return ITSuppliesRepairMap;
    }
    //已办页面初始化
    @ResponseBody
    @RequestMapping("/itsuppliesrepair/getCompleteList")
    public Map<String, List<ITSuppliesRepair>> getCompleteList(ITSuppliesRepair iTSuppliesRepair) {
        Map<String, List<ITSuppliesRepair>> ITSuppliesRepairMap = new HashMap<String, List<ITSuppliesRepair>>();
        iTSuppliesRepair.setCreator(CommonUtil.getPersonId());
        iTSuppliesRepair.setChanger(CommonUtil.getPersonId());
        iTSuppliesRepair.setCreateDept(CommonUtil.getDefaultDept());
        iTSuppliesRepair.setChangeDept(CommonUtil.getDefaultDept());
        ITSuppliesRepairMap.put("data", ITSuppliesRepairService.getCompleteList(iTSuppliesRepair));
        return ITSuppliesRepairMap;
    }
    //代办业务跳转
    @RequestMapping("/ITsuppliesRepair/ITsuppliesRepairProcess")
    public ModelAndView ITSuppliesProcess() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/ITsuppliesRepair/ITsuppliesRepairProcess");
        return mv;
    }
    /*
    待办办理按钮
     */
    @ResponseBody
    @RequestMapping("/ITSuppliesRepair/auditITSuppliesRepairById")
    public ModelAndView auditITSuppliesRepairById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/ITsuppliesRepair/addITsuppliesReapairProcess");
        ITSuppliesRepair iTSuppliesRepair = ITSuppliesRepairService.getITSuppliesRepairById(id);
        mv.addObject("head", "审批");
        mv.addObject("ITSuppliesRepair", iTSuppliesRepair);
        return mv;
    }
    /*
    待办修改按钮
     */
    @ResponseBody
    @RequestMapping("/ITSuppliesRepair/ITSuppliesRepairUpdateById")
    public ModelAndView updateITSuppliesRepairById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/ITsuppliesRepair/editITSuppliesRepairProcess");
        ITSuppliesRepair iTSuppliesRepair = ITSuppliesRepairService.getITSuppliesRepairById(id);
        mv.addObject("head", "修改");
        mv.addObject("ITSuppliesRepair", iTSuppliesRepair);
        return mv;
    }
    @ResponseBody
    @RequestMapping("/ITSuppliesRepair/printITSuppliesRepair")
    public ModelAndView printITSuppliesRepair(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/ITsuppliesRepair/printITSuppliesRepair");
        ITSuppliesRepair iTSuppliesRepair = ITSuppliesRepairService.getITSuppliesRepairById(id);
        String workflowName = workflowService.getWorkflowNameByWorkflowCode("T_BG_ITSUPPLIESREPAIR_WF01");
        String requestDate = iTSuppliesRepair.getRequestDate().replace("T", " ");
        String state = stampService.getStateById(id);
        List<Handle> list= stampService.getHandlebyId(id);
        int size=list.size();
        mv.addObject("handleList", list);
        mv.addObject("size",size);
        mv.addObject("state",state);
        mv.addObject("requestDate", requestDate);
        mv.addObject("iTSuppliesRepair", iTSuppliesRepair);
        mv.addObject("workflowName", workflowName);
        return mv;
    }
}
