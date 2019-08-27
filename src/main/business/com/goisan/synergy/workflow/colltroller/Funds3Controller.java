package com.goisan.synergy.workflow.colltroller;

import com.goisan.synergy.workflow.bean.Funds3;
import com.goisan.synergy.workflow.bean.Funds3Relation;
import com.goisan.synergy.workflow.service.Funds3Service;
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
public class Funds3Controller {
    @Resource
    private Funds3Service funds3Service;
    @Resource
    private EmpService empService;
    @Resource
    private WorkflowService workflowService;
    @Resource
    public DefinitionService definitionService;
    @Resource
    private StampService stampService;
    @RequestMapping("/funds3/request")
    public ModelAndView funds3List() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/funds3/funds");
        return mv;
    }

    @RequestMapping("/funds3/process")
    public ModelAndView funds3ListDb() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/funds3/fundsProcess");
        return mv;
    }

    @RequestMapping("/funds3/complete")
    public ModelAndView funds3ListYb() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/funds3/fundsComplete");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/funds3/getFundsList")
    public Map<String, List<Funds3>> funds3Action(Funds3 funds3) {
        Map<String, List<Funds3>> FundsMap = new HashMap<String, List<Funds3>>();
        funds3.setCreator(CommonUtil.getPersonId());
        funds3.setCreateDept(CommonUtil.getDefaultDept());
        FundsMap.put("data", funds3Service.fundsAction(new Funds3()));
        return FundsMap;
    }

    @ResponseBody
    @RequestMapping("/funds3/getFundsListProcess")
    public Map<String, List<Funds3>> fundsProcess(Funds3 funds3 ) {
        //String sql = workflowService.getUnAudit("T_BG_FUNDS_WF",CommonUtil.getPersonId());
        Map<String, List<Funds3>> fundsMap = new HashMap<String, List<Funds3>>();
        funds3.setCreator(CommonUtil.getPersonId());
        funds3.setCreateDept(CommonUtil.getDefaultDept());
        List<Funds3> r = funds3Service.fundsProcess(funds3);
        fundsMap.put("data", r);
        return fundsMap;
    }

    @ResponseBody
    @RequestMapping("/funds3/getFundsListComplete")
    public Map<String, List<Funds3>> fundsComplete(Funds3 funds3 ) {
        Map<String, List<Funds3>> fundsMap = new HashMap<String, List<Funds3>>();
        funds3.setCreator(CommonUtil.getPersonId());
        funds3.setCreateDept(CommonUtil.getDefaultDept());
        List<Funds3> r = funds3Service.fundsComplete(funds3);
        fundsMap.put("data", r);
        return fundsMap;
    }

    @ResponseBody
    @RequestMapping("/funds3/search")
    public Map<String, List<Funds3>> search(Funds3 funds3){
        Map<String, List<Funds3>>  fundsMap = new HashMap<String, List<Funds3>>();
        funds3.setCreator(CommonUtil.getPersonId());
        funds3.setCreateDept(CommonUtil.getDefaultDept());
       /* List<Funds> r = fundsService.fundsAction(funds);
        fundsMap.put("data", r);
        return fundsMap;*/
        fundsMap.put("data", funds3Service.fundsAction(funds3));
        return fundsMap;
    }
    @ResponseBody
    @RequestMapping("/funds3/getFundsById")
    public ModelAndView getFundsById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/funds3/editFunds");
        Funds3 funds3 = funds3Service.getFundsById(id);
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+"T"+time;
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        funds3.setRequestDate(datetime);
        funds3.setManager(personName);
        funds3.setRequestDept(deptName);
        mv.addObject("head", "修改申请");
        mv.addObject("funds3", funds3);
        return mv;
    }

    @RequestMapping("/funds3/addFunds")
    public ModelAndView addFunds() {
        Funds3 funds3 = new Funds3();
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/funds3/editFunds");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+"T"+time;
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        funds3.setRequestDate(datetime);
        funds3.setManager(personName);
        funds3.setRequestDept(deptName);
        mv.addObject("name",personName);
        mv.addObject("dept",deptName);
        mv.addObject("funds3",funds3);
        mv.addObject("head", "新增申请");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/funds3/deleteFundsById")
    public Message deleteFundsById(String id) {
        funds3Service.deleteById(id);
        return new Message(1, "删除成功！", null);
    }

    @ResponseBody
    @RequestMapping("/funds3/saveFunds")
    public Message saveFunds(Funds3 funds3){
        funds3.setRequestDept(CommonUtil.getLoginUser().getDefaultDeptId());
        funds3.setManager(CommonUtil.getPersonId());
        if(funds3.getId()==null || funds3.getId().equals("")){
            funds3.setCreator(CommonUtil.getPersonId());
            funds3.setCreateDept(CommonUtil.getDefaultDept());
            funds3.setId(CommonUtil.getUUID());
            funds3.setRequestFlag("0");
            String upper = UpperMoney.change(Double.parseDouble(funds3.getAmount()));
            funds3.setAmountUpper(upper);
            funds3Service.insertFunds(funds3);
            return new Message(1, "新增成功！", null);
        }else{
            funds3.setChanger(CommonUtil.getPersonId());
            funds3.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            String upper = UpperMoney.change(Double.parseDouble(funds3.getAmount()));
            funds3.setAmountUpper(upper);
            funds3Service.updateFunds(funds3);
            return new Message(1, "修改成功！", null);
        }
    }

    @ResponseBody
    @RequestMapping("/funds3/getDept")
    public List<AutoComplete> getDept() {
        return funds3Service.selectDept();
    }

    @ResponseBody
    @RequestMapping("/funds3/getPerson")
    public List<AutoComplete> getPerson() {
        return funds3Service.selectPerson();
    }

    @ResponseBody
    @RequestMapping("/funds3/auditFundsById")
    public ModelAndView waitRoleById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/funds3/addFundsProcess");
        Funds3 funds3 = funds3Service.getFundsById(id);
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
        mv.addObject("funds3", funds3);
        mv.addObject("head", "审批");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/funds3/auditEdit")
    public ModelAndView auditEdit(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/funds3/auditEditFunds");
        Funds3 funds3 = funds3Service.getFundsById(id);
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+"T"+time;
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        funds3.setRequestDate(datetime);
        funds3.setManager(personName);
        funds3.setRequestDept(deptName);
        mv.addObject("name",personName);
        mv.addObject("dept",deptName);
        mv.addObject("head", "修改");
        mv.addObject("funds3", funds3);
        return mv;
    }
    /*待办关联业务jsp*/
    @RequestMapping("/funds3/processLoadIndexUnAudit")
    public ModelAndView loadIndexUnAudit(String id) {
        String personId = CommonUtil.getPersonId();
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/funds3/fundUnAudit");
        //mv.addObject("task",   taskService.findTaskList(personId));
        mv.addObject("data", workflowService.getRelationListById(personId,id));
        return mv;
    }
    /*关联中的详情页*/
    @RequestMapping("/funds3/getWotkflowLog")
    public ModelAndView getWotkflowLog(String tableName, String businessId, String url, String
            backUrl,String type) {
        ModelAndView mv = null;
        Start start = workflowService.getWorkflowStart(tableName, businessId);
        List<Handle> workflowLog = workflowService.getHandleList(start.getStartId());
        List<Node> nodes = workflowService.getNodeListByWorkflowId(start.getWorkflowId());
        if ("1".equals(type)){
            mv = new ModelAndView("/business/synergy/workflow/funds3/fundsAuditRelation");
        }else{
            mv = new ModelAndView("/business/synergy/workflow/funds3/fundsAudit");
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
    @RequestMapping("/funds3/getFundsLog")
    public ModelAndView getFundsLog(String tableName, String businessId, String url, String
            backUrl,String type) {
        Start start = workflowService.getWorkflowStart(tableName, businessId);
        List<Handle> workflowLog = workflowService.getHandleList(start.getStartId());
        List<Node> nodes = workflowService.getNodeListByWorkflowId(start.getWorkflowId());
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/funds3/fundsAudtInfo");
        mv.addObject("tableName", tableName);
        mv.addObject("businessId", businessId);
        mv.addObject("workflowLog", workflowLog);
        mv.addObject("size", nodes.size());
        mv.addObject("type", type);
        mv.addObject("nodes", nodes);
        mv.addObject("url", url);
        return mv;
    }
    @RequestMapping("/funds3/relationRequest")
    public ModelAndView toRelationFunds(String id,String type) {
        ModelAndView mv = new ModelAndView();
        String flag = workflowService.getRejectState("T_BG_FUNDS3_WF", id, CommonUtil
                .getPersonId());
        if ("1".equals(flag)){
            flag = "1";
        }else{
            flag = "0";
        }
        if((type .equals("1")  && flag .equals("1") ) || type .equals("2") ){
            mv.setViewName("/business/synergy/workflow/funds3/relationFundsUnEdit");
        }else{
            mv.setViewName("/business/synergy/workflow/funds3/relationFunds");
        }
        mv.addObject("flag",flag);
        mv.addObject("id", id);
        mv.addObject("type",type);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/funds3/getRelationFundsList")
    public Map<String, List> fundsComplete(String id) {
        Map<String, List> map = new HashMap<String, List>();
        List<IndexUnAudti> list = workflowService.getRelationListById(CommonUtil.getPersonId(),id);
        map.put("data", list);
        return map;
    }

    @RequestMapping("/funds3/getWorkflowList")
    public ModelAndView getSignList(String id) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/funds3/completeList");
        mv.addObject("id", id);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/funds3/workflowList")
    public Map<String, List> viewSignList(String id, String workflowId) {
        Map<String, List> map = new HashMap<String, List>();
        List<IndexUnAudti> list = workflowService.getUnRelationList(workflowId, CommonUtil.getPersonId(), id);
        map.put("data", list);
        return map;
    }

    @ResponseBody
    @RequestMapping("/funds3/saveRelationFunds")
    public Message saveRelationFunds(String ids) {
        Funds3Relation funds3Relation = new Funds3Relation();
        funds3Relation.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
        funds3Relation.setCreator(CommonUtil.getPersonId());
        String[] arr_id = ids.split("','");
        for (int i = 0; i < arr_id.length; i++) {
            String[] arr_values = arr_id[i].split(",");
            funds3Relation.setId(CommonUtil.getUUID());
            funds3Relation.setBusinessId(arr_values[0].replace("'",""));
            funds3Relation.setUrl(arr_values[1]);
            funds3Relation.setAppUrl(arr_values[2]);
            funds3Relation.setFundsId(arr_values[3].replace("'",""));
            funds3Service.insertFundsRelation(funds3Relation);
        }
        return new Message(1, "新增成功！", null);
    }

    @ResponseBody
    @RequestMapping("/funds3/deleteRelationFundsById")
    public Message deleteFundsRelationById1(String businessId, String id) {
        funds3Service.deleteRelationById(businessId,id);
        return new Message(1, "删除成功！", null);
    }
    //手机端
    @RequestMapping("/funds3/fundsListResult")
    public ModelAndView getlistResult1(String id,String type) {
        String startId=funds3Service.getStartById(id);
        List<Handle> workflowLog = workflowService.getHandleList(startId);
        Start start = workflowService.getStartByIdApp(startId);
        String url = workflowService.getAppUrlByWorkFlowId(start.getWorkflowId());
        List<Node> nodes = workflowService.getNodeListByWorkflowId(start.getWorkflowId());
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/commonjsp/auditDoApp3");
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
    @RequestMapping("/funds3/printFunds")
    public ModelAndView printHallUse(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/funds3/printFunds");
        String workflowName=workflowService.getWorkflowNameByWorkflowCode("T_BG_FUNDS3_WF01");
        String state = stampService.getStateById(id);
        Funds3 funds3 = funds3Service.getFundsById(id);
        List<Handle> list=stampService.getHandlebyId(id);
        int size=list.size();
        mv.addObject("handleList", list);
        mv.addObject("size",size);
        mv.addObject("state",state);
        mv.addObject("funds", funds3);
        mv.addObject("workflowName",workflowName);
        return mv;
    }
}
