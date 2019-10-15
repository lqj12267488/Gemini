package com.goisan.table.dao;

import com.goisan.system.bean.BaseBean;
import com.goisan.table.bean.Programme;

import java.util.List;

public interface ProgrammeDao {

    List<BaseBean> getProgrammeList(BaseBean baseBean);

    void saveProgramme(BaseBean baseBean);

    Programme getProgrammeById(String id);

    void updateProgramme(BaseBean baseBean);

    void delProgramme(String id);

}
