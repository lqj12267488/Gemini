package com.goisan.studentwork.internships.dao;

import com.goisan.educational.place.meetingRoom.bean.MeetingRoom;
import com.goisan.studentwork.employments.bean.Employments;
import com.goisan.studentwork.internships.bean.InternshipManage;
import com.goisan.studentwork.internships.bean.Internships;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by hanyu on 2017/7/31.
 */

@Repository
public interface InternshipsDao {
    List<Internships> getInternshipsList(String internshipUnitId);
    void insertInternships(Internships internships);
    List<Internships> InternshipsAction(Internships internships);
    List<Internships> InternshipsActionList(Internships internships);
    Internships getInternshipsById(String internshipUnitId);
    void updateInternshipsById(Internships internships);
    void deleteInternshipsById(String internshipUnitId);
    List<AutoComplete> selectDept();
    List<AutoComplete> selectPerson();
    String getPersonNameById(String id);
    String getDeptNameById(String id);
    Internships selectId(String internshipUnitId);
    Internships selectAll(String id);
    Internships selectOne(String internshipUnitId);
    List<InternshipManage> getInternshipsByInternshipUnitName(String internshipUnitName);

}
