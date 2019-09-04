package com.goisan.archives.dao;

import com.goisan.archives.bean.ArchivesType;
import com.goisan.system.bean.Tree;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ArchivesTypeDao {
    List<Tree> getArchivesTypeTree();
    ArchivesType getArchivesTypeById(String typeId);
    ArchivesType getArchivesTypeByName(String name);
    List<ArchivesType> checkName(ArchivesType archivesType);
    List<ArchivesType> checkId(ArchivesType archivesType);
    List<ArchivesType> allPid(ArchivesType archivesType);
    String getMaxDeptOrder(String parentTypeId);
    String getMaxTypeid(String pId);
    void saveArchivesType(ArchivesType archivesType);
    void updateArchivesType(ArchivesType archivesType);
    void updateArchivesTypeName(ArchivesType archivesType);
    void deleteArchivesType(String id);
    void deleteArchivesName(String name);
    String getTypeName(String pId);
}
