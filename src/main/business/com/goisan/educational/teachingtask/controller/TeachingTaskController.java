package com.goisan.educational.teachingtask.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.educational.backboneTeacher.bean.BackboneTeacher;
import com.goisan.educational.score.service.ScoreChangeService;
import com.goisan.educational.teachingtask.bean.TeachingTask;
import com.goisan.educational.teachingtask.dao.TeachingTaskDao;
import com.goisan.educational.teachingtask.service.TeachingTaskService;
import com.goisan.system.bean.Dept;
import com.goisan.system.bean.EmpDeptRelation;
import com.goisan.system.bean.LoginUser;
import com.goisan.system.bean.RoleEmpDeptRelation;
import com.goisan.system.dao.SysDicDao;
import com.goisan.system.service.DeptService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.beans.factory.annotation.Autowired;
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
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @function: 教学任务Contoller层
 * @author: ZhangHao
 * @date: 2018/10/19
 */
@Controller
public class TeachingTaskController {
    @Resource
    private ScoreChangeService scoreChangeService;
    @Resource
    private TeachingTaskService teachingTaskService;
    @Resource
    private DeptService deptService;

    /**
     * @function: 添加教学任务
     * @author: ZhangHao
     * @date: 2018/10/29
     */
    @ResponseBody
    @RequestMapping("/teachingTask/saveTeachingTask")
    private Message insertTeachingTask(TeachingTask teachingTask) {
        return teachingTaskService.saveOrUpdateTeachingTask(teachingTask);
    }

    /**
     * @function: 删除教学任务
     * @author: ZhangHao
     * @date: 2018/10/29
     */
    @ResponseBody
    @RequestMapping("/teachingTask/deleteTeachingTask")
    private Message deleteTeachingTask(String ids) {
        return teachingTaskService.deleteTeachingTaskByIds(ids);
    }

    /**
     * @function: 获取数据集合
     * @author: ZhangHao
     * @date: 2018/10/29
     */
    @ResponseBody
    @RequestMapping("/teachingTask/getTeachingTaskList")
    private Map<String, Object> getArrayClassList(TeachingTask teachingTask, int draw, int start, int length) {


        if (teachingTask != null) {

            LoginUser user = CommonUtil.getLoginUser();

            List<String> userDept = user.getDeptId();
            List<Dept> deptList = deptService.getDeptByDeptName("教务处");

            boolean bRet = true;

            if (deptList != null && deptList.size() > 0 && userDept != null && userDept.size() > 0) {

                for (Dept dept : deptList) {

                    if (dept != null && userDept.contains(dept.getDeptId())) {

                        bRet = false;
                    }
                }
            }

            if (bRet) {

                teachingTask.setTeacherId(user.getPersonId());
            }
        }
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> teachingTasks = new HashMap();
        List<TeachingTask> list = teachingTaskService.getTeachingTaskList(teachingTask);

        PageInfo<List<TeachingTask>> info = new PageInfo(list);
        teachingTasks.put("draw", draw);
        teachingTasks.put("recordsTotal", info.getTotal());
        teachingTasks.put("recordsFiltered", info.getTotal());
        teachingTasks.put("data", list);
        return teachingTasks;
    }

    @ResponseBody
    @RequestMapping("/teachingTask/getTeachingTaskList2")
    private Map<String, Object> getTeachingTaskList2(TeachingTask teachingTask, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> teachingTasks = new HashMap();
        teachingTask.setDepartment(CommonUtil.getDefaultDept());
        List<TeachingTask> list = teachingTaskService.getTeachingTaskListBydept(teachingTask);
        PageInfo<List<TeachingTask>> info = new PageInfo(list);
        teachingTasks.put("draw", draw);
        teachingTasks.put("recordsTotal", info.getTotal());
        teachingTasks.put("recordsFiltered", info.getTotal());
        teachingTasks.put("data", list);
        return teachingTasks;
    }

