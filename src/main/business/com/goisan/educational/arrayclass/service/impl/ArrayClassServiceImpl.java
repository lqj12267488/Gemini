package com.goisan.educational.arrayclass.service.impl;

import com.goisan.educational.arrayclass.bean.*;
import com.goisan.educational.arrayclass.dao.ArrayClassDao;
import com.goisan.educational.arrayclass.service.ArrayClassService;
import com.goisan.educational.courseplan.bean.CoursePlan;
import com.goisan.educational.major.bean.Major;
import com.goisan.system.bean.*;
import com.goisan.system.tools.CommonUtil;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.sql.Date;
import java.util.List;

@Service
@Transactional
public class ArrayClassServiceImpl implements ArrayClassService {
    @Resource
    private ArrayClassDao arrayClassDao;

    public List<ArrayClass> getArrayclassTeacherId(String arrayClassId){
        return arrayClassDao.getArrayclassTeacherId(arrayClassId);
    }

    public String getPlanIdByArrayClassId(String arrayClassId){
        return arrayClassDao.getPlanIdByArrayClassId(arrayClassId);
    }

    public List<ArrayClassCoursePlan> getArrayClassListBySchoolYearTermCoursePlan(ArrayClassCoursePlan arrayClassCoursePlan){
        return arrayClassDao.getArrayClassListBySchoolYearTermCoursePlan(arrayClassCoursePlan);
    }

    public List<ArrayClass> getArrayClassList(ArrayClass arrayClass) {
        return arrayClassDao.getArrayClassList(arrayClass);
    }

    public List<ArrayClassTime> getArrayClassTimeList(ArrayClassTime arrayClassTime) {
        return arrayClassDao.getArrayClassTimeList(arrayClassTime);
    }

    @Override
    public List<ArrayClassTime> checkArrayClassTimeList(ArrayClassTime arrayClassTime) {
        return arrayClassDao.checkArrayClassTimeList(arrayClassTime);
    }

    public void insertArrayClass(ArrayClass arrayClass) {
        arrayClassDao.insertArrayClass(arrayClass);
    }

    public ArrayClass getArrayClassById(String id) {
        return arrayClassDao.getArrayClassById(id);
    }

    public ArrayClassTime getArrayClassTimeById(String id) {
        return arrayClassDao.getArrayClassTimeById(id);
    }

    public void updateArrayClass(ArrayClass arrayClass) {
        arrayClassDao.updateArrayClass(arrayClass);
    }

    public void deleteArrayClassById(String id) {
        arrayClassDao.deleteArrayClassById(id);
    }

    public void editArrayClassFlagById(String id,String flag) {
        arrayClassDao.editArrayClassFlagById(id,flag);
    }

    public List<ArrayClassCourse> getArrayClassCourseList(ArrayClassCourse arrayClassCourse) {
        return arrayClassDao.getArrayClassCourseList(arrayClassCourse);
    }

    public void insertArrayClassCourse(ArrayClassCourse arrayClassCourse) {
        arrayClassDao.insertArrayClassCourse(arrayClassCourse);
    }
    public List<ArrayClassCourse> getArrayClassCourseByCourse(ArrayClassCourse arrayClassCourse){
        return arrayClassDao.getArrayClassCourseByCourse(arrayClassCourse);
    }
    public List<ArrayClassCourse> getArrayClassCourseBy(ArrayClassCourse arrayClassCourse){
        return arrayClassDao.getArrayClassCourseBy(arrayClassCourse);
    }
    public ArrayClassCourse getArrayClassCourseById(String id) {
        return arrayClassDao.getArrayClassCourseById(id);
    }

    public void updateArrayClassCourse(ArrayClassCourse arrayClassCourse) {
        arrayClassDao.updateArrayClassCourse(arrayClassCourse);
    }

    public void deleteArrayClassCourseById(String id) {
        arrayClassDao.deleteArrayClassCourseById(id);
    }

