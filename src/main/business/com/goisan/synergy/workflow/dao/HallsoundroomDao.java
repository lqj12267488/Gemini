package com.goisan.synergy.workflow.dao;

import com.goisan.synergy.workflow.bean.Hallsoundroom;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Administrator on 2017/5/6.
 */
@Repository
public interface HallsoundroomDao {
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
