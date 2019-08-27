package com.goisan.data.dao;

import com.goisan.data.bean.Data;
import com.goisan.data.bean.DataLocation;
import com.goisan.data.bean.DataType;
import com.goisan.system.bean.Tree;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DataDao {
    List<Tree> getDataTypeTree();

    DataType getDataTypeById(String typeId);

    List<DataType> checkName(DataType dataType);

    void saveDataType(DataType dataType);

    void updateDataType(DataType dataType);

    void deleteDataType(String id);

    String getTypeName(String pId);

    DataType getNewTypeId(String pId);

    String getMaxTypeid(String pId);

    List<Tree> getDataLocationTree();

    String getMaxLocationId(String pId);

    List<DataLocation> checkLocationName(DataLocation dataLocation);

    void saveDataLocation(DataLocation dataLocation);

    DataLocation getDataLocationById(String id);

    void updateDataLocation(DataLocation dataLocation);

    List<Data> getDataList(Data data);

    Data getDataById(String dataId);

    void insertData(Data data);

    void updateData(Data data);

    void deleteData(String dataId);
}
