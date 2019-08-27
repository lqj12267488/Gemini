package com.goisan.logistics.assets.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.educational.major.bean.Major;
import com.goisan.educational.textbook.bean.TextBookStatistics;
import com.goisan.logistics.assets.bean.Assets;
import com.goisan.logistics.assets.bean.AssetsDetails;
import com.goisan.logistics.assets.bean.AssetsLog;
import com.goisan.logistics.assets.service.AssetsService;
import com.goisan.system.bean.*;
import com.goisan.system.service.CommonService;
import com.goisan.system.service.DeptService;
import com.goisan.system.service.EmpService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.CellRangeAddressList;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by Administrator on 2017/5/24.
 */
@Controller
@RequestMapping("/assets")
public class AssetsController {
    @Resource
    private AssetsService assetsService;
    @Resource
    private EmpService empService;
    @Resource
    private DeptService deptService;
    @Resource
    private CommonService commonService;
    /*
    RequestMapping 是数据库中的resource_url字段的数据
    mav.setViewName 是存放jsp路径的
     */

    /**
     * 资产入库管理跳转
     *
     * @return
     */

    @RequestMapping("/assetsList")
    public ModelAndView assetsList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/logistics/assets/assetsList");
        return mv;
    }

    /**
     * 资产入库管理页面
     */
    @ResponseBody
    @RequestMapping("/getAssetsList")
    public Map<String, Object> getAssetsList(Assets assets,int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> assetsList = new HashMap<String, Object>();
        assets.setCreator(CommonUtil.getPersonId());
        assets.setCreateDept(CommonUtil.getDefaultDept());
        assets.setLevel(CommonUtil.getLoginUser().getLevel());
        List<Assets> list = assetsService.assetsAction(assets);
        PageInfo<List<TextBookStatistics>> info = new PageInfo(list);
        assetsList.put("draw", draw);
        assetsList.put("recordsTotal", info.getTotal());
        assetsList.put("recordsFiltered", info.getTotal());
        assetsList.put("data", list);
        return assetsList;

    }


    /**
     * 资产入库管理新增页
     */
    @RequestMapping("/editAssets")
    public ModelAndView addAssets() {
        ModelAndView mv = new ModelAndView("/business/logistics/assets/editAssets");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        //SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        //String time = formatTime.format(new Date());
        String datetime = date;
        Assets assets = new Assets();
        assets.setInTime(datetime);
        mv.addObject("head", "新增");
        mv.addObject("assets", assets);
        return mv;
    }

    /**
     * 修改页面
     */
    @ResponseBody
    @RequestMapping("/getAssetsById")
    public ModelAndView getAssetsById(String id) {
        ModelAndView mv = new ModelAndView("/business/logistics/assets/editAssets");
        Assets assets = assetsService.getAssetsById(id);
        mv.addObject("head", "修改");
        mv.addObject("assets", assets);
        return mv;
    }

    /**
     * 新增及修改
     */
    @ResponseBody
    @RequestMapping("/saveAssets")
    public Message saveAssets(Assets assets) {
        Assets assets1 = assetsService.getAssetsById(assets.getId());
//        if (assets1 != null){
//            return new Message(0, "同一个采购物品不可以多次分配至资产!", null);
//        }else {
            assets.setCreateTime(CommonUtil.getDate());
            if (assets.getId() == null || assets.getId().equals("")) {
                assets.setId(CommonUtil.getUUID());//UUID
                assets.setAssetsNumIn(assets.getAssetsNumAll());
                CommonUtil.save(assets);
                assetsService.insertAssets(assets);
                return new Message(1, "新增成功!", null);
            } else {
                CommonUtil.update(assets);
                assetsService.updateAssets(assets);
                return new Message(1, "修改成功!", null);
            }
//        }
    }

    @ResponseBody
    @RequestMapping("/saveAssetsList")
    public Message saveAssetsList(Assets assets) {
        Assets assets1 = assetsService.getAssetsById(assets.getId());
        if (assets1 != null){
            return new Message(0, "同一个采购物品不可以多次分配至资产!", null);
        }else {
//            assets.setCreateTime(CommonUtil.getDate());
//            if (assets.getId() == null || assets.getId().equals("")) {
//                assets.setId(CommonUtil.getUUID());//UUID
                assets.setAssetsNumIn(assets.getAssetsNumAll());
                CommonUtil.save(assets);
                assetsService.insertAssets(assets);
                return new Message(1, "新增成功!", null);
//            } else {
//                CommonUtil.update(assets);
//                assetsService.updateAssets(assets);
//                return new Message(1, "修改成功!", null);
//            }
        }
    }

    /**
     * 删除方法
     */
    @ResponseBody
    @RequestMapping("/deleteAssetsById")
    public Message deleteRoleById(String id) {
        assetsService.deleteAssetsById(id);
        String assetsId = id;
        assetsService.deleteAssetsDetailById(assetsId);
        return new Message(1, "删除成功!", null);
    }

    @RequestMapping("toAllot")
    public String toAllot(String ids, Model model) {

        List<Assets> assets = assetsService.getAssetsByIds(ids.substring(0, ids.length() - 2));
        model.addAttribute("assets", assets);
        model.addAttribute("ids", ids.substring(0, ids.length() - 2).replaceAll("'", ""));
        return "/business/logistics/assets/allot";
    }

    @ResponseBody
    @RequestMapping("/allot")
    public Message allot(HttpServletRequest request, Model model) {
        Map<String, String[]> data = request.getParameterMap();
        String ids = data.get("ids")[0];
        String useType = data.get("useType")[0];
        for (String id : ids.split(",")) {
            int sum = Integer.parseInt(data.get(id)[0]);
            AssetsDetails details = assetsService.getAssetsDetails(id);
            if (details == null) {
                Assets assets = assetsService.getAssetsById(id);
                for (int i = 0; i < sum; i++) {
                    String track = "在" + CommonUtil.now("yyyy-MM-dd") +
                            empService.getPersonNameById(CommonUtil.getPersonId()) + "将此资产分配给";
                    AssetsDetails assetsDetails = new AssetsDetails();
                    assetsDetails.setAssetsId(CommonUtil.getUUID());
                    assetsDetails.setParentAssetsId(id);
                    assetsDetails.setAssetsType(assets.getAssetsType());
                    assetsDetails.setAssetsNum("1");
                    assetsDetails.setUseTime(CommonUtil.formatData("yyyy-MM-dd", data.get("useTime")[0]));
                    assetsDetails.setUnit(assets.getUnit());
                    assetsDetails.setPrice(assets.getPrice());
                    assetsDetails.setSpecifications(assets.getSpecifications());
                    assetsDetails.setBrand(assets.getBrand());
                    assetsDetails.setRemark(assets.getRemark());
                    assetsDetails.setStatus("2");
                    assetsDetails.setUseType(useType);
                    assetsDetails.setUsePosition(data.get("usePosition")[0]);
                    if ("1".equals(useType)) {
                        assetsDetails.setUserDept(data.get("personId")[0].split(",")[0]);
                        assetsDetails.setUserId(data.get("personId")[0].split(",")[1]);
                        track += empService.getPersonNameById(data.get("personId")[0].split(",")
                                [1]);
                    }
                    if ("2".equals(useType)) {
                        assetsDetails.setUserDept(data.get("deptId")[0]);
                        track += data.get("deptId")[0];
                    }
                    CommonUtil.save(assetsDetails);
                    AssetsLog assetsLog = new AssetsLog();
                    assetsLog.setId(CommonUtil.getUUID());
                    assetsLog.setAssetsId(assetsDetails.getAssetsId());
                    assetsLog.setParentAssetsId(assetsDetails.getParentAssetsId());
                    track += "，位置：" + data.get("usePosition")[0];
                    assetsLog.setTrack(track);
                    assetsLog.setStatus("2");
                    CommonUtil.save(assetsLog);
                    assetsService.saveAssetsDetailsAndLog(assetsDetails, assetsLog);
                    if (sum == Integer.parseInt(assets.getAssetsNumIn())) {
                        assets.setStatus("2");
                    }
                    assets.setAssetsNumIn(Integer.parseInt(assets.getAssetsNumIn()) - 1 + "");
                    assets.setInTime(assets.getInTime().replaceAll("T", " "));
                    CommonUtil.update(assets);
                    assetsService.updateAssets(assets);
                }
            } else {
                String track = "在" + CommonUtil.now("yyyy-MM-dd") +
                        empService.getPersonNameById(CommonUtil.getPersonId()) + "将此资产分配给";
                details.setStatus("2");
                details.setUseType(useType);
                if ("1".equals(useType)) {
                    details.setUserDept(data.get("personId")[0].split(",")[0]);
                    details.setUserId(data.get("personId")[0].split(",")[1]);
                    track += empService.getPersonNameById(data.get("personId")[0].split(",")[1]);
                }
                if ("2".equals(useType)) {
                    String dept = data.get("deptId")[0];
                    details.setUserDept(data.get("deptId")[0]);
                    track += deptService.getDeptById(data.get("deptId")[0]).getDeptName();
                }
                details.setUsePosition(data.get("usePosition")[0]);
                CommonUtil.update(details);
                AssetsLog assetsLog = new AssetsLog();
                assetsLog.setId(CommonUtil.getUUID());
                assetsLog.setAssetsId(details.getAssetsId());
                assetsLog.setParentAssetsId(details.getParentAssetsId());
                track += "，位置：" + data.get("usePosition")[0];
                assetsLog.setTrack(track);
                assetsLog.setStatus("2");
                CommonUtil.save(assetsLog);
                assetsService.updateAssetsDetailsSaveAndLog(details, assetsLog);
            }

        }
        return new Message(0, "分配成功！", null);
    }

    @RequestMapping("/toChangeAsset")
    public String toChangeAsset(String ids, Model model) {
        List<Assets> assets = assetsService.getAssetsByIds(ids.substring(0, ids.length() - 2));
        String assetsName = "";
        for (Assets asset : assets) {
            assetsName += asset.getAssetsName() + ",";
        }
        model.addAttribute("assetsName", assetsName.substring(0, assetsName.length() - 1));
        model.addAttribute("ids", ids.replaceAll("'", ""));
        return "/business/logistics/assets/changeAsset";
    }

    @ResponseBody
    @RequestMapping("/changeAssets")
    public Message changeAssets(String ids, String status, String direction, String scrapReson, String deptid) {
        String[] tmp = ids.split(",");

        for (String id : tmp) {
            AssetsDetails details = assetsService.getAssetsDetails(id);
            if (details == null) {
                Assets assets = assetsService.getAssetsById(id);
                int numIn = Integer.parseInt(assets.getAssetsNumIn());
                for (int i = 0; i < numIn; i++) {
                    String track = "在" + CommonUtil.now("yyyy-MM-dd") +
                            empService.getPersonNameById(CommonUtil.getPersonId()) + "将此资产变更为" +
                            commonService.getSysDictVal(status, "XCZT");
                    AssetsDetails assetsDetails = new AssetsDetails();
                    assetsDetails.setAssetsId(CommonUtil.getUUID());
                    assetsDetails.setParentAssetsId(id);
                    assetsDetails.setAssetsType(assets.getAssetsType());
                    assetsDetails.setAssetsNum("1");
                    assetsDetails.setUnit(assets.getUnit());
                    assetsDetails.setPrice(assets.getPrice());
                    assetsDetails.setSpecifications(assets.getSpecifications());
                    assetsDetails.setBrand(assets.getBrand());
                    assetsDetails.setRemark(assets.getRemark());
                    //assetsDetails.setDirection(direction);
                    assetsDetails.setUsePosition(direction);
                    assetsDetails.setStatus(status);
                    assetsDetails.setScrapReson(scrapReson);
                    assetsDetails.setUserDept(CommonUtil.getDefaultDept());
                    assetsDetails.setUserId(CommonUtil.getPersonId());
                    //assetsDetails.setUseTime(CommonUtil.getDate());
                    CommonUtil.save(assetsDetails);
                    AssetsLog assetsLog = new AssetsLog();
                    assetsLog.setId(CommonUtil.getUUID());
                    assetsLog.setAssetsId(assetsDetails.getAssetsId());
                    assetsLog.setParentAssetsId(assetsDetails.getParentAssetsId());
                    if ("8".equals(status)) {
                        assetsDetails.setUserDept(deptid);
                        track += deptService.getDeptById(deptid).getDeptName();
                    }
                    track += "，位置：" + direction;
                    assetsLog.setTrack(track);
                    assetsLog.setStatus(status);
                    assetsLog.setScrapReson(scrapReson);
                    CommonUtil.save(assetsLog);
                    //assetsService.updateAssetsDetailsByPid(id, direction, status);
                    assetsService.saveAssetsDetailsAndLog(assetsDetails, assetsLog);
                    assets.setAssetsNumIn(0 + "");
                    assets.setInTime(assets.getInTime().replaceAll("T", " "));
                    CommonUtil.update(assets);
                    assetsService.updateAssets(assets);
                }
            } else {
                String track = "在" + CommonUtil.now("yyyy-MM-dd") +
                        empService.getPersonNameById(CommonUtil.getPersonId()) + "将此资产变更为" +
                        commonService.getSysDictVal(status, "XCZT");
                details.setStatus(status);
                details.setUserId(null);
                details.setUserDept(null);
                details.setUsePosition(direction);
                CommonUtil.update(details);
                AssetsLog assetsLog = new AssetsLog();
                assetsLog.setId(CommonUtil.getUUID());
                assetsLog.setAssetsId(details.getAssetsId());
                assetsLog.setParentAssetsId(details.getParentAssetsId());
                if ("8".equals(status)) {
                    details.setUserDept(deptid);
                    track += deptService.getDeptById(deptid).getDeptName();
                }
                track += "，位置：" + direction;
                assetsLog.setTrack(track);
                assetsLog.setStatus(status);
                CommonUtil.save(assetsLog);
                assetsService.updateAssetsDetailsSaveAndLog(details, assetsLog);
            }

        }

        return new Message(0, "操作成功！", null);
    }

    @RequestMapping("/toAassigned")
    public String toAssigned() {
        return "/business/logistics/assets/assigned";
    }

    @ResponseBody
    @RequestMapping("/getAssigned")
    public Map<String, Object> getAssigned(AssetsDetails assetsDetails,int draw,int start,int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String,Object> assetsDetailsList = new HashMap<String, Object>();
        assetsDetails.setCreateDept(CommonUtil.getDefaultDept());
        assetsDetails.setLevel(CommonUtil.getLoginUser().getLevel());
        List<AssetsDetails> list = assetsService.getAssigned(assetsDetails);
        PageInfo<List<AssetsDetails>> info = new PageInfo(list);
        assetsDetailsList.put("draw", draw);
        assetsDetailsList.put("recordsTotal", info.getTotal());
        assetsDetailsList.put("recordsFiltered", info.getTotal());
        assetsDetailsList.put("data", list);
        return assetsDetailsList;
    }

    @RequestMapping("/toChanged")
    public String toChanged() {
        return "/business/logistics/assets/changed";
    }

    @ResponseBody
    @RequestMapping("/getChanged")
    public Map getChanged(AssetsDetails assetsDetails) {
        assetsDetails.setCreateDept(CommonUtil.getDefaultDept());
        assetsDetails.setLevel(CommonUtil.getLoginUser().getLevel());
        return CommonUtil.tableMap(assetsService.getChanged(assetsDetails));
    }

    @ResponseBody
    @RequestMapping("/getAssetsDetailsList")
    public Map getAssetsDetailsList(AssetsDetails assetsDetails) {
        return CommonUtil.tableMap(assetsService.getAssetsDetailsList(assetsDetails));
    }

    @RequestMapping("/toAssetsDetailsList")
    public String toAssetsDetailsList() {
        return "/business/logistics/assets/assetsDetailsList";
    }

    @RequestMapping("/viewLog")
    public String viewLog(String id, Model model) {
        model.addAttribute("id", id);
        model.addAttribute("head", "资产日志");
        return "/business/logistics/assets/logs";
    }

    @ResponseBody
    @RequestMapping("/getLogs")
    public Map getLogs(String id) {
        return CommonUtil.tableMap(assetsService.getLogs(id));
    }

    @RequestMapping("/exportAssignedList")
    public void exportAssignedList(String ids, HttpServletResponse response) {
        List<AssetsDetails> map = assetsService.exportAssignedList(ids);
        HSSFWorkbook wb = new HSSFWorkbook();
        String[] strs1 = {"", "资产名称", "资产类型", "资产数量", "计量单位", "品牌", "单价", "规格", "备注", "使用部门", "使用人", "使用时间", "位置"};
        HSSFSheet sheet = wb.createSheet("已分配资产");
        HSSFRow row = sheet.createRow(0);
        for (int i = 0; i < strs1.length; i++) {
            row.createCell(i).setCellValue(strs1[i]);
        }

        for (int i = 0; i < map.size(); i++) {
            HSSFRow sheetRow = sheet.createRow(i + 1);
            sheetRow.createCell(0).setCellValue(i + 1);
            sheetRow.createCell(1).setCellValue(map.get(i).getAssetsName());
            sheetRow.createCell(2).setCellValue(map.get(i).getAssetsType());
            sheetRow.createCell(3).setCellValue(map.get(i).getAssetsNum());
            sheetRow.createCell(4).setCellValue(map.get(i).getUnit());
            sheetRow.createCell(5).setCellValue(map.get(i).getBrand());
            sheetRow.createCell(6).setCellValue(map.get(i).getPrice());
            sheetRow.createCell(7).setCellValue(map.get(i).getSpecifications());
            sheetRow.createCell(8).setCellValue(map.get(i).getRemark());
            sheetRow.createCell(9).setCellValue(map.get(i).getUserDept());
            sheetRow.createCell(10).setCellValue(map.get(i).getUserId());
            sheetRow.createCell(11).setCellValue(map.get(i).getUseTimeShow());
            sheetRow.createCell(12).setCellValue(map.get(i).getUsePosition());
        }
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode("已分配资产.xls", "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
        } catch (
                IOException e) {
            e.printStackTrace();
        } finally {
            try {
                os.flush();
                os.close();
                wb.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

    }

    /**
     * 批量导出
     */
    @RequestMapping("/exportAssetsList")
    public void exportAssetsList(String ids, HttpServletResponse response) {

        List<Assets> map = assetsService.getAssetsIdByIds(ids);/*
        List<Assets> map = assetsService.exportAssets(ids);*/
        HSSFWorkbook wb = new HSSFWorkbook();
        String[] strs1 = {"", "资产名称", "资产类型", "资产数量", "在库数量", "计量单位", "品牌", "单价", "规格", "备注", "入库时间"};
        HSSFSheet sheet = wb.createSheet("在库资产");
        HSSFRow row = sheet.createRow(0);
        for (int i = 0; i < strs1.length; i++) {
            row.createCell(i).setCellValue(strs1[i]);
        }
        for (int i = 0; i < map.size(); i++) {
            HSSFRow sheetRow = sheet.createRow(i + 1);
            sheetRow.createCell(0).setCellValue(i + 1);
            sheetRow.createCell(1).setCellValue(map.get(i).getAssetsName());
            sheetRow.createCell(2).setCellValue(map.get(i).getAssetsType());
            sheetRow.createCell(3).setCellValue(map.get(i).getAssetsNumAll());
            sheetRow.createCell(4).setCellValue(map.get(i).getAssetsNumIn());
            sheetRow.createCell(5).setCellValue(map.get(i).getUnit());
            sheetRow.createCell(6).setCellValue(map.get(i).getBrand());
            sheetRow.createCell(7).setCellValue(map.get(i).getPrice());
            sheetRow.createCell(8).setCellValue(map.get(i).getSpecifications());
            sheetRow.createCell(9).setCellValue(map.get(i).getRemark());
            sheetRow.createCell(10).setCellValue(map.get(i).getInTime());
        }
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode("在库资产.xls", "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
        } catch (
                IOException e) {
            e.printStackTrace();
        } finally {
            try {
                os.flush();
                os.close();
                wb.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    @RequestMapping("/viewImportList")
    public String viewImportList(Model model) {
        return "/business/logistics/assets/importView";
    }


    /*@ResponseBody
    @RequestMapping("/getAssetsExcelTemplate")
    public void getAssetsExcelTemplate(HttpServletResponse response) {

        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet work = workbook.createSheet("work");
        CellStyle cellStyle = workbook.createCellStyle();
        Font font = workbook.createFont();
        font.setColor(IndexedColors.RED.index);
        cellStyle.setWrapText(true);
        cellStyle.setFont(font);


        CellStyle cellStyle1 = workbook.createCellStyle();
        Font font1 = workbook.createFont();
        cellStyle1.setFillForegroundColor(IndexedColors.GREY_40_PERCENT.getIndex());
        cellStyle1.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        cellStyle1.setAlignment(HorizontalAlignment.CENTER);
        font1.setBold(true);
        cellStyle1.setFont(font1);

        HSSFCell cell0_0 = work.createRow(0).createCell(0);
        HSSFCell cell0_1 = work.createRow(0).createCell(1);
        HSSFCell cell0_2 = work.createRow(0).createCell(2);
        HSSFCell cell0_3 = work.createRow(0).createCell(3);
        HSSFCell cell0_4 = work.createRow(0).createCell(4);
        HSSFCell cell0_5 = work.createRow(0).createCell(5);
        HSSFCell cell0_6 = work.createRow(0).createCell(6);
        HSSFCell cell0_7 = work.createRow(0).createCell(7);
        HSSFCell cell0_8 = work.createRow(0).createCell(8);

        work.setColumnWidth(0, 19 * 256);
        work.setColumnWidth(1, 19 * 256);
        work.setColumnWidth(2, 19 * 256);
        work.setColumnWidth(3, 19 * 256);
        work.setColumnWidth(4, 19 * 256);
        work.setColumnWidth(5, 19 * 256);
        work.setColumnWidth(6, 19 * 256);
        work.setColumnWidth(7, 19 * 256);
        work.setColumnWidth(8, 19 * 256);

        HSSFCell cell1_0 = work.createRow(1).createCell(0);
        HSSFCell cell1_1 = work.createRow(1).createCell(1);
        HSSFCell cell1_2 = work.createRow(1).createCell(2);
        HSSFCell cell1_3 = work.createRow(1).createCell(3);
        HSSFCell cell1_4 = work.createRow(1).createCell(4);
        HSSFCell cell1_5 = work.createRow(1).createCell(5);
        HSSFCell cell1_6 = work.createRow(1).createCell(6);
        HSSFCell cell1_7 = work.createRow(1).createCell(7);
        HSSFCell cell1_8 = work.createRow(1).createCell(8);

        cell0_0.setCellStyle(cellStyle);
        cell0_1.setCellStyle(cellStyle);
        cell0_2.setCellStyle(cellStyle);
        cell0_3.setCellStyle(cellStyle);
        cell0_4.setCellStyle(cellStyle);
        cell0_5.setCellStyle(cellStyle);
        cell0_6.setCellStyle(cellStyle);
        cell0_7.setCellStyle(cellStyle);
        cell0_8.setCellStyle(cellStyle);

        cell0_0.setCellValue("说明：此项为必填项");
        cell0_1.setCellValue("说明：此项为必填项");
        cell0_2.setCellValue("说明：此项为必填项，格式2000-12-12");
        cell0_3.setCellValue("说明：此项为必填项，请填写数字");
        cell0_4.setCellValue("说明：此项为必填项，请填写数字");
        cell0_5.setCellValue("说明：此项为必填项");
        cell0_6.setCellValue("说明：此项为必填项");
        cell0_7.setCellValue("");
        cell0_8.setCellValue("");

        cell1_0.setCellStyle(cellStyle1);
        cell1_1.setCellStyle(cellStyle1);
        cell1_2.setCellStyle(cellStyle1);
        cell1_3.setCellStyle(cellStyle1);
        cell1_4.setCellStyle(cellStyle1);
        cell1_5.setCellStyle(cellStyle1);
        cell1_6.setCellStyle(cellStyle1);
        cell1_7.setCellStyle(cellStyle1);
        cell1_8.setCellStyle(cellStyle1);
        cell1_8.setCellType(CellType.STRING);

        HSSFCellStyle textS = workbook.createCellStyle();
        HSSFDataFormat form = workbook.createDataFormat();
        textS.setDataFormat(form.getFormat("@"));
        for (int i = 2; i < 10000; i++) {
            HSSFRow row = work.createRow(i);
            for (int j = 2; j <9; j++) {
                row.createCell(j).setCellStyle(textS);
            }
        }
        cell1_0.setCellValue("资产类型");
        cell1_1.setCellValue("资产名称");
        cell1_2.setCellValue("取得日期");
        cell1_3.setCellValue("数量");
        cell1_4.setCellValue("价值");
        cell1_5.setCellValue("品牌");
        cell1_6.setCellValue("规格型号");
        cell1_7.setCellValue("使用部门");
        cell1_8.setCellValue("备注");

        List<String> list5 = assetsService.getUserDictName("XCLB");
        String[] strs5 = new String[list5.size()];

        int end5 = list5.size();
        for (int i = 0; i < end5; i++) {
            strs5[i] = list5.get(i);
        }
        CellRangeAddressList regions5 = new CellRangeAddressList(2, 99999, 1, 1);
        DVConstraint constraint5 = DVConstraint.createExplicitListConstraint(strs5);
        HSSFDataValidation dataValidation5 = new HSSFDataValidation(regions5, constraint5);
        work.addValidationData(dataValidation5);

        try {
            workbook.write(new File("C:\\windows\\temp\\personEvaluationTemplate.xls"));
        } catch (IOException e) {
            e.printStackTrace();
        }


        String rootPath = new File(getClass().getResource("/").getPath()).getParentFile().getParent().toString();
        rootPath = rootPath.replaceAll("%20", " ");
        String fileName = "C:\\windows\\temp\\personEvaluationTemplate.xls";
        File file = FileUtils.getFile(fileName);
        OutputStream os = null;

        try {
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("在库资产信息表模板.xls", "utf-8"));
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
    }*/

    /**
     * 模板导出
     *
     * @param response
     */
    @RequestMapping("/getAssetsExcelTemplate")
    public void getAssetsExcelTemplate(HttpServletResponse response, String id) {
        HSSFWorkbook wb = new HSSFWorkbook();
        //创建HSSFSheet对象
        HSSFSheet sheet = wb.createSheet("在库资产信息表模板");
        HSSFCellStyle cellStyle = wb.createCellStyle();
        //cellStyle.setFillForegroundColor((short) 13);// 设置背景色
        cellStyle.setBorderLeft(BorderStyle.THIN);//左边框
        cellStyle.setBorderTop(BorderStyle.THIN);//上边框
        cellStyle.setBorderRight(BorderStyle.THIN);//右边框
        cellStyle.setBorderBottom(BorderStyle.THIN); //下边框
        cellStyle.setAlignment(HorizontalAlignment.CENTER); // 居中
        HSSFCellStyle headStyle = wb.createCellStyle();
        headStyle.cloneStyleFrom(cellStyle);
        HSSFFont hssfFont = wb.createFont();
        hssfFont.setColor(HSSFColor.RED.index);
        headStyle.setFont(hssfFont);
        sheet.setDefaultColumnWidth(25);
        sheet.createRow(0).createCell(0).setCellStyle(headStyle);
        sheet.getRow(0).getCell(0).setCellValue("说明：此项为必填项");
        sheet.getRow(0).createCell(1).setCellStyle(headStyle);
        sheet.getRow(0).getCell(1).setCellValue("说明：此项为必填项");
        sheet.getRow(0).createCell(2).setCellStyle(headStyle);
        sheet.getRow(0).getCell(2).setCellValue("说明：此项为必填项，格式2000-12-12");
        sheet.getRow(0).createCell(3).setCellStyle(headStyle);
        sheet.getRow(0).getCell(3).setCellValue("说明：此项为必填项，请填写数字");
        sheet.getRow(0).createCell(4).setCellStyle(headStyle);
        sheet.getRow(0).getCell(4).setCellValue("说明：此项为必填项，请填写数字");
        sheet.getRow(0).createCell(5).setCellStyle(headStyle);
        sheet.getRow(0).getCell(5).setCellValue("说明：此项为必填项");
        sheet.getRow(0).createCell(6).setCellStyle(headStyle);
        sheet.getRow(0).getCell(6).setCellValue("");
        sheet.getRow(0).createCell(7).setCellStyle(headStyle);
        sheet.getRow(0).getCell(7).setCellValue("");
        sheet.getRow(0).createCell(8).setCellStyle(headStyle);
        sheet.getRow(0).getCell(8).setCellValue("");
        sheet.createRow(1).createCell(0).setCellStyle(cellStyle);
        sheet.getRow(1).getCell(0).setCellValue("资产类型");
        sheet.getRow(1).createCell(1).setCellStyle(cellStyle);
        sheet.getRow(1).getCell(1).setCellValue("资产名称");
        sheet.getRow(1).createCell(2).setCellStyle(cellStyle);
        sheet.getRow(1).getCell(2).setCellValue("取得日期");
        sheet.getRow(1).createCell(3).setCellStyle(cellStyle);
        sheet.getRow(1).getCell(3).setCellValue("数量");
        sheet.getRow(1).createCell(4).setCellStyle(cellStyle);
        sheet.getRow(1).getCell(4).setCellValue("价值");
        sheet.getRow(1).createCell(5).setCellStyle(cellStyle);
        sheet.getRow(1).getCell(5).setCellValue("品牌");
        sheet.getRow(1).createCell(6).setCellStyle(cellStyle);
        sheet.getRow(1).getCell(6).setCellValue("规格型号");
        sheet.getRow(1).createCell(7).setCellStyle(cellStyle);
        sheet.getRow(1).getCell(7).setCellValue("使用部门");
        sheet.getRow(1).createCell(8).setCellStyle(cellStyle);
        sheet.getRow(1).getCell(8).setCellValue("备注");
        HSSFCellStyle textS = wb.createCellStyle();
        HSSFDataFormat form = wb.createDataFormat();
        textS.setDataFormat(form.getFormat("@"));
        for (int i = 2; i < 10000; i++) {
            HSSFRow row = sheet.createRow(i);
            for (int j = 2; j <9; j++) {
                row.createCell(j).setCellStyle(textS);
            }
        }
        setHSSFPrompt(sheet, "", "", 1, 65535, 0, 0);
        setHSSFPrompt(sheet, "", "", 1, 65535, 1, 1);
        setHSSFPrompt(sheet, "", "", 1, 65535, 2, 2);
        setHSSFPrompt(sheet, "", "", 1, 65535, 3, 3);
        setHSSFPrompt(sheet, "", "", 1, 65535, 4, 4);
        setHSSFPrompt(sheet, "", "", 1, 65535, 5, 5);
        List<Select2> list = assetsService.getDeptName();
        List<Select2> list5 = assetsService.getUserDictName("XCLB");
        String[] major = new String[list.size()];
        for (int i = 0; i < list.size(); i++) {
            major[i] = list.get(i).getText();
        }
        setHSSFValidation(sheet, major, 2, 65535, 7, 7);
        HSSFSheet sheet2 = wb.createSheet("Sheet2");
        wb.setSheetHidden(1, 1);
        for (int i = 0; i <  list5.size(); i++) {
            sheet2.createRow(i).createCell(0).setCellValue( list5.get(i).getText());
        }
        setDataValidation(sheet, "Sheet2!$A$1:$A$" +  list5.size(), 2, 65535, 0, 0);

        OutputStream os = null;
        try {
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode("在库资产信息表模板.xls", "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (os != null) {
                    os.flush();
                    os.close();
                    wb.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    private static void setDataValidation(HSSFSheet sheet, String strFormula, int firstRow, int endRow, int firstCol, int endCol) {
        CellRangeAddressList regions = new CellRangeAddressList(firstRow, endRow, firstCol, endCol);
        DVConstraint constraint = DVConstraint.createFormulaListConstraint(strFormula);//add
        HSSFDataValidation dataValidation = new HSSFDataValidation(regions, constraint);//add
        dataValidation.createErrorBox("Error", "Error");
        dataValidation.createPromptBox("", null);
        sheet.addValidationData(dataValidation);
    }


    public static void setHSSFValidation(HSSFSheet sheet, String[] textlist, int firstRow, int endRow, int firstCol, int endCol) {
        // 加载下拉列表内容
        DVConstraint constraint = DVConstraint.createExplicitListConstraint(textlist);
        // 设置数据有效性加载在哪个单元格上,四个参数分别是：起始行、终止行、起始列、终止列
        CellRangeAddressList regions = new CellRangeAddressList(firstRow, endRow, firstCol, endCol);
        // 数据有效性对象
        HSSFDataValidation hssfDataValidation = new HSSFDataValidation(regions, constraint);
        sheet.addValidationData(hssfDataValidation);
    }

    /**
     * 设置单元格上提示
     *
     * @param sheet         要设置的sheet.
     * @param promptTitle   标题
     * @param promptContent 内容
     * @param firstRow      开始行
     * @param endRow        结束行
     * @param firstCol      开始列
     * @param endCol        结束列
     * @return 设置好的sheet.
     */
    public static void setHSSFPrompt(HSSFSheet sheet, String promptTitle, String promptContent, int firstRow, int endRow, int firstCol, int endCol) {
        // 构造constraint对象
        DVConstraint constraint = DVConstraint.createCustomFormulaConstraint("BB1");
        // 四个参数分别是：起始行、终止行、起始列、终止列
        CellRangeAddressList regions = new CellRangeAddressList(firstRow, endRow, firstCol, endCol);
        // 数据有效性对象
        HSSFDataValidation hssfDataValidation = new HSSFDataValidation(regions, constraint);
        hssfDataValidation.createPromptBox(promptTitle, promptContent);
        sheet.addValidationData(hssfDataValidation);
    }



    /**
     * 获取真实行数
     * @param workbook 工作簿对象
     * @return 真实行数
     */
    private int getRealLastRowNum(Workbook workbook) {
        Sheet sheetAt = workbook.getSheetAt(0);
        int lastRowNum = sheetAt.getLastRowNum();

        Row row = sheetAt.getRow(0);
        int realLastRowNum = 0;
        error:
        for (int i = 0; i < lastRowNum; i++) {
            StringBuilder str = new StringBuilder();
            for (int j = 0; j < sheetAt.getRow(0).getPhysicalNumberOfCells(); j++) {
                Cell cell = sheetAt.getRow(i).getCell(j);
                try {
                    cell.setCellType(CellType.STRING);
                    str.append(cell.getStringCellValue());
                }
                catch (Exception e)
                {
                    break error;
                }

            }
            if (!"".equals(str.toString().replaceAll(" ", "")))
            {
                realLastRowNum = realLastRowNum + 1;
            }
        }
        System.err.println("----------------------> 真实行数 "+realLastRowNum);
        return realLastRowNum;

    }

    @ResponseBody
    @RequestMapping("/importAssets")
    public Message importEmp(@RequestParam(value = "file", required = false) CommonsMultipartFile file) {
        List<Tree> depts = deptService.getDeptTree();
        List<Select2> xclbList = commonService.getUserDict("XCLB");
        TableDict tableDict = new TableDict();
        tableDict.setId("DEPT_ID");
        tableDict.setText("DEPT_NAME");
        tableDict.setTableName("T_SYS_DEPT");
        tableDict.setWhere("  WHERE VALID_FLAG='1' ");
        List<Select2> bz = commonService.getTableDict(tableDict);

        List<Assets> assetsList = new ArrayList<Assets>();
        int count = 0;
        int num = 0;
        Object str;
        String msg = "第";
        HSSFWorkbook workbook = null;
        try {
            workbook = new HSSFWorkbook(file.getInputStream());
        } catch (IOException e) {
            e.printStackTrace();
            ++num;
        }
        if (num > 0) {
            return new Message(1, "导入失败！请重新导入", null);
        } else {
            HSSFSheet sheet = workbook.getSheetAt(0);
            int end = getRealLastRowNum(workbook);
            for (int i = 2; i < end; i++) {
                HSSFRow row = sheet.getRow(i);
                int flag = 1;
                Assets assets = new Assets();
                AssetsDetails details = new AssetsDetails();
                assets.setId(CommonUtil.getUUID());
                //assets.setAssetsId(CommonUtil.changeToString(row.getCell(1)));
                for (Select2 AssetsType : xclbList) {
                    if (AssetsType.getText().equals(row.getCell(0).toString())) {
                        assets.setAssetsType(AssetsType.getId());
                    }
                }
                assets.setAssetsName(CommonUtil.changeToString(row.getCell(1)));
                assets.setInTime(CommonUtil.changeToString(row.getCell(2)));
                int assetsNumAll = CommonUtil.changeToInteger(row.getCell(3));
                int assetspriceAll = CommonUtil.changeToInteger(row.getCell(4));
                String assetsprice = (assetspriceAll / assetsNumAll) + "";
                assets.setPrice(assetsprice);
                assets.setBrand(CommonUtil.changeToString(row.getCell(5)));
                assets.setSpecifications(CommonUtil.changeToString(row.getCell(6)));
                assets.setRemark(CommonUtil.changeToString(row.getCell(8)));
                assets.setCreator(CommonUtil.getPersonId());
                assets.setCreateDept(CommonUtil.getDefaultDept());
                assets.setCreateTime(CommonUtil.getDate());
                assets.setValidFlag("1");
                assets.setUnit("1");
                if ("".equals(CommonUtil.changeToString(row.getCell(7))) || null == CommonUtil.changeToString(row.getCell(7))) {

                } else {
                    for (Select2 UserDept : bz) {
                        if (UserDept.getText().equals(row.getCell(7).toString())) {
                            details.setUserDept(UserDept.getId());
                        }
                    }
                }
                if (details.getUserDept() == null || details.getUserDept().equals("")) {
                    assets.setAssetsNumIn(assetsNumAll + "");
                    assets.setAssetsNumAll(assetsNumAll + "");
                } else {
                    assets.setAssetsNumIn("0");
                    assets.setAssetsNumAll(assetsNumAll + "");
                }
                assetsService.insertAssets(assets);

                if (null != details.getUserDept() && !details.getUserDept().equals("")) {
                    details.setAssetsId(CommonUtil.getUUID());
                    details.setParentAssetsId(assets.getId());
                    details.setAssetsName(assets.getAssetsName());
                    details.setAssetsNum(assets.getAssetsNumAll());
                    details.setStatus("2");
                    details.setPrice(assetsprice);
                    details.setSpecifications(assets.getSpecifications());
                    details.setUnit("1");
                    AssetsLog assetsLog = new AssetsLog();
                    assetsLog.setId(CommonUtil.getUUID());
                    assetsLog.setAssetsId(details.getAssetsId());
                    assetsLog.setParentAssetsId(details.getParentAssetsId());
                    String track = "";
                    assetsLog.setTrack(details.getUserDept());
                    CommonUtil.save(assetsLog);
                    assetsService.saveAssetsDetailsAndLog(details, assetsLog);
                }

                if (flag == 0) {
                    msg += i + ",";
                    count++;
                }

            }
            if (count > 0) {
                msg = msg.substring(0, msg.length() - 1) + "行,人员身份信息不正确！请重新导入！";
            } else {
                msg = "导入成功！";
            }
            return new Message(1, msg, null);
        }
    }

}