    public List<ArrayClassCourseWeek> getArrayClassCourseWeekList(ArrayClassCourseWeek arrayClassCourseWeek) {
        return arrayClassDao.getArrayClassCourseWeekList(arrayClassCourseWeek);
    }

    public void insertArrayClassCourseWeek(ArrayClassCourseWeek arrayClassCourseWeek) {
        arrayClassDao.insertArrayClassCourseWeek(arrayClassCourseWeek);
    }

    public ArrayClassCourseWeek getArrayClassCourseWeekById(String id) {
        return arrayClassDao.getArrayClassCourseWeekById(id);
    }

    public void updateArrayClassCourseWeek(ArrayClassCourseWeek arrayClassCourseWeek) {
        arrayClassDao.updateArrayClassCourseWeek(arrayClassCourseWeek);
    }

    public void deleteArrayClassCourseWeekById(String id) {
        arrayClassDao.deleteArrayClassCourseWeekById(id);
    }

    public ArrayClassTeacher getArrayClassTeacherByid(String id) {
        return arrayClassDao.getArrayClassTeacherByid(id);
    }

    public List<Tree> getALLClassTree() {
        return arrayClassDao.getALLClassTree();
    }

    public List<Tree> getClassTreeByDepartmentId(String id) {
        return arrayClassDao.getClassTreeByDepartmentId(id);
    }

    public List<ArrayClassCourseWeekClass> getSelectedClassById(String id) {
        return arrayClassDao.getSelectedClassById(id);
    }

    public void deleteOriginalCourseClass(String id) {
        arrayClassDao.deleteOriginalCourseClass(id);
    }

    public List<Dept> chooseDeptList(@Param(value = "id")String id) {
        return arrayClassDao.chooseDeptList(id);
    }

    public List<Major> chooseMajorList(@Param(value = "dept_id")String dept_id, @Param(value = "id") String id) {
        return arrayClassDao.chooseMajorList(dept_id,id);
    }

    public List<ClassBean> chooseClassList(@Param(value = "majorCode")String majorCode, @Param(value = "id") String id) {
        return arrayClassDao.chooseClassList(majorCode,id);
    }

    public void insertClass(ArrayClassCourseWeekClass arrayClassCourseWeekClass) {
        arrayClassDao.insertClass(arrayClassCourseWeekClass);
    }

    public List<Select2> getClassTree(String roomType) {
        return arrayClassDao.getClassTree(roomType);
    }

    public List<CoursePlan> checkCoursePlanForArrayClass() {
        return arrayClassDao.checkCoursePlanForArrayClass();
    }

    public List<ArrayClass> getArrayClassId() {
        return arrayClassDao.getArrayClassId();
    }

    public List<ArrayclassArray> getArrayClassArray(String arrayclassId) {
        return arrayClassDao.getArrayClassArray(arrayclassId);
    }

    public void insertCoursePlanForArrayClassCoursePublic(ArrayClassCourse arrayClassCourse) {
        arrayClassDao.insertCoursePlanForArrayClassCoursePublic(arrayClassCourse);
    }

    public void insertCoursePlanForArrayClassCourse(ArrayClassCourse arrayClassCourse) {
        arrayClassDao.insertCoursePlanForArrayClassCourse(arrayClassCourse);
    }

    public void insertCoursePlanForArrayClassResultClass(ArrayclassResultClass arrayclassResultClass) {
        arrayClassDao.insertCoursePlanForArrayClassResultClass(arrayclassResultClass);
    }

    public void insertCoursePlanForArrayClassClass(@Param(value = "arrayClassClass")ArrayClassClass arrayClassClass, @Param(value = "planId") String planId) {
        arrayClassDao.insertCoursePlanForArrayClassClass(arrayClassClass,planId);
    }

    public void insertCoursePlanForArrayClassRoom(@Param(value = "arrayClassRoom")ArrayClassRoom arrayClassRoom, @Param(value = "planId") String planId) {
        arrayClassDao.insertCoursePlanForArrayClassRoom(arrayClassRoom,planId);
    }

