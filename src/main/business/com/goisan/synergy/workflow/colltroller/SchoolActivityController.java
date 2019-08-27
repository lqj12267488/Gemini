package com.goisan.synergy.workflow.colltroller;

import com.goisan.synergy.workflow.bean.SchoolActivity;
import com.goisan.synergy.workflow.service.SchoolActivityService;
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

/**协同办公-校外人员进校参加活动管理
 * Created by wq on 2017/10/11.
 */
@Controller
public class SchoolActivityController {
    @Resource
    private SchoolActivityService schoolActivityService;
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
    @RequestMapping("/schoolActivity/request")
    public ModelAndView schoolActivityList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/schoolactivity/schoolActivityList");
        return mv;
    }
    /**功能：申请页申请信息查询
     * modify by wq
     * @return hotelStayMap
     */
    @ResponseBody
    @RequestMapping("/schoolActivity/getSchoolActivityList")
    public Map<String, List<SchoolActivity>> getSchoolActivityList(SchoolActivity schoolActivity) {
        Map<String, List<SchoolActivity>> schoolActivityMap = new HashMap<String, List<SchoolActivity>>();
        schoolActivity.setCreator(CommonUtil.getPersonId());
        schoolActivity.setChangeDept(CommonUtil.getDefaultDept());
        schoolActivityMap.put("data", schoolActivityService.getSchoolActivityList(schoolActivity));
        return schoolActivityMap;
    }
    /***
     * 功能：跳转到申请新增界面(包括申请部门，人员，时间显示)
     * modify by wq
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/schoolActivity/addSchoolActivity")
    public ModelAndView addSchoolActivity() {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/schoolactivity/editSchoolActivity");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+'T'+time;
        SchoolActivity schoolActivity=new SchoolActivity();
        schoolActivity.setRequestTime(datetime);
        String personName = schoolActivityService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = schoolActivityService.getDeptNameById(CommonUtil.getDefaultDept());
        schoolActivity.setRequester(personName);
        schoolActivity.setRequestDept(deptName);
        mv.addObject("head", "新增申请");
        mv.addObject("schoolActivity",schoolActivity);
        return mv;
    }
    /**功能：跳转到申请修改界面（回显原申请信息）
     * modify by wq
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/schoolActivity/getSchoolActivityById")
    public ModelAndView getSchoolActivityById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/schoolactivity/editSchoolActivity");
        SchoolActivity schoolActivity = schoolActivityService.getSchoolActivityById(id);
        mv.addObject("head", "申请修改");
        mv.addObject("schoolActivity", schoolActivity);
        return mv;
    }
    /**功能：申请信息保存（包括通过申请id是否存在选择新增或修改申请信息）
     * modify by wq
     * @return 弹窗提示
     */
    @ResponseBody
    @RequestMapping("/schoolActivity/saveSchoolActivity")
    public Message saveSchoolActivity(SchoolActivity schoolActivity){
        if(schoolActivity.getId()==null || schoolActivity.getId().equals("")){
            schoolActivity.setCreator(CommonUtil.getPersonId());
            schoolActivity.setCreateDept(CommonUtil.getDefaultDept());
            schoolActivity.setRequester(CommonUtil.getPersonId());
            schoolActivity.setRequestDept(CommonUtil.getDefaultDept());
            schoolActivity.setId(CommonUtil.getUUID());
            schoolActivityService.insertSchoolActivity(schoolActivity);
            return new Message(1, "新增成功！", null);
        }else{
            schoolActivity.setChanger(CommonUtil.getPersonId());
            schoolActivity.setChangeDept(CommonUtil.getDefaultDept());
            schoolActivity.setRequester(CommonUtil.getPersonId());
            schoolActivity.setRequestDept(CommonUtil.getDefaultDept());
            schoolActivityService.updateSchoolActivity(schoolActivity);
            return new Message(1, "修改成功！", null);
        }
    }
    /**功能：申请信息删除（通过申请id删除申请信息）
     * modify by wq
     * @return 弹窗提示
     */
    @ResponseBody
    @RequestMapping("/schoolActivity/deleteSchoolActivity")
    public Message deleteSchoolActivityById(String id) {
        schoolActivityService.deleteSchoolActivity(id);
        filesService.delFilesByBusinessId(id);
        return new Message(1, "删除成功！", null);
    }
    /**功能：待办页面跳转
     * modify by wq
     * @return mv界面
     */
    @RequestMapping("/schoolActivity/process")
    public ModelAndView schoolActivityListProcess() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/schoolactivity/schoolActivityProcess");
        return mv;
    }
    /**功能：待办页需处理的申请信息查询
     * modify by wq
     * @return hotelStayMap
     */
    @ResponseBody
    @RequestMapping("/schoolActivity/getSchoolActivityProcessList")
    public Map<String, List<SchoolActivity>> getSchoolActivityProcessList(SchoolActivity schoolActivity) {
        Map<String, List<SchoolActivity>> schoolActivityMap = new HashMap<String, List<SchoolActivity>>();
        schoolActivity.setCreator(CommonUtil.getPersonId());
        schoolActivity.setCreateDept(CommonUtil.getDefaultDept());
        schoolActivity.setChanger(CommonUtil.getPersonId());
        schoolActivity.setChangeDept(CommonUtil.getDefaultDept());
        schoolActivityMap.put("data", schoolActivityService.getSchoolActivityProcessList(schoolActivity));
        return schoolActivityMap;
    }
    /**功能：被驳回申请的信息修改（因为界面形式不同，不能使用申请页的添加和修改方法）
     * modify by wq
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/schoolActivity/editSchoolActivityProcess")
    public ModelAndView editSchoolActivityProcess(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/schoolactivity/editSchoolActivityProcess");
        SchoolActivity schoolActivity = schoolActivityService.getSchoolActivityById(id);
        mv.addObject("head", "修改");
        mv.addObject("schoolActivity", schoolActivity);
        return mv;
    }
    /**功能：已办页面跳转
     * modify by wq
     * @return mv界面
     */
    @RequestMapping("/schoolActivity/complete")
    public ModelAndView schoolActivityListComplete() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/schoolactivity/schoolActivityComplete");
        return mv;
    }
    /**功能：已办页已处理的申请信息查询
     * modify by wq
     * @return hotelStayMap
     */
    @ResponseBody
    @RequestMapping("/schoolActivity/getSchoolActivityCompleteList")
    public Map<String, List<SchoolActivity>> getSchoolActivityCompleteList(SchoolActivity schoolActivity) {
        Map<String, List<SchoolActivity>> schoolActivityMap = new HashMap<String, List<SchoolActivity>>();
        schoolActivity.setCreator(CommonUtil.getPersonId());
        schoolActivity.setCreateDept(CommonUtil.getDefaultDept());
        schoolActivity.setChanger(CommonUtil.getPersonId());
        schoolActivity.setChangeDept(CommonUtil.getDefaultDept());
        schoolActivityMap.put("data", schoolActivityService.getSchoolActivityCompleteList(schoolActivity));
        return schoolActivityMap;
    }
    /**功能：查看申请信息及办理流程
     * modify by wq
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/schoolActivity/auditSchoolActivityById")
    public ModelAndView auditSchoolActivityById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/schoolactivity/auditSchoolActivity");
        SchoolActivity schoolActivity = schoolActivityService.getSchoolActivityById(id);
        mv.addObject("head", "审批");
        mv.addObject("schoolActivity", schoolActivity);
        return mv;
    }
    /**功能：办理申请
     * modify by wq
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/schoolActivity/auditSchoolActivity")
    public ModelAndView auditSchoolActivity(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/schoolactivity/auditSchoolActivity");
        SchoolActivity schoolActivity = schoolActivityService.getSchoolActivityById(id);
        mv.addObject("head", "办理");
        mv.addObject("schoolActivity", schoolActivity);
        return mv;
    }
    /**PC端打印*/
    @ResponseBody
    @RequestMapping("/schoolActivity/printSchoolActivity")
    public ModelAndView printHallUse(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/schoolactivity/printSchoolActivity");
        SchoolActivity schoolActivity = schoolActivityService.getSchoolActivityById(id);
        String  workflowName = workflowService.getWorkflowNameByWorkflowCode("T_BG_SCHOOLACTIVITY_WF01");
        String state = stampService.getStateById(id);
        List<Handle> list= stampService.getHandlebyId(id);
        int size=list.size();
        mv.addObject("handleList", list);
        mv.addObject("size",size);
        mv.addObject("state",state);
        mv.addObject("data", schoolActivity);
        mv.addObject("workflowName",workflowName);
        return mv;
    }
    //查询所有部门id和名称
    @ResponseBody
    @RequestMapping("/schoolActivity/getDept")
    public List<AutoComplete> selectDept() {
        return schoolActivityService.selectDept();
    }
    //查询所有人员id和姓名
    @ResponseBody
    @RequestMapping("/schoolActivity/getPerson")
    public List<AutoComplete> selectPerson() {
        return schoolActivityService.selectPerson();
    }
}