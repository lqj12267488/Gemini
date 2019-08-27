package com.goisan.educational.teachingtask.service.Impl;

import com.goisan.educational.course.bean.Course;
import com.goisan.educational.course.dao.CourseDao;
import com.goisan.educational.exam.bean.ExamCourseClass;
import com.goisan.educational.exam.dao.ExamDao;
import com.goisan.educational.score.service.ScoreChangeService;
import com.goisan.educational.teachingtask.bean.TeachingTask;
import com.goisan.educational.teachingtask.dao.TeachingTaskDao;
import com.goisan.educational.teachingtask.service.TeachingTaskService;
import com.goisan.educational.teachingtask.tool.TeachingTaskExcelUtil;
import com.goisan.system.bean.*;
import com.goisan.system.dao.*;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @function: 教学任务Service层接口实现类
 * @author: ZhangHao
 * @date: 2018/10/14
 */
@Service
public class TeachingTaskServiceImpl implements TeachingTaskService {

    /**
     * @function: 查询教学任务数据
     * @author: ZhangHao
     * @date: 2018/10/14
     * @param: baseBean
     */
    @Override
    public List<TeachingTask> getTeachingTaskList (TeachingTask teachingTask) {
        return teachingTaskDao.getTeachingTaskList(teachingTask);
    }

