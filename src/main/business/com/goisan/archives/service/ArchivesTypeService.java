package com.goisan.archives.service;

import com.goisan.archives.bean.ArchivesType;
import com.goisan.system.bean.Tree;

import java.util.List;

public interface ArchivesTypeService {
    List<Tree> getArchivesTypeTree();
    ArchivesType getArchivesTypeById(String typeId);
    List<ArchivesType> checkName(ArchivesType archivesType);
    String getNewTypeId(String pId);
    String getMaxDeptOrder(String parentTypeId);
    void saveArchivesType(ArchivesType archivesType);
    void updateArchivesType(ArchivesType archivesType);
    void deleteArchivesType(String id);
    String getTypeName(String pId);
}
