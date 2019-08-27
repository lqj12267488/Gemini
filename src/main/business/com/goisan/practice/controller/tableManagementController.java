package com.goisan.practice.controller;

import com.fasterxml.jackson.annotation.JsonTypeInfo;
import com.goisan.practice.bean.Insurance;
import com.goisan.practice.bean.Material;
import com.goisan.practice.bean.SampleTable;
import com.goisan.practice.service.InsuranceService;
import com.goisan.practice.service.SampleTableService;
import com.goisan.system.bean.*;
import com.goisan.system.service.CommonService;
import com.goisan.system.service.EmpService;
import com.goisan.system.service.FilesService;
import com.goisan.system.service.StudentService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import com.sun.org.apache.bcel.internal.generic.NEW;
import org.apache.commons.io.FileUtils;
import org.apache.ibatis.javassist.tools.rmi.Sample;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Controller
public class tableManagementController {
    private static String COM_REPORT_PATH = null;
    @Resource
    private SampleTableService sampleTableService;
    @Resource
    private CommonService commonService;
    @Resource
    private FilesService filesService;
    @Resource
    private EmpService empService;
    /**
     * 实习样表首页跳转
     * @return
     */
    @RequestMapping("/table/management")
    public ModelAndView insuranceList() {
        ModelAndView mv = new ModelAndView();
        List<String> list = empService.getEmpRole(CommonUtil.getPersonId(),CommonUtil.getDefaultDept());
        String flag = "";
        String flag1 = "";
        if (list.contains("25c728a6-b9c5-4135-bc86-85672bda4eaa")){
            flag = "1";
        }
        if (list.contains("cdd60883-0066-49e4-bbf9-79736a9e254e")){
            flag1 = "0";
        }

        mv.addObject("flag",flag);
        mv.addObject("flag1",flag1);
        mv.setViewName("/business/practice/tableManagementList");
        return mv;
    }

    @RequestMapping("/tableManagement/toUpload")
    public String toUpload(String id, Model model) {
        model.addAttribute("id", id);
        return "/business/practice/upload";
    }

