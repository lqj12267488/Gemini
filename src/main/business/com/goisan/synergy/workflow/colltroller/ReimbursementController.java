package com.goisan.synergy.workflow.colltroller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.synergy.workflow.bean.Reimbursement;
import com.goisan.synergy.workflow.service.FundsService;
import com.goisan.synergy.workflow.service.ReimbursementService;
import com.goisan.synergy.workflow.service.StampService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import com.goisan.workflow.bean.Handle;
import com.goisan.workflow.bean.Node;
import com.goisan.workflow.bean.Start;
import com.goisan.workflow.service.WorkflowService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ReimbursementController {
    @Resource
    private ReimbursementService reimbursementService;
    @Resource
    private WorkflowService workflowService;
    @Resource
    private StampService stampService;
    @RequestMapping("/reimbursement/request")
    public ModelAndView Reimbursement(){
        ModelAndView mv=new ModelAndView("/business/synergy/workflow/reimbursement/reimbursement");
        return mv;
    }
    //查询符合条件的数据
    @ResponseBody
    @RequestMapping("/reimbursement/info")
    public Map<String, Object> search(Reimbursement reimbursement, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> reimbursements = new HashMap();
        reimbursement.setCreator(CommonUtil.getPersonId());
        reimbursement.setCreateDept(CommonUtil.getDefaultDept());

        List<Reimbursement> list = reimbursementService.reimbursementInfo(reimbursement);
        PageInfo<List<Reimbursement>> info = new PageInfo(list);
        reimbursements.put("draw", draw);
        reimbursements.put("recordsTotal", info.getTotal());
        reimbursements.put("recordsFiltered", info.getTotal());
        reimbursements.put("data", list);
        return reimbursements;
    }
    /*新增*/
    @RequestMapping("/reimbursement/addReimbur")
    public ModelAndView addReimbur(){
        ModelAndView mv=new ModelAndView("/business/synergy/workflow/reimbursement/editReimbur");
        Reimbursement reimbursement = new Reimbursement();
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        String date = formatDate.format(new java.util.Date());
        reimbursement.setRequestDate(date);
        reimbursement.setRequester(reimbursementService.getPersonNameById(CommonUtil.getPersonId()));
        reimbursement.setRequestDept(reimbursementService.getDeptNameById(CommonUtil.getDefaultDept()));
        mv.addObject("head", "新增申请");
        mv.addObject("reimbursement",reimbursement);
        return mv;
    }
    /*修改*/
    @ResponseBody
    @RequestMapping("/reimbursement/editReimbur")
    public ModelAndView editReimbur(String id) {
        ModelAndView mv = new ModelAndView("business/synergy/workflow/reimbursement/editReimbur");
        Reimbursement reimbursement = reimbursementService.getReimbursementById(id);
        mv.addObject("head", "修改"); //修改页面头部 显示的文字
        mv.addObject("reimbursement", reimbursement);//通过XuZhe.字段名查询字段
        return mv;
    }

    /*保存*/
    @ResponseBody
    @RequestMapping("/reimbursement/saveReimbur")
    public Message saveReimbur(Reimbursement reimbursement){
        reimbursement.setRequestDept(CommonUtil.getDefaultDept());
        reimbursement.setRequester(CommonUtil.getPersonId());
        if(reimbursement.getId()==null || reimbursement.getId().equals("")){
            reimbursement.setCreateDept(CommonUtil.getDefaultDept());
            reimbursement.setCreator(CommonUtil.getPersonId());
            reimbursement.setId(CommonUtil.getUUID());
            reimbursementService.insertReimbursement(reimbursement);
            return new Message(1, "新增成功！", null);
        }else{
            reimbursement.setChanger(CommonUtil.getPersonId());
            reimbursement.setChangeDept(CommonUtil.getDefaultDept());
            reimbursementService.updateReimbursement(reimbursement);
            return new Message(1, "修改成功！", null);
        }
    }
    /*删除*/
    @ResponseBody
    @RequestMapping("/reimbursement/deleteReimbursement")
    public Message deleteReimbursement(String id) {
        reimbursementService.deleteReimbursement(id);
        return new Message(1, "删除成功！", null);
    }
    /*待办页*/
    @RequestMapping("/reimbursement/reimbursementProcess")
    public ModelAndView reimbursementProcess() {
        ModelAndView mv = new ModelAndView("business/synergy/workflow/reimbursement/reimburProcess");
        return mv;
    }
    /*待办查询*/
    @ResponseBody
    @RequestMapping("/reimbursement/getReimbursementProcess")
    public Map<String, Object> getReimbursementProcess(Reimbursement reimbursement, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> reimbursements = new HashMap();
        reimbursement.setCreator(CommonUtil.getPersonId());
        reimbursement.setCreateDept(CommonUtil.getDefaultDept());

        List<Reimbursement> list = reimbursementService.getReimbursementProcess(reimbursement);
        PageInfo<List<Reimbursement>> info = new PageInfo(list);
        reimbursements.put("draw", draw);
        reimbursements.put("recordsTotal", info.getTotal());
        reimbursements.put("recordsFiltered", info.getTotal());
        reimbursements.put("data", list);
        return reimbursements;
    }
    //办理界面
    @ResponseBody
    @RequestMapping("/reimbursement/auditReimbursement")
    public ModelAndView auditReimbursement(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/reimbursement/auditReimbursement");
        Reimbursement reimbursement = reimbursementService.getReimbursementById(id);
        mv.addObject("head", "办理");
        mv.addObject("reimbursement", reimbursement);
        return mv;
    }
    /**功能：被驳回申请的信息修改（因为界面形式不同，不能使用申请页的添加和修改方法）
     * modify by wq
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/reimbursement/editReimbursementProcess")
    public ModelAndView auditEditAssets(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/reimbursement/editReimbursementProcess");
        Reimbursement reimbursement = reimbursementService.getReimbursementById(id);
        mv.addObject("head", "修改");
        mv.addObject("reimbursement", reimbursement);
        return mv;
    }
    /**
     * 已办界面
    * */
    @RequestMapping("/reimbursement/reimbursementComplete")
    public ModelAndView AssetsScrapListComplete() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/reimbursement/reimbursementComplete");
        return mv;
    }
    /**
     * 已办数据查询*/
    @ResponseBody
    @RequestMapping("/reimbursement/getReimbursementComplete")
    public Map<String, Object> getCameraListComplete(Reimbursement reimbursement, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> reimbursements = new HashMap();
        reimbursement.setCreator(CommonUtil.getPersonId());
        reimbursement.setCreateDept(CommonUtil.getDefaultDept());

        List<Reimbursement> list = reimbursementService.getReimbursementComplete(reimbursement);
        PageInfo<List<Reimbursement>> info = new PageInfo(list);
        reimbursements.put("draw", draw);
        reimbursements.put("recordsTotal", info.getTotal());
        reimbursements.put("recordsFiltered", info.getTotal());
        reimbursements.put("data", list);
        return reimbursements;
    }
    @ResponseBody
    @RequestMapping("/reimbursement/getDept")
    public List<AutoComplete> selectDept() {
        return reimbursementService.selectDept();
    }

    @ResponseBody
    @RequestMapping("/reimbursement/getPerson")
    public List<AutoComplete> getPerson() {
        return reimbursementService.selectPerson();
    }

    //手机端
    @Resource
    private FundsService fundsService;
    @RequestMapping("/reimbursement/fundsListResult")
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
    @RequestMapping("/reimbursement/printFunds")
    public ModelAndView printReimbursement(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/reimbursement/printReimbursement");
        String workflowName=workflowService.getWorkflowNameByWorkflowCode("T_BG_REIMBURSEMENT_WF01");
        Reimbursement reimbursement = reimbursementService.getReimbursementById(id);
        String state = stampService.getStateById(id);
        List<Handle> list=stampService.getHandlebyId(id);
        int size=list.size();
        mv.addObject("handleList", list);
        mv.addObject("size",size);
        mv.addObject("state",state);
        mv.addObject("reimbursement", reimbursement);
        mv.addObject("workflowName",workflowName);
        return mv;
    }
}
