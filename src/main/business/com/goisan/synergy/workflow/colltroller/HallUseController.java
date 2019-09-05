package com.goisan.synergy.workflow.colltroller;

import com.goisan.synergy.workflow.bean.HallUse;
import com.goisan.synergy.workflow.bean.Standard;
import com.goisan.synergy.workflow.service.HallUseService;
import com.goisan.synergy.workflow.service.StampService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Select2;
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
 * 礼堂使用管理
 * Created by wq on 2017/7/18.
 */
@Controller
public class HallUseController {
    @Resource
    private HallUseService hallUseService;
    @Resource
    private FilesService filesService;
    @Resource
    private EmpService empService;
    @Resource
    private WorkflowService workflowService;
    @Resource
    private StampService stampService;

    /**
     * 功能：申请页面跳转
     * modify by wq
     *
     * @return mv页面
     */
    @RequestMapping("/hallUse/request")
    public ModelAndView hallUseList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/hallUse/hallUse");
        return mv;
    }

    /**
     * 功能：申请页申请列表显示和查询
     * modify by wq
     *
     * @return hotelStayMap
     */
    @ResponseBody
    @RequestMapping("/hallUse/getHallUseList")
    public Map<String, List<HallUse>> getHallUseList(HallUse hallUse) {
        Map<String, List<HallUse>> hallUseMap = new HashMap<String, List<HallUse>>();
        hallUse.setCreator(CommonUtil.getPersonId());
        hallUse.setChangeDept(CommonUtil.getDefaultDept());
        hallUseMap.put("data", hallUseService.getHallUseList(hallUse));
        return hallUseMap;
    }

    /***
     * 功能：跳转到新增界面(包括申请部门，人员，时间显示)
     * modify by wq
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/hallUse/addHallUse")
    public ModelAndView addHallUse(Standard standard) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/hallUse/editHallUse");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date + 'T' + time;
        HallUse hallUse = new HallUse();
        hallUse.setRequestDate(datetime);
        hallUse.setStartTime(datetime);
        hallUse.setEndTime(datetime);
        String personName = hallUseService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = hallUseService.getDeptNameById(CommonUtil.getDefaultDept());
        hallUse.setRequester(personName);
        hallUse.setRequestDept(deptName);
        standard.setLevel(CommonUtil.getLoginUser().getLevel());
        standard.setCreateDept(CommonUtil.getDefaultDept());
        standard.setStandardType("1");
        standard = hallUseService.getHallUseStandard(standard);
        mv.addObject("standard", standard);
        mv.addObject("head", "新增申请");
        mv.addObject("hallUse", hallUse);
        return mv;
    }

    /**
     * 功能：跳转到修改界面（回显原申请信息）
     * modify by wq
     *
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/hallUse/getHallUseById")
    public ModelAndView getHallUseById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/hallUse/editHallUse");
        HallUse hallUse = hallUseService.getHallUseById(id);
        Standard standard=new Standard();
        standard.setLevel(CommonUtil.getLoginUser().getLevel());
        standard.setCreateDept(CommonUtil.getDefaultDept());
        standard.setStandardType("1");
        standard = hallUseService.getHallUseStandard(standard);
        mv.addObject("standard", standard);
        mv.addObject("head", "申请修改");
        mv.addObject("hallUse", hallUse);
        return mv;
    }

    /**
     * 功能：申请新增和修改保存（包括通过申请id是否存在选择新增或修改申请信息）
     * modify by wq
     *
     * @return 弹窗提示
     */
    @ResponseBody
    @RequestMapping("/hallUse/saveHallUse")
    public Message saveHallUse(HallUse hallUse) {
        if (hallUse.getId() == null || hallUse.getId().equals("")) {
            hallUse.setCreator(CommonUtil.getPersonId());
            hallUse.setCreateDept(CommonUtil.getDefaultDept());
            hallUse.setRequester(CommonUtil.getPersonId());
            hallUse.setRequestDept(CommonUtil.getDefaultDept());
            hallUse.setLeaderDept(CommonUtil.getDefaultDept());
            hallUse.setId(CommonUtil.getUUID());
            hallUseService.insertHallUse(hallUse);
            return new Message(1, "新增成功！", null);
        } else {
            hallUse.setRequester(CommonUtil.getPersonId());
            hallUse.setRequestDept(CommonUtil.getDefaultDept());
            hallUse.setChanger(CommonUtil.getPersonId());
            hallUse.setChangeDept(CommonUtil.getDefaultDept());
            hallUseService.updateHallUse(hallUse);
            return new Message(1, "修改成功！", null);
        }
    }

    /**
     * 功能：申请信息删除（通过申请id删除申请信息）
     * modify by wq
     *
     * @return 弹窗提示
     */
    @ResponseBody
    @RequestMapping("/hallUse/deleteHallUse")
    public Message deleteHallUseById(String id) {
        hallUseService.deleteHallUse(id);
        filesService.delFilesByBusinessId(id);
        return new Message(1, "删除成功！", null);
    }

    /**
     * 功能：待办页面跳转
     * modify by wq
     *
     * @return mv界面
     */
    @RequestMapping("/hallUse/process")
    public ModelAndView hallUseListProcess() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/hallUse/hallUseProcess");
        return mv;
    }

    /**
     * 功能：待办页列表显示和查询
     * modify by wq
     *
     * @return hotelStayMap
     */
    @ResponseBody
    @RequestMapping("/hallUse/getHallUseProcessList")
    public Map<String, List<HallUse>> getHallUseProcessList(HallUse hallUse) {
        Map<String, List<HallUse>> hallUseMap = new HashMap<String, List<HallUse>>();
        hallUse.setCreator(CommonUtil.getPersonId());
        hallUse.setCreateDept(CommonUtil.getDefaultDept());
        hallUse.setChanger(CommonUtil.getPersonId());
        hallUse.setChangeDept(CommonUtil.getDefaultDept());
        hallUseMap.put("data", hallUseService.getHallUseProcessList(hallUse));
        return hallUseMap;
    }

    /**
     * 功能：待办页修改页面跳转（因为界面形式不同，不能使用申请页的添加和修改方法）
     * modify by wq
     *
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/hallUse/editHallUseProcess")
    public ModelAndView editHallUseProcess(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/hallUse/editHallUseProcess");
        HallUse hallUse = hallUseService.getHallUseById(id);
        Standard standard=new Standard();
        standard.setLevel(CommonUtil.getLoginUser().getLevel());
        standard.setCreateDept(CommonUtil.getDefaultDept());
        standard.setStandardType("1");
        standard = hallUseService.getHallUseStandard(standard);
        mv.addObject("standard", standard);
        mv.addObject("head", "修改");
        mv.addObject("hallUse", hallUse);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/hallUse/printHallUse")
    public ModelAndView printHallUse(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/hallUse/printHallUse");
        HallUse hallUse = hallUseService.getHallUseById(id);
        String workflowName = "";
        if("0".equals(hallUse.getMeetingRequest())){
            workflowName = workflowService.getWorkflowNameByWorkflowCode("T_BG_HALLUSE_WF03");
        }else{
            workflowName = workflowService.getWorkflowNameByWorkflowCode("T_BG_HALLUSE_WF02");
        }
        Standard standard=new Standard();
        standard.setLevel(CommonUtil.getLoginUser().getLevel());
        standard.setCreateDept(CommonUtil.getDefaultDept());
        standard.setStandardType("1");
        standard = hallUseService.getHallUseStandard(standard);
        String requestDate = hallUse.getRequestDate().replace("T", " ");
        String startTime = hallUse.getStartTime().replace("T", " ");
        String endTime = hallUse.getEndTime().replace("T", " ");
        String state = stampService.getStateById(id);
        List<Handle> list= stampService.getHandlebyId(id);
        int size=list.size();
        mv.addObject("handleList", list);
        mv.addObject("size",size);
        mv.addObject("state",state);
        mv.addObject("requestDate", requestDate);
        mv.addObject("startTime", startTime);
        mv.addObject("endTime", endTime);
        mv.addObject("standard", standard);
        mv.addObject("hallUse", hallUse);
        mv.addObject("workflowName", workflowName);
        return mv;
    }


    /**
     * 功能：已办页面跳转
     * modify by wq
     *
     * @return mv界面
     */
    @RequestMapping("/hallUse/complete")
    public ModelAndView hallUseListComplete() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/hallUse/hallUseComplete");
        return mv;
    }

    /**
     * 功能：已办页列表显示和查询
     * modify by wq
     *
     * @return hotelStayMap
     */
    @ResponseBody
    @RequestMapping("/hallUse/getHallUseCompleteList")
    public Map<String, List<HallUse>> getHallUseCompleteList(HallUse hallUse) {
        Map<String, List<HallUse>> hallUseMap = new HashMap<String, List<HallUse>>();
        hallUse.setCreator(CommonUtil.getPersonId());
        hallUse.setCreateDept(CommonUtil.getDefaultDept());
        hallUse.setChanger(CommonUtil.getPersonId());
        hallUse.setChangeDept(CommonUtil.getDefaultDept());
        hallUseMap.put("data", hallUseService.getHallUseCompleteList(hallUse));
        return hallUseMap;
    }

    /**
     * 功能：查看申请信息及办理流程
     * modify by wq
     *
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/hallUse/auditHallUseById")
    public ModelAndView auditHallUseById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/hallUse/auditHallUse");
        HallUse hallUse = hallUseService.getHallUseById(id);
//        String leader=hallUseService.getPersonNameById(hallUse.getLeader());
//        hallUse.setLeader(leader);
        mv.addObject("head", "审批");
        mv.addObject("hallUse", hallUse);
        return mv;
    }

    /**
     * 功能：办理申请
     * modify by wq
     *
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/hallUse/auditHallUse")
    public ModelAndView auditHallUse(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/hallUse/auditHallUse");
        HallUse hallUse = hallUseService.getHallUseById(id);
        mv.addObject("head", "办理");
        mv.addObject("hallUse", hallUse);
        return mv;
    }

    //获取部门名称
    @ResponseBody
    @RequestMapping("/hallUse/getDept")
    public List<AutoComplete> selectDept() {
        return hallUseService.selectDept();
    }

    //获取人员姓名
    @ResponseBody
    @RequestMapping("/hallUse/getPerson")
    public List<AutoComplete> selectPerson() {
        return hallUseService.selectPerson();
    }

    //获取当前人员所在部门的所有人员
    @ResponseBody
    @RequestMapping("/hallUse/getDeptPerson")
    public List<Select2> getDeptPerson() {
        return hallUseService.getDeptPerson(CommonUtil.getDefaultDept());
    }

    // 礼堂使用规范维护
    @ResponseBody
    @RequestMapping("/hallUse/standardEdit")
    public ModelAndView standardEdit(Standard standard) {
        standard.setStandardType("1");
        standard.setCreateDept(CommonUtil.getDefaultDept());
        standard.setLevel(CommonUtil.getLoginUser().getLevel());
        standard = hallUseService.getHallUseStandard(standard);
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/hallUse/hallUseStandardEdit");
        mv.addObject("standard", standard);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/hallUse/standardSave")
    public Message standardSave(Standard standard) {
        if (standard.getId() == null || standard.getId().equals("")) {
            standard.setCreator(CommonUtil.getPersonId());
            standard.setCreateDept(CommonUtil.getDefaultDept());
            standard.setChanger(CommonUtil.getPersonId());
            standard.setChangeDept(CommonUtil.getDefaultDept());
            hallUseService.insertHallUseStandard(standard);
            return new Message(1, "新增成功！", null);
        } else {
            standard.setChanger(CommonUtil.getPersonId());
            standard.setChangeDept(CommonUtil.getDefaultDept());
            hallUseService.updateHallUseStandard(standard);
            return new Message(1, "修改成功！", null);
        }
    }
}