    /**
     * @function: 通过Id获取教学任务实体类
     * @author: ZhangHao
     * @date: 2018/10/14
     * @param: id
     */
    @Override
    public TeachingTask getTeachingTaskById (String id) {

        try {

            if (id != null && !"".equals(id)) {

                return teachingTaskDao.getTeachingTaskById(id);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return null;
    }

    /**
     * @function: 添加或编辑教学任务
     * @author: ZhangHao
     * @date: 2018/10/14
     * @param: TeachingTask
     */
    @Override
    public Message saveOrUpdateTeachingTask (TeachingTask teachingTask) {

        try {

            if (teachingTask != null) {

                if(teachingTask.getId()!=null && !"".equals(teachingTask.getId())){

                    TeachingTask oldTeachingTask = teachingTaskDao.getTeachingTaskByClassIdAndCourseIdAndSemester(teachingTask);//教学计划去重

                    if(oldTeachingTask != null){

                        return new Message(0, "抱歉！"+oldTeachingTask.getSemesterName()+"学期"+oldTeachingTask.getClassName()+"的"+oldTeachingTask.getCourseName()+"已由"+oldTeachingTask.getTeacherName()+"老师教授，请检查落课数据是否正确", null);
                    }

                    CommonUtil.update(teachingTask);

                    if (teachingTaskDao.updateTeachingTask(teachingTask)>0) {

                        return new Message(1, "修改成功", null);
                    }

                } else{

                    TeachingTask oldTeachingTask = teachingTaskDao.getTeachingTaskByClassIdAndCourseIdAndSemester(teachingTask);//教学计划去重

                    if(oldTeachingTask != null){

                        return new Message(0, "抱歉！"+oldTeachingTask.getSemesterName()+"学期"+oldTeachingTask.getClassName()+"的"+oldTeachingTask.getCourseName()+"已由"+oldTeachingTask.getTeacherName()+"老师教授，请检查落课数据是否正确", null);
                    }

                    teachingTask.setId(CommonUtil.getUUID());
                    CommonUtil.save(teachingTask);

                    if(teachingTaskDao.insertTeachingTask(teachingTask) > 0) {

                        return new Message(1, "添加成功", null);
                    }
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return null;
    }

    /**
     * @function: 根据Id删除教学任务实体类
     * @author: ZhangHao
     * @date: 2018/10/14
     * @param: id
     */
    @Override
    public Message deleteTeachingTaskByIds (String ids) {

        try {

            if (ids != null && !"".equals(ids)) {

                if(teachingTaskDao.deleteTeachingTaskByIds(ids) > 0) {

                    return new Message(1, "删除成功", null);
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return null;
    }

    /**
     * @function: 模板导出方法
     * @author: ZhangHao
     * @date: 2018/10/27
     */
    public boolean readOutTemplate(HttpServletRequest request, HttpServletResponse response) {

        OutputStream os = null;

        try {

            String deptId= request.getParameter("deptId");
            String userId = request.getParameter("userId");
            String semester = request.getParameter("semester");

            if(deptId != null && !"".equals(deptId) && userId != null && !"".equals(userId) && semester != null && !"".equals(semester)){

                Emp emp = empDao.getEmpByEmpId(userId);
                Dept dept = deptDao.getDeptById(deptId);
                String smer = sysDicDao.getDicName("XQ",semester);

                if(emp != null && dept != null && smer != null && !"".equals(smer)){

                    String fileName = "教学任务上传模板";

                    response.setContentType("application/vnd.ms-excel");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(fileName+".xls", "utf-8"));
                    os = response.getOutputStream();

                    TeachingTaskExcelUtil tteu = new TeachingTaskExcelUtil();

                    tteu.writeTeachingTaskExcelTemplate(os, dept.getDeptName(), emp, smer);
                }

            }

        } catch (Exception e) {

            e.printStackTrace();

        } finally {

            try {

                if(os != null){

                    os.close();
                }

            } catch (IOException ioe){

                ioe.printStackTrace();
            }
        }

        return false;
    }

    /**
     * @function: 上传数据读取导入
     * @author: ZhangHao
     * @date: 2018/10/27
     */
    public Message loadingExcel(CommonsMultipartFile file){

        try {

            if(file != null){

                HSSFWorkbook workbook = new HSSFWorkbook(file.getInputStream());

                for (int i = 0; i < workbook.getNumberOfSheets(); i++) {// 获取每个Sheet表

                    HSSFSheet sheet = workbook.getSheetAt(i);
                    HSSFRow rowCheck = sheet.getRow(0);

                    if(rowCheck != null){

                        HSSFCell cellCheck = rowCheck.getCell(0);

                        if(cellCheck != null && "系(部)教师落课一览表(汇总）".equals(cellCheck.toString())){

                            String semester = "";
                            String deptId = "";
                            String preparedBy = "";
                            String preparedTime = "";
                            String preparedByName = "";
                            String staffIdBy = "";
                            HSSFCell cellTemp = sheet.getRow(1).getCell(0);

                            if(cellTemp != null && cellTemp.toString()!=null && !"".equals(cellTemp.toString())){

                                semester = cellTemp.toString();
                            }

                            cellTemp = sheet.getRow(2).getCell(1);

                            if(cellTemp != null && cellTemp.toString()!=null && !"".equals(cellTemp.toString())){

                                deptId = cellTemp.toString();
                            }

                            cellTemp = sheet.getRow(2).getCell(3);

                            if(cellTemp != null && cellTemp.toString()!=null && !"".equals(cellTemp.toString())){

                                preparedByName = cellTemp.toString();
                            }

                            cellTemp = sheet.getRow(2).getCell(5);

                            if(cellTemp != null && cellTemp.toString()!=null && !"".equals(cellTemp.toString())){

                                preparedBy = cellTemp.toString();
                            }

                            cellTemp = sheet.getRow(2).getCell(7);

                            if(cellTemp != null && cellTemp.toString()!=null && !"".equals(cellTemp.toString())){

                                staffIdBy = cellTemp.toString();
                            }

                            cellTemp = sheet.getRow(2).getCell(9);

                            if(cellTemp != null && cellTemp.toString()!=null && !"".equals(cellTemp.toString())){

                                preparedTime = cellTemp.toString();
                            }

                            if(semester == null || "".equals(semester)){

                                return new Message(0,"抱歉！学期不能为空", null);
                            }

                            if(deptId == null || "".equals(deptId)){

                                return new Message(0,"抱歉！部门不能为空", null);
                            }

                            if((preparedBy == null || "".equals(preparedBy)) && (staffIdBy == null || "".equals(staffIdBy)) ){

                                return new Message(0,"抱歉！填表人身份证号和填表人编号不能同时为空", null);
                            }

                            if(preparedTime == null || "".equals(preparedTime)){

                                return new Message(0,"抱歉！填表时间不能为空", null);
                            }

                            List<TeachingTask> dataList = new ArrayList<>();

                            for (int j = 4; j < sheet.getLastRowNum() + 1; j++) {// getLastRowNum，获取最后一行的行标

                                HSSFRow row = sheet.getRow(j);

                                if (row != null) {

                                    TeachingTask teachingTask = new TeachingTask();

                                    HSSFCell cell = row.getCell(2);

                                    HSSFCell cell1 = row.getCell(11);
                                    if(cell != null && cell.toString()!=null && !"".equals(cell.toString())){

                                        teachingTask.setTeacherId(cell.toString());
                                        teachingTask.setTeacherName(row.getCell(1).toString());

                                    }else if(cell1 != null && cell1.toString()!=null && !"".equals(cell1.toString())){
                                        HSSFCell hssef2 = row.getCell(11);
                                        hssef2.setCellType(hssef2.CELL_TYPE_STRING);
                                        teachingTask.setStaffId(hssef2.toString() + "");
                                        teachingTask.setTeacherName(row.getCell(1).toString());
                                    }else{
                                        return new Message(0,"抱歉！"+row.getCell(1).toString()+"老师的身份证号和老师的编号不能同时为空", null);
                                    }

                                    cell = row.getCell(3);

                                    if(cell != null && cell.toString()!=null && !"".equals(cell.toString())){

                                        teachingTask.setClassInfo(cell.toString());

                                    }

                                    cell = row.getCell(4);

                                    if(cell != null && cell.toString()!=null && !"".equals(cell.toString())){

                                        teachingTask.setStudentNum(cell.toString().replace(".0",""));

                                    }

                                    cell = row.getCell(5);

                                    if(cell != null && cell.toString()!=null && !"".equals(cell.toString())){

                                        teachingTask.setCourseId(cell.toString());

                                    }

                                    cell = row.getCell(6);

                                    if(cell != null && cell.toString()!=null && !"".equals(cell.toString())){

                                        teachingTask.setWeekTime(cell.toString().replace(".0",""));

                                    }

                                    cell = row.getCell(7);

                                    if(cell != null && cell.toString()!=null && !"".equals(cell.toString())){

                                        teachingTask.setEmployedTitle(cell.toString());

                                    }

                                    cell = row.getCell(8);

                                    if(cell != null && cell.toString()!=null && !"".equals(cell.toString())){

                                        teachingTask.setOtherDept(cell.toString());

                                    }

                                    cell = row.getCell(9);

                                    if(cell != null && cell.toString()!=null && !"".equals(cell.toString())){

                                        teachingTask.setRemarks(cell.toString());

                                    }

                                    cell = row.getCell(10);

                                    if(cell != null && cell.toString()!=null && !"".equals(cell.toString())){

                                        String tmpStr=cell.toString();
                                        if ("考试".equals(tmpStr))
                                        {
                                            teachingTask.setExamMethod("1");
                                        }
                                        if ("考察".equals(tmpStr))
                                        {
                                            teachingTask.setExamMethod("2");
                                        }

                                    }

                                    teachingTask.setSemester(semester);
                                    teachingTask.setDepartment(deptId);
                                    if(preparedBy == null || "".equals(preparedBy)){
                                        teachingTask.setStaffIdBy(staffIdBy);
                                    }else{
                                        teachingTask.setPreparedBy(preparedBy);
                                    }
                                    teachingTask.setPreparedTime(preparedTime);
                                    teachingTask.setPreparedByName(preparedByName);
                                    dataList.add(teachingTask);
                                }
                            }

                            if(dataList != null && dataList.size() > 0){

                                return this.submitData(dataList);

                            } else {

                                return new Message(0,"抱歉，Excel中数据为空！", null);
                            }

                        } else {

                            return new Message(0,"请检查落课一览表模板！", null);
                        }
                    }
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return new Message(0,"系统错误，请稍后重试", null);
    }

    /**
     * @function: Excel数据批量入库
     * @author: ZhangHao
     * @date: 2018/10/27
     * @param: null
     */
    private Message submitData(List<TeachingTask> dataList){

        try {

            if(dataList != null && dataList.size() > 0){

                for(TeachingTask teachingTask : dataList){

                    if(teachingTask != null){

                        String teaIdCard = teachingTask.getTeacherId();
                        String teaStaffId = teachingTask.getStaffId();
                        String semesterName = teachingTask.getSemester();
                        String deptName = teachingTask.getDepartment();
                        String userIdCard = teachingTask.getPreparedBy();
                        String userStaffId = teachingTask.getStaffIdBy();
                        String className = teachingTask.getClassInfo();
                        String courseName = teachingTask.getCourseId();
                        String preparedTime = teachingTask.getPreparedTime();
                        Dept dept = null;

                        List<Dept> deptList = deptDao.getDeptByDeptName(deptName);

                        if(deptList != null && deptList.size() > 0 ){

                            dept = deptList.get(0);
                        }
                        Emp teacher;
                        if(teaIdCard == null || "".equals(teaIdCard)){
                            teacher = empDao.getEmpByStaffId(teaStaffId);
                        }else{
                            teacher = empDao.getEmpByIdCard(teaIdCard);
                        }
                        Emp user;
                        if(userIdCard == null || "".equals(userIdCard)){
                            user = empDao.getEmpByStaffId(teaStaffId);
                        }else{
                            user = empDao.getEmpByIdCard(userIdCard);
                        }


                        Course course = null;

                        List<Course> courseList = courseDao.getCourseByCourseName(courseName);

                        if(courseList != null && courseList.size() > 0 ){

                            course = courseList.get(0);
                        }

                        ClassBean classBean = classDao.selectClassBeranByClassName(className,"");

                        String semester = sysDicDao.getDicCode("XQ",semesterName);

                        preparedTime=(preparedTime!=null)?preparedTime.replace("年","-").replace("月","-").replace("日",""):null;
                        preparedTime = preparedTime.replace(" ", "");
                        if(semester == null || "".equals(semester)){

                            return new Message(0,"抱歉!并没有找到名称为"+semesterName+"的学期", null);
                        }

                        if(dept == null){

                            return new Message(0,"抱歉!并没有找到名称为"+deptName+"的系部", null);
                        }

                        if(teacher == null){

                            return new Message(0,"抱歉!并没有找到"+teachingTask.getTeacherName()+"老师，请检查身份证号。", null);
                        }

                        if(user == null){

                            return new Message(0,"抱歉!并没有找填表人"+teachingTask.getPreparedByName()+"，请检查身份证号。", null);
                        }

                        if(course == null){

                            return new Message(0,"抱歉!并没有找到名称为"+courseName+"的课程", null);
                        }

                        if(classBean == null){

                            return new Message(0,"抱歉!并没有找到名称为"+className+"的班级", null);
                        }

                        teachingTask.setId(CommonUtil.getUUID());
                        CommonUtil.save(teachingTask);
                        teachingTask.setTeacherId(teacher.getPersonId());
                        teachingTask.setSemester(semester);
                        teachingTask.setDepartment(dept.getDeptId());
                        teachingTask.setPreparedBy(user.getPersonId());
                        teachingTask.setClassInfo(classBean.getClassId());
                        teachingTask.setCourseId(course.getCourseId());
                        teachingTask.setPreparedTime(preparedTime);

                        TeachingTask oldTeachingTask = teachingTaskDao.getTeachingTaskByClassIdAndCourseIdAndSemester(teachingTask);//教学计划去重

                        if(oldTeachingTask != null){

                            return new Message(0, "抱歉！"+oldTeachingTask.getSemesterName()+"学期"+oldTeachingTask.getClassName()+"的"+oldTeachingTask.getCourseName()+"已由"+oldTeachingTask.getTeacherName()+"老师教授，请检查落课数据是否正确", null);
                        }

                        teachingTaskDao.insertTeachingTask(teachingTask);
                    }
                }

                return new Message(1,"上传成功", null);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return new Message(0,"系统错误，请稍后重试", null);
    }

    /**
     * @function: 获取默认填表人
     * @author: ZhangHao
     * @date: 2018/10/27
     */
    public TeachingTask getEmpByPreparedBy(){

        try {

            List<TeachingTask> tempList = teachingTaskDao.getNewestPreparedBy();

            if(tempList != null && tempList.size() > 0){

                return tempList.get(0);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return null;
    }

    /**
     * @function: Excel导出主方法
     * @author: ZhangHao
     * @date: 2018/10/29
     */
    public Message readOutTeachingTaskData(HttpServletRequest request, HttpServletResponse response){

        OutputStream os = null;

        try {

            String deptId= request.getParameter("deptId");
            String userId = request.getParameter("userId");
            String semester = request.getParameter("semester");

            if(semester != null && !"".equals(semester)){

                String smer = sysDicDao.getDicName("XQ",semester);

                if(smer != null && !"".equals(smer)){

                    String fileName = smer+"教学任务一览";

                    response.setContentType("application/vnd.ms-excel");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(fileName+".xls", "utf-8"));
                    os = response.getOutputStream();

                    TeachingTask queryObj = new TeachingTask();
                    queryObj.setSemester(semester);
                    queryObj.setDepartment(deptId);
                    queryObj.setPreparedBy(userId);

//                    查询数据列表
                    List<TeachingTask> dataList = teachingTaskDao.getTeachingTaskList(queryObj);
//                    TeachingTask firstTeachingTask = (dataList!=null && dataList.size() >0)?dataList.get(0):new TeachingTask();
                    TeachingTask firstTeachingTask = new TeachingTask();
                    firstTeachingTask.setDepartmentName(request.getParameter("departmentShow"));
                    firstTeachingTask.setPreparedByName(request.getParameter("teacherShow"));
                    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    firstTeachingTask.setPreparedTime(simpleDateFormat.format(new Date()));
                    TeachingTaskExcelUtil tteu = new TeachingTaskExcelUtil();
                    tteu.writeTeachingTaskExcelData(os, smer, firstTeachingTask, dataList,fileName);
                }
            }

        } catch (Exception e) {

            e.printStackTrace();

        } finally {

            try {

                if(os != null){

                    os.close();
                }

            } catch (IOException ioe){

                ioe.printStackTrace();
            }
        }

        return null;
    }

    /**
     * @function: 通过学期、课程ID、班级ID获取教学计划
     * @author: ZhangHao
     * @date: 2018/10/29
     */
    public TeachingTask getTeachingTaskByClassIdAndCourseIdAndSemester(String classInfo, String courseId, String semester){

        try {

            if(classInfo != null && !"".equals(classInfo) && courseId != null && !"".equals(courseId) && semester != null && !"".equals(semester)){

                TeachingTask teachingTask = new TeachingTask();

                teachingTask.setSemester(semester);
                teachingTask.setClassInfo(classInfo);
                teachingTask.setCourseId(courseId);

                return teachingTaskDao.getTeachingTaskByClassIdAndCourseIdAndSemester(teachingTask);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return null;
    }

    /**
     * @function: 根据落课计划和考试ID验证老师能入哪科的考试成绩
     * @author: ZhangHao
     * @date: 2018/10/29
     */
    public List<Select2> checkCourseForTeacher(String teacherId, String semester, String examId){

        try {

            if(teacherId != null && !"".equals(teacherId) && semester != null && !"".equals(semester) && examId != null && !"".equals(examId)){

                TeachingTask teachingTask = new TeachingTask();

                teachingTask.setTeacherId(teacherId);
                teachingTask.setSemester(semester);

                List<ExamCourseClass> examCourseClassList = examDao.getExamCourseClassByExamId(examId);

                if(examCourseClassList != null && examCourseClassList.size() > 0){

                    List<EmpDeptRelation>  list = scoreChangeService.getEmployeeDeptByDeptIdPersonId(CommonUtil.getPersonId());

                    if(list.size()>0 || CommonUtil.getPersonId().equals("sa")){

                        List<Select2> realEcc = new ArrayList<>();

                        Select2 select = new Select2();
                        select.setId("教务处管理员没有课程限制");
                        select.setText("教务处管理员没有课程限制");

                        realEcc.add(select);

                        return realEcc;
                    }

                    List<TeachingTask> teachingTaskList = teachingTaskDao.getTeachingTaskList(teachingTask);

                    if(teachingTaskList != null && teachingTaskList.size() > 0){

                        Map<String,ExamCourseClass> eccMap = new HashMap<>();

                        for(ExamCourseClass ecc : examCourseClassList){

                            if(ecc != null){

                                eccMap.put(ecc.getCourseId(),ecc);
                            }
                        }

                        if(eccMap.size() > 0){

                            List<Select2> realEcc = new ArrayList<>();
                            List<String> noInCourse = new ArrayList<>();

                            for(TeachingTask task : teachingTaskList){

                                if(task != null){

                                    ExamCourseClass ecc = eccMap.get(task.getCourseId());

                                    if(ecc != null){

                                        if(!noInCourse.contains(task.getCourseId())){

                                            noInCourse.add(task.getCourseId());

                                            Select2 select = new Select2();
                                            select.setId(task.getCourseId());
                                            select.setText(ecc.getCourseShow()+"--"+ecc.getTrainingLevelShow());

                                            realEcc.add(select);
                                        }
                                    }
                                }
                            }

                            return realEcc;
                        }
                    }
                }
            }


        } catch (Exception e) {

            e.printStackTrace();
        }

        return null;
    }

    /**
     * @function: 通过教师ID获取落课计划学期
     * @author: ZhangHao
     * @date: 2018/10/29
     */
    public List<Select2> checkSemesterForTeacher(String teacherId){

        try {

            List<EmpDeptRelation> list = scoreChangeService.getEmployeeDeptByDeptIdPersonId(CommonUtil.getPersonId());

            if(list.size()>0 || CommonUtil.getPersonId().equals("sa")){

                List<Select2> semesterSelect = new ArrayList<>();

                Select2 select = new Select2();
                select.setId("教务处管理员没有学期限制");
                select.setText("教务处管理员没学期程限制");

                semesterSelect.add(select);

                return semesterSelect;
            }

            if(teacherId != null && !"".equals(teacherId)){

                TeachingTask teachingTask = new TeachingTask();
                teachingTask.setTeacherId(teacherId);

                List<TeachingTask> teachingTaskList = teachingTaskDao.getTeachingTaskList(teachingTask);

                if(teachingTaskList != null && teachingTaskList.size() > 0){

                    List<Select2> semesterSelect = new ArrayList<>();

                    List<String> noInTrem = new ArrayList<>();

                    for(TeachingTask tt : teachingTaskList){

                        if(tt != null){

                            if(!noInTrem.contains(tt.getSemester())){

                                noInTrem.add(tt.getSemester());

                                Select2 select = new Select2();
                                select.setId(tt.getSemester());
                                select.setText(tt.getSemesterName());

                                semesterSelect.add(select);
                            }
                        }
                    }

                    return semesterSelect;
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return null;
    }

    @Resource
    private TeachingTaskDao teachingTaskDao;

    @Autowired
    private EmpDao empDao;

    @Autowired
    private DeptDao deptDao;

    @Autowired
    private SysDicDao sysDicDao;

    @Resource
    private CourseDao courseDao;

    @Autowired
    private ClassDao classDao;

    @Autowired
    private ExamDao examDao;

    @Autowired
    private ScoreChangeService scoreChangeService;

    @Override
    public List<TeachingTask> getTeachingTaskListBydept(TeachingTask teachingTask){
        try{
            if (teachingTask != null) {
                return teachingTaskDao.getTeachingTaskListBydept(teachingTask);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

      /**
     * 通过教师编号查找教师id
     * @param staffId
     * @return
     */
      public String getPersonIdByStaffId(String staffId){ return teachingTaskDao.getPersonIdByStaffId(staffId); }
}
