package com.goisan.archives.service;

import com.goisan.archives.bean.ArchivesType;
import com.goisan.system.bean.Tree;

import java.util.List;

public interface ArchivesTypeService {
    List<Tree> getArchivesTypeTree();
    ArchivesType getArchivesTypeById(String typeId);
    ArchivesType getArchivesTypeByName(String name);
    List<ArchivesType> checkName(ArchivesType archivesType);
    List<ArchivesType> checkId(ArchivesType archivesType);
    List<ArchivesType> allPid(ArchivesType archivesType);
    String getNewTypeId(String pId);
    String getMaxDeptOrder(String parentTypeId);
    void saveArchivesType(ArchivesType archivesType);
    void updateArchivesType(ArchivesType archivesType);
    void updateArchivesTypeName(ArchivesType archivesType);
    void deleteArchivesType(String id);
    void deleteArchivesName(String name);
    String getTypeName(String pId);
}
