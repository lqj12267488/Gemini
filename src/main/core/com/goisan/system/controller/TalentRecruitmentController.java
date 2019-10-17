package com.goisan.system.controller;

import com.goisan.synergy.workflow.service.DocumentService;
import com.goisan.synergy.workflow.service.StampService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.TalentRecruitment;
import com.goisan.system.service.TalentRecruitmentService;
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

@Controller
public class TalentRecruitmentController {

    @Resource
    private TalentRecruitmentService talentRecruitmentService;
    @Resource
    private WorkflowService workflowService;
    @Resource
    private StampService stampService;

    /**
     * 人才招聘计划申请跳转
     * request by hanyue
     * modify by hanyue
     *
     * @return
     */
    @RequestMapping("/talentRecruitment/request")
    public ModelAndView talentRecruitmentList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/talentRecruitment/talentRecruitment");
        return mv;
    }

    /**
     * 人才招聘计划URL
     * url by hanyue
     * modify by hanyue
     *
     * @param talentRecruitment
     * @return
     */
    @ResponseBody
    @RequestMapping("/talentRecruitment/getTalentRecruitmentList")
    public Map<String, List<TalentRecruitment>> getTalentRecruitmentList(TalentRecruitment talentRecruitment) {
        Map<String, List<TalentRecruitment>> talentRecruitmentMap = new HashMap<String, List<TalentRecruitment>>();
        talentRecruitment.setCreator(CommonUtil.getPersonId());
        talentRecruitment.setCreateDept(CommonUtil.getDefaultDept());
        talentRecruitmentMap.put("data", talentRecruitmentService.getTalentRecruitmentList(talentRecruitment));
        return talentRecruitmentMap;
    }

    /**
     * 人才招聘计划新增
     * add by hanyue
     * modify by hanyue
     *
     * @return
     */
    @RequestMapping("/talentRecruitment/editTalentRecruitment")
    public ModelAndView addTalentRecruitment() {
        ModelAndView mv = new ModelAndView("/core/talentRecruitment/editTalentRecruitment");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date + 'T' + time;
        String personName = talentRecruitmentService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = talentRecruitmentService.getDeptNameById(CommonUtil.getDefaultDept());
        TalentRecruitment talentRecruitment = new TalentRecruitment();
        talentRecruitment.setRequester(personName);
        talentRecruitment.setRequestDate(datetime);
        talentRecruitment.setRequestDept(deptName);
        talentRecruitment.setPost(talentRecruitmentService.getPostByPersonId(CommonUtil.getPersonId()));
        mv.addObject("head", "人才招聘计划新增");
        mv.addObject("talentRecruitment", talentRecruitment);
        return mv;
    }

    /**
     * 人才招聘计划修改
     * update by hanyue
     * modify by hanyue
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/talentRecruitment/getTalentRecruitmentById")
    public ModelAndView getTalentRecruitmentById(String id) {
        ModelAndView mv = new ModelAndView("/core/talentRecruitment/editTalentRecruitment");
        TalentRecruitment talentRecruitment = talentRecruitmentService.getTalentRecruitmentById(id);
        mv.addObject("head", "人才招聘计划修改");
        mv.addObject("talentRecruitment", talentRecruitment);
        return mv;
    }

    /**
     * 保存人才招聘计划
     * save by hanyue
     * modify by hanyue
     *
     * @param talentRecruitment
     * @return
     */
    @ResponseBody
    @RequestMapping("/talentRecruitment/saveTalentRecruitment")
    public Message saveTalentRecruitment(TalentRecruitment talentRecruitment) {
        if (talentRecruitment.getId() == null || talentRecruitment.getId().equals("")) {
            talentRecruitment.setCreator(CommonUtil.getPersonId());
            talentRecruitment.setCreateDept(CommonUtil.getDefaultDept());
            talentRecruitment.setRequester(CommonUtil.getPersonId());
            talentRecruitment.setRequestDept(CommonUtil.getDefaultDept());
            talentRecruitment.setId(CommonUtil.getUUID());
            talentRecruitmentService.insertTalentRecruitment(talentRecruitment);
            return new Message(1, "新增成功！", null);
        } else {
            talentRecruitment.setRequester(CommonUtil.getPersonId());
            talentRecruitment.setRequestDept(CommonUtil.getDefaultDept());
            talentRecruitment.setChanger(CommonUtil.getPersonId());
            talentRecruitment.setChangeDept(CommonUtil.getDefaultDept());
            talentRecruitmentService.updateTalentRecruitmentById(talentRecruitment);
            return new Message(1, "修改成功！", null);
        }
    }

    /**
     * 删除人才招聘计划
     * delete by hanyue
     * modify by hanyue
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/talentRecruitment/deleteTalentRecruitmentById")
    public Message deleteTalentRecruitmentById(String id) {
        talentRecruitmentService.deleteTalentRecruitmentById(id);
        return new Message(1, "删除成功！", null);
    }

    /**
     * 部门自动提示框
     * dept by hanyue
     * modify by hanyue
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/talentRecruitment/autoCompleteDept")
    public List<AutoComplete> autoCompleteDept() {
        return talentRecruitmentService.autoCompleteDept();
    }

    /**
     * 人员自动提示框
     * person by hanyue
     * modify by hanyue
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/talentRecruitment/autoCompleteEmployee")
    public List<AutoComplete> autoCompleteEmployee() {
        return talentRecruitmentService.autoCompleteEmployee();
    }

    /**
     * 代办业务跳转
     * agency business by hanyue
     * modify by hanyue
     *
     * @return
     */
    @RequestMapping("/talentRecruitment/process")
    public ModelAndView talentRecruitmentProcess() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/talentRecruitment/talentRecruitmentProcess");
        return mv;
    }

    /**
     * 代办业务初始化
     * agency business initialize by hanyue
     * modify by hanyue
     *
     * @param talentRecruitment
     * @return
     */
    @ResponseBody
    @RequestMapping("/talentRecruitment/getProcessList")
    public Map<String, List<TalentRecruitment>> getProcessList(TalentRecruitment talentRecruitment) {
        Map<String, List<TalentRecruitment>> talentRecruitmentMap = new HashMap<String, List<TalentRecruitment>>();
        talentRecruitment.setCreator(CommonUtil.getPersonId());
        talentRecruitment.setCreateDept(CommonUtil.getDefaultDept());
        talentRecruitment.setChanger(CommonUtil.getPersonId());
        talentRecruitment.setChangeDept(CommonUtil.getDefaultDept());
        talentRecruitmentMap.put("data", talentRecruitmentService.getProcessList(talentRecruitment));
        return talentRecruitmentMap;
    }

    /**
     * 已办业务跳转
     * already done business by hanyue
     * modify by hanyue
     *
     * @return
     */
    @RequestMapping("/talentRecruitment/complete")
    public ModelAndView talentRecruitmentComplete() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/talentRecruitment/talentRecruitmentComplete");
        return mv;
    }

    /**
     * 已办页面初始化
     * already done business initialize by hanyue
     * modify by hanyue
     *
     * @param talentRecruitment
     * @return
     */
    @ResponseBody
    @RequestMapping("/talentRecruitment/getCompleteList")
    public Map<String, List<TalentRecruitment>> getCompleteList(TalentRecruitment talentRecruitment) {
        Map<String, List<TalentRecruitment>> talentRecruitmentMap = new HashMap<String, List<TalentRecruitment>>();
        talentRecruitment.setCreator(CommonUtil.getPersonId());
        talentRecruitment.setCreateDept(CommonUtil.getDefaultDept());
        talentRecruitment.setChanger(CommonUtil.getPersonId());
        talentRecruitment.setChangeDept(CommonUtil.getDefaultDept());
        talentRecruitmentMap.put("data", talentRecruitmentService.getCompleteList(talentRecruitment));
        return talentRecruitmentMap;
    }

    /**
     * 待办修改
     * agency update by hanyue
     * modify by hanyue
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/talentRecruitment/auditTalentRecruitmentEdit")
    public ModelAndView auditTalentRecruitmentEdit(String id) {
        ModelAndView mv = new ModelAndView("/core/talentRecruitment/editTalentRecruitmentProcess");
        TalentRecruitment talentRecruitment = talentRecruitmentService.getTalentRecruitmentById(id);
        mv.addObject("head", "修改");
        mv.addObject("talentRecruitment", talentRecruitment);
        return mv;
    }

    /**
     * 查看流程轨迹
     * process trajectory by hanyue
     * modify by hanyue
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/talentRecruitment/auditTalentRecruitmentById")
    public ModelAndView waitRoleById(String id) {
        ModelAndView mv = new ModelAndView("/core/talentRecruitment/addTalentRecruitmentProcess");
        TalentRecruitment talentRecruitment = talentRecruitmentService.getTalentRecruitmentById(id);
        mv.addObject("head", "审批");
        mv.addObject("talentRecruitment", talentRecruitment);
        return mv;
    }

    @Resource
    private DocumentService documentService;

    @ResponseBody
    @RequestMapping("/talentRecruitment/printTalentRecruitment")
    public ModelAndView printTalentRecruitment(String id) {
        ModelAndView mv = new ModelAndView("/core/talentRecruitment/printTalentRecruitment");
        TalentRecruitment talentRecruitment = talentRecruitmentService.getTalentRecruitmentById(id);
        String workflowName = workflowService.getWorkflowNameByWorkflowCode("T_BG_DEVICEBORROW_WF01");
        String state = stampService.getStateById(id);
        String dean = documentService.getDocumentHandleById2(id, "院长");
        String chairman = documentService.getDocumentHandleById2(id, "董事长");
        String deptPerson = documentService.getDocumentHandleById2(id, "部门负责人");
        String leader = documentService.getDocumentHandleById2(id, "分管院领导");

        String deanTime = talentRecruitmentService.getTalentRecruitmentHandleDateById(id, "院长");
        if (!"".equals(deanTime)) {
            deanTime = deanTime.split("-")[0] + "年" + deanTime.split("-")[1] + "月" + deanTime.split("-")[2] + "日";
        }
        String chairmanTime = talentRecruitmentService.getTalentRecruitmentHandleDateById(id, "董事长");
        if (!"".equals(chairmanTime)) {
            chairmanTime = chairmanTime.split("-")[0] + "年" + chairmanTime.split("-")[1] + "月" + chairmanTime.split("-")[2] + "日";
        }
        String deptPersonTime = talentRecruitmentService.getTalentRecruitmentHandleDateById(id, "部门负责人");
        if (!"".equals(deptPersonTime)) {
            deptPersonTime = deptPersonTime.split("-")[0] + "年" + deptPersonTime.split("-")[1] + "月" + deptPersonTime.split("-")[2] + "日";
        }
        String leaderTime = talentRecruitmentService.getTalentRecruitmentHandleDateById(id, "分管院领导");
        if (!"".equals(leaderTime)) {
            leaderTime = leaderTime.split("-")[0] + "年" + leaderTime.split("-")[1] + "月" + leaderTime.split("-")[2] + "日";
        }
        if (!"".equals(talentRecruitment.getRequestDate())) {
            talentRecruitment.setRequestDate(talentRecruitment.getRequestDate().split("T")[0].split("-")[0] + "年" + talentRecruitment.getRequestDate().split("T")[0].split("-")[1] + "月" + talentRecruitment.getRequestDate().split("T")[0].split("-")[2] + "日");
        }
        if (!"".equals(talentRecruitment.getStationDate())) {
            talentRecruitment.setStationDate(talentRecruitment.getStationDate().split("T")[0].split("-")[0] + "年" + talentRecruitment.getStationDate().split("T")[0].split("-")[1] + "月" + talentRecruitment.getStationDate().split("T")[0].split("-")[2] + "日");
        }

        String deanRemark = talentRecruitmentService.getTalentRecruitmentHandleRemarkById(id, "院长");
        String chairmanRemark = talentRecruitmentService.getTalentRecruitmentHandleRemarkById(id, "董事长");
        String deptPersonRemark = talentRecruitmentService.getTalentRecruitmentHandleRemarkById(id, "部门负责人");
        String leaderRemark = talentRecruitmentService.getTalentRecruitmentHandleRemarkById(id, "分管院领导");
        List<Handle> list = stampService.getHandlebyId(id);
        int size = list.size();
        mv.addObject("handleList", list);
        mv.addObject("size", size);
        mv.addObject("state", state);
        if (talentRecruitment.getSex().length() > 1) {
            talentRecruitment.setSex("4");
        }
        String requestDate = talentRecruitment.getRequestDate().replace("T", " ");
        mv.addObject("requestDate", requestDate);
        mv.addObject("talentRecruitment", talentRecruitment);
        mv.addObject("workflowName", workflowName);
        mv.addObject("dean", dean);
        mv.addObject("chairman", chairman);
        mv.addObject("deptPerson", deptPerson);
        mv.addObject("leader", leader);
        mv.addObject("deanTime", deanTime);
        mv.addObject("deanRemark", deanRemark);
        mv.addObject("chairmanTime", chairmanTime);
        mv.addObject("chairmanRemark", chairmanRemark);
        mv.addObject("deptPersonTime", deptPersonTime);
        mv.addObject("deptPersonRemark", deptPersonRemark);
        mv.addObject("leaderTime", leaderTime);
        mv.addObject("leaderRemark", leaderRemark);
        return mv;
    }

}
