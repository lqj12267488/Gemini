package com.goisan.synergy.workflow.colltroller;



import com.goisan.synergy.workflow.bean.LeagueRelation;
import com.goisan.synergy.workflow.bean.Leagues;
import com.goisan.synergy.workflow.service.LeaguesService;
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
public class LeaguesController {
    @Resource
    private LeaguesService leaguesService;
    @Resource
    private EmpService empService;
    @Resource
    private WorkflowService workflowService;
    @Resource
    public DefinitionService definitionService;
    @Resource
    public StampService stampService;
    @RequestMapping("/leagues/request")
    public ModelAndView leagueList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/leagues/leaguesRequest");
        return mv;
    }

    @RequestMapping("/leagues/process")
    public ModelAndView leagueListDb() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/leagues/leaguesProcess");
        return mv;
    }

    @RequestMapping("/leagues/complete")
    public ModelAndView leagueListYb() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/leagues/leaguesComplete");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/leagues/getLeaguesList")
    public Map<String, List<Leagues>> leaguesAction(Leagues leagues) {
        Map<String, List<Leagues>> leagueMap = new HashMap<String, List<Leagues>>();
        leagues.setCreator(CommonUtil.getPersonId());
        leagues.setCreateDept(CommonUtil.getDefaultDept());
        leagueMap.put("data", leaguesService.leaguesAction(leagues));
        return leagueMap;
    }

    @ResponseBody
    @RequestMapping("/leagues/getLeaguesListProcess")
    public Map<String, List<Leagues>> leagueProcess(Leagues leagues) {
        Map<String, List<Leagues>> leagueMap = new HashMap<String, List<Leagues>>();
        leagues.setCreator(CommonUtil.getPersonId());
        leagues.setCreateDept(CommonUtil.getDefaultDept());
        List<Leagues> r = leaguesService.leaguesProcess(leagues);
        leagueMap.put("data", r);
        return leagueMap;
    }

    @ResponseBody
    @RequestMapping("/leagues/getLeagueListComplete")
    public Map<String, List<Leagues>> leagueComplete(Leagues leagues) {
        Map<String, List<Leagues>> leagueMap = new HashMap<String, List<Leagues>>();
        leagues.setCreator(CommonUtil.getPersonId());
        leagues.setCreateDept(CommonUtil.getDefaultDept());
        List<Leagues> r = leaguesService.leaguesComplete(leagues);
        leagueMap.put("data", r);
        return leagueMap;
    }

    @ResponseBody
    @RequestMapping("/leagues/search")
    public Map<String, List<Leagues>> search(Leagues leagues){
        Map<String, List<Leagues>>  leagueMap = new HashMap<String, List<Leagues>>();
        leagues.setCreator(CommonUtil.getPersonId());
        leagues.setCreateDept(CommonUtil.getDefaultDept());
        leagueMap.put("data", leaguesService.leaguesAction(leagues));
        return leagueMap;
    }
    @ResponseBody
    @RequestMapping("/leagues/getLeagueById")
    public ModelAndView getLeagueById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/leagues/editLeagues");
        Leagues leagues = leaguesService.getLeaguesById(id);
        String date = leagues.getRequestDate().substring(0,10);
        String time = leagues.getRequestDate().substring(11,16);
        String datetime = date+"T"+time;
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        leagues.setRequestDate(datetime);
        leagues.setManager(personName);
        leagues.setRequestDept(deptName);
        mv.addObject("head", "修改申请");
        mv.addObject("leagues", leagues);
        return mv;
    }

    @RequestMapping("/leagues/addLeague")
    public ModelAndView addLeague() {
        Leagues leagues = new Leagues();
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/leagues/editLeagues");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+"T"+time;
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        leagues.setRequestDate(datetime);
        leagues.setManager(personName);
        leagues.setRequestDept(deptName);
        mv.addObject("name",personName);
        mv.addObject("dept",deptName);
        mv.addObject("leagues",leagues);
        mv.addObject("head", "新增申请");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/leagues/deleteLeaguesById")
    public Message deleteLeagueById(String id) {
        leaguesService.deleteById(id);
        return new Message(1, "删除成功！", null);
    }

    @ResponseBody
    @RequestMapping("/leagues/saveLeague")
    public Message saveLeague(Leagues leagues){
        leagues.setRequestDept(CommonUtil.getLoginUser().getDefaultDeptId());
        leagues.setManager(CommonUtil.getPersonId());
        if(leagues.getId()==null || leagues.getId().equals("")){
            leagues.setCreator(CommonUtil.getPersonId());
            leagues.setCreateDept(CommonUtil.getDefaultDept());
            leagues.setId(CommonUtil.getUUID());
            leagues.setRequestFlag("0");
            String upper = UpperMoney.change(Double.parseDouble(leagues.getAmount()));
            leagues.setAmountUpper(upper);
            leaguesService.insertLeagues(leagues);
            return new Message(1, "新增成功！", null);
        }else{
            leagues.setChanger(CommonUtil.getPersonId());
            leagues.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            String upper = UpperMoney.change(Double.parseDouble(leagues.getAmount()));
            leagues.setAmountUpper(upper);
            leaguesService.updateLeagues(leagues);
            return new Message(1, "修改成功！", null);
        }
    }

    @ResponseBody
    @RequestMapping("/leagues/getDept")
    public List<AutoComplete> getDept() {
        return leaguesService.selectDept();
    }

    @ResponseBody
    @RequestMapping("/leagues/getPerson")
    public List<AutoComplete> getPerson() {
        return leaguesService.selectPerson();
    }

    @ResponseBody
    @RequestMapping("/leagues/auditLeaguesById")
    public ModelAndView waitRoleById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/leagues/addLeaguesProcess");
        Leagues leagues = leaguesService.getLeaguesById(id);
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        mv.addObject("name",personName);
        mv.addObject("dept",deptName);
        mv.addObject("leagues", leagues);
        mv.addObject("head", "审批");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/leagues/auditEdit")
    public ModelAndView auditEdit(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/leagues/auditEditLeagues");
        Leagues leagues = leaguesService.getLeaguesById(id);
        String date = leagues.getRequestDate().substring(0,10);
        String time = leagues.getRequestDate().substring(11,16);
        String datetime = date+"T"+time;
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        leagues.setRequestDate(datetime);
        leagues.setManager(personName);
        leagues.setRequestDept(deptName);
        mv.addObject("name",personName);
        mv.addObject("dept",deptName);
        mv.addObject("head", "修改");
        mv.addObject("leagues", leagues);
        return mv;
    }
    /*待办关联业务jsp*/
    @RequestMapping("/leagues/processLoadIndexUnAudit")
    public ModelAndView loadIndexUnAudit(String id) {
        String personId = CommonUtil.getPersonId();
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/leagues/leaguesUnAudit");
        //mv.addObject("task",   taskService.findTaskList(personId));
        mv.addObject("data", workflowService.getRelationListById(personId,id));
        return mv;
    }
    /*关联中的详情页*/
    @RequestMapping("/leagues/getWotkflowLog")
    public ModelAndView getWotkflowLog(String tableName, String businessId, String url, String
            backUrl,String type) {
        ModelAndView mv = null;
        Start start = workflowService.getWorkflowStart(tableName, businessId);
        List<Handle> workflowLog = workflowService.getHandleList(start.getStartId());
        List<Node> nodes = workflowService.getNodeListByWorkflowId(start.getWorkflowId());
        if ("1".equals(type)){
            mv = new ModelAndView("/business/synergy/workflow/league/leagueAuditRelation");
        }else{
            mv = new ModelAndView("/business/synergy/workflow/league/leagueAudit");
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
    @RequestMapping("/leagues/getLeagueLog")
    public ModelAndView getLeagueLog(String tableName, String businessId, String url, String
            backUrl,String type) {
        Start start = workflowService.getWorkflowStart(tableName, businessId);
        List<Handle> workflowLog = workflowService.getHandleList(start.getStartId());
        List<Node> nodes = workflowService.getNodeListByWorkflowId(start.getWorkflowId());
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/league/leagueAudtInfo");
        mv.addObject("tableName", tableName);
        mv.addObject("businessId", businessId);
        mv.addObject("workflowLog", workflowLog);
        mv.addObject("size", nodes.size());
        mv.addObject("type", type);
        mv.addObject("nodes", nodes);
        mv.addObject("url", url);
        return mv;
    }
    @RequestMapping("/leagues/relationRequest")
    public ModelAndView toRelationLeague(String id,String type) {
        ModelAndView mv = new ModelAndView();
        String flag = workflowService.getRejectState("T_BG_LEAGUE_WF", id, CommonUtil
                .getPersonId());
        if ("1".equals(flag)){
            flag = "1";
        }else{
            flag = "0";
        }
        if((type .equals("1")  && flag .equals("1") ) || type .equals("2") ){
            mv.setViewName("/business/synergy/workflow/league/relationLeagueUnEdit");
        }else{
            mv.setViewName("/business/synergy/workflow/league/relationLeague");
        }
        mv.addObject("flag",flag);
        mv.addObject("id", id);
        mv.addObject("type",type);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/leagues/getRelationLeagueList")
    public Map<String, List> leagueComplete(String id) {
        Map<String, List> map = new HashMap<String, List>();
        List<IndexUnAudti> list = workflowService.getRelationListById(CommonUtil.getPersonId(),id);
        map.put("data", list);
        return map;
    }

    @RequestMapping("/leagues/getWorkflowList")
    public ModelAndView getSignList(String id) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/league/completeList");
        mv.addObject("id", id);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/leagues/workflowList")
    public Map<String, List> viewSignList(String id, String workflowId) {
        Map<String, List> map = new HashMap<String, List>();
        List<IndexUnAudti> list = workflowService.getUnRelationList(workflowId, CommonUtil.getPersonId(), id);
        map.put("data", list);
        return map;
    }

    @ResponseBody
    @RequestMapping("/leagues/saveRelationLeague")
    public Message saveRelationLeague(String ids) {
        LeagueRelation leagueRelation = new LeagueRelation();
        leagueRelation.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
        leagueRelation.setCreator(CommonUtil.getPersonId());
        String[] arr_id = ids.split("','");
        for (int i = 0; i < arr_id.length; i++) {
            String[] arr_values = arr_id[i].split(",");
            leagueRelation.setId(CommonUtil.getUUID());
            leagueRelation.setBusinessId(arr_values[0].replace("'",""));
            leagueRelation.setUrl(arr_values[1]);
            leagueRelation.setAppUrl(arr_values[2]);
            leagueRelation.setFundsId(arr_values[3].replace("'",""));
            leaguesService.insertLeagueRelation(leagueRelation);
        }
        return new Message(1, "新增成功！", null);
    }

    @ResponseBody
    @RequestMapping("/leagues/deleteRelationLeagueById")
    public Message deleteLeagueRelationById(String businessId, String id) {
        leaguesService.deleteRelationById(businessId,id);
        return new Message(1, "删除成功！", null);
    }
    //手机端
    @RequestMapping("/leagues/leagueListResult")
    public ModelAndView getlistResult(String id,String type) {
        String startId=leaguesService.getStartById(id);
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
    /*PC端打印*/
    @ResponseBody
    @RequestMapping("/leagues/printLeagues")
    public ModelAndView printHallUse(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/leagues/printLeagues");
        String workflowName=workflowService.getWorkflowNameByWorkflowCode("T_BG_LEAGUE_WF01");
        Leagues leagues = leaguesService.getLeaguesById(id);
        String state = stampService.getStateById(id);
        List<Handle> list=stampService.getHandlebyId(id);
        int size=list.size();
        mv.addObject("handleList", list);
        mv.addObject("size",size);
        mv.addObject("state",state);
        mv.addObject("leagues", leagues);
        mv.addObject("workflowName",workflowName);
        return mv;
    }
}
