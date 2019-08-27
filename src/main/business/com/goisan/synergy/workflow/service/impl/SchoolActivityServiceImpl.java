package com.goisan.synergy.workflow.service.impl;
import com.goisan.synergy.workflow.bean.SchoolActivity;
import com.goisan.synergy.workflow.dao.SchoolActivityDao;
import com.goisan.synergy.workflow.service.SchoolActivityService;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;
/**协同办公-校外人员进校参加活动管理
 * Created by wq on 2017/10/11.
 */
@Service
public class SchoolActivityServiceImpl implements SchoolActivityService{
    @Resource
    private SchoolActivityDao schoolActivityDao;

    public List<SchoolActivity> getSchoolActivityList(SchoolActivity schoolActivity) {
        return schoolActivityDao.getSchoolActivityList(schoolActivity);
    }

    public void insertSchoolActivity(SchoolActivity schoolActivity) {
        schoolActivityDao.insertSchoolActivity(schoolActivity);
    }

    public void deleteSchoolActivity(String id) {
        schoolActivityDao.deleteSchoolActivity(id);
    }

    public void updateSchoolActivity(SchoolActivity schoolActivity) {
        schoolActivityDao.updateSchoolActivity(schoolActivity);
    }

    public SchoolActivity getSchoolActivityById(String id) {
        return schoolActivityDao.getSchoolActivityById(id);
    }

    public List<SchoolActivity> getSchoolActivityProcessList(SchoolActivity schoolActivity) {
        return schoolActivityDao.getSchoolActivityProcessList(schoolActivity);
    }

    public List<SchoolActivity> getSchoolActivityCompleteList(SchoolActivity schoolActivity) {
        return schoolActivityDao.getSchoolActivityCompleteList(schoolActivity);
    }

    public List<AutoComplete> selectPerson() {
        return schoolActivityDao.selectPerson();
    }

    public List<AutoComplete> selectDept() {
        return schoolActivityDao.selectDept();
    }

    public String getPersonNameById(String personId) {
        return schoolActivityDao.getPersonNameById(personId);
    }

    public String getDeptNameById(String deptId) {
        return schoolActivityDao.getDeptNameById(deptId);
    }
}