    @ResponseBody
    @RequestMapping("/tableManagement/upload")
    public Message update(String id, @RequestParam(value = "file") MultipartFile file) {
        filesService.delFilesByBusinessId(id);
        COM_REPORT_PATH = new File(this.getClass().getResource("/").getPath()).getParentFile().getParentFile().getPath();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        String urlParten = "/files/%s/%s";
        String fileName = file.getOriginalFilename();
        String path = String.format(urlParten, "T_JY_PRACTICE_SAMPLE_TABLE", sdf.format(new java.util.Date()));
        String url = path + "/" + CommonUtil.getUUID() + fileName.substring(fileName.indexOf("."));
        FileOutputStream fos = null;
        try {
            File f = new File(COM_REPORT_PATH + path);
            boolean mkdirs = f.mkdirs();
            if (!mkdirs) {
                fos = new FileOutputStream(new File(COM_REPORT_PATH + url));
                fos.write(file.getBytes());
            } else {
                return new Message(0, "上传失败！", null);
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (fos != null) {
                    fos.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        Files uploadFiles = new Files();
        uploadFiles.setFileId(CommonUtil.getUUID());
        uploadFiles.setFileName(fileName);
        uploadFiles.setFileType(fileName.substring(fileName.lastIndexOf(".") + 1));
        uploadFiles.setFileUrl(url);
        uploadFiles.setBusinessId(id);
        uploadFiles.setTableName("T_JY_PRACTICE_SAMPLE_TABLE");
        uploadFiles.setBusinessType("1");
        uploadFiles.setCreator(CommonUtil.getPersonId());
        uploadFiles.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
        filesService.insertFiles(uploadFiles);
//        teachingplanNewService.changeTeachingplanNewStatus(id, "1");
        return new Message(0, "上传成功！", null);
    }

    /**
     * 实习样表首页数据查询
     * @param sampleTable
     * @return
     */
    @ResponseBody
    @RequestMapping("/tableManagement/list")
    public Map<String, List<SampleTable>> getTableManagementList(SampleTable sampleTable) {
        Map<String, List<SampleTable>> sampleTableMap = new HashMap<String, List<SampleTable>>();
//        sampleTable.setCreator(CommonUtil.getPersonId());
//        sampleTable.setChangeDept(CommonUtil.getDefaultDept());
        sampleTableMap.put("data", sampleTableService.getTableManagementList(sampleTable));
        return sampleTableMap;
    }

    /**
     * 样表新增
     * @return
     */
    @ResponseBody
    @RequestMapping("/tableManagement/edit")
    public ModelAndView addInsuranceInstall(String id) {
        if (id == "" || id == null){
            ModelAndView mv = new ModelAndView("/business/practice/editSampleTable");
            mv.addObject("head", "新增样表信息");
            return mv;
        }{
            ModelAndView mv = new ModelAndView("/business/practice/editSampleTable");
            SampleTable sampleTable = sampleTableService.getSampleTableById(id);
            mv.addObject("head", "修改样表信息");
            mv.addObject("id",id);
            mv.addObject("sampleTable",sampleTable);
            return mv;
        }

//        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
//        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
//        String date = formatDate.format(new java.util.Date());
//        String time = formatTime.format(new java.util.Date());
//        String datetime = date+'T'+time;
//        Material material=new Material();
//        material.setUploadTime(datetime);
//        material.setUploadPerson(CommonUtil.getPersonName());
    }

    /**
     * 新增和修改保存
     * @param sampleTable
     * @return
     */
    @ResponseBody
    @RequestMapping("/sampleTable/saveDetails")
    public Message savematerial(SampleTable sampleTable){
        if(sampleTable.getId() == null || sampleTable.equals("") || sampleTable.getId() == ""){
            sampleTable.setCreator(CommonUtil.getPersonId());
            sampleTable.setCreateDept(CommonUtil.getDefaultDept());
            sampleTable.setId(CommonUtil.getUUID());
            sampleTableService.insertSampleTable(sampleTable);
            return new Message(1, "新增成功！", null);
        }else{
            sampleTable.setChanger(CommonUtil.getPersonId());
            sampleTable.setChangeDept(CommonUtil.getDefaultDept());
            sampleTableService.updateSampleTableById(sampleTable);
            return new Message(1, "修改成功！", null);
        }
    }
    /**
     * 删除
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/sampleTable/deleteSampleTableById")
    public Message deleteDeptById(String id) {
        sampleTableService.deleteSampleTableById(id);
        return new Message(1, "删除成功！", null);
    }
//
//    /**
//     * 导入页面跳转
//     * @param
//     * @return
//     */
//    @RequestMapping("/insurance/toImportInsurance")
//    public ModelAndView toImportStudent() {
//        ModelAndView mv = new ModelAndView();
//        mv.setViewName("/business/practice/importInsurance");
//        return mv;
//    }
//
//    /**
//     * 导入实习保险数据
//     * @param file
//     * @return
//     */
//    @ResponseBody
//    @RequestMapping("/insurance/importInsurance")
//    public Message importStudent(@RequestParam(value = "file", required = false) CommonsMultipartFile file) {
//        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
//        List<Select2> sexs = commonService.getSysDict("XB","");
//        int count = 0 ;
//        try {
//            HSSFWorkbook workbook = new HSSFWorkbook(file.getInputStream());
//            HSSFSheet sheet = workbook.getSheetAt(0);
//            int end = sheet.getLastRowNum();
//            for (int i = 2; i <= end; i++) {
//                HSSFRow row = sheet.getRow(i);
//                if(null == row && count == 0){
//                    return new Message(0, "无数据，导入失败！", "error");
//                }else if(null == row || row.getLastCellNum() == 1){
//                    return new Message(1, "共计"+count+"条，导入成功！", "success");
//                }
//
//                Insurance insurance = new Insurance();
//
//                for (Select2 sex : sexs) {
//                    if (sex.getText().equals(row.getCell(1).toString())) {
//                        insurance.setSex(sex.getId());
//                    }
//                }
//                insurance.setName(CommonUtil.toIdcardCheck(row.getCell(2).toString()));
//                insurance.setIdcard(CommonUtil.toIdcardCheck(row.getCell(2).toString()));
//                Insurance insurance1 = new Insurance();
//                insurance1 = insuranceService.getStudent(insurance.getIdcard());
//                insurance.setDepartmentsId(insurance1.getDepartmentsId());
//                insurance.setMajorCode(insurance1.getMajorCode());
//                insurance.setClassId(insurance1.getClassId());
//                insurance.setInsuranceNumber(CommonUtil.toIdcardCheck(row.getCell(4).toString()));
//                insuranceService.insertInsurance(insurance);
//                count++;
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//            String msg = "导入"+count+"条成功，第"+(count+1)+"条数据异常。导入失败！" ;
//            return new Message(0, msg, null);
//        }
//
//        return new Message(1, "共计"+count+"条，导入成功！", "success");
//    }
//
//    /**
//     * 实习保险模板
//     * @param response
//     */
//    @RequestMapping("/insurance/getInsuranceExcelTemplate")
//    public void getStudentExcelTemplate(HttpServletResponse response) {
//        String rootPath = new File(getClass().getResource("/").getPath()).getParentFile().getParent().toString();
//        rootPath = rootPath.replaceAll("%20"," ");
//        String fileName = rootPath + "/template/insuranceTemplate.xls";
//        File file = FileUtils.getFile(fileName);
//        OutputStream os = null;
//
//        try {
//            response.setContentType("application/vnd.ms-excel");
//            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
//                    ("实习保险基本信息模板.xls", "utf-8"));
//            os = response.getOutputStream();
//            os.write(FileUtils.readFileToByteArray(file));
//        } catch (UnsupportedEncodingException e) {
//            e.printStackTrace();
//        } catch (IOException e) {
//            e.printStackTrace();
//        } finally {
//            try {
//                os.flush();
//                os.close();
//            } catch (IOException e) {
//                e.printStackTrace();
//            }
//        }
//    }
}
