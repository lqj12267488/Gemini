package com.goisan.archives.service.impl;

import com.goisan.archives.bean.Archives;
import com.goisan.archives.bean.ArchivesFile;
import com.goisan.archives.bean.ArchivesRole;
import com.goisan.archives.dao.ArchivesDao;
import com.goisan.archives.service.ArchivesService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.EmpDeptTree;
import com.goisan.system.bean.Select2;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ArchivesServiceImpl implements ArchivesService {
    @Resource
    private ArchivesDao archivesDao;

    public List<Archives> getArchivesList(Archives archives) {
        return archivesDao.getArchivesList(archives);
    }

    public Archives getArchivesById(String archivesId) {
        return archivesDao.getArchivesById(archivesId);
    }

    public void insertArchives(Archives archives) {
        archivesDao.insertArchives(archives);
    }

    public void updateArchives(Archives archives) {
        archivesDao.updateArchives(archives);
    }

    public void updateValidFlag(Archives archives) {
        archivesDao.updateValidFlag(archives);
    }

    public void deleteArchivesById(String archivesId) {
        archivesDao.deleteArchivesById(archivesId);
    }

    public String getPersonNameById(String id) {
        return archivesDao.getPersonNameById(id);
    }

    public String getDeptNameById(String id) {
        return archivesDao.getDeptNameById(id);
    }

    public List<AutoComplete> selectDept() {
        return archivesDao.selectDept();
    }

    public List<AutoComplete> selectPerson() {
        return archivesDao.selectPerson();
    }

    public List<Select2> getDeptList() {
        return archivesDao.getDeptList();
    }

    public String getStaffBelongs(String personId) {
        return archivesDao.getStaffBelongs(personId);
    }

    public ArchivesFile getArchivesFilesById(String archivesId) {
        return archivesDao.getArchivesFilesById(archivesId);
    }

    public List<ArchivesFile> getFilesByArchivesId(String archivesId) {
        return archivesDao.getFilesByArchivesId(archivesId);
    }

    public List<Archives> getArchivesLogList(Archives archives) {
        return archivesDao.getArchivesLogList(archives);
    }

    public ArchivesFile getArchivesFileById(String fileId) {
        return archivesDao.getArchivesFileById(fileId);
    }

    public void insertArchivesFile(ArchivesFile archivesFile) {
        archivesDao.insertArchivesFile(archivesFile);
    }

    public void deleteFileByFileId(String fileId) {
        archivesDao.deleteFileByFileId(fileId);
    }

    public void deleteFileByArchivesId(String archivesId) {
        archivesDao.deleteFileByArchivesId(archivesId);
    }

    public void archivesRequestFlag(Archives archives) {
        archivesDao.archivesRequestFlag(archives);
    }

    public void archivesEditRequest(Archives archives) {
        archivesDao.archivesEditRequest(archives);
    }

    public void updateArchivesDelStateById(Archives archives) {
        archivesDao.updateArchivesDelStateById(archives);
    }

    public List<Archives> getArchivesRecycleBinList(Archives archives) {
        return archivesDao.getArchivesRecycleBinList(archives);
    }

    public void delRoleEmpDeptByArchivesIdAndInsertRoleEmpDept(String archivesId, String checkList) {
        archivesDao.delRoleEmpDeptByArchivesId(archivesId);
        if (checkList.length() > 0) {
            String[] check = checkList.split("@@@");
            for (int i = 0; i < check.length; i++) {
                ArchivesRole ar = new ArchivesRole();
                ar.setArchivesId(archivesId);
                String a = check[i];
                String[] b = a.split("@");
                ar.setDeptId(b[0].toString());
                ar.setPersonId(b[1].toString());
                ar.setCreator(CommonUtil.getPersonId());
                ar.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
                ar.setCreateTime(CommonUtil.getDate());
                archivesDao.insertRoleEmpDept(ar);
            }
        }
    }

    public void delRoleEmpDeptByArchivesId(String id) {
        archivesDao.delRoleEmpDeptByArchivesId(id);
    }

    public void insertRoleEmpDept(ArchivesRole ar) {
        archivesDao.insertRoleEmpDept(ar);
    }

    public List<EmpDeptTree> getArchivesDeptAndPersonTree(String id) {
        return archivesDao.getArchivesDeptAndPersonTree(id);
    }

    @Override
    public Archives getPrintById(String archivesId) {
        return archivesDao.getPrintById(archivesId);
    }

    public List<Archives> getAllArchivesList(Archives archives) {
        return archivesDao.getAllArchivesList(archives);
    }
    @Override
    public void insertArchivesLog(Archives archives) {
        archivesDao.insertArchivesLog(archives);
    }
}
