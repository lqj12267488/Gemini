package com.goisan.educational.major.controller;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.educational.major.bean.*;
import com.goisan.educational.major.service.MajorLeaderService;
import com.goisan.educational.teacher.bean.TeacherCondition;
import com.goisan.studentwork.employments.bean.Employments;
import com.goisan.system.bean.CommonBean;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/**
 * Created by admin on 2017/5/18.
 */
@Controller
public class MajorLeaderController {

    @Resource
    private MajorLeaderService majorLeaderService;

    /**
     * 专业带头人*/
    @RequestMapping("/majorLeader/mLeader")
    public ModelAndView mLeader() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/major/majorLeaderList");
        mv.addObject("pType","1");
        return mv;
    }
    /**
     * 专业负责人*/
    @RequestMapping("/majorResponsible/mResponsible")
    public ModelAndView mResponsible() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/major/majorResponsibleList");
        mv.addObject("pType","2");
        return mv;
    }
    /**
     * 专业骨干教师*/
    @RequestMapping("/majorMainTeacher/mMainTeacher")
    public ModelAndView mMainTeacher() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/major/majorMainTeacherList");
        mv.addObject("pType","3");
        return mv;
    }
    /**
     * 列表sql*/
    @ResponseBody
    @RequestMapping("/majorLeader/majorLeaderList")
    public Map<String, Object> majorLeaderList(MajorLeader m,int draw, int start, int length){
        PageHelper.startPage(start / length + 1, length);
        Map<String,Object> tmapList = new HashMap<String, Object>();
        if(m.getPersonIdShow() !=null && m.getPersonIdShow() !=""){
            try {
                m.setPersonIdShow(URLDecoder.decode(m.getPersonIdShow(), "UTF-8"));
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        List<MajorLeader> list = majorLeaderService.getMajorLeaderList(m);
        PageInfo<List<MajorLeader>> info = new PageInfo(list);
        tmapList.put("draw", draw);
        tmapList.put("recordsTotal", info.getTotal());
        tmapList.put("recordsFiltered", info.getTotal());
        tmapList.put("data", list);

       // tmap.put("data",majorLeaderService.getMajorLeaderList(m));
        return tmapList;
    }

    /**
     * 根据教师id获取用户信息
     */
    @ResponseBody
    @RequestMapping("/majorLeader/getTeacherById")
    public Map<String, String> getTeacherById(String tid){

        return this.majorLeaderService.getTeacherById(tid);
    }


    /**
     * 新增修改页*/
    @ResponseBody
    @RequestMapping("/majorLeader/editMajorLeader")
    public ModelAndView editMajorLeader(String id,String personType) {
        ModelAndView mv = new ModelAndView();
        if(id!=null && id!="") {
            MajorLeader  mm = majorLeaderService.getMajorLeaderById(id);
            List<ResearchResult> researchResults=this.majorLeaderService.getResearchResultsByMajorLeaderId(mm.getId());
            mv.addObject("researchResults", researchResults);
            mv.addObject("mm",mm);
            mv.addObject("head", "修改");
        }else {
            mv.addObject("head","新增");
        }
        mv.addObject("personType",personType);
        mv.setViewName("/core/major/editMajorLeader");
        return mv;
    }

    /**
     * 专业带头人保存方法
     * param researchNum 科研成果个数
     * */
    @ResponseBody
    @RequestMapping("/majorLeader/saveMajorLeader")
    public Message saveTalent(MajorLeader  m, Integer researchNum, HttpServletRequest request) {
        if(researchNum==null)//防止researchNum为null出错
            researchNum=0;
        if(null == m.getId()  || m.getId().equals("")){
            String id=CommonUtil.getUUID();
            m.setId(id);
            for(int i=0;i<researchNum;i++){ //取出每个科研并储存
                /**
                 *每个科研成果属性不相同，第一个成果为原属性，第二个成果属性为原属性加1，以此类推
                 */
                String temp="";
                if(i!=0){
                    temp=""+i;
                }
                ResearchResult researchResult=new ResearchResult();
                String name=(String)request.getParameter("huodeName"+temp);
                researchResult.setName(name);
                String huodeLv=(String)request.getParameter("huodeLv"+temp);
                researchResult.setGetPrizeClass(huodeLv);
                String huodeInfo=(String) request.getParameter("huodeInfo"+temp);
                researchResult.setDetail(huodeInfo);
                String shijian2=(String) request.getParameter("shijian2"+temp);
                researchResult.setGetDate(shijian2);
                String hezuo=(String)request.getParameter("hezuo"+temp);
                researchResult.setCooperationDetail(hezuo);
                researchResult.setId(CommonUtil.getUUID());
                researchResult.setCreator(CommonUtil.getPersonId());
                researchResult.setCreateDept(CommonUtil.getDefaultDept());
                researchResult.setMajorLeaderId(id);
                this.majorLeaderService.insertResearchResult(researchResult);
            }

            m.setPersonType("1");
            m.setCreator(CommonUtil.getPersonId());
            m.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
            majorLeaderService.insertMajorLeader(m);
            return new Message(1, "新增成功！", null);
        }else{
            //修改请求，先删除之前的科研成果
            this.majorLeaderService.deleteResearchResultByMajorLeaderId(m.getId());

            ResearchResult[] researchResults=new ResearchResult[researchNum];
            for(int i=0;i<researchNum;i++){ //取出每个科研并储存
                /**
                 *每个科研成果属性不相同，第一个成果为原属性，第二个成果属性为原属性加1，以此类推
                 */
                String temp="";
                if(i!=0){
                    temp=""+i;
                }
                ResearchResult researchResult=new ResearchResult();
                String name=(String)request.getParameter("huodeName"+temp);
                researchResult.setName(name);
                String huodeLv=(String)request.getParameter("huodeLv"+temp);
                researchResult.setGetPrizeClass(huodeLv);
                String huodeInfo=(String) request.getParameter("huodeInfo"+temp);
                researchResult.setDetail(huodeInfo);
                String shijian2=(String) request.getParameter("shijian2"+temp);
                researchResult.setGetDate(shijian2);
                String hezuo=(String)request.getParameter("hezuo"+temp);
                researchResult.setCooperationDetail(hezuo);
                researchResult.setId(CommonUtil.getUUID());
                researchResult.setCreator(CommonUtil.getPersonId());
                researchResult.setCreateDept(CommonUtil.getDefaultDept());
                researchResult.setMajorLeaderId(m.getId());
                this.majorLeaderService.insertResearchResult(researchResult);
            }
            m.setChanger(CommonUtil.getPersonId());
            m.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            majorLeaderService.updateMajorLeader(m);
            return new Message(1, "修改成功！", null);
        }
    }
    /**
     * 删除方法*/
    @ResponseBody
    @RequestMapping("/majorLeader/delMajorLeader")
    public Message delMajorLeader(String  id) {
        majorLeaderService.deleteMajorLeader(id);
            return new Message(1, "删除成功！", null);
    }
    /**
     * 专业带头人导出
     * @return
     */
    @ResponseBody
    @RequestMapping("/majorLeader/daochuDate")
    public void getCmteListGroupByMajor(HttpServletResponse response,MajorLeader m) {

        this.majorLeaderService.majorLeaderExpertExcel(response, m);
    }
    @ResponseBody
    @RequestMapping("/majorLeader/savePerRelation")
    public Message savePerRelation(String teamId,String memberType, String checkList) {
        majorLeaderService.delRoleEmpDeptByArchivesIdAndInsertRoleEmpDept(teamId,memberType,checkList);
        return new Message(1, "保存成功！", null);
    }




    /**
     * 专业负责人相关
     */


    /**
     * 新增修改页*/
    @ResponseBody
    @RequestMapping("/majorResponsible/editMajorResponsible")
    public ModelAndView editMajorResponsible(String id,String personType) {
        ModelAndView mv = new ModelAndView();
        if(id!=null && id!="") {
            MajorResponsible mm = majorLeaderService.getMajorResponsibleById(id);
            mv.addObject("mm",mm);
        }
        mv.setViewName("/core/major/editMajorResponsible");
        mv.addObject("personType",personType);
        return mv;
    }


    /**
     * 专业负责人保存方法*/
    @ResponseBody
    @RequestMapping("/majorResponsible/saveMajorResponsible")
    public Message saveMajorResponsible(MajorResponsible  m) {
        if(null == m.getId()  || m.getId().equals("")){
            m.setCreator(CommonUtil.getPersonId());
            m.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
            majorLeaderService.insertMajorResponsible(m);
            return new Message(1, "新增成功！", null);
        }else{
            m.setChanger(CommonUtil.getPersonId());
            m.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            majorLeaderService.updateMajorResponsible(m);
            return new Message(1, "修改成功！", null);
        }
    }




/**
     * 专业负责人*/
        @RequestMapping("/majorResponsible/mResponsibleByMajor")
        public ModelAndView mResponsibleMajor() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/major/majorResponsibleListByMajor");
        mv.addObject("pType","2");
        return mv;
    }

    /**
     * 列表sql*/
    @ResponseBody
    @RequestMapping("/majorResponsible/majorResponsibleList")
    public Map<String, Object> majorLeaderList(MajorResponsible m,int draw, int start, int length){
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> tmapList = new HashMap<String, Object>();
        if(m.getPersonIdShow() !=null && m.getPersonIdShow() !=""){
            try {
                m.setPersonIdShow(URLDecoder.decode(m.getPersonIdShow(), "UTF-8"));
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
       // Map<String, List<MajorResponsible>> tmap = new HashMap<String, List<MajorResponsible>>();
        List<MajorResponsible> list = majorLeaderService.getMajorResponsibleList(m);
        PageInfo<List<MajorResponsible>> info = new PageInfo(list);
        tmapList.put("draw", draw);
        tmapList.put("recordsTotal", info.getTotal());
        tmapList.put("recordsFiltered", info.getTotal());
        tmapList.put("data", list);

        //tmap.put("data",majorLeaderService.getMajorResponsibleList(m));
        return tmapList;
    }

    /**
     * 删除方法*/
    @ResponseBody
    @RequestMapping("/majorResponsible/delMajorResponsible")
    public Message delMajorResponsible(String  id) {
        majorLeaderService.deleteMajorResponsible(id);
        return new Message(1, "删除成功！", null);
    }





    /**
     * 专业负责人导出
     * @return
     */
    @ResponseBody
    @RequestMapping("/majorResponsible/daochuDate")
    public void getCCmteListGroupByMajor(HttpServletResponse response,MajorResponsible m) {

        HSSFWorkbook workbook = new HSSFWorkbook();
        Sheet sheet = workbook.createSheet("专业负责人人信息表");
        // 标题部分
        CellStyle titleStyle = workbook.createCellStyle();
        Font titleFont = workbook.createFont();
        titleFont.setFontName("楷体");
        titleFont.setFontHeightInPoints((short)20);
        titleStyle.setAlignment(CellStyle.ALIGN_CENTER);
        titleStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        titleStyle.setFont(titleFont);
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 24));
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 0, 24));
        int rowNum = 0;
        Cell title1 = sheet.createRow(rowNum++).createCell(0);
        String xxmc= CommonBean.getParamValue("SZXXMC");
        title1.setCellValue(xxmc);
        title1.setCellStyle(titleStyle);
        Cell title2 = sheet.createRow(rowNum++).createCell(0);
        title2.setCellValue("专业负责人情况统计表");
        title2.setCellStyle(titleStyle);
        m.setPersonType("1");
        List<MajorResponsible> majorLeaders = majorLeaderService.getMajorResponsibleList(m);
        CellStyle cellStyle0 = workbook.createCellStyle();
        String tablename = "";


        cellStyle0.setAlignment(HorizontalAlignment.CENTER);
        cellStyle0.setVerticalAlignment(VerticalAlignment.CENTER);
        cellStyle0.setWrapText(true);
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 0, 0));//序号
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 1, 1));//专业所属系部
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 2, 2));//专业代码
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 3, 3));//专业名称（全称）
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 4, 4));//教师性质
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 5, 5));//教工号
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 6, 6));//姓名
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 7, 7));//性别
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 8, 8));//出生日期
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 9, 9));//学历
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 10, 10));//学位
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 11, 11));//工作单位名称（全称）
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 12, 12));//职务
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 13, 13));//区号-单位电话号码
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 14, 14));//电子邮箱
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 15, 15));//担任专业带头人工作年限（年）
        sheet.addMergedRegion(new CellRangeAddress(2, 2, 16, 19));//专业技术职务（最高）
        sheet.addMergedRegion(new CellRangeAddress(2, 2, 20, 24));//代表性科研成果（最高）


        sheet.setColumnWidth(0, 18 * 256);
        sheet.setColumnWidth(1, 18 * 256);
        sheet.setColumnWidth(2, 18 * 256);
        sheet.setColumnWidth(3, 18 * 256);
        sheet.setColumnWidth(4, 18 * 256);
        sheet.setColumnWidth(5, 18 * 256);
        sheet.setColumnWidth(6, 18 * 256);
        sheet.setColumnWidth(7, 18 * 256);
        sheet.setColumnWidth(8, 18 * 256);
        sheet.setColumnWidth(9, 18 * 256);
        sheet.setColumnWidth(10, 18 * 256);
        sheet.setColumnWidth(11, 18 * 256);
        sheet.setColumnWidth(12, 18 * 256);
        sheet.setColumnWidth(13, 18 * 256);
        sheet.setColumnWidth(14, 18 * 256);
        sheet.setColumnWidth(15, 18 * 256);
        sheet.setColumnWidth(16, 18 * 256);
        sheet.setColumnWidth(17, 18 * 256);
        sheet.setColumnWidth(18, 18 * 256);
        sheet.setColumnWidth(19, 18 * 256);
        sheet.setColumnWidth(20, 18 * 256);
        sheet.setColumnWidth(21, 18 * 256);
        sheet.setColumnWidth(22, 18 * 256);
        sheet.setColumnWidth(23, 18 * 256);
        sheet.setColumnWidth(24, 18 * 256);

        Row row0 = sheet.createRow(2);
        Row row1 = sheet.createRow(3);

        Cell ce1 = row0.createCell(0);
        ce1.setCellValue("序号");
        ce1.setCellStyle(cellStyle0);

        Cell ce2 = row0.createCell(1);
        ce2.setCellValue("专业所属系部");
        ce2.setCellStyle(cellStyle0);

        Cell ce3 = row0.createCell(2);
        ce3.setCellValue("专业代码");
        ce3.setCellStyle(cellStyle0);

        Cell ce4 = row0.createCell(3);
        ce4.setCellValue("专业名称（全称）");
        ce4.setCellStyle(cellStyle0);

        Cell ce5 = row0.createCell(4);
        ce5.setCellValue("教师性质");
        ce5.setCellStyle(cellStyle0);

        Cell ce6 = row0.createCell(5);
        ce6.setCellValue("教工号");
        ce6.setCellStyle(cellStyle0);

        Cell ce7 = row0.createCell(6);
        ce7.setCellValue("姓名");
        ce7.setCellStyle(cellStyle0);

        Cell ce8 = row0.createCell(7);
        ce8.setCellValue("性别");
        ce8.setCellStyle(cellStyle0);

        Cell ce9 = row0.createCell(8);
        ce9.setCellValue("出生日期");
        ce9.setCellStyle(cellStyle0);

        Cell ce10 = row0.createCell(9);
        ce10.setCellValue("学历");
        ce10.setCellStyle(cellStyle0);

        Cell ce11 = row0.createCell(10);
        ce11.setCellValue("学位");
        ce11.setCellStyle(cellStyle0);

        Cell ce12 = row0.createCell(11);
        ce12.setCellValue("工作单位名称（全称）");
        ce12.setCellStyle(cellStyle0);

        Cell ce13 = row0.createCell(12);
        ce13.setCellValue("职务");
        ce13.setCellStyle(cellStyle0);

        Cell ce14 = row0.createCell(13);
        ce14.setCellValue("区号-单位电话号码");
        ce14.setCellStyle(cellStyle0);

        Cell ce15 = row0.createCell(14);
        ce15.setCellValue("电子邮箱");
        ce15.setCellStyle(cellStyle0);

        Cell ce17 = row0.createCell(15);
        ce17.setCellValue("担任专业带头人工作年限（年）");
        ce17.setCellStyle(cellStyle0);

        Cell ce18 = row0.createCell(16);
        ce18.setCellValue("专业技术职务（最高）");
        ce18.setCellStyle(cellStyle0);

        Cell ce19 = row1.createCell(16);
        ce19.setCellValue("等级");
        ce19.setCellStyle(cellStyle0);

        Cell ce20 = row1.createCell(17);
        ce20.setCellValue("名称（全称）");
        ce20.setCellStyle(cellStyle0);

        Cell ce21 = row1.createCell(18);
        ce21.setCellValue("发证单位（全称）");
        ce21.setCellStyle(cellStyle0);

        Cell ce22 = row1.createCell(19);
        ce22.setCellValue("获取日期（年月）");
        ce22.setCellStyle(cellStyle0);



        int i = 4;
        int dataNum=1;
        for (MajorResponsible majorLeader : majorLeaders) {
            Row row = sheet.createRow(i);
            Cell cells0 = row.createCell(0);
            cells0.setCellValue(dataNum++);
            cells0.setCellStyle(cellStyle0);

            Cell cells1 = row.createCell(1);
            cells1.setCellValue(majorLeader.getDepartmentsIdShow());
            cells1.setCellStyle(cellStyle0);

            Cell cells2 = row.createCell(2);
            cells2.setCellValue(majorLeader.getMajorCode());
            cells2.setCellStyle(cellStyle0);

            Cell cells3 = row.createCell(3);
            cells3.setCellValue(majorLeader.getMajorIdShow());
            cells3.setCellStyle(cellStyle0);

            Cell cells4 = row.createCell(4);
            cells4.setCellValue(majorLeader.getTeacherCategoryShow());
            cells4.setCellStyle(cellStyle0);

            Cell cells5 = row.createCell(5);
            cells5.setCellValue(majorLeader.getTeacherNum());
            cells5.setCellStyle(cellStyle0);

            Cell cells6 = row.createCell(6);
            cells6.setCellValue(majorLeader.getPersonIdShow());
            cells6.setCellStyle(cellStyle0);

            Cell cells7 = row.createCell(7);
            cells7.setCellValue(majorLeader.getSexShow());
            cells7.setCellStyle(cellStyle0);

            Cell cells8 = row.createCell(8);
            String bd=majorLeader.getBirthday().substring(0,10);
            cells8.setCellValue(bd);
            cells8.setCellStyle(cellStyle0);

            Cell cells9 = row.createCell(9);
            cells9.setCellValue(majorLeader.getEducationShow());
            cells9.setCellStyle(cellStyle0);

            Cell cells10 = row.createCell(10);
            cells10.setCellValue(majorLeader.getDegreeShow());
            cells10.setCellStyle(cellStyle0);

            Cell cells11 = row.createCell(11);
            cells11.setCellValue(majorLeader.getWorkDept());
            cells11.setCellStyle(cellStyle0);

            Cell cells12 = row.createCell(12);
            cells12.setCellValue(majorLeader.getPosition());
            cells12.setCellStyle(cellStyle0);

            Cell cells13 = row.createCell(13);
            cells13.setCellValue(majorLeader.getGuhua());
            cells13.setCellStyle(cellStyle0);

            Cell cells14 = row.createCell(14);
            cells14.setCellValue(majorLeader.getEmail());
            cells14.setCellStyle(cellStyle0);

            Cell cells15 = row.createCell(15);
            cells15.setCellValue(majorLeader.getZyWorkdate());
            cells15.setCellStyle(cellStyle0);

            Cell cells16 = row.createCell(16);
            cells16.setCellValue(majorLeader.getPositionLeave());
            cells16.setCellStyle(cellStyle0);

            Cell cells17 = row.createCell(17);
            cells17.setCellValue(majorLeader.getPositionName());
            cells17.setCellStyle(cellStyle0);

            Cell cells18 = row.createCell(18);
            cells18.setCellValue(majorLeader.getOffice());
            cells18.setCellStyle(cellStyle0);

            Cell cells19 = row.createCell(19);
            cells19.setCellValue(majorLeader.getPositionDate());
            cells19.setCellStyle(cellStyle0);

            Cell cells20 = row.createCell(20);
            cells20.setCellValue(majorLeader.getResearchResult());
            cells20.setCellStyle(cellStyle0);

            i = i + 1;
        }
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ( "专业负责人信息表.xls", "utf-8"));
            os = response.getOutputStream();
            workbook.write(os);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (os != null) {
                    os.flush();
                    os.close();
                }
                workbook.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }




}
