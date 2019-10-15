package com.goisan.table.service;

import com.goisan.system.bean.BaseBean;
import com.goisan.table.bean.Programme;

import java.util.List;

public interface ProgrammeService {

    List<BaseBean> getProgrammeList(BaseBean baseBean);

    void saveProgramme(BaseBean baseBean);

    Programme getProgrammeById(String id);

    void updateProgramme(BaseBean baseBean);

    void delProgramme(String id);

}