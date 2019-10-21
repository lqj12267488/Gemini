package com.goisan.personnel.teachManageinfo.controller;

import com.goisan.personnel.teachManageinfo.bean.TeachMgeInfo;
import com.goisan.personnel.teachManageinfo.service.TeachMgeInfoService;
import com.goisan.personnel.teachercontract.bean.TeacherContract;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.system.bean.BaseBean;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;

@Controller
public class TeachMgeInfoController {

    @Resource
    private TeachMgeInfoService teachMgeInfoService;

    @Autowired
    private CommonService commonService;

    @Autowired
    private EmpService empService;


    @RequestMapping("/TeachMgeInfo/toTeachMgeInfoList")
    public String toTeachMgeInfoList() {
        return "/business/personnel/teachManageinfo/teachMgeInfoList";
    }

    @ResponseBody
    @RequestMapping("/TeachMgeInfo/getTeachMgeInfoList")
    public Map<String,Object> getTeachMgeInfoList(TeachMgeInfo teachMgeInfo,int draw, int start, int length) {
         PageHelper.startPage(start / length + 1, length);
         Map<String, Object> map = new HashMap(16);
         List<BaseBean> list =  teachMgeInfoService.getTeachMgeInfoList(teachMgeInfo);
         PageInfo<List<BaseBean>> info = new PageInfo(list);
         map.put("draw", draw);
         map.put("recordsTotal", info.getTotal());
         map.put("recordsFiltered", info.getTotal());
         map.put("data", list);
        return map;
    }


    @ResponseBody
    @RequestMapping("/TeachMgeInfo/saveTeachMgeInfo")
    public Message saveTeachMgeInfo(TeachMgeInfo teachMgeInfo) {
        if (null != teachMgeInfo.getPersonId() && !"".equals(teachMgeInfo.getPersonId())) {
            teachMgeInfoService.saveTeachMgeInfo(teachMgeInfo);
            return new Message(0, "保存成功！", null);
        } else {
            return new Message(0, "保存失败！", null);
        }
    }

    @RequestMapping("/TeachMgeInfo/toTeachMgeInfoEdit")
    public String toEditTeachMgeInfo(String personId,String deptId,String seeFlag, Model model) {
        model.addAttribute("data", teachMgeInfoService.getTeachMgeInfoById(personId,deptId));
        if (StringUtils.isEmpty(seeFlag)){
            model.addAttribute("head", "修改");
        }else {
            model.addAttribute("head", "详情");
        }
        model.addAttribute("seeFlag", seeFlag);
        return "/business/personnel/teachManageinfo/teachMgeInfoEdit";
    }

    @RequestMapping("/TeachMgeInfo/importTeachMgeInfo")
    public String importTeachMgeInfo(){
        return "/business/personnel/teachManageinfo/importMgeInfo";
    }

