package com.goisan.studentwork.dormitory.service.impl;

import com.goisan.educational.place.dorm.bean.Dorm;
import com.goisan.studentwork.dormitory.bean.DormAdjustLog;
import com.goisan.studentwork.dormitory.bean.DormAdjustResult;
import com.goisan.studentwork.dormitory.bean.DormAway;
import com.goisan.studentwork.dormitory.dao.DormAdjustResultDao;
import com.goisan.studentwork.dormitory.service.DormAdjustResultService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.ClassBean;
import com.goisan.system.bean.Student;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by mcq on 2017/8/21.
 */
@Service
public class DormAdjustResultServiceImpl implements DormAdjustResultService {
    @Resource
    private DormAdjustResultDao dormAdjustResultDao;

    public List<Student> getDistributeList(Student student) {
        return dormAdjustResultDao.getDistributeList(student);
    }

    public List<DormAdjustResult> getAdjustmentList(DormAdjustResult dormAdjustResult) {
        return dormAdjustResultDao.getAdjustmentList(dormAdjustResult);
    }

    public List<Student> getStudentByValue(String check_value) {
        return dormAdjustResultDao.getStudentByValue(check_value);
    }

    public List<Student> getStudentByIds(String ids) {
        return dormAdjustResultDao.getStudentByIds(ids);
    }

    public Student selectStudentByValue(String check_value) {
        return dormAdjustResultDao.selectStudentByValue(check_value);
    }


    public void insertDormAdjustResult(DormAdjustResult dormAdjustResult) {
        dormAdjustResultDao.insertDormAdjustResult(dormAdjustResult);
    }

    public void insertDormAdjustLog(DormAdjustLog dormAdjustLog) {
        dormAdjustResultDao.insertDormAdjustLog(dormAdjustLog);
    }

    public void updateStudentDormFlag(Student student) {
        dormAdjustResultDao.updateStudentDormFlag(student);
    }

    public void updateDormNowNumber(Dorm dorm) {
        dormAdjustResultDao.updateDormNowNumber(dorm);
    }

    public String getDormOverplusNumber(String dormId) {
        return dormAdjustResultDao.getDormOverplusNumber(dormId);
    }

    public String getDormOriginalNowNumber(String dormId) {
        return dormAdjustResultDao.getDormOriginalNowNumber(dormId);
    }

    public void updateDormAdjustResult(DormAdjustResult dormAdjustResult) {
        dormAdjustResultDao.updateDormAdjustResult(dormAdjustResult);
    }

    public void updateDormAdjustLog(DormAdjustLog dormAdjustLog) {
        dormAdjustResultDao.updateDormAdjustLog(dormAdjustLog);
    }

    public void delDormAdjustResultById(String ids) {
        dormAdjustResultDao.delDormAdjustResultById(ids);
    }

    public List<AutoComplete> autoCompleteStudentClassDorm() {
        return dormAdjustResultDao.autoCompleteStudentClassDorm();
    }

    public void updateOneStudentDormFlag(Student student) {
        dormAdjustResultDao.updateOneStudentDormFlag(student);
    }

    public String getDormType(String dormId) {
        return dormAdjustResultDao.getDormType(dormId);
    }

    public String getDormName(String dormId) {
        return dormAdjustResultDao.getDormName(dormId);
    }

    public List<DormAdjustResult> selectDormAdjustResultByStudentId(String ids) {
        return dormAdjustResultDao.selectDormAdjustResultByStudentId(ids);
    }

    public List<DormAdjustLog> getLogList(String id) {
        return dormAdjustResultDao.getLogList(id);
    }

    public String getClassIdByStudentId(String id) {
        return dormAdjustResultDao.getClassIdByStudentId(id);
    }

