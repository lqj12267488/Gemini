package com.goisan.synergy.workflow.colltroller;

import com.goisan.synergy.workflow.bean.ITDeviceRepai;
import com.goisan.synergy.workflow.service.ITDeviceRepaiService;
import com.goisan.synergy.workflow.service.StampService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.service.EmpService;
import com.goisan.system.service.FilesService;
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
public class ITDeviceRepaiController {
    @Resource
    private ITDeviceRepaiService itDeviceRepaiService;
    @Resource
    private EmpService empService;
    @Resource
    private FilesService filesService;
    @Resource
    private WorkflowService workflowService;
    @Resource
    private StampService stampService;
    @RequestMapping("/itdevicerepai/request")
    public ModelAndView ITDeviceList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/ITdeviceRepai/ITDviceRepai");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/itdevicerepai/getITDeviceList")
    public Map<String, List<ITDeviceRepai>> getITDeviceList(ITDeviceRepai itDeviceRepai) {
        Map<String, List<ITDeviceRepai>> ITDeviceMap = new HashMap<String, List<ITDeviceRepai>>();
        itDeviceRepai.setCreator(CommonUtil.getPersonId());
        itDeviceRepai.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
        ITDeviceMap.put("data", itDeviceRepaiService.ITDeviceAction(itDeviceRepai));
        return ITDeviceMap;
    }
    /*待办*/
    @RequestMapping("/itdevicerepai/process")
    public ModelAndView ITDeviceListProcess() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/ITdeviceRepai/ITDviceRepaiProcess");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/itdevicerepai/getITDeviceListProcess")
    public Map<String, List<ITDeviceRepai>> iTDeviceProcess(ITDeviceRepai itDeviceRepai) {
        //String sql = workflowService.getUnAudit("T_BG_ITDEVICEREPAIR_WF",CommonUtil.getPersonId());
        Map<String, List<ITDeviceRepai>> ITDeviceMap = new HashMap<String, List<ITDeviceRepai>>();
        itDeviceRepai.setCreator(CommonUtil.getPersonId());
        itDeviceRepai.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
        List<ITDeviceRepai> r = itDeviceRepaiService.iTDeviceProcess(itDeviceRepai);
        ITDeviceMap.put("data", r);
        return ITDeviceMap;
    }

    @RequestMapping("/itdevicerepai/complete")
    public ModelAndView ITDeviceListComplete() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/ITdeviceRepai/ITDviceRepaiComplete");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/itdevicerepai/auditITDeviceRepaiById")
    public ModelAndView waitRoleById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/ITdeviceRepai/addITDeviceRepaiProcess");
        ITDeviceRepai itDeviceRepai = itDeviceRepaiService.getITDeviceById(id);
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+"T"+time;
        /*String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());*/
        itDeviceRepai.setRequestDate(datetime);
        /*itDeviceRepai.setRequester(personName);
        itDeviceRepai.setRequestDept(deptName);*/
        mv.addObject("head", "审批");
        mv.addObject("itDeviceRepair", itDeviceRepai);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/itdevicerepai/getITDeviceListComplete")
    public Map<String, List<ITDeviceRepai>> iTDeviceComplete(ITDeviceRepai itDeviceRepai) {
        Map<String, List<ITDeviceRepai>> ITDeviceMap = new HashMap<String, List<ITDeviceRepai>>();
        itDeviceRepai.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
        itDeviceRepai.setCreator(CommonUtil.getPersonId());
        List<ITDeviceRepai> r = itDeviceRepaiService.iTDeviceComplete(itDeviceRepai);
        ITDeviceMap.put("data", r);
        return ITDeviceMap;
    }

    @ResponseBody
    @RequestMapping("/itdevicerepai/deleteITDeviceById")
    public Message deleteITDeviceById(String id) {
        itDeviceRepaiService.deleteITDeviceById(id);
        filesService.delFilesByBusinessId(id);
        return new Message(1, "删除成功！", null);
    }

    @ResponseBody
    @RequestMapping("/itdevicerepai/getITDeviceById")
    public ModelAndView getITDeviceById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/ITdeviceRepai/editITDeviceRepai");
        ITDeviceRepai itDeviceRepai = itDeviceRepaiService.getITDeviceById(id);
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+"T"+time;
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        itDeviceRepai.setRequestDate(datetime);
        itDeviceRepai.setRequester(personName);
        itDeviceRepai.setRequestDept(deptName);
        mv.addObject("head", "修改");
        mv.addObject("itDeviceRepair", itDeviceRepai);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/itdevicerepai/updateITDeviceRepaiById")
    public Message updateITDeviceById(ITDeviceRepai itDeviceRepai) {
        if (itDeviceRepai.getId() == null || itDeviceRepai.equals("") || itDeviceRepai.getId() == "") {
            Date date = new java.sql.Date(new Date().getTime());
            itDeviceRepai.setCreator(CommonUtil.getPersonId());
            itDeviceRepai.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
            itDeviceRepai.setRequestDept(CommonUtil.getLoginUser().getDefaultDeptId());
            itDeviceRepai.setRequester(CommonUtil.getPersonId());
            itDeviceRepaiService.insertITDevice(itDeviceRepai);
            return new Message(1, "新增成功！", null);
        } else {
            itDeviceRepai.setRequestDept(CommonUtil.getLoginUser().getDefaultDeptId());
            itDeviceRepai.setRequester(CommonUtil.getPersonId());
            itDeviceRepai.setChanger(CommonUtil.getPersonId());
            itDeviceRepai.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            itDeviceRepaiService.updateITDeviceById(itDeviceRepai);
            return new Message(1, "修改成功！", null);
        }
    }

    @ResponseBody
    @RequestMapping("/itdevicerepai/addTDeviceRepai")
    public ModelAndView addITDevice() {

        ModelAndView mv = new ModelAndView("/business/synergy/workflow/ITdeviceRepai/editITDeviceRepai");
        ITDeviceRepai itDeviceRepai = new ITDeviceRepai();
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+"T"+time;
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        itDeviceRepai.setRequestDate(datetime);
        itDeviceRepai.setRequester(personName);
        itDeviceRepai.setRequestDept(deptName);
        mv.addObject("head", "新增申请");
        mv.addObject("itDeviceRepair",itDeviceRepai);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/itdevicerepai/searchITDevicerepai")
    public Map<String, List<ITDeviceRepai>> searchITDevice(ITDeviceRepai itDeviceRepai) {
        Map<String, List<ITDeviceRepai>> softMap = new HashMap<String, List<ITDeviceRepai>>();
        itDeviceRepai.setCreator(CommonUtil.getPersonId());
        softMap.put("data", itDeviceRepaiService.getITDeviceList(itDeviceRepai));
        return softMap;
    }

    @ResponseBody
    @RequestMapping("/itdevicerepai/getDept")
    public List<AutoComplete> getDept() {
        return itDeviceRepaiService.selectDept();
    }

    @ResponseBody
    @RequestMapping("/itdevicerepai/getPerson")
    public List<AutoComplete> getPerson() {
        return itDeviceRepaiService.selectPerson();
    }

    @ResponseBody
    @RequestMapping("/itDeviceRepair/auditEdit")
    public ModelAndView auditEdit(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/ITdeviceRepai/auditEditITDeviceRepai");
        ITDeviceRepai itDeviceRepai = itDeviceRepaiService.getITDeviceById(id);
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+"T"+time;
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        itDeviceRepai.setRequestDate(datetime);
        itDeviceRepai.setRequester(personName);
        itDeviceRepai.setRequestDept(deptName);
        mv.addObject("head", "修改");
        mv.addObject("itDeviceRepair", itDeviceRepai);
        return mv;
    }
    @ResponseBody
    @RequestMapping("/ITdeviceRepai/printItDeviceRepair")
    public ModelAndView printItDeviceRepair(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/ITdeviceRepai/printItDeviceRepair");
        ITDeviceRepai itDeviceRepai = itDeviceRepaiService.getITDeviceById(id);
        String workflowName = workflowService.getWorkflowNameByWorkflowCode("T_BG_ITDEVICEREPAIR_WF01");
        String requestDate = itDeviceRepai.getRequestDate().replace("T", " ");
        String state = stampService.getStateById(id);
        List<Handle> list= stampService.getHandlebyId(id);
        int size=list.size();
        mv.addObject("handleList", list);
        mv.addObject("size",size);
        mv.addObject("state",state);
        mv.addObject("requestDate", requestDate);
        mv.addObject("itDeviceRepai", itDeviceRepai);
        mv.addObject("workflowName", workflowName);
        return mv;
    }
}
