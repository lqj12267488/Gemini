package com.goisan.table.dao;

import com.goisan.system.bean.BaseBean;
import com.goisan.table.bean.Associations;

import java.util.List;

public interface AssociationsDao {

    List<Associations> getAssociationsList(BaseBean baseBean);

    void saveAssociations(BaseBean baseBean);

    Associations getAssociationsById(String id);

    void updateAssociations(BaseBean baseBean);

    void delAssociations(String id);

}