    public void updateDormAdjustResult(String dormId, String id, String qsid) {
        String dormName=dormAdjustResultDao.getDormName(dormId);
        String qsName=dormAdjustResultDao.getDormName(qsid);
        String classId= dormAdjustResultDao.getClassIdByStudentId(id);
        //更新寝室分配结果表
        DormAdjustResult dormAdjustResult=new DormAdjustResult();
        CommonUtil.update(dormAdjustResult);
        dormAdjustResult.setStudentId(id);
        dormAdjustResult.setDormId(qsid);
        dormAdjustResult.setDormFlag("2");
        dormAdjustResultDao.updateDormAdjustResult(dormAdjustResult);
        //插入寝室分配日志表(转入寝室)
        DormAdjustLog inDormAdjustLog=new DormAdjustLog();
        CommonUtil.save(inDormAdjustLog);
        inDormAdjustLog.setDormId(dormId);
        inDormAdjustLog.setStudentId(id);
        inDormAdjustLog.setClassId(classId);
        inDormAdjustLog.setLogType("4");
        inDormAdjustLog.setContent("从"+qsName+"调至"+dormName+"");
        dormAdjustResultDao.insertDormAdjustLog(inDormAdjustLog);
        //插入寝室分配日志表(转出寝室)
        DormAdjustLog  outDormAdjustLog=new DormAdjustLog();
        CommonUtil.save(outDormAdjustLog);
        outDormAdjustLog.setDormId(qsid);
        outDormAdjustLog.setClassId(classId);
        outDormAdjustLog.setStudentId(id);
        outDormAdjustLog.setLogType("4");
        outDormAdjustLog.setContent("从"+qsName+"调至"+dormName+"");
        dormAdjustResultDao.insertDormAdjustLog(outDormAdjustLog);
        //更新学生表
        Student student=new Student();
        student.setStudentId(id);
        student.setDormFlag("2");
        CommonUtil.update(student);
        dormAdjustResultDao.updateOneStudentDormFlag(student);
        //更新寝室表
        String oldNowNumber =dormAdjustResultDao.getDormOriginalNowNumber(dormId);
        String newNowNumber =dormAdjustResultDao.getDormOriginalNowNumber(qsid);
        //新寝室更新
        Dorm newDorm=new Dorm();
        newDorm.setId(qsid);
        newDorm.setNowNumber(String.valueOf(Integer.parseInt(newNowNumber)+1));
        //老寝室更新
        Dorm oldDorm=new Dorm();
        oldDorm.setNowNumber(String.valueOf(Integer.parseInt(oldNowNumber)-1));
        oldDorm.setId(dormId);
        dormAdjustResultDao.updateDormNowNumber(newDorm);
        dormAdjustResultDao.updateDormNowNumber(oldDorm);
    }

    public void saveDoublePerpleAdjust(String firstStudent, String firstClass, String firstDorm, String secondStudent, String secondClass, String secondDorm) {
        String firstDormName=dormAdjustResultDao.getDormName(firstDorm);
        String seconDormdName=dormAdjustResultDao.getDormName(secondDorm);
        //更新寝室分配结果表第一个学生更新
        DormAdjustResult firstStudentAdjust=new DormAdjustResult();
        DormAdjustResult secondStudentAdjust=new DormAdjustResult();
        CommonUtil.update(firstStudentAdjust);
        CommonUtil.update(secondStudentAdjust);
        firstStudentAdjust.setStudentId(firstStudent);
        firstStudentAdjust.setDormId(secondDorm);
        firstStudentAdjust.setDormFlag("2");
        dormAdjustResultDao.updateDormAdjustResult(firstStudentAdjust);
        //更新寝室分配结果表第二个学生更新
        secondStudentAdjust.setStudentId(secondStudent);
        secondStudentAdjust.setDormId(firstDorm);
        secondStudentAdjust.setDormFlag("2");
        dormAdjustResultDao.updateDormAdjustResult(secondStudentAdjust);

        //插入寝室分配日志表第一个学生更新
        DormAdjustLog firstStudentLog=new DormAdjustLog();
        CommonUtil.save(firstStudentLog);
        firstStudentLog.setLogId(CommonUtil.getUUID());
        firstStudentLog.setStudentId(firstStudent);
        firstStudentLog.setClassId(firstClass);
        firstStudentLog.setDormId(secondDorm);
        firstStudentLog.setLogType("4");
        firstStudentLog.setContent("从"+firstDormName+"调至"+seconDormdName+"");
        dormAdjustResultDao.insertDormAdjustLog(firstStudentLog);
        //插入寝室分配日志表第二个学生更新
        DormAdjustLog secondStudentLog=new DormAdjustLog();
        CommonUtil.save(secondStudentLog);
        secondStudentLog.setStudentId(secondStudent);
        secondStudentLog.setClassId(secondClass);
        secondStudentLog.setDormId(firstDorm);
        secondStudentLog.setLogType("4");
        secondStudentLog.setContent("从"+seconDormdName+"调至"+firstDormName+"");
        dormAdjustResultDao.insertDormAdjustLog(secondStudentLog);
    }

