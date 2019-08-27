package com.goisan.synergy.workflow.service;

import com.goisan.synergy.workflow.bean.Photography;
import com.goisan.system.bean.AutoComplete;

import java.util.List;

/**
 * Created by Administrator on 2017/7/26.
 */
public interface PhotographyService {
    List<Photography> getPhotographyList(Photography photography);
    void insertPhotography(Photography photography);
    void updatePhotographyById(Photography photography);
    void deletePhotographyById(String id);
    //回显,通过修改的id
    Photography getPhotographyById(String id);
    List<Photography> getPhotographyListProcess(Photography photography);
    List<AutoComplete> selectDept();
    List<AutoComplete> selectPerson();
    List<Photography> getPhotographyListComplete(Photography photography);
    String getPersonNameById(String personId);
    String getDeptNameById(String deptId);
}
