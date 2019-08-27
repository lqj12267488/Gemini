package com.goisan.synergy.workflow.colltroller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.synergy.workflow.bean.Stamp;
import com.goisan.synergy.workflow.service.StampService;
import com.goisan.system.bean.AutoComplete;
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
 * Created by znw on 2017/5/6.
 */
@Controller
public class StampController {

    @Resource
    private StampService stampService;
    @Resource
    private FilesService filesService;
    @Resource
    private WorkflowService workflowService;

    //印章申请跳转
    @RequestMapping("/stamp/request")
    public ModelAndView stampList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/stamp/stamp");
        return mv;
    }
    //印章申请URL
    @ResponseBody
    @RequestMapping("/stamp/getStampList")
    public Map<String,Object> getStampList(Stamp stamp, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> stamps = new HashMap();
        stamp.setCreator(CommonUtil.getPersonId());
        stamp.setCreateDept(CommonUtil.getDefaultDept());
        List<Stamp> list = stampService.getStampList(stamp);
        PageInfo<List<Stamp>> info = new PageInfo(list);
        stamps.put("draw", draw);
        stamps.put("recordsTotal", info.getTotal());
        stamps.put("recordsFiltered", info.getTotal());
        stamps.put("data", list);
        return stamps;
    }
    //印章新增
    @RequestMapping("/stamp/editStamp")
    public ModelAndView addStamp() {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/stamp/editStamp");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+'T'+time;
        String personName = stampService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = stampService.getDeptNameById(CommonUtil.getDefaultDept());
        Stamp stamp=new Stamp();
        stamp.setManager(personName);
        stamp.setRequestDate(datetime);
        stamp.setRequestDept(deptName);
        mv.addObject("head", "印章新增");
        mv.addObject("stamp", stamp);
        return mv;
    }
    //印章修改
    @ResponseBody
    @RequestMapping("/stamp/getStampById")
    public ModelAndView getStampById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/stamp/editStamp");
        Stamp stamp = stampService.getStampById(id);
        mv.addObject("head", "印章修改");
        mv.addObject("stamp", stamp);
        return mv;
    }
    //保存印章
    @ResponseBody
    @RequestMapping("/stamp/saveStamp")
    public Message saveStamp(Stamp stamp){
        if(stamp.getId()==null || stamp.getId().equals("")){
            stamp.setCreator(CommonUtil.getPersonId());
            stamp.setCreateDept(CommonUtil.getDefaultDept());
            stamp.setManager(CommonUtil.getPersonId());
            stamp.setRequestDept(CommonUtil.getDefaultDept());
            stamp.setId(CommonUtil.getUUID());
            stampService.insertStamp(stamp);
            return new Message(1, "新增成功！", null);
        }else{
            stamp.setManager(CommonUtil.getPersonId());
            stamp.setRequestDept(CommonUtil.getDefaultDept());
            stamp.setChanger(CommonUtil.getPersonId());
            stamp.setChangeDept(CommonUtil.getDefaultDept());
            stampService.updateStampById(stamp);
            return new Message(1, "修改成功！", null);
        }
    }
    //删除印章
    @ResponseBody
    @RequestMapping("/stamp/deleteStampById")
    public Message deleteStampById(String id) {
        stampService.deleteStampById(id);
        filesService.delFilesByBusinessId(id);
        return new Message(1, "删除成功！", null);
    }

    @ResponseBody
    @RequestMapping("/stamp/autoCompleteDept")
    public List<AutoComplete> autoCompleteDept() {
        return stampService.autoCompleteDept();
    }
    //人员自动提示框
    @ResponseBody
    @RequestMapping("/stamp/autoCompleteEmployee")
    public List<AutoComplete> autoCompleteEmployee() {
        return stampService.autoCompleteEmployee();
    }
    //代办业务跳转
    @RequestMapping("/stamp/process")
    public ModelAndView stamppProcess() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/stamp/stampProcess");
        return mv;
    }
    //代办页面初始化
    @ResponseBody
    @RequestMapping("/stamp/getProcessList")
    public Map<String, Object> getProcessList(Stamp stamp, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> stamps = new HashMap();
        stamp.setCreator(CommonUtil.getPersonId());
        stamp.setCreateDept(CommonUtil.getDefaultDept());
        stamp.setChanger(CommonUtil.getPersonId());
        stamp.setChangeDept(CommonUtil.getDefaultDept());
        List<Stamp> list = stampService.getProcessList(stamp);
        PageInfo<List<Stamp>> info = new PageInfo(list);
        stamps.put("draw", draw);
        stamps.put("recordsTotal", info.getTotal());
        stamps.put("recordsFiltered", info.getTotal());
        stamps.put("data", list);
        return stamps;
    }

    //已办业务跳转
    @RequestMapping("/stamp/complete")
    public ModelAndView stamppComplete() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/stamp/stampComplete");
        return mv;
    }
    //已办页面初始化
    @ResponseBody
    @RequestMapping("/stamp/getCompleteList")
    public Map<String, Object> getCompleteList(Stamp stamp, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> stamps = new HashMap();
        stamp.setCreator(CommonUtil.getPersonId());
        stamp.setCreateDept(CommonUtil.getDefaultDept());
        stamp.setChanger(CommonUtil.getPersonId());
        stamp.setChangeDept(CommonUtil.getDefaultDept());
        List<Stamp> list = stampService.getCompleteList(stamp);
        PageInfo<List<Stamp>> info = new PageInfo(list);
        stamps.put("draw", draw);
        stamps.put("recordsTotal", info.getTotal());
        stamps.put("recordsFiltered", info.getTotal());
        stamps.put("data", list);
        return stamps;
    }

     //待办修改
    @ResponseBody
    @RequestMapping("/stamp/auditStampEdit")
    public ModelAndView auditStampEdit(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/stamp/editStampProcess");
        Stamp stamp = stampService.getStampById(id);
        mv.addObject("head", "修改");
        mv.addObject("stamp", stamp);
        return mv;
    }
    //查看流程轨迹
    @ResponseBody
    @RequestMapping("/stamp/auditStampById")
    public ModelAndView waitRoleById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/stamp/addStampProcess");
        Stamp stamp = stampService.getStampById(id);
        mv.addObject("head", "审批");
        mv.addObject("stamp", stamp);
        return mv;
    }
    @ResponseBody
    @RequestMapping("/stamp/printStamp")
    public ModelAndView printStamp(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/stamp/printStamp");
        Stamp stamp = stampService.getStampById(id);
        String state = stampService.getStateById(id);
        String workflowName = "";
        if ("2".equals(stamp.getStampFlag())) {
            workflowName = workflowService.getWorkflowNameByWorkflowCode("T_BG_STAMP_WF02");
        }else{
            workflowName = workflowService.getWorkflowNameByWorkflowCode("T_BG_STAMP_WF01");
        }
        List<Handle> list=stampService.getHandlebyId(id);
        int size=list.size();
        mv.addObject("handleList", list);
        mv.addObject("size",size);
        mv.addObject("state",state);
        String requestDate = stamp.getRequestDate().replace("T", " ");
        mv.addObject("requestDate", requestDate);
        mv.addObject("stamp", stamp);
        mv.addObject("workflowName", workflowName);
        return mv;
    }

}