    public void insertCoursePlanForArrayClassTeacherCoursePublic(@Param(value = "arrayClassTeacherCourse")ArrayClassTeacherCourse arrayClassTeacherCourse, @Param(value = "planId") String planId) {
        arrayClassDao.insertCoursePlanForArrayClassTeacherCoursePublic(arrayClassTeacherCourse,planId);
    }

    public void insertCoursePlanForArrayClassTeacherCourse(@Param(value = "arrayClassTeacherCourse")ArrayClassTeacherCourse arrayClassTeacherCourse, @Param(value = "planId") String planId) {
        arrayClassDao.insertCoursePlanForArrayClassTeacherCourse(arrayClassTeacherCourse,planId);
    }

    public void insertCoursePlanForArrayClassTeacher(@Param(value = "arrayClassTeacher")ArrayClassTeacher arrayClassTeacher, @Param(value = "planId") String planId) {
        arrayClassDao.insertCoursePlanForArrayClassTeacher(arrayClassTeacher,planId);
    }

    public void exportCoursePlan(@Param(value = "arrayClassTeacher")ArrayClassTeacher arrayClassTeacher, @Param(value = "arrayClassClass") ArrayClassClass arrayClassClass,
                                 @Param(value = "arrayClassTeacherCourse") ArrayClassTeacherCourse arrayClassTeacherCourse, @Param(value = "arrayClassTeacherCourse") ArrayClassTeacherCourse arrayClassTeacherCoursePublic, @Param(value = "arrayClassRoom") ArrayClassRoom arrayClassRoom,
                                 ArrayClassCourse arrayClassCourse, ArrayClassCourse arrayClassCoursePublic, ArrayclassResultClass arrayclassResultClass, @Param(value = "arrayclassArray")ArrayclassArray arrayclassArray,
                                 String arr_planId, String arrayClassId) {
        String planID = "";
        String arrayclassTeacherId1= "";
        arrayClassDao.deleteCoursePlanForArrayClassTeacher(arrayClassId);
        arrayClassDao.deleteCoursePlanForArrayClassCourse(arrayClassId);
        arrayClassDao.deleteCoursePlanForArrayClassClass(arrayClassId);
        arrayClassDao.deleteCoursePlanForArrayClassRoom(arrayClassId);
        arrayClassDao.deleteCoursePlanForArrayClassTeacherCourse(arrayClassId);
        arrayClassDao.deleteCoursePlanForArrayClassArray(arrayClassId);
        List<ArrayClassCoursePlan> arrayClassCoursePlan = arrayClassDao.getArrayClassPlan(arrayClassId);
        for (int i = 0; i < arrayClassCoursePlan.size(); i++) {
            planID += arrayClassCoursePlan.get(i).getPlanId() + ",";
        }
        String[] planId = planID.split(",");
        for (int i = 0; i < planId.length; i++) {
            arrayClassCourse.setPlanId(planId[i]);
            arrayClassCoursePublic.setPlanId(planId[i]);
            /*arrayClassTeacherCourse.setId(CommonUtil.getUUID());
            arrayClassTeacherCoursePublic.setId(CommonUtil.getUUID());
            arrayclassArray.setArrayId(CommonUtil.getUUID());
            arrayClassRoom.setId(CommonUtil.getUUID());
            arrayClassCourse.setArrayClassCourseId(CommonUtil.getUUID());
            arrayClassCoursePublic.setArrayClassCourseId(CommonUtil.getUUID());
            arrayClassClass.setArrayclassClassId(CommonUtil.getUUID());
            arrayClassTeacher.setArrayclassTeacherId(CommonUtil.getUUID());
            arrayclassResultClass.setId(CommonUtil.getUUID());*/

            arrayClassDao.insertCoursePlanForArrayClassCourse(arrayClassCourse);
            arrayClassDao.insertCoursePlanForArrayClassCoursePublic(arrayClassCoursePublic);
            arrayClassDao.insertCoursePlanForArrayClassClass(arrayClassClass,planId[i]);
            arrayClassDao.insertCoursePlanForArrayClassRoom(arrayClassRoom,planId[i]);
            arrayClassDao.insertCoursePlanForArrayClassTeacher(arrayClassTeacher,planId[i]);
            arrayClassDao.insertCoursePlanForArrayClassTeacherCoursePublic(arrayClassTeacherCoursePublic,planId[i]);
            /*arrayClassDao.insertCoursePlanForArrayClassTeacherCourse(arrayClassTeacherCourse,planId[i]);*/
            arrayClassDao.insertCoursePlanForArrayClassArray(arrayclassArray,planId[i]);
        }
        /**
         * 将T_JW_ARRAYCLASS_ARRAY表中WeekHours字段拆分存到T_JW_ARRAYCLASS_RESULT_CLASS表中
         */
        /*String arr_weekHours = "";
        List<ArrayclassArray> list = arrayClassDao.getArrayClassArray(arrayClassId);
        for (int i = 0; i < list.size(); i++) {
            arr_weekHours += list.get(i).getWeekHours() + ",";
        }
        String[] weekHours = arr_weekHours.split(",");
        for (int i = 0; i < list.size(); i++) {
            for (int j = 0; j < Integer.parseInt(weekHours[i]); j++) {
                arrayClassDao.insertCoursePlanForArrayClassResultClass(arrayclassResultClass);
            }
        }*/
    }

