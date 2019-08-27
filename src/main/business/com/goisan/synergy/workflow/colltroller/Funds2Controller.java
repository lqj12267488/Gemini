package com.goisan.synergy.workflow.colltroller;

import com.goisan.synergy.workflow.bean.Funds2;
import com.goisan.synergy.workflow.bean.Funds2Relation;
import com.goisan.synergy.workflow.service.Funds2Service;
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
public class Funds2Controller {
    @Resource
    private Funds2Service funds2Service;
    @Resource
    private EmpService empService;
    @Resource
    private WorkflowService workflowService;
    @Resource
    public DefinitionService definitionService;
    @Resource
    private StampService stampService;
    @RequestMapping("/funds2/request")
    public ModelAndView funds2List() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/funds2/funds");
        return mv;
    }

    @RequestMapping("/funds2/process")
    public ModelAndView funds2ListDb() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/funds2/fundsProcess");
        return mv;
    }

    @RequestMapping("/funds2/complete")
    public ModelAndView funds2ListYb() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/funds2/fundsComplete");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/funds2/getFundsList")
    public Map<String, List<Funds2>> funds2Action(Funds2 funds2) {
        Map<String, List<Funds2>> FundsMap = new HashMap<String, List<Funds2>>();
        funds2.setCreator(CommonUtil.getPersonId());
        funds2.setCreateDept(CommonUtil.getDefaultDept());
        FundsMap.put("data", funds2Service.fundsAction(new Funds2()));
        return FundsMap;
    }

    @ResponseBody
    @RequestMapping("/funds2/getFundsListProcess")
    public Map<String, List<Funds2>> fundsProcess(Funds2 funds2 ) {
        //String sql = workflowService.getUnAudit("T_BG_FUNDS_WF",CommonUtil.getPersonId());
        Map<String, List<Funds2>> fundsMap = new HashMap<String, List<Funds2>>();
        funds2.setCreator(CommonUtil.getPersonId());
        funds2.setCreateDept(CommonUtil.getDefaultDept());
        List<Funds2> r = funds2Service.fundsProcess(funds2);
        fundsMap.put("data", r);
        return fundsMap;
    }

    @ResponseBody
    @RequestMapping("/funds2/getFundsListComplete")
    public Map<String, List<Funds2>> fundsComplete(Funds2 funds2 ) {
        Map<String, List<Funds2>> fundsMap = new HashMap<String, List<Funds2>>();
        funds2.setCreator(CommonUtil.getPersonId());
        funds2.setCreateDept(CommonUtil.getDefaultDept());
        List<Funds2> r = funds2Service.fundsComplete(funds2);
        fundsMap.put("data", r);
        return fundsMap;
    }

    @ResponseBody
    @RequestMapping("/funds2/search")
    public Map<String, List<Funds2>> search(Funds2 funds2){
        Map<String, List<Funds2>>  fundsMap = new HashMap<String, List<Funds2>>();
        funds2.setCreator(CommonUtil.getPersonId());
        funds2.setCreateDept(CommonUtil.getDefaultDept());
       /* List<Funds> r = fundsService.fundsAction(funds);
        fundsMap.put("data", r);
        return fundsMap;*/
        fundsMap.put("data", funds2Service.fundsAction(funds2));
        return fundsMap;
    }
    @ResponseBody
    @RequestMapping("/funds2/getFundsById")
    public ModelAndView getFundsById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/funds2/editFunds");
        Funds2 funds2 = funds2Service.getFundsById(id);
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+"T"+time;
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        funds2.setRequestDate(datetime);
        funds2.setManager(personName);
        funds2.setRequestDept(deptName);
        mv.addObject("head", "修改申请");
        mv.addObject("funds2", funds2);
        return mv;
    }

    @RequestMapping("/funds2/addFunds")
    public ModelAndView addFunds() {
        Funds2 funds2 = new Funds2();
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/funds2/editFunds");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+"T"+time;
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        funds2.setRequestDate(datetime);
        funds2.setManager(personName);
        funds2.setRequestDept(deptName);
        mv.addObject("name",personName);
        mv.addObject("dept",deptName);
        mv.addObject("funds2",funds2);
        mv.addObject("head", "新增申请");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/funds2/deleteFundsById")
    public Message deleteFundsById(String id) {
        funds2Service.deleteById(id);
        return new Message(1, "删除成功！", null);
    }

    @ResponseBody
    @RequestMapping("/funds2/saveFunds")
    public Message saveFunds(Funds2 funds2){
        funds2.setRequestDept(CommonUtil.getLoginUser().getDefaultDeptId());
        funds2.setManager(CommonUtil.getPersonId());
        if(funds2.getId()==null || funds2.getId().equals("")){
            funds2.setCreator(CommonUtil.getPersonId());
            funds2.setCreateDept(CommonUtil.getDefaultDept());
            funds2.setId(CommonUtil.getUUID());
            funds2.setRequestFlag("0");
            String upper = UpperMoney.change(Double.parseDouble(funds2.getAmount()));
            funds2.setAmountUpper(upper);
            funds2Service.insertFunds(funds2);
            return new Message(1, "新增成功！", null);
        }else{
            funds2.setChanger(CommonUtil.getPersonId());
            funds2.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            String upper = UpperMoney.change(Double.parseDouble(funds2.getAmount()));
            funds2.setAmountUpper(upper);
            funds2Service.updateFunds(funds2);
            return new Message(1, "修改成功！", null);
        }
    }

    @ResponseBody
    @RequestMapping("/funds2/getDept")
    public List<AutoComplete> getDept() {
        return funds2Service.selectDept();
    }

    @ResponseBody
    @RequestMapping("/funds2/getPerson")
    public List<AutoComplete> getPerson() {
        return funds2Service.selectPerson();
    }

    @ResponseBody
    @RequestMapping("/funds2/auditFundsById")
    public ModelAndView waitRoleById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/funds2/addFundsProcess");
        Funds2 funds2 = funds2Service.getFundsById(id);
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
        mv.addObject("funds2", funds2);
        mv.addObject("head", "审批");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/funds2/auditEdit")
    public ModelAndView auditEdit(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/funds2/auditEditFunds");
        Funds2 funds2 = funds2Service.getFundsById(id);
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+"T"+time;
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        funds2.setRequestDate(datetime);
        funds2.setManager(personName);
        funds2.setRequestDept(deptName);
        mv.addObject("name",personName);
        mv.addObject("dept",deptName);
        mv.addObject("head", "修改");
        mv.addObject("funds2", funds2);
        return mv;
    }
    /*待办关联业务jsp*/
    @RequestMapping("/funds2/processLoadIndexUnAudit")
    public ModelAndView loadIndexUnAudit(String id) {
        String personId = CommonUtil.getPersonId();
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/funds2/fundUnAudit");
        //mv.addObject("task",   taskService.findTaskList(personId));
        mv.addObject("data", workflowService.getRelationListById(personId,id));
        return mv;
    }
    /*关联中的详情页*/
    @RequestMapping("/funds2/getWotkflowLog")
    public ModelAndView getWotkflowLog(String tableName, String businessId, String url, String
            backUrl,String type) {
        ModelAndView mv = null;
        Start start = workflowService.getWorkflowStart(tableName, businessId);
        List<Handle> workflowLog = workflowService.getHandleList(start.getStartId());
        List<Node> nodes = workflowService.getNodeListByWorkflowId(start.getWorkflowId());
        if ("1".equals(type)){
            mv = new ModelAndView("/business/synergy/workflow/funds2/fundsAuditRelation");
        }else{
            mv = new ModelAndView("/business/synergy/workflow/funds2/fundsAudit");
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
    @RequestMapping("/funds2/getFundsLog")
    public ModelAndView getFundsLog(String tableName, String businessId, String url, String
            backUrl,String type) {
        Start start = workflowService.getWorkflowStart(tableName, businessId);
        List<Handle> workflowLog = workflowService.getHandleList(start.getStartId());
        List<Node> nodes = workflowService.getNodeListByWorkflowId(start.getWorkflowId());
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/funds2/fundsAudtInfo");
        mv.addObject("tableName", tableName);
        mv.addObject("businessId", businessId);
        mv.addObject("workflowLog", workflowLog);
        mv.addObject("size", nodes.size());
        mv.addObject("type", type);
        mv.addObject("nodes", nodes);
        mv.addObject("url", url);
        return mv;
    }
    @RequestMapping("/funds2/relationRequest")
    public ModelAndView toRelationFunds(String id,String type) {
        ModelAndView mv = new ModelAndView();
        String flag = workflowService.getRejectState("T_BG_FUNDS2_WF", id, CommonUtil
                .getPersonId());
        if ("1".equals(flag)){
            flag = "1";
        }else{
            flag = "0";
        }
        if((type .equals("1")  && flag .equals("1") ) || type .equals("2") ){
            mv.setViewName("/business/synergy/workflow/funds2/relationFundsUnEdit");
        }else{
            mv.setViewName("/business/synergy/workflow/funds2/relationFunds");
        }
        mv.addObject("flag",flag);
        mv.addObject("id", id);
        mv.addObject("type",type);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/funds2/getRelationFundsList")
    public Map<String, List> fundsComplete(String id) {
        Map<String, List> map = new HashMap<String, List>();
        List<IndexUnAudti> list = workflowService.getRelationListById(CommonUtil.getPersonId(),id);
        map.put("data", list);
        return map;
    }

    @RequestMapping("/funds2/getWorkflowList")
    public ModelAndView getSignList(String id) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/funds2/completeList");
        mv.addObject("id", id);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/funds2/workflowList")
    public Map<String, List> viewSignList(String id, String workflowId) {
        Map<String, List> map = new HashMap<String, List>();
        String a = CommonUtil.getPersonId();
        List<IndexUnAudti> list = workflowService.getUnRelationList(workflowId, CommonUtil.getPersonId(), id);
        map.put("data", list);
        return map;
    }

    @ResponseBody
    @RequestMapping("/funds2/saveRelationFunds")
    public Message saveRelationFunds(String ids) {
        Funds2Relation funds2Relation = new Funds2Relation();
        funds2Relation.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
        funds2Relation.setCreator(CommonUtil.getPersonId());
        String[] arr_id = ids.split("','");
        for (int i = 0; i < arr_id.length; i++) {
            String[] arr_values = arr_id[i].split(",");
            funds2Relation.setId(CommonUtil.getUUID());
            funds2Relation.setBusinessId(arr_values[0].replace("'",""));
            funds2Relation.setUrl(arr_values[1]);
            funds2Relation.setAppUrl(arr_values[2]);
            funds2Relation.setFundsId(arr_values[3].replace("'",""));
            funds2Service.insertFundsRelation(funds2Relation);
        }
        return new Message(1, "新增成功！", null);
    }

    @ResponseBody
    @RequestMapping("/funds2/deleteRelationFundsById")
    public Message deleteFundsRelationById1(String businessId, String id) {
        funds2Service.deleteRelationById(businessId,id);
        return new Message(1, "删除成功！", null);
    }
    //手机端
    @RequestMapping("/funds2/fundsListResult")
    public ModelAndView getlistResult1(String id,String type) {
        String startId=funds2Service.getStartById(id);
        List<Handle> workflowLog = workflowService.getHandleList(startId);
        Start start = workflowService.getStartByIdApp(startId);
        String url = workflowService.getAppUrlByWorkFlowId(start.getWorkflowId());
        List<Node> nodes = workflowService.getNodeListByWorkflowId(start.getWorkflowId());
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/commonjsp/auditDoApp2");
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
    @RequestMapping("/funds2/printFunds")
    public ModelAndView printHallUse(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/funds2/printFunds");
        String workflowName=workflowService.getWorkflowNameByWorkflowCode("T_BG_FUNDS2_WF01");
        String state = stampService.getStateById(id);
        Funds2 funds2 = funds2Service.getFundsById(id);
        List<Handle> list=stampService.getHandlebyId(id);
        int size=list.size();
        mv.addObject("handleList", list);
        mv.addObject("size",size);
        mv.addObject("state",state);
        mv.addObject("funds", funds2);
        mv.addObject("workflowName",workflowName);
        return mv;
    }
}
