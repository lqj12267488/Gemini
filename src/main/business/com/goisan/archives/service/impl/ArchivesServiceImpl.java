package com.goisan.archives.service.impl;

import com.goisan.archives.bean.Archives;
import com.goisan.archives.bean.ArchivesFile;
import com.goisan.archives.bean.ArchivesRole;
import com.goisan.archives.dao.ArchivesDao;
import com.goisan.archives.service.ArchivesService;
import com.goisan.system.bean.*;
import com.goisan.system.dao.FilesDao;
import com.goisan.system.service.EmpService;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ArchivesServiceImpl implements ArchivesService {
    @Resource
    private ArchivesDao archivesDao;
    @Resource
    FilesDao filesDao;

    public List<Archives> getArchivesList(Archives archives) {
        return archivesDao.getArchivesList(archives);
    }

    public Archives getArchivesById(String archivesId) {
        return archivesDao.getArchivesById(archivesId);
    }

    public Archives getArchivesByIds(String businessId) {
        return archivesDao.getArchivesByIds(businessId);
    }

    public void insertArchives(Archives archives) {
        archivesDao.insertArchives(archives);
    }

    public String getArchivesName(String oneLevel){
        return archivesDao.getArchivesName(oneLevel);
    }

    public void updateArchives(Archives archives) {
        archivesDao.updateArchives(archives);
    }

    public void updateArchivesState(String id) {
        archivesDao.updateArchivesState(id);
    }

    public void updateValidFlag(Archives archives) {
        archivesDao.updateValidFlag(archives);
    }

    public void updateArchivesInfo(String id) {
        archivesDao.updateArchivesInfo(id);
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

    @Override
    public String getFileNum(String id) {
        return archivesDao.getFileNum(id);
    }

    @Override
    public String getArchivesCode(String id) {
        return archivesDao.getArchivesCode(id);
    }

    public List<AutoComplete> selectDept() {
        return archivesDao.selectDept();
    }

    public List<AutoComplete> selectPerson() {
        return archivesDao.selectPerson();
    }

    @Override
    public List<AutoComplete> selectRequester(String deptId) {
        return archivesDao.selectRequester(deptId);
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

    public List<EmpDeptTree> getArchivesDeptAndPersonTree(EmpDeptTree edt) {
        return archivesDao.getArchivesDeptAndPersonTree(edt);
    }

    @Override
    public Archives getPrintById(String archivesId) {
        return archivesDao.getPrintById(archivesId);
    }

    @Override
    public Archives getArchivesLogById(String archivesId) {
        return archivesDao.getArchivesLogById(archivesId);
    }

    public List<Archives> getAllArchivesList(Archives archives) {
        return archivesDao.getAllArchivesList(archives);
    }
    @Override
    public void insertArchivesLog(Archives archives) {
        archivesDao.insertArchivesLog(archives);
    }

    public void updateArchivesRemark(Archives archives) {
        archivesDao.updateArchivesRemark(archives);
    }

    public List<Archives> getArchivesHeadmasterList(Archives archives) {
        return archivesDao.getArchivesHeadmasterList(archives);
    }

    @Override
    public List<Archives> getArchivesListLingDao(Archives archives) {
        return archivesDao.getArchivesListLingDao(archives);
    }

    @Override
    public List<Archives> getArchivesListBumen(Archives archives) {
        return archivesDao.getArchivesListBumen(archives);
    }

    public void archivesRoleTakeBack(String id) {
        archivesDao.archivesRoleTakeBack(id);
    }

    public void updateArchivesRoleState(String id) {
        archivesDao.updateArchivesRoleState(id);
    }

    public void updateRoleState(String archivesId) {
        archivesDao.updateRoleState(archivesId);
    }

    public List getArchivesCheckEmp(String archivesId , String deptId){
        return archivesDao.getArchivesCheckEmp(archivesId , deptId);
    }

    public List<Emp> getPersonBydeptId(String deptId){
        return archivesDao.getPersonBydeptId(deptId);
    }

    public void saveArchivesPower(String deptId ,String archivesId,String checkList){
        archivesDao.delArchivesPower(archivesId,deptId);
        String[] check ;
        if(!checkList.equals("")){
            check = checkList.split("##");
            archivesDao.updateRoleState(archivesId);
        }else{
            check = new String[0];
        }
        ArchivesRole role = new ArchivesRole();
        CommonUtil.save(role);
        for (int i = 0; i < check.length; i++) {
            role.setArchivesId(archivesId);
            String a = check[i];
            String[] b = a.split(",");
            role.setDeptId(b[1].toString());
            role.setPersonId(b[0].toString());
            archivesDao.insertRoleEmpDept(role);
        }
    }
    @Resource
    private EmpService empService;
    public String getCheckListCount(Archives archives){
        String personId= CommonUtil.getPersonId();
        String deptId= CommonUtil.getDefaultDept();
        List list = empService.getEmpRole(personId,deptId);
        if (list.contains("b34d00b3-bcde-4600-9d4c-a48906c7d750")){
            archives.setCreateDept(deptId);
            archives.setRoleFlag("1");//是部门主任角色中的人
        }else {
            archives.setCreator(personId);
            archives.setRoleFlag("2");//不是部门主任角色中的人
        }
        return archivesDao.getCheckListCount(archives);
    }

    public List<Archives> allArchivesId(Archives arc) {
        return archivesDao.allArchivesId(arc);
    }

    public List<Files> getFilesByBusinessId(String businessId) {
        return filesDao.getFilesByBusinessId(businessId);
    }

    @Override
    public Files getFileById(String fileId) {
        return filesDao.getFileById(fileId);
    }
}
