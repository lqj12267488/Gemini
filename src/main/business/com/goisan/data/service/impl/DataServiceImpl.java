package com.goisan.data.service.impl;

import com.goisan.data.bean.Data;
import com.goisan.data.bean.DataLocation;
import com.goisan.data.bean.DataType;
import com.goisan.data.dao.DataDao;
import com.goisan.data.service.DataService;
import com.goisan.system.bean.Tree;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class DataServiceImpl implements DataService {
    @Resource
    private DataDao dataDao;
    @Override
    public List<Tree> getDataTypeTree() {
        return dataDao.getDataTypeTree();
    }

    @Override
    public DataType getDataTypeById(String typeId) {
        return dataDao.getDataTypeById(typeId);
    }

    @Override
    public List<DataType> checkName(DataType DataType) {
        return dataDao.checkName(DataType);
    }

    @Override
    public void saveDataType(DataType DataType) {
        dataDao.saveDataType(DataType);
    }

    @Override
    public void updateDataType(DataType DataType) {
        dataDao.updateDataType(DataType);
    }

    @Override
    public void deleteDataType(String id) {
        dataDao.deleteDataType(id);
    }
    @Override
    public String getTypeName(String pId) {
        return dataDao.getTypeName(pId);
    }

    @Override
    public String getNewTypeId(String pId) {
        String id = dataDao.getMaxTypeid(pId);
        return CommonUtil.getnextId(id, pId);
    }

    @Override
    public List<Tree> getDataLocationTree() {
        return dataDao.getDataLocationTree();
    }

    @Override
    public String getNewLocationId(String pId) {
        String id = dataDao.getMaxLocationId(pId);
        return CommonUtil.getnextId(id, pId);
    }

    @Override
    public List<DataLocation> checkLocationName(DataLocation dataLocation) {
        return dataDao.checkLocationName(dataLocation);
    }

    @Override
    public void saveDataLocation(DataLocation dataLocation) {
        dataDao.saveDataLocation(dataLocation);
    }

    @Override
    public DataLocation getDataLocationById(String id) {
        return dataDao.getDataLocationById(id);
    }

    @Override
    public void updateDataLocation(DataLocation dataLocation) {
        dataDao.updateDataLocation(dataLocation);
    }

    @Override
    public List<Data> getDataList(Data data) {
        return dataDao.getDataList(data);
    }

    @Override
    public Data getDataById(String dataId) {
        return dataDao.getDataById(dataId);
    }

    @Override
    public void insertData(Data data) {
        dataDao.insertData(data);
    }

    @Override
    public void updateData(Data data) {
        dataDao.updateData(data);
    }

    @Override
    public void deleteData(String dataId) {
        dataDao.deleteData(dataId);
    }

}
