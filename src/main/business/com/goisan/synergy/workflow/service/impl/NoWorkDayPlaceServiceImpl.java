package com.goisan.synergy.workflow.service.impl;

import com.goisan.synergy.workflow.bean.NoWorkDayPlace;
import com.goisan.synergy.workflow.bean.Standard;
import com.goisan.synergy.workflow.dao.NoWorkDayPlaceDao;
import com.goisan.synergy.workflow.service.NoWorkDayPlaceService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Select2;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**非工作日学校场所使用管理
 * Created by wq on 2017/7/19.
 */
@Service
public class NoWorkDayPlaceServiceImpl implements NoWorkDayPlaceService {
    @Resource
    private NoWorkDayPlaceDao noWorkDayPlaceDao;

    public List<NoWorkDayPlace> getNoWorkDayPlaceList(NoWorkDayPlace noWorkDayPlace) {
        return noWorkDayPlaceDao.getNoWorkDayPlaceList(noWorkDayPlace);
    }

    public void insertNoWorkDayPlace(NoWorkDayPlace noWorkDayPlace) {
        noWorkDayPlaceDao.insertNoWorkDayPlace(noWorkDayPlace);
    }

    public void deleteNoWorkDayPlace(String id) {
        noWorkDayPlaceDao.deleteNoWorkDayPlace(id);
    }

    public void updateNoWorkDayPlace(NoWorkDayPlace noWorkDayPlace) {
        noWorkDayPlaceDao.updateNoWorkDayPlace(noWorkDayPlace);
    }

    public NoWorkDayPlace getNoWorkDayPlaceById(String id) {
        return noWorkDayPlaceDao.getNoWorkDayPlaceById(id);
    }

    public List<NoWorkDayPlace> getNoWorkDayPlaceProcessList(NoWorkDayPlace noWorkDayPlace) {
        return noWorkDayPlaceDao.getNoWorkDayPlaceProcessList(noWorkDayPlace);
    }

    public List<NoWorkDayPlace> getNoWorkDayPlaceCompleteList(NoWorkDayPlace noWorkDayPlace) {
        return noWorkDayPlaceDao.getNoWorkDayPlaceCompleteList(noWorkDayPlace);
    }

    public List<AutoComplete> selectPerson() {
        return noWorkDayPlaceDao.selectPerson();
    }

    public List<AutoComplete> selectDept() {
        return noWorkDayPlaceDao.selectDept();
    }

    public String getPersonNameById(String personId) {
        return noWorkDayPlaceDao.getPersonNameById(personId);
    }

    public String getDeptNameById(String deptId) {
        return noWorkDayPlaceDao.getDeptNameById(deptId);
    }

    public List<Select2> getDeptPerson(String deptId) {
        return noWorkDayPlaceDao.getDeptPerson(deptId);
    }

    public Standard getNoWorkDayPlaceStandard(String type){ return noWorkDayPlaceDao.getNoWorkDayPlaceStandard(type);}

    public void insertNoWorkDayPlaceStandard(Standard standard) {
        noWorkDayPlaceDao.insertNoWorkDayPlaceStandard(standard);
    }

    public void updateNoWorkDayPlaceStandard(Standard standard){
        noWorkDayPlaceDao.updateNoWorkDayPlaceStandard(standard);
    }
}