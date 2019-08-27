package com.goisan.synergy.workflow.colltroller;

import com.goisan.synergy.workflow.bean.SchoolVehicle;
import com.goisan.synergy.workflow.service.SchoolVehicleService;
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
 * Created by wq on 2017/10/10.
 */
@Controller
public class SchoolVehicleController {
    @Resource
    private SchoolVehicleService schoolVehicleService;
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
    @RequestMapping("/schoolVehicle/request")
    public ModelAndView schoolVehicleList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/schoolvehicle/schoolVehicleList");
        return mv;
    }
    /**功能：申请页申请信息查询
     * modify by wq
     * @return hotelStayMap
     */
    @ResponseBody
    @RequestMapping("/schoolVehicle/getSchoolVehicleList")
    public Map<String, List<SchoolVehicle>> getSchoolVehicleList(SchoolVehicle schoolVehicle) {
        Map<String, List<SchoolVehicle>> schoolVehicleMap = new HashMap<String, List<SchoolVehicle>>();
        schoolVehicle.setCreator(CommonUtil.getPersonId());
        schoolVehicle.setChangeDept(CommonUtil.getDefaultDept());
        schoolVehicleMap.put("data", schoolVehicleService.getSchoolVehicleList(schoolVehicle));
        return schoolVehicleMap;
    }
    /***
     * 功能：跳转到申请新增界面(包括申请部门，人员，时间显示)
     * modify by wq
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/schoolVehicle/addSchoolVehicle")
    public ModelAndView addSchoolVehicle() {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/schoolvehicle/editSchoolVehicle");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+'T'+time;
        SchoolVehicle schoolVehicle=new SchoolVehicle();
        schoolVehicle.setRequestTime(datetime);
        String personName = schoolVehicleService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = schoolVehicleService.getDeptNameById(CommonUtil.getDefaultDept());
        schoolVehicle.setRequester(personName);
        schoolVehicle.setRequestDept(deptName);
        mv.addObject("head", "新增申请");
        mv.addObject("schoolVehicle",schoolVehicle);
        return mv;
    }
    /**功能：跳转到申请修改界面（回显原申请信息）
     * modify by wq
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/schoolVehicle/getSchoolVehicleById")
    public ModelAndView getSchoolVehicleById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/schoolvehicle/editSchoolVehicle");
        SchoolVehicle schoolVehicle = schoolVehicleService.getSchoolVehicleById(id);
        mv.addObject("head", "申请修改");
        mv.addObject("schoolVehicle", schoolVehicle);
        return mv;
    }
    /**功能：申请信息保存（包括通过申请id是否存在选择新增或修改申请信息）
     * modify by wq
     * @return 弹窗提示
     */
    @ResponseBody
    @RequestMapping("/schoolVehicle/saveSchoolVehicle")
    public Message saveSchoolVehicle(SchoolVehicle schoolVehicle){
        if(schoolVehicle.getId()==null || schoolVehicle.getId().equals("")){
            schoolVehicle.setCreator(CommonUtil.getPersonId());
            schoolVehicle.setCreateDept(CommonUtil.getDefaultDept());
            schoolVehicle.setRequester(CommonUtil.getPersonId());
            schoolVehicle.setRequestDept(CommonUtil.getDefaultDept());
            schoolVehicle.setId(CommonUtil.getUUID());
            schoolVehicleService.insertSchoolVehicle(schoolVehicle);
            return new Message(1, "新增成功！", null);
        }else{
            schoolVehicle.setChanger(CommonUtil.getPersonId());
            schoolVehicle.setChangeDept(CommonUtil.getDefaultDept());
            schoolVehicle.setRequester(CommonUtil.getPersonId());
            schoolVehicle.setRequestDept(CommonUtil.getDefaultDept());
            schoolVehicleService.updateSchoolVehicle(schoolVehicle);
            return new Message(1, "修改成功！", null);
        }
    }
    /**功能：申请信息删除（通过申请id删除申请信息）
     * modify by wq
     * @return 弹窗提示
     */
    @ResponseBody
    @RequestMapping("/schoolVehicle/deleteSchoolVehicle")
    public Message deleteSchoolVehicleById(String id) {
        schoolVehicleService.deleteSchoolVehicle(id);
        filesService.delFilesByBusinessId(id);
        return new Message(1, "删除成功！", null);
    }
    /**功能：待办页面跳转
     * modify by wq
     * @return mv界面
     */
    @RequestMapping("/schoolVehicle/process")
    public ModelAndView schoolVehicleListProcess() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/schoolvehicle/schoolVehicleProcess");
        return mv;
    }
    /**功能：待办页需处理的申请信息查询
     * modify by wq
     * @return hotelStayMap
     */
    @ResponseBody
    @RequestMapping("/schoolVehicle/getSchoolVehicleProcessList")
    public Map<String, List<SchoolVehicle>> getSchoolVehicleProcessList(SchoolVehicle schoolVehicle) {
        Map<String, List<SchoolVehicle>> schoolVehicleMap = new HashMap<String, List<SchoolVehicle>>();
        schoolVehicle.setCreator(CommonUtil.getPersonId());
        schoolVehicle.setCreateDept(CommonUtil.getDefaultDept());
        schoolVehicle.setChanger(CommonUtil.getPersonId());
        schoolVehicle.setChangeDept(CommonUtil.getDefaultDept());
        schoolVehicleMap.put("data", schoolVehicleService.getSchoolVehicleProcessList(schoolVehicle));
        return schoolVehicleMap;
    }
    /**功能：被驳回申请的信息修改（因为界面形式不同，不能使用申请页的添加和修改方法）
     * modify by wq
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/schoolVehicle/editSchoolVehicleProcess")
    public ModelAndView editSchoolVehicleProcess(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/schoolvehicle/editSchoolVehicleProcess");
        SchoolVehicle schoolVehicle = schoolVehicleService.getSchoolVehicleById(id);
        mv.addObject("head", "修改");
        mv.addObject("schoolVehicle", schoolVehicle);
        return mv;
    }
    /**功能：已办页面跳转
     * modify by wq
     * @return mv界面
     */
    @RequestMapping("/schoolVehicle/complete")
    public ModelAndView schoolVehicleListComplete() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/schoolvehicle/schoolVehicleComplete");
        return mv;
    }
    /**功能：已办页已处理的申请信息查询
     * modify by wq
     * @return hotelStayMap
     */
    @ResponseBody
    @RequestMapping("/schoolVehicle/getSchoolVehicleCompleteList")
    public Map<String, List<SchoolVehicle>> getSchoolVehicleCompleteList(SchoolVehicle schoolVehicle) {
        Map<String, List<SchoolVehicle>> schoolVehicleMap = new HashMap<String, List<SchoolVehicle>>();
        schoolVehicle.setCreator(CommonUtil.getPersonId());
        schoolVehicle.setCreateDept(CommonUtil.getDefaultDept());
        schoolVehicle.setChanger(CommonUtil.getPersonId());
        schoolVehicle.setChangeDept(CommonUtil.getDefaultDept());
        schoolVehicleMap.put("data", schoolVehicleService.getSchoolVehicleCompleteList(schoolVehicle));
        return schoolVehicleMap;
    }
    /**功能：查看申请信息及办理流程
     * modify by wq
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/schoolVehicle/auditSchoolVehicleById")
    public ModelAndView auditSchoolVehicleById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/schoolvehicle/auditSchoolVehicle");
        SchoolVehicle schoolVehicle = schoolVehicleService.getSchoolVehicleById(id);
        mv.addObject("head", "审批");
        mv.addObject("schoolVehicle", schoolVehicle);
        return mv;
    }
    /**PC端打印*/
    @ResponseBody
    @RequestMapping("/schoolVehicle/printSchoolVehicle")
    public ModelAndView printHallUse(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/schoolvehicle/printSchoolVehicle");
        SchoolVehicle schoolVehicle = schoolVehicleService.getSchoolVehicleById(id);
        String workflowName = workflowService.getWorkflowNameByWorkflowCode("T_BG_SCHOOLVEHICLE_WF01");
        String state = stampService.getStateById(id);
        List<Handle> list= stampService.getHandlebyId(id);
        int size=list.size();
        mv.addObject("handleList", list);
        mv.addObject("size",size);
        mv.addObject("state",state);
        mv.addObject("workflowName",workflowName);
        mv.addObject("data", schoolVehicle);
        return mv;
    }
    /**功能：办理申请
     * modify by wq
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/schoolVehicle/auditSchoolVehicle")
    public ModelAndView auditSchoolVehicle(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/schoolvehicle/auditSchoolVehicle");
        SchoolVehicle schoolVehicle = schoolVehicleService.getSchoolVehicleById(id);
        mv.addObject("head", "办理");
        mv.addObject("schoolVehicle", schoolVehicle);
        return mv;
    }
    //查询所有部门id和名称
    @ResponseBody
    @RequestMapping("/schoolVehicle/getDept")
    public List<AutoComplete> selectDept() {
        return schoolVehicleService.selectDept();
    }
    //查询所有人员id和姓名
    @ResponseBody
    @RequestMapping("/schoolVehicle/getPerson")
    public List<AutoComplete> selectPerson() {
        return schoolVehicleService.selectPerson();
    }
}
