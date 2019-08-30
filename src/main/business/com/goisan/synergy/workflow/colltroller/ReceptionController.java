package com.goisan.synergy.workflow.colltroller;

import com.goisan.synergy.workflow.bean.Reception;
import com.goisan.synergy.workflow.service.ReceptionService;
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

@Controller
public class ReceptionController {
    @Resource
    private ReceptionService receptionService;
    @Resource
    private WorkflowService workflowService;
    @Resource
    private StampService stampService;

    /**
     * 接待管理申请跳转
     * request by hanyue
     * modify by hanyue
     *
     * @return
     */
    @RequestMapping("/reception/request")
    public ModelAndView receptionList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/reception/reception");
        return mv;
    }

    /**
     * 接待管理URL
     * url by hanyue
     * modify by hanyue
     *
     * @param reception
     * @return
     */
    @ResponseBody
    @RequestMapping("/reception/getReceptionList")
    public Map<String, List<Reception>> getReceptionList(Reception reception) {
        Map<String, List<Reception>> receptionMap = new HashMap<String, List<Reception>>();
        reception.setCreator(CommonUtil.getPersonId());
        reception.setCreateDept(CommonUtil.getDefaultDept());
        receptionMap.put("data", receptionService.getReceptionList(reception));
        return receptionMap;
    }

    /**
     * 接待管理新增
     * add by hanyue
     * modify by hanyue
     *
     * @return
     */
    @RequestMapping("/reception/editReception")
    public ModelAndView addReception() {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/reception/editReception");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date + 'T' + time;
        String personName = receptionService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = receptionService.getDeptNameById(CommonUtil.getDefaultDept());
        Reception reception = new Reception();
        reception.setRequester(personName);
        reception.setRequestDate(datetime);
        reception.setReceptionTime(datetime);
        reception.setRequestDept(deptName);
        mv.addObject("head", "接待管理新增");
        mv.addObject("reception", reception);
        return mv;
    }

    /**
     * 接待管理修改
     * update by hanyue
     * modify by hanyue
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/reception/getReceptionById")
    public ModelAndView getReceptionById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/reception/editReception");
        Reception reception = receptionService.getReceptionById(id);
        mv.addObject("head", "接待管理修改");
        mv.addObject("reception", reception);
        return mv;
    }

    /**
     * 保存接待管理
     * save by hanyue
     * modify by hanyue
     *
     * @param reception
     * @return
     */
    @ResponseBody
    @RequestMapping("/reception/saveReception")
    public Message saveReception(Reception reception) {
        if (reception.getId() == null || reception.getId().equals("")) {
            reception.setCreator(CommonUtil.getPersonId());
            reception.setCreateDept(CommonUtil.getDefaultDept());
            reception.setRequester(CommonUtil.getPersonId());
            reception.setRequestDept(CommonUtil.getDefaultDept());
            reception.setId(CommonUtil.getUUID());
            receptionService.insertReception(reception);
            return new Message(1, "新增成功！", null);
        } else {
            reception.setRequester(CommonUtil.getPersonId());
            reception.setRequestDept(CommonUtil.getDefaultDept());
            reception.setChanger(CommonUtil.getPersonId());
            reception.setChangeDept(CommonUtil.getDefaultDept());
            receptionService.updateReceptionById(reception);
            return new Message(1, "修改成功！", null);
        }
    }

    /**
     * 删除接待管理
     * delete by hanyue
     * modify by hanyue
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/reception/deleteReceptionById")
    public Message deleteReceptionById(String id) {
        receptionService.deleteReceptionById(id);
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
    @RequestMapping("/reception/autoCompleteDept")
    public List<AutoComplete> autoCompleteDept() {
        return receptionService.autoCompleteDept();
    }

    /**
     * 人员自动提示框
     * person by hanyue
     * modify by hanyue
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/reception/autoCompleteEmployee")
    public List<AutoComplete> autoCompleteEmployee() {
        return receptionService.autoCompleteEmployee();
    }

    /**
     * 代办业务跳转
     * agency business by hanyue
     * modify by hanyue
     *
     * @return
     */
    @RequestMapping("/reception/process")
    public ModelAndView receptionProcess() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/reception/receptionProcess");
        return mv;
    }

    /**
     * 代办业务初始化
     * agency business initialize by hanyue
     * modify by hanyue
     *
     * @param reception
     * @return
     */
    @ResponseBody
    @RequestMapping("/reception/getProcessList")
    public Map<String, List<Reception>> getProcessList(Reception reception) {
        Map<String, List<Reception>> receptionMap = new HashMap<String, List<Reception>>();
        reception.setCreator(CommonUtil.getPersonId());
        reception.setCreateDept(CommonUtil.getDefaultDept());
        reception.setChanger(CommonUtil.getPersonId());
        reception.setChangeDept(CommonUtil.getDefaultDept());
        receptionMap.put("data", receptionService.getProcessList(reception));
        return receptionMap;
    }

    /**
     * 已办业务跳转
     * already done business by hanyue
     * modify by hanyue
     *
     * @return
     */
    @RequestMapping("/reception/complete")
    public ModelAndView receptionComplete() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/reception/receptionComplete");
        return mv;
    }

    /**
     * 已办页面初始化
     * already done business initialize by hanyue
     * modify by hanyue
     *
     * @param reception
     * @return
     */
    @ResponseBody
    @RequestMapping("/reception/getCompleteList")
    public Map<String, List<Reception>> getCompleteList(Reception reception) {
        Map<String, List<Reception>> receptionMap = new HashMap<String, List<Reception>>();
        reception.setCreator(CommonUtil.getPersonId());
        reception.setCreateDept(CommonUtil.getDefaultDept());
        reception.setChanger(CommonUtil.getPersonId());
        reception.setChangeDept(CommonUtil.getDefaultDept());
        receptionMap.put("data", receptionService.getCompleteList(reception));
        return receptionMap;
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
    @RequestMapping("/reception/auditReceptionEdit")
    public ModelAndView auditReceptionEdit(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/reception/editReceptionProcess");
        Reception reception = receptionService.getReceptionById(id);
        mv.addObject("head", "修改");
        mv.addObject("reception", reception);
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
    @RequestMapping("/reception/auditReceptionById")
    public ModelAndView waitRoleById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/reception/addReceptionProcess");
        Reception reception = receptionService.getReceptionById(id);
        mv.addObject("head", "审批");
        mv.addObject("reception", reception);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/reception/printReception")
    public ModelAndView printReception(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/reception/printReception");
        Reception reception = receptionService.getReceptionById(id);
        String workflowName = workflowService.getWorkflowNameByWorkflowCode("T_BG_RECEPTION_WF01");
        String state = stampService.getStateById(id);
        List<Handle> list= stampService.getHandlebyId(id);
        int size=list.size();
        mv.addObject("handleList", list);
        mv.addObject("size",size);
        mv.addObject("state",state);
        String requestDate = reception.getRequestDate().replace("T", " ");
        String revertTime = reception.getReceptionTime().replace("T", " ");
        mv.addObject("requestDate", requestDate);
        mv.addObject("revertTime", revertTime);
        mv.addObject("reception", reception);
        mv.addObject("workflowName", workflowName);
        return mv;
    }
}
