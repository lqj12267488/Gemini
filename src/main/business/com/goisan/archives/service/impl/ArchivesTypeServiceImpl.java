package com.goisan.archives.service.impl;

import com.goisan.archives.bean.ArchivesType;
import com.goisan.archives.dao.ArchivesTypeDao;
import com.goisan.archives.service.ArchivesTypeService;
import com.goisan.system.bean.Tree;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ArchivesTypeServiceImpl implements ArchivesTypeService {
    @Resource
    private ArchivesTypeDao archivesTypeDao;
    @Override
    public List<Tree> getArchivesTypeTree() {
        return archivesTypeDao.getArchivesTypeTree();
    }

    @Override
    public ArchivesType getArchivesTypeById(String typeId) {
        return archivesTypeDao.getArchivesTypeById(typeId);
    }

    @Override
    public List<ArchivesType> checkName(ArchivesType archivesType) {
        return archivesTypeDao.checkName(archivesType);
    }

    @Override
    public String getNewTypeId(String pId) {
        String id = archivesTypeDao.getMaxTypeid(pId);
        return CommonUtil.getnextId(id, pId);
    }

    @Override
    public String getMaxDeptOrder(String parentTypeId) {
        return archivesTypeDao.getMaxDeptOrder(parentTypeId);
    }

    @Override
    public void saveArchivesType(ArchivesType archivesType) {
        archivesTypeDao.saveArchivesType(archivesType);
    }

    @Override
    public void updateArchivesType(ArchivesType archivesType) {
        archivesTypeDao.updateArchivesType(archivesType);
    }

    @Override
    public void deleteArchivesType(String id) {
        archivesTypeDao.deleteArchivesType(id);
    }
    @Override
    public String getTypeName(String pId) {
        return archivesTypeDao.getTypeName(pId);
    }

}
