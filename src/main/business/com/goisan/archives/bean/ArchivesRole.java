package com.goisan.archives.bean;

import com.goisan.system.bean.BaseBean;

/**
 * Created by admin on 2017/4/28.
 */
public class ArchivesRole extends BaseBean {
    private String id;
    private String archivesId;
    private String personId;
    private String deptId;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getArchivesId() {
        return archivesId;
    }

    public void setArchivesId(String archivesId) {
        this.archivesId = archivesId;
    }

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public String getDeptId() {
        return deptId;
    }

    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }
}
