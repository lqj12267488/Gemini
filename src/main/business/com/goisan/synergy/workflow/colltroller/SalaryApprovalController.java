package com.goisan.synergy.workflow.colltroller;

import com.goisan.synergy.workflow.bean.SalaryApproval;
import com.goisan.synergy.workflow.service.SalaryApprovalService;
import com.goisan.synergy.workflow.service.StampService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.LoginUser;
import com.goisan.system.service.EmpService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import com.goisan.workflow.bean.Handle;
import com.goisan.workflow.service.WorkflowService;
import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by hanyu on 2017/7/18.
 */
@Controller
public class SalaryApprovalController {
    @Resource
    private SalaryApprovalService salaryApprovalService;

    @Resource
    private EmpService empService;
    @Resource
    private WorkflowService workflowService;
    @Resource
    private StampService stampService;

    /**
     * 工资单申请跳转
     * request by hanyue
     * modify by hanyue
     * @return
     */
    @RequestMapping("/salaryApproval/request")
    public ModelAndView salaryApprovalList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/salaryApproval/salaryApproval");
        return mv;
    }
    /**
     *  工资单URL
     *  url by hanyue
     *  modify by hanyue
     * @param salaryApproval
     * @return
     */
    @ResponseBody
    @RequestMapping("/salaryApproval/getSalaryApprovalList")
    public Map<String, List<SalaryApproval>> getSalaryApprovalList(SalaryApproval salaryApproval) {
        Map<String, List<SalaryApproval>> group = new HashMap<String, List<SalaryApproval>>();
        salaryApproval.setCreator(CommonUtil.getPersonId());
        salaryApproval.setCreateDept(CommonUtil.getDefaultDept());
        group.put("data",salaryApprovalService.getSalaryApprovalList(salaryApproval));
        return group;
    }
    /**
     * 工资单新增
     * add by hanyue
     * modify by hanyue
     * @return
     */
    @RequestMapping("/salaryApproval/getAddSalaryApproval")
    public ModelAndView getAddSalary() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/salaryApproval/editSalaryApproval");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+'T'+time;
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        SalaryApproval salaryApproval=new SalaryApproval();
        salaryApproval.setRequestDate(datetime);
        salaryApproval.setRequester(personName);
        salaryApproval.setRequestDept(deptName);
        mv.addObject("head","新增工资单");
        mv.addObject("salaryApproval",salaryApproval);
        mv.addObject("personName",personName);
        mv.addObject("deptName", deptName);
        return mv;
    }
    /**
     * 工资单修改
     * update by hanyue
     * modify by hanyue
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/salaryApproval/getSalaryApprovalById")
    public ModelAndView updateSalaryApproval(String id) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/salaryApproval/editSalaryApproval");
        mv.addObject("head","修改工资单");
        SalaryApproval salaryApproval = salaryApprovalService.getSalaryApprovalById(id);
        mv.addObject("salaryApproval",salaryApproval);
        return mv;
    }

    /**
     * 保存工资单
     * save by hanyue
     * modify by hanyue
     * @param salaryApproval
     * @return
     */
    @ResponseBody
    @RequestMapping("/salaryApproval/saveSalaryApproval")
    public Message saveSalaryApproval(SalaryApproval salaryApproval){
        LoginUser login = CommonUtil.getLoginUser();
        if(null ==salaryApproval.getId() || salaryApproval.getId().equals("")){
            salaryApproval.setCreator(login.getPersonId());
            salaryApproval.setCreateDept(login.getDefaultDeptId());
            salaryApprovalService.insertSalaryApproval(salaryApproval);
            return new Message(1, "新增成功！", null);
        }else{
            salaryApproval.setChanger(login.getPersonId());
            salaryApproval.setChangeDept(login.getDefaultDeptId());
            salaryApprovalService.updateSalaryApproval(salaryApproval);
            return new Message(1, "修改成功！", null);
        }
    }
    /**
     * 删除工资单
     * delete by hanyue
     * modify by hanyue
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/salaryApproval/deleteSalaryApproval")
    public Message deleteSalaryApproval(String id){
        salaryApprovalService.deleteSalaryApprovalById(id);
        return new Message(1, "删除成功！", null);
    }
    /**
     * 部门自动提示框
     * dept by hanyue
     * modify by hanyue
     * @return
     */
    @ResponseBody
    @RequestMapping("/salaryApproval/autoCompleteDept")
    public List<AutoComplete> autoCompleteDept() {
        return salaryApprovalService.autoCompleteDept();
    }
    /**
     * 人员自动提示框
     * person by hanyue
     * modify by hanyue
     * @return
     */
    @ResponseBody
    @RequestMapping("/salaryApproval/autoCompleteEmployee")
    public List<AutoComplete> autoCompleteEmployee() {
        return salaryApprovalService.autoCompleteEmployee();
    }
    /**
     * 代办业务跳转
     * agency business by hanyue
     * modify by hanyue
     * @return
     */
    @RequestMapping("/salaryApproval/process")
    public ModelAndView salaryApprovalProcess() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/salaryApproval/salaryApprovalProcess");
        return mv;
    }
    /**
     * 代办业务初始化
     * agency business initialize by hanyue
     * modify by hanyue
     * @param salaryApproval
     * @return
     */
    @ResponseBody
    @RequestMapping("/salaryApproval/getProcessList")
    public Map<String, List<SalaryApproval>> getProcessList(SalaryApproval salaryApproval) {
        Map<String, List<SalaryApproval>> salaryApprovalMap = new HashMap<String, List<SalaryApproval>>();
        salaryApproval.setCreator(CommonUtil.getPersonId());
        salaryApproval.setCreateDept(CommonUtil.getDefaultDept());
        salaryApproval.setChanger(CommonUtil.getPersonId());
        salaryApproval.setChangeDept(CommonUtil.getDefaultDept());
        salaryApprovalMap.put("data", salaryApprovalService.getProcessList(salaryApproval));
        return salaryApprovalMap;
    }

    /**
     * 已办业务跳转
     * already done business by hanyue
     * modify by hanyue
     * @return
     */
    @RequestMapping("/salaryApproval/complete")
    public ModelAndView salaryApprovalComplete() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/salaryApproval/salaryApprovalComplete");
        return mv;
    }
    /**
     * 已办页面初始化
     * already done business initialize by hanyue
     * modify by hanyue
     * @param salaryApproval
     * @return
     */
    @ResponseBody
    @RequestMapping("/salaryApproval/getCompleteList")
    public Map<String, List<SalaryApproval>> getCompleteList(SalaryApproval salaryApproval) {
        Map<String, List<SalaryApproval>> salaryApprovalMap = new HashMap<String, List<SalaryApproval>>();
        salaryApproval.setCreator(CommonUtil.getPersonId());
        salaryApproval.setCreateDept(CommonUtil.getDefaultDept());
        salaryApproval.setChanger(CommonUtil.getPersonId());
        salaryApproval.setChangeDept(CommonUtil.getDefaultDept());
        salaryApprovalMap.put("data", salaryApprovalService.getCompleteList(salaryApproval));
        return salaryApprovalMap;
    }

    /**
     * 待办修改
     * agency update by hanyue
     * modify by hanyue
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/salaryApproval/auditSalaryApprovalEdit")
    public ModelAndView auditSalaryApprovalEdit(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/salaryApproval/editSalaryApprovalProcess");
        SalaryApproval salaryApproval = salaryApprovalService.getSalaryApprovalById(id);
        mv.addObject("head", "修改");
        mv.addObject("salaryApproval", salaryApproval);
        return mv;
    }
    /**
     * 查看流程轨迹
     * process trajectory by hanyue
     * modify by hanyue
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/salaryApproval/auditSalaryApprovalById")
    public ModelAndView waitRoleById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/salaryApproval/addSalaryApprovalProcess");
        SalaryApproval salaryApproval = salaryApprovalService.getSalaryApprovalById(id);
        mv.addObject("head", "审批");
        mv.addObject("salaryApproval", salaryApproval);
        return mv;
    }
    /**PC端打印*/
    @ResponseBody
    @RequestMapping("/salaryApproval/printSalaryApproval")
    public ModelAndView printHallUse(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/salaryApproval/printSalaryApproval");
        SalaryApproval salaryApproval = salaryApprovalService.getSalaryApprovalById(id);
        String  workflowName = workflowService.getWorkflowNameByWorkflowCode("T_BG_SALARYAPPROVAL_WF01");
        String state = stampService.getStateById(id);
        List<Handle> list= stampService.getHandlebyId(id);
        int size=list.size();
        mv.addObject("handleList", list);
        mv.addObject("size",size);
        mv.addObject("state",state);
        mv.addObject("data", salaryApproval);
        mv.addObject("workflowName",workflowName);
        return mv;
    }
    /**
     * 导入页面
     * @return
     */
    @RequestMapping("/salaryApproval/toImportSalary")
    public ModelAndView toImportStudent(){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/salaryApproval/salaryApprovalImport");
        return mv;
    }
    @ResponseBody
    @RequestMapping("/salaryApproval/importSalary")
    public Message importStudent(@RequestParam(value = "file", required = false) CommonsMultipartFile file) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        LoginUser login = CommonUtil.getLoginUser();
        int count =0;
        try {
            HSSFWorkbook workbook = new HSSFWorkbook(file.getInputStream());
            HSSFSheet sheet = workbook.getSheetAt(0);
            int end = sheet.getLastRowNum();
            for (int i = 2; i <= end; i++) {
                HSSFRow row = sheet.getRow(i);
                SalaryApproval salaryApproval = new SalaryApproval();
                HSSFCell hssef1 = row.getCell(0);
                hssef1.setCellType(hssef1.CELL_TYPE_STRING);
                salaryApproval.setYear(CommonUtil.changeToInteger(hssef1)+"");
                HSSFCell hssef2 = row.getCell(1);
                hssef2.setCellType(hssef2.CELL_TYPE_STRING);
                salaryApproval.setMonth(CommonUtil.changeToInteger(hssef2)+"");
                salaryApproval.setFileName(row.getCell(2).toString());
                salaryApproval.setRemark(row.getCell(3).toString());
                salaryApproval.setCreator(login.getPersonId());
                salaryApproval.setCreateDept(login.getDefaultDeptId());
                salaryApprovalService.insertSalaryApprovalImport(salaryApproval);
                count ++;
            }
        }
        catch (Exception e) {
            e.printStackTrace();
            String msg = "导入"+count+"条成功，第"+(count+1)+"条数据异常。导入失败！" ;
            return new Message(0, msg, null);
        }
        return new Message(1, "共计"+count+"条，导入成功！", null);
    }
    /**
     * 导出模板
     * @param response
     */
    @ResponseBody
    @RequestMapping("/salaryApproval/getSalaryExcelTemplate")
    public void getSalaryExcelTemplate(HttpServletResponse response) {
        String rootPath = new File(getClass().getResource("/").getPath()).getParentFile().getParent().toString();
        rootPath = rootPath.replaceAll("%20"," ");
        String fileName = rootPath + "/template/salaryApprovalTemplate.xls";
        File file = FileUtils.getFile(fileName);
        OutputStream os = null;

        try {
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("工资单表模板.xls", "utf-8"));
            os = response.getOutputStream();
            os.write(FileUtils.readFileToByteArray(file));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                os.flush();
                os.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}