    @RequestMapping("/TeachMgeInfo/mgeInfoTemplate")
    public void mgeInfoTemplate(HttpServletRequest request, HttpServletResponse response){
        HSSFWorkbook wb = new HSSFWorkbook();
        HSSFFont defaultFont = PoiUtils.createDefaultFont(wb, false);
        HSSFFont headFont = PoiUtils.createFont(wb, 14, "宋体", true,null);
        HSSFFont redFont = PoiUtils.createFont(wb, 8, "宋体", false, HSSFColor.RED.index);
        HSSFCellStyle defaultStyle = PoiUtils.createStyle(wb, defaultFont, false);
        HSSFCellStyle headStyle = PoiUtils.createStyle(wb, headFont, false);
        HSSFCellStyle tipStyle = PoiUtils.createStyle(wb, redFont, false);

        String fileName = "档案资料信息";
        HSSFSheet sheet = wb.createSheet(fileName);
        HSSFRow rowtips = sheet.createRow(0);
        PoiUtils.createCellWithStyleAndValue(rowtips,0,"*:必填项",tipStyle);
        PoiUtils.createCellWithStyleAndValue(rowtips,1,"日期格式:",tipStyle);
        PoiUtils.createCellWithStyleAndValue(rowtips,2,"yyyy/MM/dd",tipStyle);

        HSSFRow row0 = sheet.createRow(1);
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 0, 23));
        PoiUtils.createCellWithStyleAndValue(row0,0,fileName,headStyle);

        HSSFRow row1 = sheet.createRow(2);
        PoiUtils.createCellWithStyleAndValue(row1,0,"序号",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row1,1,"姓名",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row1,2,"证件号*",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row1,3,"银行卡号*",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row1,4,"一寸照",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row1,5,"身份证复印件",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row1,6,"身份证期限",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row1,7,"户口",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row1,8,"毕业证",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row1,9,"学位证",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row1,10,"解除劳务合同",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row1,11,"计算机",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row1,12,"英语",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row1,13,"国语水平",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row1,14,"普通话",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row1,15,"教师资格证",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row1,16,"其他资格证",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row1,17,"驾驶证",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row1,18,"电工证",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row1,19,"退休证",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row1,20,"退休证明",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row1,21,"外单位交社保证明",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row1,22,"人事档案",defaultStyle);
        PoiUtils.createCellWithStyleAndValue(row1,23,"其他资料",defaultStyle);

        List<String> list1 = commonService.getSysDictName("YW","");
        String[] yw = new String[list1.size()];
        for (int j = 0; j < list1.size(); j++) {
            yw[j] = list1.get(j);
        }
        PoiUtils.setHSSFValidation(sheet, yw, 2, 5000, 4, 5);
        PoiUtils.setHSSFValidation(sheet, yw, 2, 5000, 7, 23);
        PoiUtils.outFile(wb,fileName,response);
    }

    @RequestMapping("/TeachMgeInfo/importMgeInfo")
    @ResponseBody
    public Message importMgeInfo(@RequestParam(value = "file", required = false) CommonsMultipartFile file){
        int count=4;
        int rightCount = 0 ;
        int errCount = 0 ;
        HSSFWorkbook workbook = null;
        StringBuilder sb = new StringBuilder();
        List<Select2> yw = commonService.getSysDict("YW","");
        try {
            workbook = new HSSFWorkbook(file.getInputStream());
        }catch (Exception e){
            return new Message(0,"文件错误,请下载导入模板导入",null);
        }
        try {
            HSSFSheet sheet = workbook.getSheetAt(0);
            if (!PoiUtils.checkFile(sheet.getSheetName(),"档案资料信息")){
                return new Message(0,"文件错误,请下载导入模板导入",null);
            }

            int end = sheet.getLastRowNum();
            for (int i = 3; i <= end; i++) {
                HSSFRow row = sheet.getRow(i);
                String idcard = PoiUtils.cellValue(row.getCell(2));
                String bankId = PoiUtils.cellValue(row.getCell(3));
                if (null==idcard || "".equals(idcard)||null == bankId || "".equals(bankId) || (bankId.length()!=19 && bankId.length()!=16)){
                    sb.append("第");
                    sb.append(count);
                    sb.append("行 ");
                    errCount++;
                }else {
                 /** 根据idcard 查询personId*/
                    Emp emp = empService.getEmpByIdCard(idcard);
                    if (null==emp){
                        sb.append("第");
                        sb.append(count);
                        sb.append("行 ");
                        errCount++;
                    }else {
                        String personId = emp.getPersonId();
                        /**
                         * 1. 根据personId 查询档案资料
                         * 2. 如果存在，修改
                         *    如果不存在，新增
                         */
                        TeachMgeInfo teachMgeInfo = new TeachMgeInfo();
                        teachMgeInfo.setPersonId(personId);

                        teachMgeInfo.setBankId(bankId);
                        teachMgeInfo.setPhone(PoiUtils.cellSelectValue(yw,row.getCell(4)));
                        teachMgeInfo.setIdcardCopy(PoiUtils.cellSelectValue(yw,row.getCell(5)));
                        teachMgeInfo.setIdcardEndtime(PoiUtils.cellDateValue(row.getCell(6)));

                        teachMgeInfo.setAccount(PoiUtils.cellSelectValue(yw,row.getCell(7)));
                        teachMgeInfo.setDiploma(PoiUtils.cellSelectValue(yw,row.getCell(8)));
                        teachMgeInfo.setDegreeCert(PoiUtils.cellSelectValue(yw,row.getCell(9)));
                        teachMgeInfo.setDisContract(PoiUtils.cellSelectValue(yw,row.getCell(10)));
                        teachMgeInfo.setComputer(PoiUtils.cellSelectValue(yw,row.getCell(11)));
                        teachMgeInfo.setEnglish(PoiUtils.cellSelectValue(yw,row.getCell(12)));
                        teachMgeInfo.setPthLevel(PoiUtils.cellSelectValue(yw,row.getCell(13)));
                        teachMgeInfo.setPutonghua(PoiUtils.cellSelectValue(yw,row.getCell(14)));

                        teachMgeInfo.setTeachCert(PoiUtils.cellSelectValue(yw,row.getCell(15)));
                        teachMgeInfo.setOtherCert(PoiUtils.cellSelectValue(yw,row.getCell(16)));
                        teachMgeInfo.setDriverCert(PoiUtils.cellSelectValue(yw,row.getCell(17)));
                        teachMgeInfo.setEleCert(PoiUtils.cellSelectValue(yw,row.getCell(18)));

                        teachMgeInfo.setRetireCert(PoiUtils.cellSelectValue(yw,row.getCell(19)));
                        teachMgeInfo.setRetireProve(PoiUtils.cellSelectValue(yw,row.getCell(20)));
                        teachMgeInfo.setExtSsCert(PoiUtils.cellSelectValue(yw,row.getCell(21)));
                        teachMgeInfo.setPersonFile(PoiUtils.cellSelectValue(yw,row.getCell(22)));
                        teachMgeInfo.setOtherInfo(PoiUtils.cellSelectValue(yw,row.getCell(23)));
                        teachMgeInfoService.saveTeachMgeInfo(teachMgeInfo);
                        rightCount++;
                    }
                }
                count++;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (errCount==0) {
            return new Message(1, "成功导入" + rightCount + "条", null);
        }else {
            return new Message(0,"成功导入"+ rightCount + "条\n 失败"+errCount+"条："+sb.toString()+"有错误",null);
        }
    }
}
