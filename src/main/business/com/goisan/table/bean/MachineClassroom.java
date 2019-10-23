package com.goisan.table.bean;

import com.goisan.system.bean.BaseBean;

public class MachineClassroom extends BaseBean {

    /**主键id*/
    private String id;

    /**阅览室座位数（个）*/
    private String readingRoomSeat;

    /**计算机数合计*/
    private String computerNumber;

    /**教学用计算机*/
    private String teachingComputer;

    /**平板电脑*/
    private String tabletPc;

    /**公共机房*/
    private String publicComputerRoom;

    /**专业机房*/
    private String professionalComputer;

    /**教室（间）*/
    private String classroom;

    /**网络多媒体教室*/
    private String multimediaClassroom;

    /**年份*/
    private String year;

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getReadingRoomSeat() {
        return readingRoomSeat;
    }

    public void setReadingRoomSeat(String readingRoomSeat) {
        this.readingRoomSeat = readingRoomSeat;
    }

    public String getComputerNumber() {
        return computerNumber;
    }

    public void setComputerNumber(String computerNumber) {
        this.computerNumber = computerNumber;
    }

    public String getTeachingComputer() {
        return teachingComputer;
    }

    public void setTeachingComputer(String teachingComputer) {
        this.teachingComputer = teachingComputer;
    }

    public String getTabletPc() {
        return tabletPc;
    }

    public void setTabletPc(String tabletPc) {
        this.tabletPc = tabletPc;
    }

    public String getPublicComputerRoom() {
        return publicComputerRoom;
    }

    public void setPublicComputerRoom(String publicComputerRoom) {
        this.publicComputerRoom = publicComputerRoom;
    }

    public String getProfessionalComputer() {
        return professionalComputer;
    }

    public void setProfessionalComputer(String professionalComputer) {
        this.professionalComputer = professionalComputer;
    }

    public String getClassroom() {
        return classroom;
    }

    public void setClassroom(String classroom) {
        this.classroom = classroom;
    }

    public String getMultimediaClassroom() {
        return multimediaClassroom;
    }

    public void setMultimediaClassroom(String multimediaClassroom) {
        this.multimediaClassroom = multimediaClassroom;
    }

}
