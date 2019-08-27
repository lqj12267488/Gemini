package com.goisan.synergy.workflow.colltroller;

import com.goisan.synergy.workflow.bean.NewsDraft;
import com.goisan.synergy.workflow.service.NewsDraftService;
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
 * Created by Administrator on 2017/7/20.
 */
@Controller
public class NewsDraftController {
    @Resource
    private NewsDraftService newsDraftService;
    @Resource
    private EmpService empService;
    @Resource
    private FilesService filesService;
    @Resource
    private WorkflowService workflowService;
    @Resource
    private StampService stampService;
    /**功能：申请页面跳转
     * modify by wq
     * @return mv页面
     */
    @RequestMapping("/newsDraft/request")
    public ModelAndView newsDraftList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/newsDraft/newsDraft");
        return mv;
    }
    /**功能：申请页申请列表显示和查询
     * modify by wq
     * @return hotelStayMap
     */
    @ResponseBody
    @RequestMapping("/newsDraft/getNewsDraftList")
    public Map<String, List<NewsDraft>> getNewsDraftList(NewsDraft newsDraft) {
        Map<String, List<NewsDraft>> newsDraftMap = new HashMap<String, List<NewsDraft>>();
        newsDraft.setCreator(CommonUtil.getPersonId());
        newsDraft.setChangeDept(CommonUtil.getDefaultDept());
        newsDraftMap.put("data", newsDraftService.getNewsDraftList(newsDraft));
        return newsDraftMap;
    }
    /***
     * 功能：跳转到新增界面(包括申请部门，人员，时间显示)
     * modify by wq
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/newsDraft/addNewsDraft")
    public ModelAndView addNewsDraft() {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/newsDraft/editNewsDraft");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+'T'+time;
        NewsDraft newsDraft=new NewsDraft();
        newsDraft.setRequestDate(datetime);
        String personName = newsDraftService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = newsDraftService.getDeptNameById(CommonUtil.getDefaultDept());
        newsDraft.setRequester(personName);
        newsDraft.setRequestDept(deptName);
        mv.addObject("head", "新增申请");
        mv.addObject("newsDraft",newsDraft);
        return mv;
    }
    /**功能：跳转到修改界面（回显原申请信息）
     * modify by wq
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/newsDraft/getNewsDraftById")
    public ModelAndView getNewsDraftById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/newsDraft/editNewsDraft");
        NewsDraft newsDraft = newsDraftService.getNewsDraftById(id);
        mv.addObject("head", "申请修改");
        mv.addObject("newsDraft", newsDraft);
        return mv;
    }
    /**功能：申请新增和修改保存（包括通过申请id是否存在选择新增或修改申请信息）
     * modify by wq
     * @return 弹窗提示
     */
    @ResponseBody
    @RequestMapping("/newsDraft/saveNewsDraft")
    public Message saveNewsDraft(NewsDraft newsDraft){
        if(newsDraft.getId()==null || newsDraft.getId().equals("")){
            newsDraft.setCreator(CommonUtil.getPersonId());
            newsDraft.setCreateDept(CommonUtil.getDefaultDept());
            newsDraft.setRequester(CommonUtil.getPersonId());
            newsDraft.setRequestDept(CommonUtil.getDefaultDept());
            newsDraft.setId(CommonUtil.getUUID());
            newsDraftService.insertNewsDraft(newsDraft);
            return new Message(1, "新增成功！", null);
        }else{
            newsDraft.setRequester(CommonUtil.getPersonId());
            newsDraft.setRequestDept(CommonUtil.getDefaultDept());
            newsDraft.setChanger(CommonUtil.getPersonId());
            newsDraft.setChangeDept(CommonUtil.getDefaultDept());
            newsDraftService.updateNewsDraft(newsDraft);
            return new Message(1, "修改成功！", null);
        }
    }
    /**功能：申请信息删除（通过申请id删除申请信息）
     * modify by wq
     * @return 弹窗提示
     */
    @ResponseBody
    @RequestMapping("/newsDraft/deleteNewsDraft")
    public Message deleteNewsDraftById(String id) {
        newsDraftService.deleteNewsDraft(id);
        filesService.delFilesByBusinessId(id);
        return new Message(1, "删除成功！", null);
    }
    /**功能：待办页面跳转
     * modify by wq
     * @return mv界面
     */
    @RequestMapping("/newsDraft/process")
    public ModelAndView newsDraftListProcess() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/newsDraft/newsDraftProcess");
        return mv;
    }
    /**功能：待办页列表显示和查询
     * modify by wq
     * @return hotelStayMap
     */
    @ResponseBody
    @RequestMapping("/newsDraft/getNewsDraftProcessList")
    public Map<String, List<NewsDraft>> getNewsDraftProcessList(NewsDraft newsDraft) {
        Map<String, List<NewsDraft>> newsDraftMap = new HashMap<String, List<NewsDraft>>();
        newsDraft.setCreator(CommonUtil.getPersonId());
        newsDraft.setCreateDept(CommonUtil.getDefaultDept());
        newsDraft.setChanger(CommonUtil.getPersonId());
        newsDraft.setChangeDept(CommonUtil.getDefaultDept());
        newsDraftMap.put("data", newsDraftService.getNewsDraftProcessList(newsDraft));
        return newsDraftMap;
    }
    /**功能：待办页修改页面跳转（因为界面形式不同，不能使用申请页的添加和修改方法）
     * modify by wq
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/newsDraft/editNewsDraftProcess")
    public ModelAndView editNewsDraftProcess(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/newsDraft/editNewsDraftProcess");
        NewsDraft newsDraft = newsDraftService.getNewsDraftById(id);
        mv.addObject("head", "修改");
        mv.addObject("newsDraft", newsDraft);
        return mv;
    }
    /**功能：已办页面跳转
     * modify by wq
     * @return mv界面
     */
    @RequestMapping("/newsDraft/complete")
    public ModelAndView newsDraftListComplete() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/newsDraft/newsDraftComplete");
        return mv;
    }
    /**功能：已办页列表显示和查询
     * modify by wq
     * @return hotelStayMap
     */
    @ResponseBody
    @RequestMapping("/newsDraft/getNewsDraftCompleteList")
    public Map<String, List<NewsDraft>> getNewsDraftCompleteList(NewsDraft newsDraft) {
        Map<String, List<NewsDraft>> newsDraftMap = new HashMap<String, List<NewsDraft>>();
        newsDraft.setCreator(CommonUtil.getPersonId());
        newsDraft.setCreateDept(CommonUtil.getDefaultDept());
        newsDraft.setChanger(CommonUtil.getPersonId());
        newsDraft.setChangeDept(CommonUtil.getDefaultDept());
        newsDraftMap.put("data", newsDraftService.getNewsDraftCompleteList(newsDraft));
        return newsDraftMap;
    }
    /**功能：普通新闻稿查看申请信息及办理流程
     * modify by wq
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/newsDraft/auditNewsDraftById")
    public ModelAndView auditNewsDraftByIdP(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/newsDraft/auditNewsDraft");
        NewsDraft newsDraft = newsDraftService.getNewsDraftById(id);
        mv.addObject("head", "审批");
        mv.addObject("newsDraft", newsDraft);
        return mv;
    }
    /**功能：办理申请
     * modify by wq
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/newsDraft/auditNewsDraft")
    public ModelAndView auditNewsDraft(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/newsDraft/auditNewsDraft");
        NewsDraft newsDraft = newsDraftService.getNewsDraftById(id);
        mv.addObject("head", "办理");
        mv.addObject("newsDraft", newsDraft);
        return mv;
    }
    //获取部门名称
    @ResponseBody
    @RequestMapping("/newsDraft/getDept")
    public List<AutoComplete> selectDept() {
        return newsDraftService.selectDept();
    }
    //获取人员姓名
    @ResponseBody
    @RequestMapping("/newsDraft/getPerson")
    public List<AutoComplete> selectPerson() {
        return newsDraftService.selectPerson();
    }
    //获取当前人员所在部门的所有人员
    @ResponseBody
    @RequestMapping("/newsDraft/getDeptPerson")
    public List<Select2> getDeptPerson() {
        return newsDraftService.getDeptPerson(CommonUtil.getDefaultDept());
    }
    /**PC端打印*/
    @ResponseBody
    @RequestMapping("/newsDraft/printNewsDraft")
    public ModelAndView printHallUse(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/newsDraft/printNewsDraft");
        NewsDraft newsDraft = newsDraftService.getNewsDraftById(id);
        String workflowName;
        if ("2".equals(newsDraft.getNewsType())) {
            workflowName = workflowService.getWorkflowNameByWorkflowCode("T_BG_NEWSDRAFT_WF02");
        }else{
            workflowName = workflowService.getWorkflowNameByWorkflowCode("T_BG_NEWSDRAFT_WF01");
        }
        String state = stampService.getStateById(id);
        List<Handle> list= stampService.getHandlebyId(id);
        int size=list.size();
        mv.addObject("handleList", list);
        mv.addObject("size",size);
        mv.addObject("state",state);
        mv.addObject("workflowName", workflowName);
        mv.addObject("data", newsDraft);
        return mv;
    }
}