    public List getArrayClassPlan(String id) {
        return arrayClassDao.getArrayClassPlan(id);
    }

    public void deleteCoursePlanForArrayClassCourse(String arrayClassId) {
        arrayClassDao.deleteCoursePlanForArrayClassCourse(arrayClassId);
    }

    public void deleteCoursePlanForArrayClassClass(String arrayClassId) {
        arrayClassDao.deleteCoursePlanForArrayClassClass(arrayClassId);
    }

    public void deleteCoursePlanForArrayClassRoom(String arrayClassId) {
        arrayClassDao.deleteCoursePlanForArrayClassRoom(arrayClassId);
    }

    public void deleteCoursePlanForArrayClassTeacherCourse(String arrayClassId) {
        arrayClassDao.deleteCoursePlanForArrayClassTeacherCourse(arrayClassId);
    }

    public void deleteCoursePlanForArrayClassTeacher(String arrayClassId) {
        arrayClassDao.deleteCoursePlanForArrayClassTeacher(arrayClassId);
    }

    public void deleteCoursePlan(String arrayClassId) {
        arrayClassDao.deleteCoursePlanForArrayClassTeacher(arrayClassId);
        arrayClassDao.deleteCoursePlanForArrayClassCourse(arrayClassId);
        arrayClassDao.deleteCoursePlanForArrayClassClass(arrayClassId);
        arrayClassDao.deleteCoursePlanForArrayClassRoom(arrayClassId);
        arrayClassDao.deleteCoursePlanForArrayClassTeacherCourse(arrayClassId);
        arrayClassDao.deleteCoursePlanForArrayClassArray(arrayClassId);
    }

    public List<ArrayClassCoursePlan> getArrayClassCoursePlanList(ArrayClassCoursePlan arrayClassCoursePlan) {
        return arrayClassDao.getArrayClassCoursePlanList(arrayClassCoursePlan);
    }

    public ArrayClassCoursePlan getArrayClassCoursePlanById(String id) {
        return arrayClassDao.getArrayClassCoursePlanById(id);
    }

    public void deleteArrayClassCoursePlan(String id) {
        arrayClassDao.deleteArrayClassCoursePlan(id);
    }

    public void insertArrayClassCoursePlan(ArrayClassCoursePlan arrayClassCoursePlan) {
        arrayClassDao.insertArrayClassCoursePlan(arrayClassCoursePlan);
    }

    public void inserCoursePlan(ArrayClassCoursePlan arrayClassCoursePlan) {
        arrayClassDao.inserCoursePlan(arrayClassCoursePlan);
    }

    public void updateArrayClassCoursePlan(ArrayClassCoursePlan arrayClassCoursePlan) {
        arrayClassDao.updateArrayClassCoursePlan(arrayClassCoursePlan);
    }

