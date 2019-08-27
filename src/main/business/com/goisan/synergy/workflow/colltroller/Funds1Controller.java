package com.goisan.synergy.workflow.colltroller;

import com.goisan.synergy.workflow.bean.Funds;
import com.goisan.synergy.workflow.bean.Funds1;
import com.goisan.synergy.workflow.bean.Funds1Relation;
import com.goisan.synergy.workflow.bean.FundsRelation;
import com.goisan.synergy.workflow.service.Funds1Service;
import com.goisan.synergy.workflow.service.FundsService;
import com.goisan.synergy.workflow.service.StampService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.service.EmpService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import com.goisan.system.tools.UpperMoney;
import com.goisan.workflow.bean.Handle;
import com.goisan.workflow.bean.IndexUnAudti;
import com.goisan.workflow.bean.Node;
import com.goisan.workflow.bean.Start;
import com.goisan.workflow.service.DefinitionService;
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
 * Created by Administrator on 2017/5/6 0006.
 */
@Controller
public class Funds1Controller {
    @Resource
    private Funds1Service funds1Service;
    @Resource
    private EmpService empService;
    @Resource
    private WorkflowService workflowService;
    @Resource
    public DefinitionService definitionService;
    @Resource
    private StampService stampService;
    @RequestMapping("/funds1/request")
    public ModelAndView funds1List() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/funds1/funds");
        return mv;
    }

    @RequestMapping("/funds1/process")
    public ModelAndView funds1ListDb() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/funds1/fundsProcess");
        return mv;
    }

    @RequestMapping("/funds1/complete")
    public ModelAndView funds1ListYb() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/funds1/fundsComplete");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/funds1/getFundsList")
    public Map<String, List<Funds1>> funds1Action(Funds1 funds1) {
        Map<String, List<Funds1>> FundsMap = new HashMap<String, List<Funds1>>();
        funds1.setCreator(CommonUtil.getPersonId());
        funds1.setCreateDept(CommonUtil.getDefaultDept());
        FundsMap.put("data", funds1Service.fundsAction(new Funds1()));
        return FundsMap;
    }

    @ResponseBody
    @RequestMapping("/funds1/getFundsListProcess")
    public Map<String, List<Funds1>> funds1Process(Funds1 funds1 ) {
        //String sql = workflowService.getUnAudit("T_BG_FUNDS_WF",CommonUtil.getPersonId());
        Map<String, List<Funds1>> fundsMap = new HashMap<String, List<Funds1>>();
        funds1.setCreator(CommonUtil.getPersonId());
        funds1.setCreateDept(CommonUtil.getDefaultDept());
        List<Funds1> r = funds1Service.fundsProcess(funds1);
        fundsMap.put("data", r);
        return fundsMap;
    }

    @ResponseBody
    @RequestMapping("/funds1/getFundsListComplete")
    public Map<String, List<Funds1>> funds1Complete(Funds1 funds1 ) {
        Map<String, List<Funds1>> fundsMap = new HashMap<String, List<Funds1>>();
        funds1.setCreator(CommonUtil.getPersonId());
        funds1.setCreateDept(CommonUtil.getDefaultDept());
        List<Funds1> r = funds1Service.fundsComplete(funds1);
        fundsMap.put("data", r);
        return fundsMap;
    }

    @ResponseBody
    @RequestMapping("/funds1/search")
    public Map<String, List<Funds1>> search1(Funds1 funds1){
        Map<String, List<Funds1>>  fundsMap = new HashMap<String, List<Funds1>>();
        funds1.setCreator(CommonUtil.getPersonId());
        funds1.setCreateDept(CommonUtil.getDefaultDept());
       /* List<Funds> r = fundsService.fundsAction(funds);
        fundsMap.put("data", r);
        return fundsMap;*/
        fundsMap.put("data", funds1Service.fundsAction(funds1));
        return fundsMap;
    }
    @ResponseBody
    @RequestMapping("/funds1/getFundsById")
    public ModelAndView getFunds1ById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/funds1/editFunds");
        Funds1 funds1 = funds1Service.getFundsById(id);
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+"T"+time;
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        funds1.setRequestDate(datetime);
        funds1.setManager(personName);
        funds1.setRequestDept(deptName);
        mv.addObject("head", "修改申请");
        mv.addObject("funds1", funds1);
        return mv;
    }

    @RequestMapping("/funds1/addFunds")
    public ModelAndView addFunds1() {
        Funds1 funds1 = new Funds1();
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/funds1/editFunds");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+"T"+time;
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        funds1.setRequestDate(datetime);
        funds1.setManager(personName);
        funds1.setRequestDept(deptName);
        mv.addObject("name",personName);
        mv.addObject("dept",deptName);
        mv.addObject("funds1",funds1);
        mv.addObject("head", "新增申请");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/funds1/deleteFundsById")
    public Message deleteFunds1ById(String id) {
        funds1Service.deleteById(id);
        return new Message(1, "删除成功！", null);
    }

    @ResponseBody
    @RequestMapping("/funds1/saveFunds")
    public Message saveFunds1(Funds1 funds1){
        funds1.setRequestDept(CommonUtil.getLoginUser().getDefaultDeptId());
        funds1.setManager(CommonUtil.getPersonId());
        if(funds1.getId()==null || funds1.getId().equals("")){
            funds1.setCreator(CommonUtil.getPersonId());
            funds1.setCreateDept(CommonUtil.getDefaultDept());
            funds1.setId(CommonUtil.getUUID());
            funds1.setRequestFlag("0");
            String upper = UpperMoney.change(Double.parseDouble(funds1.getAmount()));
            funds1.setAmountUpper(upper);
            funds1Service.insertFunds(funds1);
            return new Message(1, "新增成功！", null);
        }else{
            funds1.setChanger(CommonUtil.getPersonId());
            funds1.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            String upper = UpperMoney.change(Double.parseDouble(funds1.getAmount()));
            funds1.setAmountUpper(upper);
            funds1Service.updateFunds(funds1);
            return new Message(1, "修改成功！", null);
        }
    }

    @ResponseBody
    @RequestMapping("/funds1/getDept")
    public List<AutoComplete> getDept() {
        return funds1Service.selectDept();
    }

    @ResponseBody
    @RequestMapping("/funds1/getPerson")
    public List<AutoComplete> getPerson() {
        return funds1Service.selectPerson();
    }

    @ResponseBody
    @RequestMapping("/funds1/auditFundsById")
    public ModelAndView waitRoleById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/funds1/addFundsProcess");
        Funds1 funds1 = funds1Service.getFundsById(id);
        //SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        //SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        //String date = formatDate.format(new Date());
        //String time = formatTime.format(new Date());
        //String datetime = date+"T"+time;
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        //funds.setRequestDate(datetime);
        //funds.setManager(personName);
        //funds.setRequestDept(deptName);
        mv.addObject("name",personName);
        mv.addObject("dept",deptName);
        mv.addObject("funds1", funds1);
        mv.addObject("head", "审批");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/funds1/auditEdit")
    public ModelAndView auditEdit(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/funds1/auditEditFunds");
        Funds1 funds1 = funds1Service.getFundsById(id);
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+"T"+time;
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        funds1.setRequestDate(datetime);
        funds1.setManager(personName);
        funds1.setRequestDept(deptName);
        mv.addObject("name",personName);
        mv.addObject("dept",deptName);
        mv.addObject("head", "修改");
        mv.addObject("funds1", funds1);
        return mv;
    }
    /*待办关联业务jsp*/
    @RequestMapping("/funds1/processLoadIndexUnAudit")
    public ModelAndView loadIndexUnAudit(String id) {
        String personId = CommonUtil.getPersonId();
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/funds1/fundUnAudit");
        //mv.addObject("task",   taskService.findTaskList(personId));
        mv.addObject("data", workflowService.getRelationListById(personId,id));
        return mv;
    }
    /*关联中的详情页*/
    @RequestMapping("/funds1/getWotkflowLog")
    public ModelAndView getWotkflowLog(String tableName, String businessId, String url, String
            backUrl,String type) {
        ModelAndView mv = null;
        Start start = workflowService.getWorkflowStart(tableName, businessId);
        List<Handle> workflowLog = workflowService.getHandleList(start.getStartId());
        List<Node> nodes = workflowService.getNodeListByWorkflowId(start.getWorkflowId());
        if ("1".equals(type)){
            mv = new ModelAndView("/business/synergy/workflow/funds1/fundsAuditRelation");
        }else{
            mv = new ModelAndView("/business/synergy/workflow/funds1/fundsAudit");
        }
        mv.addObject("tableName", tableName);
        mv.addObject("businessId", businessId);
        mv.addObject("workflowLog", workflowLog);
        mv.addObject("size", nodes.size());
        mv.addObject("type", type);
        mv.addObject("nodes", nodes);
        mv.addObject("url", url);
        return mv;
    }
    /*待办详情页*/
    @RequestMapping("/funds1/getFundsLog")
    public ModelAndView getFundsLog(String tableName, String businessId, String url, String
            backUrl,String type) {
        Start start = workflowService.getWorkflowStart(tableName, businessId);
        List<Handle> workflowLog = workflowService.getHandleList(start.getStartId());
        List<Node> nodes = workflowService.getNodeListByWorkflowId(start.getWorkflowId());
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/funds1/fundsAudtInfo");
        mv.addObject("tableName", tableName);
        mv.addObject("businessId", businessId);
        mv.addObject("workflowLog", workflowLog);
        mv.addObject("size", nodes.size());
        mv.addObject("type", type);
        mv.addObject("nodes", nodes);
        mv.addObject("url", url);
        return mv;
    }
    @RequestMapping("/funds1/relationRequest")
    public ModelAndView toRelationFunds(String id,String type) {
        ModelAndView mv = new ModelAndView();
        String flag = workflowService.getRejectState("T_BG_FUNDS1_WF", id, CommonUtil
                .getPersonId());
        if ("1".equals(flag)){
            flag = "1";
        }else{
            flag = "0";
        }
        if((type .equals("1")  && flag .equals("1") ) || type .equals("2") ){
            mv.setViewName("/business/synergy/workflow/funds1/relationFundsUnEdit");
        }else{
            mv.setViewName("/business/synergy/workflow/funds1/relationFunds");
        }
        mv.addObject("flag",flag);
        mv.addObject("id", id);
        mv.addObject("type",type);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/funds1/getRelationFundsList")
    public Map<String, List> fundsComplete(String id) {
        Map<String, List> map = new HashMap<String, List>();
        List<IndexUnAudti> list = workflowService.getRelationListById(CommonUtil.getPersonId(),id);
        map.put("data", list);
        return map;
    }

    @RequestMapping("/funds1/getWorkflowList")
    public ModelAndView getSignList(String id) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/funds1/completeList");
        mv.addObject("id", id);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/funds1/workflowList")
    public Map<String, List> viewSignList(String id, String workflowId) {
        Map<String, List> map = new HashMap<String, List>();
        List<IndexUnAudti> list = workflowService.getUnRelationList(workflowId, CommonUtil.getPersonId(), id);
        map.put("data", list);
        return map;
    }

    @ResponseBody
    @RequestMapping("/funds1/saveRelationFunds")
    public Message saveRelationFunds(String ids) {
        Funds1Relation funds1Relation = new Funds1Relation();
        funds1Relation.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
        funds1Relation.setCreator(CommonUtil.getPersonId());
        String[] arr_id = ids.split("','");
        for (int i = 0; i < arr_id.length; i++) {
            String[] arr_values = arr_id[i].split(",");
            funds1Relation.setId(CommonUtil.getUUID());
            funds1Relation.setBusinessId(arr_values[0].replace("'",""));
            funds1Relation.setUrl(arr_values[1]);
            funds1Relation.setAppUrl(arr_values[2]);
            funds1Relation.setFundsId(arr_values[3].replace("'",""));
            funds1Service.insertFundsRelation(funds1Relation);
        }
        return new Message(1, "新增成功！", null);
    }

    @ResponseBody
    @RequestMapping("/funds1/deleteRelationFundsById")
    public Message deleteFundsRelationById1(String businessId, String id) {
        funds1Service.deleteRelationById(businessId,id);
        return new Message(1, "删除成功！", null);
    }
    //手机端
    @RequestMapping("/funds1/fundsListResult")
    public ModelAndView getlistResult1(String id,String type) {
        String startId=funds1Service.getStartById(id);
        List<Handle> workflowLog = workflowService.getHandleList(startId);
        Start start = workflowService.getStartByIdApp(startId);
        String url = workflowService.getAppUrlByWorkFlowId(start.getWorkflowId());
        List<Node> nodes = workflowService.getNodeListByWorkflowId(start.getWorkflowId());
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/commonjsp/auditDoApp1");
        mv.addObject("type",type);
        mv.addObject("businessId", id);
        mv.addObject("workflowLog", workflowLog);
        mv.addObject("url", url+"?id="+start.getBusinessId());
        mv.addObject("size", nodes.size());
        mv.addObject("nodes", nodes);
        return mv;
    }
    /**PC端打印*/
    @ResponseBody
    @RequestMapping("/funds1/printFunds")
    public ModelAndView printHallUse(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/funds1/printFunds");
        String workflowName=workflowService.getWorkflowNameByWorkflowCode("T_BG_FUNDS1_WF01");
        String state = stampService.getStateById(id);
        Funds1 funds1 = funds1Service.getFundsById(id);
        List<Handle> list=stampService.getHandlebyId(id);
        int size=list.size();
        mv.addObject("handleList", list);
        mv.addObject("size",size);
        mv.addObject("state",state);
        mv.addObject("funds", funds1);
        mv.addObject("workflowName",workflowName);
        return mv;
    }
}