    public void saveDoubleDormAdjust(String firstDorm, String secondDorm, String firstMemberId, String secondMemberId) {
        String firstDormName=dormAdjustResultDao.getDormName(firstDorm);
        String seconDormdName=dormAdjustResultDao.getDormName(secondDorm);
        String firstArray[]=firstMemberId.split(",");
        String secondArray[]=secondMemberId.split(",");
        for(int i=0;i<firstArray.length;i++){
            String first=firstArray[i];
            String firstStudent=  first.substring(0,18);
            String firstStudentClass=  first.substring(19,first.length());
            //更新寝室分配结果表第一个学生更新
            DormAdjustResult firstStudentAdjust=new DormAdjustResult();
            CommonUtil.update(firstStudentAdjust);
            firstStudentAdjust.setStudentId(firstStudent);
            firstStudentAdjust.setDormId(secondDorm);
            firstStudentAdjust.setDormFlag("2");
            dormAdjustResultDao.updateDormAdjustResult(firstStudentAdjust);
            //插入寝室分配日志表第一个学生更新
            DormAdjustLog firstStudentLog=new DormAdjustLog();
            CommonUtil.save(firstStudentLog);
            firstStudentLog.setLogId(CommonUtil.getUUID());
            firstStudentLog.setStudentId(firstStudent);
            firstStudentLog.setClassId(firstStudentClass);
            firstStudentLog.setDormId(secondDorm);
            firstStudentLog.setLogType("4");
            firstStudentLog.setContent("从"+firstDormName+"调至"+seconDormdName+"");
            dormAdjustResultDao.insertDormAdjustLog(firstStudentLog);

        }
        for(int j=0;j<secondArray.length;j++){
            String second=secondArray[j];
            String secondStudent=  second.substring(0,18);
            String secondStudentClass=  second.substring(19,second.length());
            //更新寝室分配结果表第二个学生更新
            DormAdjustResult secondStudentAdjust=new DormAdjustResult();
            CommonUtil.update(secondStudentAdjust);
            secondStudentAdjust.setStudentId(secondStudent);
            secondStudentAdjust.setDormId(firstDorm);
            secondStudentAdjust.setDormFlag("2");
            dormAdjustResultDao.updateDormAdjustResult(secondStudentAdjust);
            //更新寝室分配日志表第二个学生更新
            DormAdjustLog secondStudentLog=new DormAdjustLog();
            CommonUtil.save(secondStudentLog);
            secondStudentLog.setStudentId(secondStudent);
            secondStudentLog.setClassId(secondStudentClass);
            secondStudentLog.setDormId(firstDorm);
            secondStudentLog.setLogType("4");
            secondStudentLog.setContent("从"+seconDormdName+"调至"+firstDormName+"");
            dormAdjustResultDao.insertDormAdjustLog(secondStudentLog);


        }
    }

