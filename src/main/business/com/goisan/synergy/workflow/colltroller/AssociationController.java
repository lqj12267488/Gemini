package com.goisan.synergy.workflow.colltroller;

import com.goisan.synergy.workflow.service.ReimbursementService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.workflow.bean.Handle;
import com.goisan.workflow.bean.IndexUnAudti;
import com.goisan.workflow.bean.Node;
import com.goisan.workflow.bean.Start;
import com.goisan.workflow.service.WorkflowService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class AssociationController {
    @Resource
    private WorkflowService workflowService;
    @Resource
    private ReimbursementService reimbursementService;
    /**业务关联主页*/
    @RequestMapping("/association/associtionList")
    public ModelAndView AssocitionList(String tableName,String id, String type,String workflowCode,String backUrl) {
        ModelAndView mv = new ModelAndView();
        String flag = workflowService.getRejectState(tableName, id, CommonUtil.getPersonId());
        if ("1".equals(flag)){
            flag = "1";
        }else{
            flag = "0";
        }
        if((type .equals("1")  && flag .equals("1") ) || type .equals("2") ){
            mv.setViewName("/business/synergy/workflow/association/associationRelationUnEdit");
        }else{
            mv.setViewName("/business/synergy/workflow/association/association");
        }
        mv.addObject("flag",flag);
        mv.addObject("id", id);
        mv.addObject("type",type);
        mv.addObject("workflowCode",workflowCode);
        mv.addObject("backUrl",backUrl);
        return mv;
    }
    @ResponseBody
    @RequestMapping("/association/associationInfo")
    public Map<String, List> AssociationInfo(String id,String workflowCode) {
        String wid=workflowService.getWorkflowIdByWorkflowCode(workflowCode);
        Map<String, List> map = new HashMap<String, List>();
        List<IndexUnAudti> list = reimbursementService.getRelationListById(CommonUtil.getPersonId(),wid,id);
        map.put("data", list);
        return map;
    }
    /**新增业务关联*/
    @RequestMapping("/association/addAssociation")
    public ModelAndView getSignList(String id,String workflowCode) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/association/addAssociation");
        mv.addObject("id", id);
        mv.addObject("workflowCode",workflowCode);
        return mv;
    }
    @ResponseBody
    @RequestMapping("/association/workflowList")
    public Map<String, List> viewSignList(String id, String workflowId,String workflowCode) {
        Map<String, List> map = new HashMap<String, List>();
        String wid=workflowService.getWorkflowIdByWorkflowCode(workflowCode);
        List<IndexUnAudti> list = reimbursementService.getUnRelationList(workflowId, CommonUtil.getPersonId(),id,wid);
        map.put("data", list);
        return map;
    }
    /**详情页*/
     /*关联中的详情页*/
    @RequestMapping("/association/getWotkflowLog")
    public ModelAndView getWotkflowLog(String tableName, String businessId, String url, String backUrl,String type) {
        ModelAndView mv = null;
        Start start = workflowService.getWorkflowStart(tableName, businessId);
        List<Handle> workflowLog = workflowService.getHandleList(start.getStartId());
        List<Node> nodes = workflowService.getNodeListByWorkflowId(start.getWorkflowId());
        if ("1".equals(type)){
            mv = new ModelAndView("/business/synergy/workflow/association/associationInfo");
        }else{
            mv = new ModelAndView("/business/synergy/workflow/association/associationAudit");
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
    @RequestMapping("/association/relationRequest")
    public ModelAndView toRelationFunds(String id,String type,String tableName) {
        ModelAndView mv = new ModelAndView();
        String flag = workflowService.getRejectState(tableName, id, CommonUtil.getPersonId());
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
    /*待办关联业务jsp*/
    @RequestMapping("/association/processLoadIndexUnAudit")
    public ModelAndView loadIndexUnAudit(String id,String workflowCode) {
        String wid=workflowService.getWorkflowIdByWorkflowCode(workflowCode);
        String personId = CommonUtil.getPersonId();
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/funds/fundUnAudit");
        //mv.addObject("task",   taskService.findTaskList(personId));
        mv.addObject("data", reimbursementService.getRelationListById(personId,wid,id));
        return mv;
    }
    /*待办详情页*/
    @RequestMapping("/association/getFundsLog")
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
}