    /**
     * @function: 打开教学任务列表显示页
     * @author: ZhangHao
     * @date: 2018/10/29
     */
    @RequestMapping("/teachingTask/teachingTaskList")
    private ModelAndView resultList() {
        List<EmpDeptRelation> list = scoreChangeService.getEmployeeDeptByDeptIdPersonId(CommonUtil.getPersonId());
        List<RoleEmpDeptRelation> list1 = scoreChangeService.getRoleByPersonId(CommonUtil.getPersonId());
        if (list.size() > 0) {
            return new ModelAndView("/business/educational/teachingtask/teachingTaskList");
        } else if (list1.size() > 0) {
            return new ModelAndView("/business/educational/teachingtask/teachingTaskList1");
        } else {
            return new ModelAndView("/business/educational/teachingtask/teachingTaskList2");
        }
    }

    /**
     * @function: 打开教学任务添加页
     * @author: ZhangHao
     * @date: 2018/10/29
     */
    @RequestMapping("/teachingTask/toAdd")
    private ModelAndView toAdd(Model model) {
        model.addAttribute("head", "新增");
        List<EmpDeptRelation> list = scoreChangeService.getEmployeeDeptByDeptIdPersonId(CommonUtil.getPersonId());
        TeachingTask teachingTask = new TeachingTask();
        if (list.size() > 0) {
            return new ModelAndView("/business/educational/teachingtask/toAdd");
        } else {
            teachingTask.setDepartment(CommonUtil.getDefaultDept());
            model.addAttribute("toEdit", teachingTask);
            return new ModelAndView("/business/educational/teachingtask/toAdd1");
        }
    }

    /**
     * @function: 打开教学任务修改页
     * @author: ZhangHao
     * @date: 2018/10/29
     */
    @RequestMapping("/teachingTask/toEdit")
    private ModelAndView toEdit(String id, Model model) {
        model.addAttribute("toEdit", teachingTaskService.getTeachingTaskById(id));
        List<EmpDeptRelation> list = scoreChangeService.getEmployeeDeptByDeptIdPersonId(CommonUtil.getPersonId());
        if (list.size() > 0) {
            model.addAttribute("head", "修改");
            return new ModelAndView("/business/educational/teachingtask/toAdd");
        } else {
            model.addAttribute("head", "修改");
            return new ModelAndView("/business/educational/teachingtask/toAdd1");
        }

    }

    /**
     * @function: 打开教学任务模板下载页
     * @author: ZhangHao
     * @date: 2018/10/29
     */
    @RequestMapping("/teachingTask/toOutExcel")
    private ModelAndView toOutExcel(Model model) {
        model.addAttribute("head", "模板下载");
        List<EmpDeptRelation> list = scoreChangeService.getEmployeeDeptByDeptIdPersonId(CommonUtil.getPersonId());
        if (list.size() > 0) {
            model.addAttribute("toEdit", teachingTaskService.getEmpByPreparedBy());
            return new ModelAndView("/business/educational/teachingtask/toOutExcel");
        } else {
            TeachingTask teachingTask = teachingTaskService.getEmpByPreparedBy();
            teachingTask.setDepartment(CommonUtil.getDefaultDept());
            model.addAttribute("toEdit", teachingTask);
            return new ModelAndView("/business/educational/teachingtask/toOutExcel1");
        }
    }

    /**
     * @function: 导出Excel模板
     * @author: ZhangHao
     * @date: 2018/10/29
     */
    @RequestMapping("/teachingTask/outTemplate")
    private void outTemplate(HttpServletRequest request, HttpServletResponse response) {
        teachingTaskService.readOutTemplate(request, response);
    }

    /**
     * @function: 打开教学任务导入页
     * @author: ZhangHao
     * @date: 2018/10/29
     */
    @RequestMapping("/teachingTask/toImportExcel")
    private ModelAndView toImportExcel(Model model) {
        return new ModelAndView("/business/educational/teachingtask/importExcel");
    }

    /**
     * @function: 数据导入
     * @author: ZhangHao
     * @date: 2018/10/29
     */
    @ResponseBody
    @RequestMapping("/teachingTask/importExcel")
    public Message importExcel(@RequestParam(value = "file", required = false) CommonsMultipartFile file) {
        return teachingTaskService.loadingExcel(file);
    }

