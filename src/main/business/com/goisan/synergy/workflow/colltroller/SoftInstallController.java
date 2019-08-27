package com.goisan.synergy.workflow.colltroller;

import com.goisan.synergy.workflow.bean.SoftInstall;
import com.goisan.synergy.workflow.service.SoftInstallService;
import com.goisan.synergy.workflow.service.StampService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.service.EmpService;
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
public class SoftInstallController {
    @Resource
    private SoftInstallService softInstallService;
    @Resource
    private WorkflowService workflowService;
    @Resource
    private EmpService empService;
    @Resource
    private StampService stampService;

    /*
    申请业务
     */
    @RequestMapping("/softInstall/request")
    public ModelAndView softInstallList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/softinstall/softInstall");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/softInstall/getSoftInstallList")
    public Map<String, List<SoftInstall>> getSoftInstallList() {
        Map<String, List<SoftInstall>> softInstallMap = new HashMap<String, List<SoftInstall>>();
        SoftInstall softInstall = new SoftInstall();
        softInstall.setCreator(CommonUtil.getPersonId());
        softInstall.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
        softInstallMap.put("data", softInstallService.softAction(softInstall));
        return softInstallMap;
    }

    @ResponseBody
    @RequestMapping("/softInstall/getSoftInstallAuditList")
    public Map getSoftInstallAuditList() {
        String sql = workflowService.getUnAudit("T_BG_SOFTINSTALL_WF", CommonUtil.getPersonId());
        SoftInstall softInstall = new SoftInstall();
        softInstall.setCreator(CommonUtil.getLoginUser().getUserAccount());
        softInstall.setCreateDept(CommonUtil.getDefaultDept());
        softInstall.setChanger(CommonUtil.getPersonId());
        softInstall.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
        return CommonUtil.tableMap(softInstallService.softAction(softInstall));
    }

    @ResponseBody
    @RequestMapping("/softInstall/deleteSoftById")
    public Message deleteDeptById(String id) {
        softInstallService.deleteSoftById(id);
        return new Message(1, "删除成功！", null);
    }

    @ResponseBody
    @RequestMapping("/softInstall/getSoftById")
    public ModelAndView getRoleById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/softinstall/editSoftInstall");
        SoftInstall softinstall = softInstallService.getSoftById(id);
        mv.addObject("head", "修改");
        mv.addObject("softinstall", softinstall);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/softInstall/updateSoftById")
    public Message updateSoftById(SoftInstall softinstall) {
        if (softinstall.getId() == null || softinstall.equals("") || softinstall.getId() == "") {
            Date date = new java.sql.Date(new Date().getTime());
            softinstall.setRequester(CommonUtil.getPersonId());
            softinstall.setRequestDept(CommonUtil.getLoginUser().getDefaultDeptId());
            softinstall.setCreator(CommonUtil.getPersonId());
            softinstall.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
            softInstallService.insertSoft(softinstall);
            return new Message(1, "新增成功！", null);
        } else {
            softinstall.setChanger(CommonUtil.getPersonId());
            softinstall.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            softInstallService.updateSoftById(softinstall);
            return new Message(1, "修改成功！", null);
        }
    }

    @ResponseBody
    @RequestMapping("/softInstall/addSoftInstall")
    public ModelAndView addSoftInstall() {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/softinstall/editSoftInstall");
        mv.addObject("head", "新增申请");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+"T"+time;
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        SoftInstall softinstall = new SoftInstall();
        softinstall.setRequestDept(deptName);
        softinstall.setRequester(personName);
        softinstall.setRequestDate(datetime);
        mv.addObject("softinstall", softinstall);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/softInstall/searchSoftInstall")
    public Map<String, List<SoftInstall>> searchSoftInstall(SoftInstall softInstall) {
        Map<String, List<SoftInstall>> softMap = new HashMap<String, List<SoftInstall>>();
        softInstall.setCreator(CommonUtil.getPersonId());
        softMap.put("data", softInstallService.getSoftList(softInstall));
        return softMap;
    }

    @ResponseBody
    @RequestMapping("/softInstall/getDept")
    public List<AutoComplete> getDept() {
        return softInstallService.selectDept();
    }

    @ResponseBody
    @RequestMapping("/softInstall/getPerson")
    public List<AutoComplete> getPerson() {
        return softInstallService.selectPerson();
    }

    /*
    待办业务
     */
    @RequestMapping("/softInstall/process")
    public ModelAndView waitInstallList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/softinstall/softInstallProcess");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/softInstall/auditSoftById")
    public ModelAndView waitRoleById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/softinstall/addSoftInstallProcess");
        SoftInstall softinstall = softInstallService.getSoftById(id);
        mv.addObject("head", "审批");
        mv.addObject("softinstall", softinstall);
        return mv;
    }
    @ResponseBody
    @RequestMapping("/softInstall/searchSoftInstallProcess")
    public Map<String, List<SoftInstall>> processSearchSoftInstall(SoftInstall softInstall) {
        Map<String, List<SoftInstall>> softMap = new HashMap<String, List<SoftInstall>>();
        if ("%%".equals(softInstall.getRequestDept())){
            softInstall.setRequestDept(null);
        }
        if ("%%".equals(softInstall.getRequester())){
            softInstall.setRequester(null);
        }
        softInstall.setCreator(CommonUtil.getPersonId());
        softInstall.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
        softMap.put("data", softInstallService.getProcessSoftList(softInstall));
        return softMap;
    }
    /*
    已办业务
     */
    @RequestMapping("/softInstall/complete")
    public ModelAndView SoftInstallCompleteList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/softinstall/softInstallComplete");
        return mv;
    }
    @ResponseBody
    @RequestMapping("/softInstall/searchSoftInstallComplete")
    public Map<String, List<SoftInstall>> completeSearchSoftInstall(SoftInstall softInstall) {
        Map<String, List<SoftInstall>> softMap = new HashMap<String, List<SoftInstall>>();
        if ("%%".equals(softInstall.getRequestDept())){
            softInstall.setRequestDept(null);
        }
        if ("%%".equals(softInstall.getRequester())){
            softInstall.setRequester(null);
        }
        softInstall.setCreator(CommonUtil.getPersonId());
        softInstall.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
        softMap.put("data", softInstallService.getCompleteSoftList(softInstall));
        return softMap;
    }

    @ResponseBody
    @RequestMapping("/softInstall/auditEdit")
    public ModelAndView auditEdit(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/softinstall/editSortInstallProcess");
        SoftInstall softinstall = softInstallService.getSoftById(id);
        mv.addObject("head", "修改");
        mv.addObject("softinstall", softinstall);
        return mv;
    }
    @ResponseBody
    @RequestMapping("/softInstall/printSoftInstall")
    public ModelAndView printSoftInstall(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/softinstall/printSoftInstall");
        SoftInstall softinstall = softInstallService.getSoftById(id);
        String workflowName = workflowService.getWorkflowNameByWorkflowCode("T_BG_SOFTINSTALL_WF01");
        String requestDate = softinstall.getRequestDate().replace("T", " ");
        String state = stampService.getStateById(id);
        List<Handle> list= stampService.getHandlebyId(id);
        int size=list.size();
        mv.addObject("handleList", list);
        mv.addObject("size",size);
        mv.addObject("state",state);
        mv.addObject("requestDate", requestDate);
        mv.addObject("softinstall", softinstall);
        mv.addObject("workflowName", workflowName);
        return mv;
    }

}