    public void insertArrayClassTime(ArrayClassTime arrayClassTime) {
        arrayClassDao.insertArrayClassTime(arrayClassTime);
    }

    public void deleteArrayClassTimeById(String id) {
        arrayClassDao.deleteArrayClassTimeById(id);
    }

    public void updateArrayClassTime(ArrayClassTime arrayClassTime) {
        arrayClassDao.updateArrayClassTime(arrayClassTime);
    }
    public String getCourseTypeById(String id){
        return arrayClassDao.getCourseTypeById(id);
    }
    //排课班级设置
    public List<BaseBean> getArrayClassClassList(BaseBean baseBean) {
        return arrayClassDao.getArrayClassClassList(baseBean);
    }

    public void saveArrayClassClass(BaseBean baseBean) {
        arrayClassDao.saveArrayClassClass(baseBean);
    }

    public BaseBean getArrayClassClassById(String id) {
        return arrayClassDao.getArrayClassClassById(id);
    }

    public void updateArrayClassClass(BaseBean baseBean) {
        arrayClassDao.updateArrayClassClass(baseBean);
    }

    public void delArrayClassClass(String id) {
        arrayClassDao.delArrayClassClass(id);
    }

    public ArrayClassClass selectArrayClassClassById(String id){
        return arrayClassDao.selectArrayClassClassById(id);
    }
    //排课禁排学时
    public List<ArrayClassCondition> getArrayClassConditionList(ArrayClassCondition arrayClassCondition){
        return arrayClassDao.getArrayClassConditionList(arrayClassCondition);
    }

    public void insertArrayClassCondition(ArrayClassCondition arrayClassCondition){
        arrayClassDao.insertArrayClassCondition(arrayClassCondition);
    }

    public void updateArrayClassCondition(ArrayClassCondition arrayClassCondition){
        arrayClassDao.updateArrayClassCondition(arrayClassCondition);
    }

    public void deleteArrayClassCondition(String id){
        arrayClassDao.deleteArrayClassCondition(id);
    }

    public List<ArrayClassCondition> getArrayClassConditionByCondition(ArrayClassCondition arrayClassCondition){
        return arrayClassDao.getArrayClassConditionByCondition(arrayClassCondition);
    }

    public ArrayClassCondition getArrayClassConditionById(String id){
        return arrayClassDao.getArrayClassConditionById(id);
    }

    public String selectConditionName(ArrayClassCondition arrayClassCondition){
       if(arrayClassCondition.getElementsType().equals("1")){
           return arrayClassDao.selectClassId(arrayClassCondition.getElementsId());
       }else if(arrayClassCondition.getElementsType().equals("3")){
           return arrayClassDao.selectCourseId(arrayClassCondition.getElementsId());
       }else if(arrayClassCondition.getElementsType().equals("2")){
           return arrayClassDao.selectTeacherPerson(arrayClassCondition.getElementsId());
       }else{
           return arrayClassDao.selectRoomName(arrayClassCondition.getElementsId());
       }
    }

    public String selectClassId(String elementsId){
        return arrayClassDao.selectClassId(elementsId);
    }

    public String selectCourseId(String elementsId){
        return arrayClassDao.selectCourseId(elementsId);
    }

    public String selectTeacherPerson(String elementsId){
        return arrayClassDao.selectTeacherPerson(elementsId);
    }

    public String selectRoomName(String elementsId){
        return arrayClassDao.selectRoomName(elementsId);
    }
    //<!--Begin wq-->
    //排课场地设置  create: wq 2017/08/11
    public List<ArrayClassRoom> getArrayClassRoomList(ArrayClassRoom arrayClassRoom) {
        return arrayClassDao.getArrayClassRoomList(arrayClassRoom);
    }

    public void insertArrayClassRoom(ArrayClassRoom arrayClassRoom) {
        arrayClassDao.insertArrayClassRoom(arrayClassRoom);
    }

