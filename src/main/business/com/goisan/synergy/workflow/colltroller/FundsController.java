package com.goisan.synergy.workflow.colltroller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.synergy.workflow.bean.Funds;
import com.goisan.synergy.workflow.bean.FundsRelation;
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
public class FundsController {
    @Resource
    private FundsService fundsService;
    @Resource
    private EmpService empService;
    @Resource
    private WorkflowService workflowService;
    @Resource
    public DefinitionService definitionService;
    @Resource
    private StampService stampService;
    @RequestMapping("/funds/request")
    public ModelAndView fundsList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/funds/funds");
        return mv;
    }

    @RequestMapping("/funds/process")
    public ModelAndView fundsListDb() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/funds/fundsProcess");
        return mv;
    }

    @RequestMapping("/funds/complete")
    public ModelAndView fundsListYb() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/funds/fundsComplete");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/funds/getFundsList")
    public Map<String, Object> fundsAction(Funds funds, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> fundss = new HashMap();
        funds.setCreator(CommonUtil.getPersonId());
        funds.setCreateDept(CommonUtil.getDefaultDept());
        List<Funds> list = fundsService.fundsAction(funds);
        PageInfo<List<Funds>> info = new PageInfo(list);
        fundss.put("draw", draw);
        fundss.put("recordsTotal", info.getTotal());
        fundss.put("recordsFiltered", info.getTotal());
        fundss.put("data", list);
        return fundss;
    }

    @ResponseBody
    @RequestMapping("/funds/getFundsListProcess")
    public Map<String, Object> fundsProcess(Funds funds, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> fundss = new HashMap();
        Map<String, List<Funds>> fundsMap = new HashMap<String, List<Funds>>();
        funds.setCreator(CommonUtil.getPersonId());
        funds.setCreateDept(CommonUtil.getDefaultDept());
        List<Funds> r = fundsService.fundsProcess(funds);

        PageInfo<List<Funds>> info = new PageInfo(r);
        fundss.put("draw", draw);
        fundss.put("recordsTotal", info.getTotal());
        fundss.put("recordsFiltered", info.getTotal());
        fundss.put("data", r);
        return fundss;
    }

    @ResponseBody
    @RequestMapping("/funds/getFundsListComplete")
    public Map<String, Object> fundsComplete(Funds funds, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> fundss = new HashMap();
        Map<String, List<Funds>> fundsMap = new HashMap<String, List<Funds>>();
        funds.setCreator(CommonUtil.getPersonId());
        funds.setCreateDept(CommonUtil.getDefaultDept());
        List<Funds> r = fundsService.fundsComplete(funds);

        PageInfo<List<Funds>> info = new PageInfo(r);
        fundss.put("draw", draw);
        fundss.put("recordsTotal", info.getTotal());
        fundss.put("recordsFiltered", info.getTotal());
        fundss.put("data", r);
        return fundss;
    }

    @ResponseBody
    @RequestMapping("/funds/search")
    public Map<String, Object> search(Funds funds,int draw,int start,int length){
        PageHelper.startPage(start/length + 1,length);
        Map<String, Object>  fundsMap = new HashMap<String, Object>();
        /*fundsMap.put("data",fundsService.fundsAction(funds));*/
        funds.setCreator(CommonUtil.getPersonId());
        funds.setCreateDept(CommonUtil.getDefaultDept());
        List<Funds> list = fundsService.fundsAction(funds);
        PageInfo<List<Funds>> info = new PageInfo(list);
        fundsMap.put("draw",draw);
        fundsMap.put("recordsTotal",info.getTotal());
        fundsMap.put("recordsFiltered",info.getTotal());
        fundsMap.put("data",list);
       /* List<Funds> r = fundsService.fundsAction(funds);
        fundsMap.put("data", r);
        return fundsMap;*/
        //fundsMap.put("data", fundsService.fundsAction(funds));
        return fundsMap;
    }
    @ResponseBody
    @RequestMapping("/funds/getFundsById")
    public ModelAndView getFundsById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/funds/editFunds");
        Funds funds = fundsService.getFundsById(id);
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+"T"+time;
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        funds.setRequestDate(datetime);
        funds.setManager(personName);
        funds.setRequestDept(deptName);
        mv.addObject("head", "修改申请");
        mv.addObject("funds", funds);
        return mv;
    }

    @RequestMapping("/funds/addFunds")
    public ModelAndView addFunds() {
        Funds funds = new Funds();
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/funds/editFunds");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+"T"+time;
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        funds.setRequestDate(datetime);
        funds.setManager(personName);
        funds.setRequestDept(deptName);
        mv.addObject("name",personName);
        mv.addObject("dept",deptName);
        mv.addObject("funds",funds);
        mv.addObject("head", "新增申请");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/funds/deleteFundsById")
    public Message deleteFundsById(String id) {
        fundsService.deleteById(id);
        return new Message(1, "删除成功！", null);
    }

    @ResponseBody
    @RequestMapping("/funds/saveFunds")
    public Message saveFunds(Funds funds){
        funds.setRequestDept(CommonUtil.getLoginUser().getDefaultDeptId());
        funds.setManager(CommonUtil.getPersonId());
        if(funds.getId()==null || funds.getId().equals("")){
            funds.setCreator(CommonUtil.getPersonId());
            funds.setCreateDept(CommonUtil.getDefaultDept());
            funds.setId(CommonUtil.getUUID());
            funds.setRequestFlag("0");
            String upper = UpperMoney.change(Double.parseDouble(funds.getAmount()));
            funds.setAmountUpper(upper);
            fundsService.insertFunds(funds);
            return new Message(1, "新增成功！", null);
        }else{
            funds.setChanger(CommonUtil.getPersonId());
            funds.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            String upper = UpperMoney.change(Double.parseDouble(funds.getAmount()));
            funds.setAmountUpper(upper);
            fundsService.updateFunds(funds);
            return new Message(1, "修改成功！", null);
        }
    }

    @ResponseBody
    @RequestMapping("/funds/getDept")
    public List<AutoComplete> getDept() {
        return fundsService.selectDept();
    }

    @ResponseBody
    @RequestMapping("/funds/getPerson")
    public List<AutoComplete> getPerson() {
        return fundsService.selectPerson();
    }

    @ResponseBody
    @RequestMapping("/funds/auditFundsById")
    public ModelAndView waitRoleById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/funds/addFundsProcess");
        Funds funds = fundsService.getFundsById(id);
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
        mv.addObject("funds", funds);
        mv.addObject("head", "审批");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/funds/auditEdit")
    public ModelAndView auditEdit(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/funds/auditEditFunds");
        Funds funds = fundsService.getFundsById(id);
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+"T"+time;
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        funds.setRequestDate(datetime);
        funds.setManager(personName);
        funds.setRequestDept(deptName);
        mv.addObject("name",personName);
        mv.addObject("dept",deptName);
        mv.addObject("head", "修改");
        mv.addObject("funds", funds);
        return mv;
    }
    /*待办关联业务jsp*/
    @RequestMapping("/funds/processLoadIndexUnAudit")
    public ModelAndView loadIndexUnAudit(String id) {
        String personId = CommonUtil.getPersonId();
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/funds/fundUnAudit");
        //mv.addObject("task",   taskService.findTaskList(personId));
        mv.addObject("data", workflowService.getRelationListById(personId,id));
        return mv;
    }
    /*关联中的详情页*/
    @RequestMapping("/funds/getWotkflowLog")
    public ModelAndView getWotkflowLog(String tableName, String businessId, String url, String
            backUrl,String type) {
        ModelAndView mv = null;
        Start start = workflowService.getWorkflowStart(tableName, businessId);
        List<Handle> workflowLog = workflowService.getHandleList(start.getStartId());
        List<Node> nodes = workflowService.getNodeListByWorkflowId(start.getWorkflowId());
        if ("1".equals(type)){
            mv = new ModelAndView("/business/synergy/workflow/funds/fundsAuditRelation");
        }else{
            mv = new ModelAndView("/business/synergy/workflow/funds/fundsAudit");
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
    @RequestMapping("/funds/getFundsLog")
    public ModelAndView getFundsLog(String tableName, String businessId, String url, String
            backUrl,String type) {
        Start start = workflowService.getWorkflowStart(tableName, businessId);
        List<Handle> workflowLog = workflowService.getHandleList(start.getStartId());
        List<Node> nodes = workflowService.getNodeListByWorkflowId(start.getWorkflowId());
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/funds/fundsAudtInfo");
        mv.addObject("tableName", tableName);
        mv.addObject("businessId", businessId);
        mv.addObject("workflowLog", workflowLog);
        mv.addObject("size", nodes.size());
        mv.addObject("type", type);
        mv.addObject("nodes", nodes);
        mv.addObject("url", url);
        return mv;
    }
    @RequestMapping("/funds/relationRequest")
    public ModelAndView toRelationFunds(String id,String type) {
        ModelAndView mv = new ModelAndView();
        String flag = workflowService.getRejectState("T_BG_FUNDS_WF", id, CommonUtil
                .getPersonId());
        if ("1".equals(flag)){
            flag = "1";
        }else{
            flag = "0";
        }
        if((type .equals("1")  && flag .equals("1") ) || type .equals("2") ){
            mv.setViewName("/business/synergy/workflow/funds/relationFundsUnEdit");
        }else{
            mv.setViewName("/business/synergy/workflow/funds/relationFunds");
        }
        mv.addObject("flag",flag);
        mv.addObject("id", id);
        mv.addObject("type",type);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/funds/getRelationFundsList")
    public Map<String, List> fundsComplete(String id) {
        Map<String, List> map = new HashMap<String, List>();
        List<IndexUnAudti> list = workflowService.getRelationListById(CommonUtil.getPersonId(),id);
        map.put("data", list);
        return map;
    }

    @RequestMapping("/funds/getWorkflowList")
    public ModelAndView getSignList(String id) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/funds/completeList");
        mv.addObject("id", id);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/funds/workflowList")
    public Map<String, List> viewSignList(String id, String workflowId) {
        Map<String, List> map = new HashMap<String, List>();
        List<IndexUnAudti> list = workflowService.getUnRelationList(workflowId, CommonUtil.getPersonId(), id);
        map.put("data", list);
        return map;
    }

    @ResponseBody
    @RequestMapping("/funds/saveRelationFunds")
    public Message saveRelationFunds(String ids) {
        FundsRelation fundsRelation = new FundsRelation();
        fundsRelation.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
        fundsRelation.setCreator(CommonUtil.getPersonId());
        String[] arr_id = ids.split("','");
        for (int i = 0; i < arr_id.length; i++) {
            String[] arr_values = arr_id[i].split(",");
            fundsRelation.setId(CommonUtil.getUUID());
            fundsRelation.setBusinessId(arr_values[0].replace("'",""));
            fundsRelation.setUrl(arr_values[1]);
            fundsRelation.setAppUrl(arr_values[2]);
            fundsRelation.setFundsId(arr_values[3].replace("'",""));
            fundsService.insertFundsRelation(fundsRelation);
        }
        return new Message(1, "新增成功！", null);
    }

    @ResponseBody
    @RequestMapping("/funds/deleteRelationFundsById")
    public Message deleteFundsRelationById(String businessId, String id) {
        fundsService.deleteRelationById(businessId,id);
        return new Message(1, "删除成功！", null);
    }
    //手机端
    @RequestMapping("/funds/fundsListResult")
    public ModelAndView getlistResult(String id,String type) {
        String startId=fundsService.getStartById(id);
        List<Handle> workflowLog = workflowService.getHandleList(startId);
        Start start = workflowService.getStartByIdApp(startId);
        String url = workflowService.getAppUrlByWorkFlowId(start.getWorkflowId());
        List<Node> nodes = workflowService.getNodeListByWorkflowId(start.getWorkflowId());
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/commonjsp/auditDoApp");
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
    @RequestMapping("/funds/printFunds")
    public ModelAndView printHallUse(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/funds/printFunds");
        String workflowName=workflowService.getWorkflowNameByWorkflowCode("T_BG_FUNDS_WF01");
        String state = stampService.getStateById(id);
        Funds funds = fundsService.getFundsById(id);
        List<Handle> list=stampService.getHandlebyId(id);
        int size=list.size();
        mv.addObject("handleList", list);
        mv.addObject("size",size);
        mv.addObject("state",state);
        mv.addObject("funds", funds);
        mv.addObject("workflowName",workflowName);
        return mv;
    }
}
