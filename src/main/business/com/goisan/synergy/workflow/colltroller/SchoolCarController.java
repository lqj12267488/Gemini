package com.goisan.synergy.workflow.colltroller;

import com.goisan.synergy.workflow.bean.SchoolCar;
import com.goisan.synergy.workflow.service.SchoolCarService;
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

/**学校车辆外出使用管理
 * Created and modify by wq on 2017/6/27 0027.
 */
@Controller
public class SchoolCarController {
    @Resource
    private SchoolCarService schoolCarService;
    @Resource
    private EmpService empService;
    @Resource
    private WorkflowService workflowService;
    @Resource
    private StampService stampService;
    /**功能：跳转到申请页面
     * modify by wq
     * @return mv页面
     */
    @RequestMapping("/schoolCar/request")
    public ModelAndView schoolCarList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/schoolCar/schoolCar");
        return mv;
    }
    /**功能：申请页申请信息查询
     * modify by wq
     * @return hotelStayMap
     */
    @ResponseBody
    @RequestMapping("/schoolCar/getSchoolCarList")
    public Map<String, List<SchoolCar>> getSchoolCarList(SchoolCar schoolCar) {
        Map<String, List<SchoolCar>> schoolCarMap = new HashMap<String, List<SchoolCar>>();
        schoolCar.setCreator(CommonUtil.getPersonId());
        schoolCar.setChangeDept(CommonUtil.getDefaultDept());
        schoolCarMap.put("data", schoolCarService.getSchoolCarList(schoolCar));
        return schoolCarMap;
    }
    /***
     * 功能：跳转到申请新增界面(包括申请部门，人员，时间显示)
     * modify by wq
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/schoolCar/addSchoolCar")
    public ModelAndView addSchoolCar() {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/schoolCar/addSchoolCar");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+'T'+time;
        SchoolCar schoolCar=new SchoolCar();
        schoolCar.setRequestDate(datetime);
        schoolCar.setStartTime(datetime);
        schoolCar.setEndTime(datetime);
        String personName = schoolCarService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = schoolCarService.getDeptNameById(CommonUtil.getDefaultDept());
        schoolCar.setRequester(personName);
        schoolCar.setRequestDept(deptName);
        mv.addObject("head", "新增申请");
        mv.addObject("schoolCar",schoolCar);
        return mv;
    }
    /**功能：跳转到申请修改界面（回显原申请信息）
     * modify by wq
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/schoolCar/getSchoolCarById")
    public ModelAndView getSchoolCarById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/schoolCar/addSchoolCar");
        SchoolCar schoolCar = schoolCarService.getSchoolCarById(id);
        mv.addObject("head", "申请修改");
        mv.addObject("schoolCar", schoolCar);
        return mv;
    }
    /**功能：申请信息保存（包括通过申请id是否存在选择新增或修改申请信息）
     * modify by wq
     * @return 弹窗提示
     */
    @ResponseBody
    @RequestMapping("/schoolCar/saveSchoolCar")
    public Message saveSchoolCar(SchoolCar schoolCar){
        if(schoolCar.getId()==null || schoolCar.getId().equals("")){
            schoolCar.setCreator(CommonUtil.getPersonId());
            schoolCar.setCreateDept(CommonUtil.getDefaultDept());
            schoolCar.setRequester(CommonUtil.getPersonId());
            schoolCar.setRequestDept(CommonUtil.getDefaultDept());
            schoolCar.setId(CommonUtil.getUUID());
            schoolCarService.insertSchoolCar(schoolCar);
            return new Message(1, "新增成功！", null);
        }else{
            schoolCar.setRequester(CommonUtil.getPersonId());
            schoolCar.setRequestDept(CommonUtil.getDefaultDept());
            schoolCar.setChanger(CommonUtil.getPersonId());
            schoolCar.setChangeDept(CommonUtil.getDefaultDept());
            schoolCarService.updateSchoolCarById(schoolCar);
            return new Message(1, "修改成功！", null);
        }
    }
    /**功能：申请信息删除（通过申请id删除申请信息）
     * modify by wq
     * @return 弹窗提示
     */
    @ResponseBody
    @RequestMapping("/schoolCar/deleteSchoolCarById")
    public Message deleteSchoolCarById(String id) {
        schoolCarService.deleteSchoolCarById(id);
        return new Message(1, "删除成功！", null);
    }
    /**功能：待办页面跳转
     * modify by wq
     * @return mv界面
     */
    @RequestMapping("/schoolCar/process")
    public ModelAndView schoolCarListProcess() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/schoolCar/schoolCarProcess");
        return mv;
    }
    /**功能：待办页需处理的申请信息查询
     * modify by wq
     * @return hotelStayMap
     */
    @ResponseBody
    @RequestMapping("/schoolCar/getSchoolCarListProcess")
    public Map<String, List<SchoolCar>> getSchoolCarListProcess(SchoolCar schoolCar) {
        Map<String, List<SchoolCar>> schoolCarMap = new HashMap<String, List<SchoolCar>>();
        schoolCar.setCreator(CommonUtil.getPersonId());
        schoolCar.setCreateDept(CommonUtil.getDefaultDept());
        schoolCar.setChanger(CommonUtil.getPersonId());
        schoolCar.setChangeDept(CommonUtil.getDefaultDept());
        schoolCarMap.put("data", schoolCarService.getSchoolCarListProcess(schoolCar));
        return schoolCarMap;
    }
    /**功能：被驳回申请的信息修改（因为界面形式不同，不能使用申请页的添加和修改方法）
     * modify by wq
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/schoolCar/editSchoolCarProcess")
    public ModelAndView editSchoolCarProcess(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/schoolCar/editSchoolCarProcess");
        SchoolCar schoolCar = schoolCarService.getSchoolCarById(id);
        mv.addObject("head", "修改");
        mv.addObject("schoolCar", schoolCar);
        return mv;
    }
    /**功能：已办页面跳转
     * modify by wq
     * @return mv界面
     */
    @RequestMapping("/schoolCar/complete")
    public ModelAndView schoolCarListComplete() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/schoolCar/schoolCarComplete");
        return mv;
    }
    /**功能：已办页已处理的申请信息查询
     * modify by wq
     * @return hotelStayMap
     */
    @ResponseBody
    @RequestMapping("/schoolCar/getSchoolCarListComplete")
    public Map<String, List<SchoolCar>> getSchoolCarListComplete(SchoolCar schoolCar) {
        Map<String, List<SchoolCar>> schoolCarMap = new HashMap<String, List<SchoolCar>>();
        schoolCar.setCreator(CommonUtil.getPersonId());
        schoolCar.setCreateDept(CommonUtil.getDefaultDept());
        schoolCar.setChanger(CommonUtil.getPersonId());
        schoolCar.setChangeDept(CommonUtil.getDefaultDept());
        schoolCarMap.put("data", schoolCarService.getSchoolCarListComplete(schoolCar));
        return schoolCarMap;
    }
    /**功能：查看申请信息及办理流程
     * modify by wq
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/schoolCar/auditSchoolCarById")
    public ModelAndView auditSchoolCarById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/schoolCar/auditSchoolCar");
        SchoolCar schoolCar = schoolCarService.getSchoolCarById(id);
        mv.addObject("head", "审批");
        mv.addObject("schoolCar", schoolCar);
        return mv;
    }
    /**功能：办理申请
     * modify by wq
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/schoolCar/auditSchoolCar")
    public ModelAndView auditSchoolCar(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/schoolCar/auditSchoolCar");
        SchoolCar schoolCar = schoolCarService.getSchoolCarById(id);
        mv.addObject("head", "办理");
        mv.addObject("schoolCar", schoolCar);
        return mv;
    }
//    查询所有部门id和名称
    @ResponseBody
    @RequestMapping("/schoolCar/getDept")
    public List<AutoComplete> selectDept() {
        return schoolCarService.selectDept();
    }
//    查询所有人员id和名称
    @ResponseBody
    @RequestMapping("/schoolCar/getPerson")
    public List<AutoComplete> getPerson() {
        return schoolCarService.selectPerson();
    }
    /**功能：车辆管理员登记页面跳转
     * modify by wq
     * @return mv界面
     */
    @RequestMapping("/schoolCar/register")
    public ModelAndView schoolCarRegister() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/schoolCar/schoolCarRegister/schoolCarRegister");
        return mv;
    }
    /**功能：车辆管理员登记信息列表
     * modify by wq
     * @return schoolCarMap
     */
    @ResponseBody
    @RequestMapping("/schoolCar/getSchoolCarRegisterList")
    public Map<String, List<SchoolCar>> getSchoolCarRegisterList(SchoolCar schoolCar) {
        Map<String, List<SchoolCar>> schoolCarMap = new HashMap<String, List<SchoolCar>>();
        schoolCar.setCreator(CommonUtil.getPersonId());
        schoolCar.setCreateDept(CommonUtil.getDefaultDept());
        schoolCar.setCarManager(CommonUtil.getPersonId());
        schoolCar.setCarManagerDept(CommonUtil.getDefaultDept());
        schoolCarMap.put("data", schoolCarService.getSchoolCarRegisterList(schoolCar));
        return schoolCarMap;
    }
    /**功能：车辆管理员登记界面
     * modify by wq
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/schoolCar/addSchoolCarRegister")
    public ModelAndView addSchoolCarRegister(String id) {
        SchoolCar schoolCar = schoolCarService.getSchoolCarById(id);
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+'T'+time;
        schoolCar.setCheckTime(datetime);
        String personName = schoolCarService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = schoolCarService.getDeptNameById(CommonUtil.getDefaultDept());
        schoolCar.setCarManager(personName);
        schoolCar.setCarManagerDept(deptName);
        if(schoolCar.getRequesterConfirmFlag()!="已登记"){
            ModelAndView mv = new ModelAndView("/business/synergy/workflow/schoolCar/schoolCarRegister/addSchoolCarRegister");
            mv.addObject("head", "登记");
            mv.addObject("schoolCar", schoolCar);
            return mv;
        }else{
            ModelAndView mv = new ModelAndView("/business/synergy/workflow/schoolCar/schoolCarRegister/schoolCarRegisterComplete");
            mv.addObject("head", "该登记信息已确认");
            mv.addObject("schoolCar", schoolCar);
            return mv;
        }
    }
    /**功能：登记信息保存（包括通过行驶里程是否存在判断是登记或修改信息）
     * modify by wq
     * @return 弹窗提示
     */
    @ResponseBody
    @RequestMapping("/schoolCar/saveSchoolCarRegister")
    public Message saveSchoolCarRegister(SchoolCar schoolCar){
        schoolCar.setCarManager(CommonUtil.getPersonId());
        schoolCar.setCarManagerDept(CommonUtil.getDefaultDept());
        schoolCarService.updateSchoolCarRegister(schoolCar);
        return new Message(1, "已移交申请人确认", null);
    }
    /**功能：管理员登记信息确认页面跳转（回显原申请信息）
     * modify by wq
     * @return mv界面
     */
    @RequestMapping("/schoolCar/confirm")
    public ModelAndView schoolCarConfirm() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/schoolCar/schoolCarRegister/schoolCarConfirm");
        return mv;
    }
    /**功能：申请人确认登记信息列表
     * modify by wq
     * @return hotelStayMap
     */
    @ResponseBody
    @RequestMapping("/schoolCar/getSchoolCarConfirmList")
    public Map<String, List<SchoolCar>> getSchoolCarConfirmList(SchoolCar schoolCar) {
        Map<String, List<SchoolCar>> schoolCarMap = new HashMap<String, List<SchoolCar>>();
        schoolCar.setCreator(CommonUtil.getPersonId());
        schoolCar.setCreateDept(CommonUtil.getDefaultDept());
        schoolCar.setCarManager(CommonUtil.getPersonId());
        schoolCar.setCarManagerDept(CommonUtil.getDefaultDept());
        schoolCarMap.put("data", schoolCarService.getSchoolCarConfirmList(schoolCar));
        return schoolCarMap;
    }
    /**功能：申请人确认登记信息界面
     * modify by wq
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/schoolCar/schoolCarConfirmRegister")
    public ModelAndView schoolCarConfirmRegister(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/schoolCar/schoolCarRegister/schoolCarConfirmRegister");
        SchoolCar schoolCar = schoolCarService.getSchoolCarById(id);
        mv.addObject("head", "确认登记信息");
        mv.addObject("schoolCar", schoolCar);
        return mv;
    }
    /**功能：登记信息保存（包括通过行驶里程是否存在判断是登记或修改信息）
     * modify by wq
     * @return 弹窗提示
     */
    @ResponseBody
    @RequestMapping("/schoolCar/confirmSchoolCarRegister")
    public Message confirmSchoolCarRegister(SchoolCar schoolCar){
        schoolCarService.updateSchoolCarConfirm(schoolCar);
        return new Message(1, "已确认登记信息", null);
    }
    /**功能：已确认登记信息显示界面
     * modify by wq
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/schoolCar/schoolCarRegisterComplete")
    public ModelAndView schoolCarRegisterComplete(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/schoolCar/schoolCarRegister/schoolCarRegisterComplete");
        SchoolCar schoolCar = schoolCarService.getSchoolCarById(id);
        mv.addObject("head", "确认登记信息");
        mv.addObject("schoolCar", schoolCar);
        return mv;
    }
    /**PC端打印*/
    @ResponseBody
    @RequestMapping("/schoolCar/printSchoolCar")
    public ModelAndView printHallUse(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/schoolCar/printSchoolCar");
        SchoolCar schoolCar = schoolCarService.getSchoolCarById(id);
        String workflowName = workflowService.getWorkflowNameByWorkflowCode("T_BG_SCHOOLCAR_WF01");
        String state = stampService.getStateById(id);
        List<Handle> list= stampService.getHandlebyId(id);
        int size=list.size();
        mv.addObject("handleList", list);
        mv.addObject("size",size);
        mv.addObject("state",state);
        mv.addObject("data", schoolCar);
        mv.addObject("workflowName",workflowName);
        return mv;
    }
}