package com.goisan.synergy.workflow.dao;
import com.goisan.synergy.workflow.bean.SchoolActivity;
import com.goisan.system.bean.AutoComplete;
import java.util.List;
/**协同办公-校外人员进校参加活动管理
 * Created by wq on 2017/10/11.
 */
public interface SchoolActivityDao {
    List<SchoolActivity> getSchoolActivityList(SchoolActivity schoolActivity);

    void insertSchoolActivity(SchoolActivity schoolActivity);

    void deleteSchoolActivity(String id);

    void updateSchoolActivity(SchoolActivity schoolActivity);

    SchoolActivity getSchoolActivityById(String id);

    List<SchoolActivity> getSchoolActivityProcessList(SchoolActivity schoolActivity);

    List<SchoolActivity> getSchoolActivityCompleteList(SchoolActivity schoolActivity);

    List<AutoComplete> selectPerson();

    List<AutoComplete> selectDept();

    String getPersonNameById(String personId);

    String getDeptNameById(String deptId);
}