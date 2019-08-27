package com.goisan.synergy.workflow.colltroller;

import com.goisan.synergy.workflow.bean.NoWorkDayPlace;
import com.goisan.synergy.workflow.bean.Standard;
import com.goisan.synergy.workflow.service.NoWorkDayPlaceService;
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

/**非工作日学校场所使用管理
 * Created by wq on 2017/7/19.
 */
@Controller
public class NoWorkDayPlaceController {
    @Resource
    private NoWorkDayPlaceService noWorkDayPlaceService;
    @Resource
    private EmpService empService;
    @Resource
    private FilesService filesService;
    @Resource
    private WorkflowService workflowService;
    @Resource
    private StampService stampService;
    /**功能：跳转到申请页面
     * modify by wq
     * @return mv页面
     */
    @RequestMapping("/noWorkDayPlace/request")
    public ModelAndView noWorkDayPlaceList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/noWorkDayPlace/noWorkDayPlace");
        return mv;
    }
    /**功能：申请页申请信息查询
     * modify by wq
     * @return hotelStayMap
     */
    @ResponseBody
    @RequestMapping("/noWorkDayPlace/getNoWorkDayPlaceList")
    public Map<String, List<NoWorkDayPlace>> getNoWorkDayPlaceList(NoWorkDayPlace noWorkDayPlace) {
        Map<String, List<NoWorkDayPlace>> noWorkDayPlaceMap = new HashMap<String, List<NoWorkDayPlace>>();
        noWorkDayPlace.setCreator(CommonUtil.getPersonId());
        noWorkDayPlace.setChangeDept(CommonUtil.getDefaultDept());
        noWorkDayPlaceMap.put("data", noWorkDayPlaceService.getNoWorkDayPlaceList(noWorkDayPlace));
        return noWorkDayPlaceMap;
    }
    /***
     * 功能：跳转到申请新增界面(包括申请部门，人员，时间显示)
     * modify by wq
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/noWorkDayPlace/addNoWorkDayPlace")
    public ModelAndView addNoWorkDayPlace() {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/noWorkDayPlace/editNoWorkDayPlace");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+'T'+time;
        NoWorkDayPlace noWorkDayPlace=new NoWorkDayPlace();
        noWorkDayPlace.setRequestDate(datetime);
        String personName = noWorkDayPlaceService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = noWorkDayPlaceService.getDeptNameById(CommonUtil.getDefaultDept());
        noWorkDayPlace.setRequester(personName);
        noWorkDayPlace.setRequestDept(deptName);
        Standard standard = noWorkDayPlaceService.getNoWorkDayPlaceStandard("2");
        mv.addObject("standard", standard);
        mv.addObject("head", "新增申请");
        mv.addObject("noWorkDayPlace",noWorkDayPlace);
        return mv;
    }
    /**功能：跳转到申请修改界面（回显原申请信息）
     * modify by wq
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/noWorkDayPlace/getNoWorkDayPlaceById")
    public ModelAndView getNoWorkDayPlaceById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/noWorkDayPlace/editNoWorkDayPlace");
        NoWorkDayPlace noWorkDayPlace = noWorkDayPlaceService.getNoWorkDayPlaceById(id);
        Standard standard = noWorkDayPlaceService.getNoWorkDayPlaceStandard("2");
        mv.addObject("standard", standard);
        mv.addObject("head", "申请修改");
        mv.addObject("noWorkDayPlace", noWorkDayPlace);
        return mv;
    }
    /**功能：申请信息保存（包括通过申请id是否存在选择新增或修改申请信息）
     * modify by wq
     * @return 弹窗提示
     */
    @ResponseBody
    @RequestMapping("/noWorkDayPlace/saveNoWorkDayPlace")
    public Message saveNoWorkDayPlace(NoWorkDayPlace noWorkDayPlace){
        if(noWorkDayPlace.getId()==null || noWorkDayPlace.getId().equals("")){
            noWorkDayPlace.setCreator(CommonUtil.getPersonId());
            noWorkDayPlace.setCreateDept(CommonUtil.getDefaultDept());
            noWorkDayPlace.setRequester(CommonUtil.getPersonId());
            noWorkDayPlace.setRequestDept(CommonUtil.getDefaultDept());
            noWorkDayPlace.setLeaderDept(CommonUtil.getDefaultDept());
            noWorkDayPlace.setId(CommonUtil.getUUID());
            noWorkDayPlaceService.insertNoWorkDayPlace(noWorkDayPlace);
            return new Message(1, "新增成功！", null);
        }else{
            noWorkDayPlace.setRequester(CommonUtil.getPersonId());
            noWorkDayPlace.setRequestDept(CommonUtil.getDefaultDept());
            noWorkDayPlace.setChanger(CommonUtil.getPersonId());
            noWorkDayPlace.setChangeDept(CommonUtil.getDefaultDept());
            noWorkDayPlaceService.updateNoWorkDayPlace(noWorkDayPlace);
            return new Message(1, "修改成功！", null);
        }
    }
    /**功能：申请信息删除（通过申请id删除申请信息）
     * modify by wq
     * @return 弹窗提示
     */
    @ResponseBody
    @RequestMapping("/noWorkDayPlace/deleteNoWorkDayPlace")
    public Message deleteNoWorkDayPlaceById(String id) {
        noWorkDayPlaceService.deleteNoWorkDayPlace(id);
        filesService.delFilesByBusinessId(id);
        return new Message(1, "删除成功！", null);
    }
    /**功能：待办页面跳转
     * modify by wq
     * @return mv界面
     */
    @RequestMapping("/noWorkDayPlace/process")
    public ModelAndView noWorkDayPlaceListProcess() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/noWorkDayPlace/noWorkDayPlaceProcess");
        return mv;
    }
    /**功能：待办页需处理的申请信息查询
     * modify by wq
     * @return hotelStayMap
     */
    @ResponseBody
    @RequestMapping("/noWorkDayPlace/getNoWorkDayPlaceProcessList")
    public Map<String, List<NoWorkDayPlace>> getNoWorkDayPlaceProcessList(NoWorkDayPlace noWorkDayPlace) {
        Map<String, List<NoWorkDayPlace>> noWorkDayPlaceMap = new HashMap<String, List<NoWorkDayPlace>>();
        noWorkDayPlace.setCreator(CommonUtil.getPersonId());
        noWorkDayPlace.setCreateDept(CommonUtil.getDefaultDept());
        noWorkDayPlace.setChanger(CommonUtil.getPersonId());
        noWorkDayPlace.setChangeDept(CommonUtil.getDefaultDept());
        noWorkDayPlaceMap.put("data", noWorkDayPlaceService.getNoWorkDayPlaceProcessList(noWorkDayPlace));
        return noWorkDayPlaceMap;
    }
    /**功能：被驳回申请的信息修改（因为界面形式不同，不能使用申请页的添加和修改方法）
     * modify by wq
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/noWorkDayPlace/editNoWorkDayPlaceProcess")
    public ModelAndView editNoWorkDayPlaceProcess(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/noWorkDayPlace/editNoWorkDayPlaceProcess");
        NoWorkDayPlace noWorkDayPlace = noWorkDayPlaceService.getNoWorkDayPlaceById(id);
        Standard standard = noWorkDayPlaceService.getNoWorkDayPlaceStandard("2");
        mv.addObject("standard", standard);
        mv.addObject("head", "修改");
        mv.addObject("noWorkDayPlace", noWorkDayPlace);
        return mv;
    }
    /**功能：已办页面跳转
     * modify by wq
     * @return mv界面
     */
    @RequestMapping("/noWorkDayPlace/complete")
    public ModelAndView noWorkDayPlaceListComplete() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/noWorkDayPlace/noWorkDayPlaceComplete");
        return mv;
    }
    /**功能：已办页已处理的申请信息查询
     * modify by wq
     * @return hotelStayMap
     */
    @ResponseBody
    @RequestMapping("/noWorkDayPlace/getNoWorkDayPlaceCompleteList")
    public Map<String, List<NoWorkDayPlace>> getNoWorkDayPlaceCompleteList(NoWorkDayPlace noWorkDayPlace) {
        Map<String, List<NoWorkDayPlace>> noWorkDayPlaceMap = new HashMap<String, List<NoWorkDayPlace>>();
        noWorkDayPlace.setCreator(CommonUtil.getPersonId());
        noWorkDayPlace.setCreateDept(CommonUtil.getDefaultDept());
        noWorkDayPlace.setChanger(CommonUtil.getPersonId());
        noWorkDayPlace.setChangeDept(CommonUtil.getDefaultDept());
        noWorkDayPlaceMap.put("data", noWorkDayPlaceService.getNoWorkDayPlaceCompleteList(noWorkDayPlace));
        return noWorkDayPlaceMap;
    }
    /**功能：查看申请信息及办理流程
     * modify by wq
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/noWorkDayPlace/auditNoWorkDayPlaceById")
    public ModelAndView auditNoWorkDayPlaceById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/noWorkDayPlace/auditNoWorkDayPlace");
        NoWorkDayPlace noWorkDayPlace = noWorkDayPlaceService.getNoWorkDayPlaceById(id);
        String leader=noWorkDayPlaceService.getPersonNameById(noWorkDayPlace.getLeader());
        noWorkDayPlace.setLeader(leader);
        mv.addObject("head", "审批");
        mv.addObject("noWorkDayPlace", noWorkDayPlace);
        return mv;
    }
    /**功能：办理申请
     * modify by wq
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/noWorkDayPlace/auditNoWorkDayPlace")
    public ModelAndView auditNoWorkDayPlace(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/noWorkDayPlace/auditNoWorkDayPlace");
        NoWorkDayPlace noWorkDayPlace = noWorkDayPlaceService.getNoWorkDayPlaceById(id);
        mv.addObject("head", "办理");
        mv.addObject("noWorkDayPlace", noWorkDayPlace);
        return mv;
    }
    //查询所有部门id和名称
    @ResponseBody
    @RequestMapping("/noWorkDayPlace/getDept")
    public List<AutoComplete> selectDept() {
        return noWorkDayPlaceService.selectDept();
    }
    //查询所有人员id和姓名
    @ResponseBody
    @RequestMapping("/noWorkDayPlace/getPerson")
    public List<AutoComplete> selectPerson() {
        return noWorkDayPlaceService.selectPerson();
    }
    //获取操作人所在部门的所有人员
    @ResponseBody
    @RequestMapping("/noWorkDayPlace/getDeptPerson")
    public List<Select2> getDeptPerson() {
        return noWorkDayPlaceService.getDeptPerson(CommonUtil.getDefaultDept());
    }

// 非工作日学校场所使用规范维护

    @RequestMapping("/noWorkDayPlace/standardEdit")
    public ModelAndView standardEdit(String type) {
        Standard standard = noWorkDayPlaceService.getNoWorkDayPlaceStandard("2");
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/noWorkDayPlace/noWorkDayPlaceStandardEdit");
        mv.addObject("standard", standard);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/noWorkDayPlace/standardSave")
    public Message standardSave(Standard standard) {
        if(standard.getId()==null || standard.getId().equals("")){
            standard.setCreator(CommonUtil.getPersonId());
            standard.setCreateDept(CommonUtil.getDefaultDept());
            standard.setChanger(CommonUtil.getPersonId());
            standard.setChangeDept(CommonUtil.getDefaultDept());
            noWorkDayPlaceService.insertNoWorkDayPlaceStandard(standard);
            return new Message(1, "新增成功！", null);
        }else{
            standard.setChanger(CommonUtil.getPersonId());
            standard.setChangeDept(CommonUtil.getDefaultDept());
            noWorkDayPlaceService.updateNoWorkDayPlaceStandard(standard);
            return new Message(1, "修改成功！", null);
        }
    }
    /**PC端打印*/
    @ResponseBody
    @RequestMapping("/noWorkDayPlace/printNoWorkDayPlace")
    public ModelAndView printHallUse(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/noWorkDayPlace/printNoWorkDayPlace");
        NoWorkDayPlace noWorkDayPlace = noWorkDayPlaceService.getNoWorkDayPlaceById(id);
        String state = stampService.getStateById(id);
        String workflowName = workflowService.getWorkflowNameByWorkflowCode("T_BG_NOWORKDAYPLACE_WF01");
        List<Handle> list= stampService.getHandlebyId(id);
        int size=list.size();
        mv.addObject("handleList", list);
        mv.addObject("size",size);
        mv.addObject("state",state);
        mv.addObject("data", noWorkDayPlace);
        mv.addObject("workflowName", workflowName);
        return mv;
    }
}