    public ArrayClassRoom getArrayClassRoomById(String id) {
        return arrayClassDao.getArrayClassRoomById(id);
    }

    public void updateArrayClassRoom(ArrayClassRoom arrayClassRoom) {
        arrayClassDao.updateArrayClassRoom(arrayClassRoom);
    }

    public void deleteArrayClassRoomById(String id) {
        arrayClassDao.deleteArrayClassRoomById(id);
    }

    public List<ArrayClassRoom> checkRoom(ArrayClassRoom arrayClassRoom) {
        return arrayClassDao.checkRoom(arrayClassRoom);
    }

    public void deleteArrayClassRoomBatch(String arrayClassId) {
        arrayClassDao.deleteArrayClassRoomBatch(arrayClassId);
    }

    public void addArrayClassRoomBatch(ArrayClassRoom arrayClassRoom) {
        Date date = new Date(new java.util.Date().getTime());
        arrayClassDao.addArrayClassRoomBatch(date,arrayClassRoom.getArrayClassId(),arrayClassRoom.getCreator(),arrayClassRoom.getCreateDept());
    }

    //排课教师设置 modify: wq 2017/08/23
    public List<ArrayClassTeacher> getArrayClassTeacher(ArrayClassTeacher arrayClassTeacher){
        return arrayClassDao.getArrayClassTeacher(arrayClassTeacher);
    }

    public void saveArrayClassTeacher(ArrayClassTeacher arrayClassTeacher){
        arrayClassDao.saveArrayClassTeacher(arrayClassTeacher);
    }

    public void delArrayClassTeacher(String arrayclassTeacherId){
        arrayClassDao.delArrayClassTeacher(arrayclassTeacherId);
    }

    public ArrayClassTeacher getArrayClassTeacherById(String arrayclassTeacherId){
        return arrayClassDao.getArrayClassTeacherById(arrayclassTeacherId);
    }

    public void updateArrayClassTeacher(ArrayClassTeacher arrayClassTeacher){
        arrayClassDao.updateArrayClassTeacher(arrayClassTeacher);
    }

    public List<ArrayClassTeacher> checkTeacher(ArrayClassTeacher arrayClassTeacher) {
        return arrayClassDao.checkTeacher(arrayClassTeacher);
    }
    //排课教师任课课程设置 create: wq 2017/08/23
    public List<ArrayClassTeacherCourse> getArrayClassTeacherCourseList(ArrayClassTeacherCourse arrayClassTeacherCourse) {
        return arrayClassDao.getArrayClassTeacherCourseList(arrayClassTeacherCourse);
    }

    public void insertArrayClassTeacherCourse(ArrayClassTeacherCourse arrayClassTeacherCourse) {
        arrayClassDao.insertArrayClassTeacherCourse(arrayClassTeacherCourse);
    }

    public ArrayClassTeacherCourse getArrayClassTeacherCourseById(String id) {
        return arrayClassDao.getArrayClassTeacherCourseById(id);
    }

    public void updateArrayClassTeacherCourse(ArrayClassTeacherCourse arrayClassTeacherCourse) {
        arrayClassDao.updateArrayClassTeacherCourse(arrayClassTeacherCourse);
    }

    public void deleteArrayClassTeacherCourseById(String id) {
        arrayClassDao.deleteArrayClassTeacherCourseById(id);
    }

    public ArrayClassCourse getCourseById(ArrayClassCourse arrayClassCourse) {
        return arrayClassDao.getCourseById(arrayClassCourse);
    }
// <!--end wq-->
    /*
    * yangshuang
    * */
    public List<BaseBean> getSchedule() {
        String empId = CommonUtil.getPersonId();
        return arrayClassDao.getSchedule(empId);
    }

    public List<BaseBean> getStudentSchedule() {
        LoginUser LoginUser = CommonUtil.getLoginUser();
        String empId = LoginUser.getPersonId();
        if(LoginUser.getUserType().equals("2")){
            empId = LoginUser.getDefaultDeptId();
        }
        return arrayClassDao.getStudentSchedule(empId);
    }

}
