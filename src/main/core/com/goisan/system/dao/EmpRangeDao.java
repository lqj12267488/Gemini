package com.goisan.system.dao;

import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.EmpRange;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by mcq on 2017/5/9.
 */
@Repository
public interface EmpRangeDao {
    List<EmpRange> getEmpRangeList(EmpRange empRange);

    void insertEmpRange(EmpRange empRange);

    EmpRange getEmpRangeById(String id);

    void updatEmpRangeById(EmpRange empRange);

    void deleteEmpRangeById(String id);

    List<AutoComplete> autoCompleteDept();

    List<AutoComplete> autoCompleteEmployee();

    List<EmpRange> getEmpRangeByEmpId(String personId);
}
