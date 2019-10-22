package com.goisan.personnel.teachercontract.controller;

import com.goisan.personnel.teachercontract.bean.TeacherContract;
import com.goisan.personnel.teachercontract.service.TeacherContractService;
import com.goisan.studentwork.maintenance.bean.MtType;
import com.goisan.system.bean.Emp;
import com.goisan.system.bean.Select2;
import com.goisan.system.service.CommonService;
import com.goisan.system.service.EmpService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import com.goisan.system.tools.PoiUtils;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.system.bean.BaseBean;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.*;

import static com.goisan.system.controller.StudentController.setHSSFValidation;

@Controller
public class TeacherContractController {

    @Resource
    private TeacherContractService teacherContractService;

    @Autowired
    private CommonService commonService;

    @Autowired
    private EmpService empService;

    @RequestMapping("/TeacherContract/toTeacherContractList")
    public String toTeacherContractList() {
        return "/business/personnel/teachercontract/teacherContractList";
    }

//    @ResponseBody
//    @RequestMapping("/TeacherContract/getTeacherContractList")
//    public Map<String,Object> getTeacherContractList(TeacherContract teacherContract,int draw, int start, int length) {
//         PageHelper.startPage(start / length + 1, length);
//         Map<String, Object> map = new HashMap(16);
//         List<TeacherContract> list =  teacherContractService.getTeacherContractList(teacherContract);
//         PageInfo<List<TeacherContract>> info = new PageInfo(list);
//         map.put("draw", draw);
//         map.put("recordsTotal",  list.size());
//         map.put("recordsFiltered", list.size());
//         map.put("data", list);
//        return map;
//    }

    @ResponseBody
    @RequestMapping("/TeacherContract/getTeacherContractList")
    public Map<String,Object> getTeacherContractList(TeacherContract teacherContract) {
        Map<String, Object> map = new HashMap(16);
        List<TeacherContract> list =  teacherContractService.getTeacherContractList(teacherContract);
        map.put("data", list);
        return map;
    }

    @RequestMapping("/TeacherContract/toTeacherContractAdd")
    public String toAddTeacherContract(Model model) {
        model.addAttribute("head", "新增");
        return "/business/personnel/teachercontract/teacherContractEdit";
    }

    @ResponseBody
    @RequestMapping("/TeacherContract/saveTeacherContract")
    public Message saveTeacherContract(TeacherContract teacherContract) {
            teacherContractService.updateTeacherContract(teacherContract);
            return new Message(0, "修改成功！", null);
    }

    @RequestMapping("/TeacherContract/toTeacherContractEdit")
    public ModelAndView toEditTeacherContract(String personId, String deptId, String seeFlag) {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("data",teacherContractService.getTeacherContractByPersonId(personId, deptId));
        if (StringUtils.isEmpty(seeFlag)){
            modelAndView.addObject("head", "修改");
        }else {
            modelAndView.addObject("head", "详情");
        }
        if (null==seeFlag){
            seeFlag ="0";
        }
        modelAndView.addObject("seeFlag", seeFlag);
        modelAndView.setViewName("/business/personnel/teachercontract/teacherContractEdit");
        return modelAndView;
    }

    @RequestMapping("/TeacherContract/importContract")
    public String importContract(){
        return "/business/personnel/teachercontract/importContract";
    }


