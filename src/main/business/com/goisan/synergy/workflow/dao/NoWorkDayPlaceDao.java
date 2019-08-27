package com.goisan.synergy.workflow.dao;

import com.goisan.synergy.workflow.bean.NoWorkDayPlace;
import com.goisan.synergy.workflow.bean.Standard;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Select2;

import java.util.List;

/**非工作日学校场所使用管理
 * Created by wq on 2017/7/19.
 */
public interface NoWorkDayPlaceDao {
    List<NoWorkDayPlace> getNoWorkDayPlaceList(NoWorkDayPlace noWorkDayPlace);

    void insertNoWorkDayPlace(NoWorkDayPlace noWorkDayPlace);

    void deleteNoWorkDayPlace(String id);

    void updateNoWorkDayPlace(NoWorkDayPlace noWorkDayPlace);

    NoWorkDayPlace getNoWorkDayPlaceById(String id);

    List<NoWorkDayPlace> getNoWorkDayPlaceProcessList(NoWorkDayPlace noWorkDayPlace);

    List<NoWorkDayPlace> getNoWorkDayPlaceCompleteList(NoWorkDayPlace noWorkDayPlace);

    List<AutoComplete> selectPerson();

    List<AutoComplete> selectDept();

    String getPersonNameById(String personId);

    String getDeptNameById(String deptId);

    List<Select2> getDeptPerson(String deptId);

    Standard getNoWorkDayPlaceStandard(String type);

    void insertNoWorkDayPlaceStandard(Standard standard);

    void updateNoWorkDayPlaceStandard(Standard standard);
}