    /**
     * @function: 打开教学任务Excel导出页
     * @author: ZhangHao
     * @date: 2018/10/29
     */
    @RequestMapping("/teachingTask/toOutData")
    private ModelAndView toOutData(Model model) {
        model.addAttribute("head", "数据导出");
        return new ModelAndView("/business/educational/teachingtask/toOutData");
    }

    /**
     * @function: 数据导出
     * @author: ZhangHao
     * @date: 2018/10/29
     */
    @RequestMapping("/teachingTask/outData")
    private void outData(HttpServletRequest request, HttpServletResponse response) {
        teachingTaskService.readOutTeachingTaskData(request, response);
    }

    /**
     * @function: 获取指定教学计划
     * @author: ZhangHao
     * @date: 2018/10/29
     */
    @ResponseBody
    @RequestMapping("/teachingTask/checkTeachingTask")
    private TeachingTask checkTeachingTask(TeachingTask teachingTask) {
        return teachingTaskService.getTeachingTaskByClassIdAndCourseIdAndSemester(teachingTask.getClassInfo(), teachingTask.getCourseId(), teachingTask.getSemester());
    }

    @Autowired
    private TeachingTaskDao teachingTaskDao;
    @Autowired
    private SysDicDao sysDicDao;

    /**
     * @function: 班级落课情况导出页
     * @author: BaiLiMing
     * @date: 2019/01/18
     */
    @RequestMapping("/teachingTask/toOutClassData")
    private ModelAndView toOutClassData(Model model) {
        model.addAttribute("head", "数据导出");
        return new ModelAndView("/business/educational/teachingtask/toOutClassData");
    }

