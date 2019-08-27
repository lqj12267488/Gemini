package com.goisan.synergy.workflow.service;

import com.goisan.synergy.workflow.bean.Hallsoundroom;
import com.goisan.system.bean.AutoComplete;

import java.util.List;

/**
 * Created by Administrator on 2017/5/6.
 */
public interface HallsoundroomService {

    List<Hallsoundroom> hallsoundroomAction(Hallsoundroom hallsoundroom);

    void insertHallsoundroom(Hallsoundroom hallsoundroom);

    Hallsoundroom getHallsoundroomById(String id);

    void updateHallsoundroom(Hallsoundroom hallsoundroom);

    void deleteHallsoundroomById(String id);

    List<Hallsoundroom> searchhallsoundroom(Hallsoundroom hallsoundroom);

    List<AutoComplete> selectDept();

    List<AutoComplete> selectPerson();

    List<Hallsoundroom> getProcessHallsoundroomList(Hallsoundroom hallsoundroom);

    List<Hallsoundroom> getCompleteHallsoundroomList(Hallsoundroom hallsoundroom);

    String getPersonNameById(String personId);

    String getDeptNameById(String deptId);
}
