package com.goisan.practice.controller;

import com.goisan.practice.bean.Insurance;
import com.goisan.practice.service.InsuranceService;
import com.goisan.system.bean.ClassStudentRelation;
import com.goisan.system.bean.LoginUser;
import com.goisan.system.bean.Select2;
import com.goisan.system.bean.Student;
import com.goisan.system.service.CommonService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
/*import com.sun.org.apache.bcel.internal.generic.NEW;*/
import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.shiro.crypto.hash.SimpleHash;
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
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class InsuranceController {
    @Resource
    private InsuranceService insuranceService;
    @Resource
    private CommonService commonService;
    /**
     * 实习材料首页跳转
     * @return
     */
    @RequestMapping("/insurance/insuranceList")
    public ModelAndView insuranceList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/practice/insuranceList");
        return mv;
    }

    /**
     * 实习材料首页数据查询
     * @param insurance
     * @return
     */
    @ResponseBody
    @RequestMapping("/insurance/getInsuranceList")
    public Map<String, List<Insurance>> getInsuranceList(Insurance insurance) {
        Map<String, List<Insurance>> softInstallMap = new HashMap<String, List<Insurance>>();
        insurance.setCreator(CommonUtil.getPersonId());
        insurance.setChangeDept(CommonUtil.getDefaultDept());
        softInstallMap.put("data", insuranceService.insuranceAction(insurance));
        return softInstallMap;
    }

    /**
     * 实习材料新增
     * @return
     */
    @ResponseBody
    @RequestMapping("/insurance/addInsurance")
    public ModelAndView addInsuranceInstall() {
        ModelAndView mv = new ModelAndView("/business/practice/editInsurance");
        mv.addObject("head", "新增实习材料");
        return mv;
    }

    /**
     * 实习材料修改
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/insurance/getInsuranceById")
    public ModelAndView getInsuranceById(String id) {
        ModelAndView mv = new ModelAndView("/business/practice/editInsurance");
        Insurance insurance = insuranceService.getInsuranceById(id);
        mv.addObject("head", "实习材料修改");
        mv.addObject("insurance", insurance);
        return mv;
    }

    /**
     * 新增和修改保存
     * @param insurance
     * @return
     */
    @ResponseBody
    @RequestMapping("/insurance/saveInsurance")
    public Message saveinsurance(Insurance insurance){
        if(insurance.getId() == null || insurance.equals("") || insurance.getId() == ""){
            insurance.setCreator(CommonUtil.getPersonId());
            insurance.setCreateDept(CommonUtil.getDefaultDept());
            insuranceService.insertInsurance(insurance);
            return new Message(1, "新增成功！", null);
        }else{
            insurance.setChanger(CommonUtil.getPersonId());
            insurance.setChangeDept(CommonUtil.getDefaultDept());
            insuranceService.updateInsuranceById(insurance);
            return new Message(1, "修改成功！", null);
        }
    }

    /**
     * 删除
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/insurance/deleteInsuranceById")
    public Message deleteDeptById(String id) {
        insuranceService.deleteInsuranceById(id);
        return new Message(1, "删除成功！", null);
    }

    /**
     * 导入页面跳转
     * @param
     * @return
     */
    @RequestMapping("/insurance/toImportInsurance")
    public ModelAndView toImportStudent() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/practice/importInsurance");
        return mv;
    }

    /**
     * 导入实习保险数据
     * @param file
     * @return
     */
    @ResponseBody
    @RequestMapping("/insurance/importInsurance")
    public Message importStudent(@RequestParam(value = "file", required = false) CommonsMultipartFile file) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        List<Select2> sexs = commonService.getSysDict("XB","");
        int count = 0 ;
        try {
            HSSFWorkbook workbook = new HSSFWorkbook(file.getInputStream());
            HSSFSheet sheet = workbook.getSheetAt(0);
            int end = sheet.getLastRowNum();
            for (int i = 2; i <= end; i++) {
                HSSFRow row = sheet.getRow(i);
                if(null == row && count == 0){
                    return new Message(0, "无数据，导入失败！", "error");
                }else if(null == row || row.getLastCellNum() == 1){
                    return new Message(1, "共计"+count+"条，导入成功！", "success");
                }

                Insurance insurance = new Insurance();

                for (Select2 sex : sexs) {
                    if (sex.getText().equals(row.getCell(1).toString())) {
                        insurance.setSex(sex.getId());
                    }
                }
                insurance.setName(CommonUtil.toIdcardCheck(row.getCell(2).toString()));
                insurance.setIdcard(CommonUtil.toIdcardCheck(row.getCell(2).toString()));
                Insurance insurance1 = new Insurance();
                insurance1 = insuranceService.getStudent(insurance.getIdcard());
                insurance.setDepartmentsId(insurance1.getDepartmentsId());
                insurance.setMajorCode(insurance1.getMajorCode());
                insurance.setClassId(insurance1.getClassId());
                insurance.setInsuranceNumber(CommonUtil.toIdcardCheck(row.getCell(4).toString()));
                insuranceService.insertInsurance(insurance);
                count++;
            }
        } catch (Exception e) {
            e.printStackTrace();
            String msg = "导入"+count+"条成功，第"+(count+1)+"条数据异常。导入失败！" ;
            return new Message(0, msg, null);
        }

        return new Message(1, "共计"+count+"条，导入成功！", "success");
    }

    /**
     * 实习保险模板
     * @param response
     */
    @RequestMapping("/insurance/getInsuranceExcelTemplate")
    public void getStudentExcelTemplate(HttpServletResponse response) {
        String rootPath = new File(getClass().getResource("/").getPath()).getParentFile().getParent().toString();
        rootPath = rootPath.replaceAll("%20"," ");
        String fileName = rootPath + "/template/insuranceTemplate.xls";
        File file = FileUtils.getFile(fileName);
        OutputStream os = null;

        try {
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("实习保险基本信息模板.xls", "utf-8"));
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
