package com.goisan.synergy.workflow.service;

import com.goisan.synergy.workflow.bean.HallUse;
import com.goisan.synergy.workflow.bean.Standard;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Select2;

import java.util.List;

/**礼堂使用管理
 * Created by wq on 2017/7/18.
 */
public interface HallUseService {
    List<HallUse> getHallUseList(HallUse hallUse);
    void insertHallUse(HallUse hallUse);
    void updateHallUseAPP(HallUse hallUse);
    void deleteHallUse(String id);
    void updateHallUse(HallUse hallUse);
    HallUse getHallUseById(String id);
    List<HallUse> getHallUseProcessList(HallUse hallUse);
    List<HallUse> getHallUseCompleteList(HallUse hallUse);
    List<AutoComplete> selectPerson();
    List<AutoComplete> selectDept();
    String getPersonNameById(String personId);
    String getDeptNameById(String deptId);
    List<Select2> getDeptPerson(String deptId);

    Standard getHallUseStandard(Standard standard);

    void insertHallUseStandard(Standard standard);

    void updateHallUseStandard(Standard standard);
}