    /**
     * @function: 班级落课情况导出
     * @author: BaiLiMing
     * @date: 2019/01/18
     */
//    @RequestMapping("/teachingTask/outClassData")
//    private void outClassData(HttpServletRequest request, HttpServletResponse response) {
//        teachingTaskService.readOutClassTaskData(request, response);
//    }
    @ResponseBody
    @RequestMapping("/teachingTask/outClassData")
    public void exportRepair(HttpServletRequest request, HttpServletResponse response) {
        int num = 1;
        String name = "sheet";
        TeachingTask queryObj = new TeachingTask();
        String deptId = request.getParameter("deptId");
        String userId = request.getParameter("userId");
        String semester = request.getParameter("semester");
        if (semester != null && !"".equals(semester)) {
            String smer = sysDicDao.getDicName("XQ", semester);
            if (smer != null && !"".equals(smer)) {
                TeachingTask firstTeachingTask = new TeachingTask();
                firstTeachingTask.setDepartmentName(request.getParameter("departmentShow"));
                firstTeachingTask.setPreparedByName(request.getParameter("teacherShow"));
                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
                firstTeachingTask.setPreparedTime(simpleDateFormat.format(new Date()));
                //创建HSSFWorkbook对象
                HSSFWorkbook wb = new HSSFWorkbook();

                queryObj.setSemester(semester);
                queryObj.setDepartment(deptId);
                queryObj.setPreparedBy(userId);
//        查询列表
        Map<String, List<TeachingTask>> dataMap = new HashMap<>();
        List<TeachingTask> dataList = teachingTaskDao.getTeachingTaskList(queryObj);
        for (TeachingTask teachingTask : dataList) {
            if (teachingTask != null) {
                List<TeachingTask> tempList = dataMap.get(teachingTask.getClassName());
                if (tempList == null) {
                    tempList = new ArrayList<>();
                }
                tempList.add(teachingTask);
                dataMap.put(teachingTask.getClassName(), tempList);
            }
        }

                if (dataMap.size() > 0) {
                    for (String className : dataMap.keySet()) {
                        List<TeachingTask> tempList = dataMap.get(className);

                        int tmp = 4;
                        int ihead = 1;
                        //创建HSSFSheet对象
                        HSSFSheet sheet = wb.createSheet(name + num);
                        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 10));//合并单元格
                        sheet.addMergedRegion(new CellRangeAddress(1, 1, 0, 10));//合并单元格
                        sheet.addMergedRegion(new CellRangeAddress(2, 2, 0, 10));//合并单元格

                        //                设置宽度
                        sheet.setColumnWidth(0, 10*256);
                        sheet.setColumnWidth(1, 16*256);
                        sheet.setColumnWidth(2, 16*256);
                        sheet.setColumnWidth(3, 10*256);
                        sheet.setColumnWidth(4, 32*256);
                        sheet.setColumnWidth(5, 10*256);
                        sheet.setColumnWidth(6, 64*256);
                        sheet.setColumnWidth(7, 24*256);
                        sheet.setColumnWidth(8, 16*256);
                        sheet.setColumnWidth(9, 32*256);
                        sheet.setColumnWidth(10,12*256);

                        /*第一行头部*/
                        HSSFRow row1 = sheet.createRow(0);
                        row1.setHeight((short) 510);
                        HSSFCell cell1 = row1.createCell(0);
                        HSSFCellStyle titleStyle = wb.createCellStyle();
                        titleStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
                        titleStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
                        HSSFFont titleFont = wb.createFont();
                        titleFont.setFontName("宋体");
                        titleFont.setFontHeightInPoints((short) 20);
                        titleFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
                        titleStyle.setFont(titleFont);
                        cell1.setCellStyle(titleStyle);
                        cell1.setCellValue("系(部)教师落课一览表(汇总）");

                        /*第二行头部*/
                        HSSFRow row2 = sheet.createRow(1);
                        row2.setHeight((short) 300);
                        HSSFCell cell2 = row2.createCell(0);
                        HSSFCellStyle titleStyle2 = wb.createCellStyle();
                        titleStyle2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
                        titleStyle2.setAlignment(HSSFCellStyle.ALIGN_CENTER);
                        HSSFFont titleFont2 = wb.createFont();
                        titleFont2.setFontName("宋体");
                        titleFont2.setFontHeightInPoints((short) 12);
                        titleFont2.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
                        titleStyle2.setFont(titleFont2);
                        cell2.setCellStyle(titleStyle2);
                        cell2.setCellValue(smer);

                        /*第三行头部*/
                        HSSFRow row3 = sheet.createRow(2);
                        row3.setHeight((short) 300);
                        HSSFCell cell3 = row3.createCell(0);
                        HSSFCellStyle titleStyle3 = wb.createCellStyle();
                        titleStyle3.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
                        titleStyle3.setAlignment(HSSFCellStyle.ALIGN_CENTER);
                        HSSFFont titleFont3 = wb.createFont();
                        titleFont3.setFontName("宋体");
                        titleFont3.setFontHeightInPoints((short) 12);
                        titleFont3.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
                        titleStyle3.setFont(titleFont3);
                        cell3.setCellStyle(titleStyle3);
                        cell3.setCellValue("系（部）名称：" + firstTeachingTask.getDepartmentName() + " 填表人：" + firstTeachingTask.getPreparedByName() + " 填表时间：" + firstTeachingTask.getPreparedTime());

                        /*字段名字体样式*/
                        HSSFRow row4 = sheet.createRow(3);
                        HSSFCellStyle trStyle4 = wb.createCellStyle();//生成样式
                        trStyle4.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);//垂直居中
                        trStyle4.setAlignment(HSSFCellStyle.ALIGN_CENTER);//居中
                        trStyle4.setBorderBottom(HSSFCellStyle.BORDER_THIN); //下边框
                        trStyle4.setBorderLeft(HSSFCellStyle.BORDER_THIN);//左边框
                        trStyle4.setBorderTop(HSSFCellStyle.BORDER_THIN);//上边框
                        trStyle4.setBorderRight(HSSFCellStyle.BORDER_THIN);//右边框
                        HSSFFont trFont4 = wb.createFont();//生成字体
                        trFont4.setFontName("宋体");//字体样式
                        trFont4.setFontHeightInPoints((short) 10);//字体大小
                        trFont4.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);//加粗
                        trFont4.setBold(true);
                        trStyle4.setFont(trFont4);//装配字体
                        row4.setHeight((short) 420);

                        row4.createCell(0).setCellValue("序号");
                        row4.createCell(1).setCellValue("任课教师");
                        row4.createCell(2).setCellValue("班级");
                        row4.createCell(3).setCellValue("人数");
                        row4.createCell(4).setCellValue("课程名称");
                        row4.createCell(5).setCellValue("周学时");
                        row4.createCell(6).setCellValue("该教师所有任课班级");
                        row4.createCell(7).setCellValue("合班情况及上课地点");
                        row4.createCell(8).setCellValue("已聘职称");
                        row4.createCell(9).setCellValue("非本系（部）注明部门或单位");
                        row4.createCell(10).setCellValue("备注");
                        for (int col = 0; col <= 10; col++) {
                            row4.getCell(col).setCellStyle(trStyle4);
                        }

                        HSSFCellStyle trStyle = wb.createCellStyle();//生成样式
                        trStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);//垂直居中
                        trStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);//居中
                        trStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); //下边框
                        trStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);//左边框
                        trStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);//上边框
                        trStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);//右边框
                        trStyle.setWrapText(true);
                        HSSFFont trFont = wb.createFont();//生成字体
                        trFont.setFontName("宋体");//字体样式
                        trFont.setFontHeightInPoints((short) 10);//字体大小
                        trStyle.setFont(trFont);//装配字体

                        int length = tempList.size();
                        int range = tmp;
                        int sum = 0;
                        for (TeachingTask teachingTask : tempList) {
                            HSSFRow row5 = sheet.createRow(tmp);
                            row5.createCell(0).setCellValue(ihead);
                            row5.createCell(1).setCellValue(teachingTask.getTeacherName());
                            row5.createCell(2);
                            row5.createCell(3);
                            if(null!=teachingTask.getStudentNum()&&!"".equals(teachingTask.getStudentNum())){
                                sum = Integer.parseInt(teachingTask.getStudentNum());
                            }
                            row5.createCell(4).setCellValue(teachingTask.getCourseName());
                            row5.createCell(5).setCellValue(teachingTask.getWeekTime());
//                            根据教师id 查询上课班级
                            TeachingTask tcTask = new TeachingTask();
                            tcTask.setTeacherId(teachingTask.getTeacherId());
                            tcTask.setSemester(semester);
//                           新增根据课程过滤
                            tcTask.setCourseId(teachingTask.getCourseId());
                            List<TeachingTask> tcTaskList = teachingTaskDao.getTeachingTaskList(tcTask);
                            StringBuffer tc = new StringBuffer();
                            for (TeachingTask task: tcTaskList) {
                                tc.append(task.getClassName()+" ");
                            }
                            row5.createCell(6).setCellValue(String.valueOf(tc));
                            row5.createCell(7).setCellValue("");
                            row5.createCell(8).setCellValue(teachingTask.getEmployedTitle());
                            row5.createCell(9).setCellValue(teachingTask.getOtherDept());
                            row5.createCell(10).setCellValue(teachingTask.getRemarks());

                            for (int i = 0; i <=10 ; i++) {
                                row5.getCell(i).setCellStyle(trStyle);
                            }
                            tmp++;
                            ihead++;
                        }
                        if (length > 1) {
                            sheet.addMergedRegion(new CellRangeAddress(range, range + length - 1, 2, 2));
                            sheet.addMergedRegion(new CellRangeAddress(range, range + length - 1, 3, 3));
                        }
                        HSSFRow row = sheet.getRow(range);
                        row.getCell(2).setCellValue(className);
                        row.getCell(3).setCellValue(String.valueOf(sum));

                        num++;
                    }

                    OutputStream os = null;
                    String fileName = smer + "班级落课情况";
                    response.setContentType("application/vnd.ms-excel");
                    try {
                        response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                                (fileName + ".xls", "utf-8"));
                        os = response.getOutputStream();
                        wb.write(os);
                    } catch (UnsupportedEncodingException e) {
                        e.printStackTrace();
                    } catch (IOException e) {
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
            }
        }
    }
}
