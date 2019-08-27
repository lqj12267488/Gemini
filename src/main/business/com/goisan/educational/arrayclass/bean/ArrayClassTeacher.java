package com.goisan.educational.arrayclass.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by admin on 2017/8/10.
 modify: wq 2017/08/23
 */
public class ArrayClassTeacher extends BaseBean {
    private String arrayclassTeacherId;
    private String arrayclassId;
    private String teacherPersonId;
    private String teacherPersonShow;
    private String teacherDeptId;
    private String courseId;

    public String getArrayclassTeacherId() {
        return arrayclassTeacherId;
    }

    public void setArrayclassTeacherId(String arrayclassTeacherId) {
        this.arrayclassTeacherId = arrayclassTeacherId;
    }

    public String getArrayclassId() {
        return arrayclassId;
    }

    public void setArrayclassId(String arrayclassId) {
        this.arrayclassId = arrayclassId;
    }

    public String getTeacherPersonId() {
        return teacherPersonId;
    }

    public void setTeacherPersonId(String teacherPersonId) {
        this.teacherPersonId = teacherPersonId;
    }

    public String getTeacherPersonShow() {
        return teacherPersonShow;
    }

    public void setTeacherPersonShow(String teacherPersonShow) {
        this.teacherPersonShow = teacherPersonShow;
    }

    public String getTeacherDeptId() {
        return teacherDeptId;
    }

    public void setTeacherDeptId(String teacherDeptId) {
        this.teacherDeptId = teacherDeptId;
    }

    public String getCourseId() {
        return courseId;
    }

    public void setCourseId(String courseId) {
        this.courseId = courseId;
    }

}
