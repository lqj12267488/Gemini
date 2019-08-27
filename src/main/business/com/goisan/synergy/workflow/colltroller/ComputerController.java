package com.goisan.synergy.workflow.colltroller;

import com.goisan.synergy.workflow.bean.Computer;
import com.goisan.synergy.workflow.service.ComputerService;
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
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/5/4.
 */
@Controller
public class ComputerController {

    @Resource
    private ComputerService computerService;
    @Resource
    private EmpService empService;
    @Resource
    private WorkflowService workflowService;
    @Resource
    private StampService stampService;
    /*
    RequestMapping 是数据库中的resource_url字段的数据
    mav.setViewName 是存放jsp路径的。
     */
    @RequestMapping("/computer/requet")
    public ModelAndView computerList(){
        ModelAndView mv= new ModelAndView();
        mv.setViewName("/business/synergy/workflow/computer/computer");
        return mv;
    }
    /*
    计算机耗材主页
     */
    @ResponseBody
    @RequestMapping("/computer/getComputerList")
    public Map<String,List<Computer>> getComputerList() {
        Map<String, List<Computer>> computerMap = new HashMap<String, List<Computer>>();
        Computer computer = new Computer();
        computer.setCreator(CommonUtil.getPersonId());
        computer.setCreateDept(CommonUtil.getDefaultDept());
        computerMap.put("data", computerService.computerAction(computer));
        return computerMap;
    }
    /*
    计算机耗材新增页
     */
    @RequestMapping("/computer/addComputer")
    public ModelAndView addComputer() {
        ModelAndView mv = new ModelAndView("business/synergy/workflow/computer/addComputer");
        mv.addObject("head", "计算机耗材新增");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new java.util.Date());
        String time = formatTime.format(new java.util.Date());
        String datetime = date+'T'+time;
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        Computer computer = new Computer();
        computer.setRequestdate(datetime);
        mv.addObject("head", "新增申请");
        mv.addObject("computer", computer);
        mv.addObject("personName",personName);
        mv.addObject("deptName", deptName);
        return mv;
    }
    /*
    新增保存
     */
    @ResponseBody
    @RequestMapping("/computer/saveComputer")
    public Message saveComputer(Computer computer){
        computer.setRequestdept(CommonUtil.getDefaultDept());
        computer.setRequester(CommonUtil.getPersonId());
        if(computer.getId()==null || computer.getId().equals("")){
            computer.setCreator(CommonUtil.getPersonId());
            computer.setCreateDept(CommonUtil.getDefaultDept());
            computer.setId(CommonUtil.getUUID());
            computer.setRequestflag("0");
            computerService.insertComputer(computer);
            return new Message(1, "新增成功！", null);
        }else{
            computer.setChanger(CommonUtil.getPersonId());
            computer.setChangeDept(CommonUtil.getDefaultDept());
            computerService.updateComputer(computer);
            return new Message(1, "修改成功！", null);
        }
    }
    /*
    修改页面
     */
    @ResponseBody
    @RequestMapping("/computer/getComputerById")
    public ModelAndView getComputerById(String id) {
        ModelAndView mv = new ModelAndView("business/synergy/workflow/computer/editComputer");
        Computer computer = computerService.getComputerById(id);
        mv.addObject("head", "计算机耗材修改");
        mv.addObject("computer", computer);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/computer/updateComputer")
    public Message updateComputer(Computer computer) {
        Date date = new Date(new java.util.Date().getTime());
        computer.setChanger(CommonUtil.getPersonId());
        computer.setChangeDept(CommonUtil.getDefaultDept());
        computerService.updateComputer(computer);
        return new Message(1, "修改成功！", null);
    }

    @ResponseBody
    @RequestMapping("/computer/deleteComputerById")
    public Message deleteDeptById(String id) {
        computerService.deleteComputerById(id);
        //菜单,按钮权限删除
        return new Message(1, "删除成功！", null);
    }

    @ResponseBody
    @RequestMapping("/computer/searchComputer")
    public Map<String, List<Computer>> searchComputer(Computer computer) {
        Map<String, List<Computer>> softMap = new HashMap<String, List<Computer>>();
        computer.setCreator(CommonUtil.getPersonId());
        computer.setCreateDept(CommonUtil.getDefaultDept());
        softMap.put("data", computerService.getComputerList(computer));
        return softMap;
    }

    @ResponseBody
    @RequestMapping("/computer/getDept")
    public List<AutoComplete> getDept() {
        return computerService.selectDept();
    }

    @ResponseBody
    @RequestMapping("/computer/getPerson")
    public List<AutoComplete> getPerson() {
        return computerService.selectPerson();
    }

    /*
    待办业务
     */
    @RequestMapping("/computer/process")
    public ModelAndView ComputerProcessList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/computer/computerProcess");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/computer/auditComputerById")
    public ModelAndView waitRoleById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/computer/addComputerProcess");
        Computer computer = computerService.getComputerId(id);
        mv.addObject("head", "审批");
        mv.addObject("computer", computer);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/process/computer/searchComputer")
    public Map<String, List<Computer>> processSearchComputer(Computer computer) {
        Map<String, List<Computer>> computerMap = new HashMap<String, List<Computer>>();
        if ("%%".equals(computer.getRequestdept())){
            computer.setRequestdept(null);
        }
        if ("%%".equals(computer.getRequester())){
            computer.setRequester(null);
        }
        computer.setCreator(CommonUtil.getPersonId());
        computer.setCreateDept(CommonUtil.getDefaultDept());
        computerMap.put("data", computerService.getProcessComputerList(computer));
        return computerMap;
    }
    /*
    已办事项
     */
    @RequestMapping("/computer/complete")
    public ModelAndView ComputerCompleteList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/computer/computerComplete");
        return mv;
    }
    @ResponseBody
    @RequestMapping("/complete/computer/searchComputer")
    public Map<String, List<Computer>> completeSearchComputer(Computer computer) {
        Map<String, List<Computer>> computerMap = new HashMap<String, List<Computer>>();
        if ("%%".equals(computer.getRequestdept())){
            computer.setRequestdept(null);
        }
        if ("%%".equals(computer.getRequester())){
            computer.setRequester(null);
        }
        computer.setCreator(CommonUtil.getPersonId());
        computer.setCreateDept(CommonUtil.getDefaultDept());
        computerMap.put("data", computerService.getCompleteComputerList(computer));
        return computerMap;
    }

    @ResponseBody
    @RequestMapping("/computer/auditEdit")
    public ModelAndView auditEdit(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/computer/auditEditComputer");
        Computer computer = computerService.getComputerById(id);
        mv.addObject("head", "修改");
        mv.addObject("computer", computer);
        return mv;
    }
    @ResponseBody
    @RequestMapping("/computer/printComputer")
    public ModelAndView printComputer(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/computer/printComputer");
        Computer computer = computerService.getComputerById(id);
        String state = stampService.getStateById(id);
        List<Handle> list= stampService.getHandlebyId(id);
        int size=list.size();
        mv.addObject("handleList", list);
        mv.addObject("size",size);
        mv.addObject("state",state);
        String workflowName = workflowService.getWorkflowNameByWorkflowCode("T_BG_COMPUTER_WF01");
        String requestDate = computer.getRequestdate().replace("T", " ");
        mv.addObject("requestDate", requestDate);
        mv.addObject("computer", computer);
        mv.addObject("workflowName", workflowName);
        return mv;
    }
}