    @RequestMapping("/TeacherContract/contractTemplate")
    public void exportStudentInsurance(HttpServletRequest request, HttpServletResponse response) {
        HSSFWorkbook wb = new HSSFWorkbook();
        HSSFFont defaultFont = PoiUtils.createDefaultFont(wb, false);
        HSSFFont headFont = PoiUtils.createFont(wb, 14, "宋体", true,null);
        HSSFFont tips = PoiUtils.createFont(wb, 8, "宋体", true, HSSFColor.RED.index);
        HSSFCellStyle defaultStyle = PoiUtils.createStyle(wb, defaultFont, false);
        HSSFCellStyle headStyle = PoiUtils.createStyle(wb, headFont, false);
        HSSFCellStyle tipStyle = PoiUtils.createStyle(wb, tips, false);

        HSSFSheet sheet = wb.createSheet("教职工合同协议信息");
        HSSFRow row0 = sheet.createRow(0);
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 2, 30));
        PoiUtils.createCellWithStyleAndValue(row0,0,"日期格式:yyyy/MM/dd",tipStyle);
        PoiUtils.createCellWithStyleAndValue(row0,1,"*必填",tipStyle);
        PoiUtils.createCellWithStyleAndValue(row0,2,"教职工合同/协议信息",headStyle);
        HSSFRow row1 = sheet.createRow(1);
        sheet.addMergedRegion(new CellRangeAddress(1, 2, 0, 0));
        sheet.addMergedRegion(new CellRangeAddress(1, 2, 1, 1));
        sheet.addMergedRegion(new CellRangeAddress(1, 2, 2, 2));
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 3, 6));
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 7, 9));
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 10, 12));
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 13, 15));
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 16, 27));
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 28, 30));

        PoiUtils.createCellWithStyleAndValue(row1,0,"序号",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row1,1,"姓名",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row1,2,"证件号*",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row1,3,"试用期",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row1,7,"第一次劳动合同",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row1,10,"第二次劳动合同",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row1,13,"第三次劳动合同",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row1,16,"兼职协议",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row1,28,"保险福利",defaultStyle);

        HSSFRow row2 = sheet.createRow(2);
        PoiUtils.createCellWithStyleAndValue(row2,3,"开始日期",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row2,4,"截止日期",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row2,5,"使用期限",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row2,6,"转正日期",defaultStyle);

        PoiUtils.createCellWithStyleAndValue(row2,7,"第一次签订开始日期",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row2,8,"第一次签订截止日期",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row2,9,"合同期限",defaultStyle);

        PoiUtils.createCellWithStyleAndValue(row2,10,"第二次签订开始日期",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row2,11,"第二次签订截止日期",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row2,12,"合同期限",defaultStyle);

        PoiUtils.createCellWithStyleAndValue(row2,13,"第三次签订开始日期",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row2,14,"第三次签订截止日期",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row2,15,"合同期限",defaultStyle);

        PoiUtils.createCellWithStyleAndValue(row2,16,"开始日期",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row2,17,"截止日期",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row2,18,"协议期限",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row2,19,"人员性质",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row2,20,"退休证明",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row2,21,"份数",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row2,22,"校龄",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row2,23,"保密协议",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row2,24,"试用期工资",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row2,25,"转正工资",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row2,26,"转正系数",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row2,27,"离职日期",defaultStyle);

        PoiUtils.createCellWithStyleAndValue(row2,28,"退休",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row2,29,"社保号",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row2,30,"数量",defaultStyle);

        List<String> list1 = commonService.getSysDictName("YW","");
        String[] yw = new String[list1.size()];
        for (int j = 0; j < list1.size(); j++) {
            yw[j] = list1.get(j);
        }
        PoiUtils.setHSSFValidation(sheet, yw, 3, 5000, 23, 23);

        List<String> list2 = commonService.getSysDictName("SF","");
        String[] sf = new String[list2.size()];
        for (int j = 0; j < list2.size(); j++) {
            sf[j] = list2.get(j);
        }
        PoiUtils.setHSSFValidation(sheet, sf, 3, 5000, 28, 28);

        List<String> list3 = commonService.getSysDictName("RYXZ","");
        String[] ryxz = new String[list3.size()];
        for (int j = 0; j < list3.size(); j++) {
            ryxz[j] = list3.get(j);
        }
        PoiUtils.setHSSFValidation(sheet, ryxz, 3, 5000, 19, 19);

        String[] sqqx= {"1月","2月","3月"};
        PoiUtils.setHSSFValidation(sheet, sqqx, 3, 5000, 5, 5);

        String[] htqx= {"1年","2年","3年"};
        PoiUtils.setHSSFValidation(sheet, htqx, 3, 5000, 9, 9);
        PoiUtils.setHSSFValidation(sheet, htqx, 3, 5000, 12, 12);
        PoiUtils.setHSSFValidation(sheet, htqx, 3, 5000, 15, 15);

        String[] xyqx= {"6月","1年","2年"};
        PoiUtils.setHSSFValidation(sheet, xyqx, 3, 5000, 18, 18);
        PoiUtils.outFile(wb, "教职工合同协议", response);
    }


    @ResponseBody
    @RequestMapping("/TeacherContract/importTeachContract")
    public Message importTeachContract(@RequestParam(value = "file", required = false) CommonsMultipartFile file) {
        int count=4;
        int rightCount = 0 ;
        int errCount = 0 ;
        HSSFWorkbook workbook = null;
        StringBuilder sb = new StringBuilder();
        List<Select2> ryxzList = commonService.getSysDict("RYXZ","");
        List<Select2> ywList = commonService.getSysDict("YW","");
        List<Select2> sfList = commonService.getSysDict("SF","");
        try {
            workbook = new HSSFWorkbook(file.getInputStream());

            HSSFSheet sheet = workbook.getSheetAt(0);
            int end = sheet.getLastRowNum();
            for (int i = 3; i <= end; i++) {
                HSSFRow row = sheet.getRow(i);
                String idcard = PoiUtils.cellValue(row.getCell(2));
                if (null==idcard || "".equals(idcard)){
                    sb.append("第");
                    sb.append(count);
                    sb.append("行 ");
                    errCount++;
                }else {
//                根据idcard 查询personId
                    Emp emp = empService.getEmpByIdCard(idcard);
                    if (null==emp){
                        sb.append("第");
                        sb.append(count);
                        sb.append("行 ");
                        errCount++;
                    }else {
                        String personId = emp.getPersonId();
                        TeacherContract teacherContract = new TeacherContract();
                        teacherContract.setPersonId(personId);
                        teacherContract.setSyStartTime(PoiUtils.cellDateValue(row.getCell(3)));
                        teacherContract.setSyEndTime(PoiUtils.cellDateValue(row.getCell(4)));
                        teacherContract.setSyContractPeriod(PoiUtils.cellValue(row.getCell(5)));
                        teacherContract.setPositiveTime(PoiUtils.cellDateValue(row.getCell(6)));

                        teacherContract.setFirstStartTime(PoiUtils.cellDateValue(row.getCell(7)));
                        teacherContract.setFirstEndTime(PoiUtils.cellDateValue(row.getCell(8)));
                        teacherContract.setFirstContractPeriod(PoiUtils.cellValue(row.getCell(9)));

                        teacherContract.setSecStartTime(PoiUtils.cellDateValue(row.getCell(10)));
                        teacherContract.setSecEndTime(PoiUtils.cellDateValue(row.getCell(11)));
                        teacherContract.setSecContractPeriod(PoiUtils.cellValue(row.getCell(12)));

                        teacherContract.setThirdStartTime(PoiUtils.cellDateValue(row.getCell(13)));
                        teacherContract.setThirdEndTime(PoiUtils.cellDateValue(row.getCell(14)));
                        teacherContract.setThirdContractPeriod(PoiUtils.cellValue(row.getCell(15)));

                        teacherContract.setJzStartTime(PoiUtils.cellDateValue(row.getCell(16)));
                        teacherContract.setJzEndTime(PoiUtils.cellDateValue(row.getCell(17)));
                        teacherContract.setJzContractPeriod(PoiUtils.cellValue(row.getCell(18)));


                        teacherContract.setPersonNature(PoiUtils.cellSelectValue(ryxzList,row.getCell(19)));

                        teacherContract.setRetireCert(PoiUtils.cellValue(row.getCell(20)));
                        teacherContract.setNums(PoiUtils.cellValue(row.getCell(21)));
                        teacherContract.setSchoolAge(PoiUtils.cellValue(row.getCell(22)));

                        teacherContract.setConfidentAgreement(PoiUtils.cellSelectValue(ywList,row.getCell(23)));

                        teacherContract.setTrpidSalary(PoiUtils.cellValue(row.getCell(24)));
                        teacherContract.setPositiveSalary(PoiUtils.cellValue(row.getCell(25)));
                        teacherContract.setPositiveCoff(PoiUtils.cellValue(row.getCell(26)));

                        teacherContract.setRetireTime(PoiUtils.cellDateValue(row.getCell(27)));

                        teacherContract.setRetireNy(PoiUtils.cellSelectValue(sfList,row.getCell(28)));

                        teacherContract.setSsnumber(PoiUtils.cellValue(row.getCell(29)));
                        if (!StringUtils.isEmpty(PoiUtils.cellValue(row.getCell(30)))){
                            teacherContract.setCounts(row.getCell(30).toString());
                        }else {
                            if (!StringUtils.isEmpty(PoiUtils.cellValue(row.getCell(29)))){
                                teacherContract.setCounts("1");
                            }
                        }
                        teacherContractService.updateTeacherContract(teacherContract);
                        rightCount++;
                    }
                }
                count++;
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        if (errCount==0) {
            return new Message(1, "成功导入" + rightCount + "条", null);
        }else {
            return new Message(0,"成功导入"+ rightCount + "条\n 失败"+errCount+"条："+sb.toString()+"有错误",null);
        }
    }
}
