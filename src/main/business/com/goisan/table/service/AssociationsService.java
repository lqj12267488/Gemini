package com.goisan.table.service;

import com.goisan.system.bean.BaseBean;
import com.goisan.table.bean.Associations;

import java.util.List;

public interface AssociationsService {

    List<Associations> getAssociationsList(BaseBean baseBean);

    void saveAssociations(BaseBean baseBean);

    Associations getAssociationsById(String id);

    void updateAssociations(BaseBean baseBean);

    void delAssociations(String id);

}