    public void saveBackDorm(String ids, String check_value, String backType, String backTypeText) {
        List<DormAdjustResult> list=dormAdjustResultDao.selectDormAdjustResultByStudentId(ids);
        String studentId="";
        String classId="";
        String dormId="";
        String name="";
        //更新学生表
        Student student=new Student();
        student.setDormFlag(backType);
        student.setStudentId(ids);
        CommonUtil.update(student);
        dormAdjustResultDao.updateStudentDormFlag(student);
        //删除学生寝室分配结果表
        dormAdjustResultDao.delDormAdjustResultById(ids);

        for(int i=0;i<list.size();i++){
            studentId=list.get(i).getStudentId();
            classId=list.get(i).getClassId();
            dormId=list.get(i).getDormId();
            name=list.get(i).getStudentName();
            //插入学生寝室分配日志表
            DormAdjustLog studentLog=new DormAdjustLog();
            studentLog.setLogId(CommonUtil.getUUID());
            CommonUtil.save(studentLog);
            studentLog.setStudentId(studentId);
            studentLog.setClassId(classId);
            studentLog.setDormId(dormId);
            studentLog.setLogType(backType);
            SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
            String date = formatDate.format(new Date());
            studentLog.setContent(""+name+"在"+date+""+backTypeText+"");
            CommonUtil.save(studentLog);
            dormAdjustResultDao.insertDormAdjustLog(studentLog);
            //更新寝室表
            String oldNowNumber =dormAdjustResultDao.getDormOriginalNowNumber(dormId);
            Dorm dorm=new Dorm();
            dorm.setId(dormId);
            dorm.setNowNumber(String.valueOf(Integer.parseInt(oldNowNumber)-1));
            dormAdjustResultDao.updateDormNowNumber(dorm);

        }

    }

    public void saveDormAdjustResult(String dormId, String check_value, String count) {
        String dormName=dormAdjustResultDao.getDormName(dormId);
        List<Student>studentList=dormAdjustResultDao.getStudentByIds(check_value);
        int oldCount= Integer.parseInt(count);
        DormAdjustResult dormAdjustResult=new DormAdjustResult();
        Student student=new Student();
        Dorm dorm=new Dorm();
        DormAdjustLog dormAdjustLog=new DormAdjustLog();
        String student_id="";
        String classId="";
        String className="";
        String studentName="";
        if(studentList.size()>0){
            for(int j=0;j<studentList.size();j++){
                //插入寝室分配结果表
                classId=studentList.get(j).getClassId();
                studentName=studentList.get(j).getName();
                student_id=studentList.get(j).getStudentId();
                dormAdjustResult.setId(CommonUtil.getUUID());
                dormAdjustResult.setDormFlag("1");
                dormAdjustResult.setDormId(dormId);
                dormAdjustResult.setClassId(classId);
                dormAdjustResult.setStudentId(student_id);
                CommonUtil.save(dormAdjustResult);
                dormAdjustResultDao.insertDormAdjustResult(dormAdjustResult);
                //插入寝室分配日志表
                CommonUtil.save(dormAdjustLog);
                dormAdjustLog.setLogId(CommonUtil.getUUID());
                dormAdjustLog.setClassId(classId);
                dormAdjustLog.setDormId(dormId);
                dormAdjustLog.setStudentId(student_id);
                dormAdjustLog.setLogType("1");
                SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
                String date = formatDate.format(new Date());
                dormAdjustLog.setContent(""+studentName+"在"+date+"被分到"+dormName+"");
                dormAdjustResultDao.insertDormAdjustLog(dormAdjustLog);
            }

            //更新学生表
            student.setStudentId(check_value);
            student.setDormFlag("1");
            CommonUtil.update(student);
            dormAdjustResultDao.updateStudentDormFlag(student);
            //更新寝室表(如果原来没人直接更新,有人加上原有的)
            String nowNumber =dormAdjustResultDao.getDormOriginalNowNumber(dormId);
            int newCount= Integer.parseInt(nowNumber);
            int allCount=oldCount+newCount;
            if("0".equals(nowNumber)){
                dorm.setNowNumber(count);
                dorm.setId(dormId);
                dormAdjustResultDao.updateDormNowNumber(dorm);
            }else{
                dorm.setNowNumber(String.valueOf(allCount));
                dorm.setId(dormId);
                dormAdjustResultDao.updateDormNowNumber(dorm);

            }

        }
    }

    @Override
    public List<DormAway> getAwayList(DormAway dormAway) {
        return dormAdjustResultDao.getAwayList(dormAway);
    }

    @Override
    public List<AutoComplete> autoCompleteStudentByAway(String classId) {
        return dormAdjustResultDao.autoCompleteStudentByAway(classId);
    }

    @Override
    public String getDormNumberByAway(String studentId) {
        return dormAdjustResultDao.getDormNumberByAway(studentId);
    }

    @Override
    public void saveAwayDorm(DormAway dormAway) {
        dormAdjustResultDao.saveAwayDorm(dormAway);
    }


}
