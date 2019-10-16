package com.goisan.table.dao;

import com.goisan.system.bean.BaseBean;
import com.goisan.table.bean.Volunteers;

import java.util.List;

public interface VolunteersDao {

    List<BaseBean> getVolunteersList(BaseBean baseBean);

    void saveVolunteers(BaseBean baseBean);

    Volunteers getVolunteersById(String id);

    void updateVolunteers(BaseBean baseBean);

    void delVolunteers(String id);

}
